1.绑定变量
1).硬解析    select * from emp where empno  =123;(时间长，因为需要解析sql语句,数据库会长时间地占用一种低级串行化设备，这种设备称为闩(shuan)latching机制--oracle共享内存中数据机构不会同时被两个进程修改)
2).软解析   select  * from emp  where empno  =: empno;(时间短,因为将查询计划存储在一个共享池(库缓存)中,以便重用)
例如：创建两个过程，比较时间
drop table t  ;
create table t( numb int);
过程1:
create or replace procedure proc1
as 
begin 
for i in 1 .. 10000
 loop 
  execute immediate
  'insert into t values (:numb)' using i;
  end loop;
  end ;
  / 
过程2:
create or replace procedure proc2
	as 
	begin 
	for i in 1 .. 10000
	loop
	 execute immediate
	 'insert into t values ('||i||')';
	 end loop;
	 end ;
	 /
开启时间统计
set timing on 
exec proc1
用时:00:00:00.60
set timing on
exec proc2
用时:00:00:09.01

2.对Oracle锁定策略的总结：
1).Oracle只在修改时才对数据加行级锁。正常情况下不会升级到块级锁或表级锁(不过两端提交期间的一段很短的时间内除外，这是一个不常见的操作)。
2).如果只是读数据，Oracle绝不会对数据锁定。不会因为简单的读操作在数据行上锁定(读取器绝对不会阻塞写入器)。
3).写入器(writer) 不会阻塞读取器(reader)。换种说法：读(read)不会被写 (write)阻塞。这一点几乎与其他所有数据库都不一样。
  在其他数据库中，读往往会被写阻塞。如果你没有充分理解这个思想，而且想通过应用逻辑对应用施加完整性约束，就极有可能做得不对。
4).写入器想写某行数据，但另一个写入器已经锁定这行数据，此时该写入器才会被阻塞。


3.防止丢失更新
Oracle的无阻塞方法有一个副作用，如果确实想保住一次最多只有一个用户访问一行数据.
例子：有一间房间，但是有两个人需要入住，这两个人同时点击订购，一个人想预订(3:00 - 4:00),另一个人想预订(3:30 - 4:00)，
      但这两个人都成功的预订了这房间。（这就出错了）
      原因分析：两个会话都通过运行查询来查找是否已经有预订，尽管另一个会话可能已经开始修改schedules表，但查询看不到这些修改（所做的修改在提交之前对其他会话来说是不可见的，而等到提交时为时已晚）。
                  由于这两个会话并没有试图修改schedules表中的同一行，所以它们不会相互阻塞。
      解决方案：开发人员需要一种方式使得这个业务规则在多用户环境下也能得到保住，也就是要确保一次只有一个人预订一种给定的资源。
                   在这种情况下，解决方案就是加入他自己的一些串行化机制。
      使用方式：for update,  字句的作用就像是一个信号量(semaphone) ，只允许串行访问resources表中特定的行，这样就能确保不会出现两个人同时
      			调度的情况。把所有的逻辑都打包进一个存储过程，只允许应用通过这个API修改数据
表1:create table resources ( resource_name varchar2(25) primary key);
表2:create table schedules(
	resource_name references resources,
	start_time date not null ,
	end_time date  not null  ,
	check(start_time<end_time),
	primary key (resource_name, start_time)
);
过程：
create or replace procedure schedule_resources(
p_resource_name in varchar2,
p_start_time in date ,
p_end_time  in date  
)
as 
 l_resource_name resources.resource_name%type;
 l_cnt            number;
begin 
-- 首先在resources表中锁定我们想调度的那个资源的相应行。如果别人已经锁定了这一行，我们就会阻塞并等待
select  resource_name into l_resource_name from resources where  resource_name = p_resource_name for update;
select count(*) into l_cnt from schedules  where resource_name = p_resource_name
		 and (start_time <= p_end_time) and (end_time >= p_start_time);
 if(l_cnt <> 0) then raise_application_error (-20001,'Room is already booky!');
  end if ;
insert into schedules(resource_name,start_time,end_time) values(p_resource_name,p_start_time,p_end_time);
end schedule_resources;
/

 --测试(注意在resources要有用户xukai)
exec schedule_resources('xukai' ,TO_DATE('2013-09-11 14:31:08', 'YYYY-MM-DD HH24:MI:SS'),
						 TO_DATE('2013-09-11 14:31:11', 'YYYY-MM-DD HH24:MI:SS'));

4.多版本性
oracel采用了一种多版本，读一致(read-consistent)的并发模型。
A.读一致查询：对于一个时间点(point in time) ,查询会产生一致的结果。
B.非阻塞查询:查询不会被写入器阻塞，但在其他数据库中可能不是这样。
多版本案例:
sql>create table t as select * from all_users;  --创建并复制表
sql>variable x	refcursor    -- 打开游标
--创建过程
sql>begin   open :x for select * from t ;
    end ;
    /
--删除表t
delete from t  ;
commit;
print x
通过游标可以显示出T表中的全部的数据。
原因：
   1).在打开游标时，Oracle不复制任何数据，如果一个表中有几亿条数据，使用游标会立即打开，它会边进行回答查询。换句话说，只是在你
      获取数据时它才从表中读取数据。
   2).为什么刚才被delete的数据还可以查询出来?
      在同一个会话中(或者也可以在另一个会话中;这同样能很好地工作)，再从该表删除所有数据。甚至用commit提交了删除所有做到工作。
      记录行都没有了，但是真的没有了吗？实际上，还是可以通过游标获取到被delete表中的数据，open命令返回的结果集在打开的那一刻（时间点）
      就已经确定。打开时，我们根本没有碰过表中的任何数据块，但答案已经是铁板钉钉的了，获取数据之前，我们无法知道答案会是什么；
      不过，从游标角度看，结果则是固定不变的。打开游标时，并非oracle将所有数据复制到另外某个位置；实际上是delete命令为我们把数据保留下来，
      把它放在一个称为(undo segment)的数据区，这个数据区也成为回滚段(rollback segment)。


5.多版本和闪回
1）.在oracle9i之前的版本
   oracle总是基于查询的某个时间点来做决定(从这个时间点开始查询是一致的).
   也就说,Oracle会保证打开的结果集肯定是以下两个时间点之一的当前结果集：
   A.游标打开时的时间点。这是read committed  隔离模式的默认行为，该模式是默认的事务。
   B.查询所属事务开始的时间点。这是 read only 和serializable隔离级别中的默认行为。
2) .在oracle9i之后的版本
   这种情况要灵活得多。实际上，我们可以指示Oracle 提供任何指定时间段查询结果
   (对于回放的时间长度有一些合理的局限;当然，这要有你的DBA来控制)，这里使用了一种称为闪回查询(flashback query)的特性。
首先得到一个SCN，这是指系统修改号(System Chanage Number) 或系统提交号(System commit Number)


