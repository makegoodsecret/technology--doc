一. 什么是数据库

		软件 ＝数据仓库＋管理软件
		Database  :数据库
		DBMS:DataBase Management  System  
		Oracle
		DB2(IBM)   Sybase(sybase)
		mysql(Oracle)      sqlserver(MS)
		sqlite(嵌入式数据库)
		access
二. 访问数据库
Orcale :
		Oracle的端口号:1521
		Oracle的名字(sid) :tarena
		数据库所在的服务器的IP地址 telnet 192.168.0.23
		 服务器的帐号： tarena
		服务器的密码：tarena
		（以下可以替换,   sqlplus openlab/open123）
		oracle数据库的连接工具: sqlplus   
		数据库访问用户: openlab
		数据库密码:open123
--sqlplus安装在本地
	c:> sqlplus openlab/open123@192.168.0.23:1521/tarena
	
	sql>conn 用户名/密码
1. 建表
1.1 创建普通的表
create table user_xukai(    -- 表名不能超过30个字符
		id number(4),			   -- 表名、列名是自由定义的
		password char(4),		  -- 所有的sql语句都是以";"结尾
		name char(20) ,				--最长不超过20位的字符串
		phone varchar(20),     --最大不超过20个字符，可以收缩
		email varchar2(50)
	);

1.1.1 插入
	insert into user_xukai values( 1001,'1234','xukai','1234567890123456789','makegoodsecret@sina.cm');

1.2 主键关联
 create table teacher (
	 varchar2(10) primary key ,
	name varchar2(10) not null
	);
create table student(
	id varchar2(10) primaty key ,
	name varchar2(10) not null,
	sex char(2) check(sex in('男 ','女')),
	birthday  date ,
	sum number(3) check (sum>=0 and sum<=100),
	tid varchar2(10) references teacher(tid)
);
2. 数据库的类型：
   2-1. 数字
		number(n)  数字(最长n位)
		number(n,m)  浮点数(总长为，小数点后m位)
		例如: number(7,2) 表示最大数为99999.99
  2-2. 字符串
	char(n) 表示定义字符串（方便查询)
				最长放入n个字符串，放入的数据如果不够n个字符则不空格，
				无论如何都占n个字符长度。
	varchar(n) 表示变长字符串（节省空间）
					最长放入n个字符，放入的数据是几个长度就占多大空间
	varchar2(n) Oracle自己定义的变长字符串
 2-3   日期
	date      日期
	01-JAN-11 2011 年1月     --是oracle 默认的日期格式   DD-MON-RR
	一月   January  JAN  二月    February     FEB  三月 March MAR
	四月    Aprill APR    五月  May   六月     June  JUN
	七月 July JUL    八月 August  AUG     九月 September  SEP
	十月 October OCT     十一月  November NOV  十二月     December DEC
	系统的当前的时间
	select sysdate from dual ;   ---dual  虚表
 select to_char(sysdate,'year month mon dd day dy am')from dual;

TO_CHAR(SYSDATE,'YEARMONTHMONDDDAYDYAM')
--------------------------------------------------------------------------------
twenty thirteen august    aug 14 wednesday wed pm

SYSDATE
---------
14-AUG-13
 select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')  from dual;    
TO_CHAR(SYSDATE,'YY')from dual;  
-------------------
2013-08-14 17:22:13

3 sql语句
3. 1 命令
	clear  scr  --  scr 代表screen  清屏
3.2 提交
	commit  提交
3.3 查询
	select * from user_xukai ;
SQL> column ESALARY  format 9999
SQL> column phone format a11 
SQL> column email format a20
SQL> column id format 99999
--     col id for 99999
SQL> select * from user_xukai
--查看表结构
desc emp ;  --desc   describe的缩写


--set linesize 150  --设置行长度为150
格式化输出： 

    ID PASS NAME   PHONE       EMAIL
------ ---- ------ ----------- --------------------
  1001 1234 xukai  12345678901 makegoodsecret@sina.
                   23456789    cm
3.4
	设置分页显示 SQL> set pagesize 100 --每100行数据分页显示 
	SQL> set 	pages 0 --pagesize可以简写为pages,设置为0表示不分页

注意：  Sqlplus 命令不需要写";" 分号
	sql语句必须以分号结束，Sqlplus命令可加可不加分号
	
三.  查询数据
create table dept_xukai(
	Deptno  Number(2) ,
	Dname   Varchar2(20) ,
	Location Varchar2(10)
);
 
 
insert into dept_xukai values(20,'xiaoshoubu','hangzhou');
 
insert into dept_xukai values(30,'sveloper','berjing');
 
insert into dept_xukai values(40,'lajibu','berjing');
commit ;

insert into user_student(1,'xukai','1','01-JAN-11',1);
create table emp_xukai(
	emp_id  number(4) ,
	ename    varchar2(20) ,
	ejob    varchar2(20) ,
	esalary number(7,2),
	ebonus number(7,2),
	ehiredate date default sysdate,
	manager number(4),
	deptno number(2)
);		

select * from dept_xukai order by  Deptno; 

 insert into emp_xukai values(1001, 'xukai0','Manager0',1000,2000,'1-MAR-1',1005,10);
 insert into emp_xukai values(1002, 'xukai1','Manager1',1000,2000,'2-APR-2',1005,10);
 
 insert into emp_xukai values(1012, 'xukai11','',1000,1000,'',1005,10);
 insert into emp_xukai values(1013, null,null,null,null,null,null,null);     
--或则  ---如果空格太多，可以简写  insert into emp_xukai ( emp_id , ename ) values (1014,'xukai14');  

 select * from emp_xukai order by emp_id;

SQL>  select ename , esalary ,esalary*12 year_sal from emp_xukai; 

ENAME         ESALARY   YEAR_SAL
---------- ---------- ----------
xukai            1000      12000
xukai0           1000      12000
 
复制别人的表（在相同的数据库中）
--注意：只复制表结构和数据，不复制约束条件
--可以为复制表再添加约束条件alter table student_xukais add constraint stu_xks_mid_fk foreign key (mid) references major_xukai(id) on  delete cascade ; 
create table emp_xukai as select * from  emp_xukais;
--create table emp as select * from openlab.emp ;

--查询员工的名字和工作，如果 没有工作就显示 no posistion 
 select ename , nvl(ejob,'no position') from emp_xukai;
--“| |”符号表示两个数据串，类似String中的+
 select emp_id||ejob  detail from emp_xukai;

1001Manager
1001Manager0
1002Manager1
--查询出员工的月收入，如果ebonus为空，就用0代替 ,如果不这么写遇到月奖金ebonus为空，月收入就也为空
－－ month_sal为月收入的列别名(可以省略 as )
select ename ,esalary ,ebonus ,esalary+nvl(ebonus,0) as month_sal from emp_xukai order by month_sal;

distinct关键字（去重复）
--查询机构中有多少的种职位
 select distinct ejob  from emp_xukai;
--查找员工分布在哪些部们 
SQL> select distinct deptno from emp_xukai;

    DEPTNO
----------

        10(a1+a2+a3+a4)
 where  条件查询
--查询薪水高于200元的员工
 select * from emp_xukai where esalary >200;
--注意：Sql语句大小写不敏感，数据大小写敏感，
 例如数据库中 有大写的Xukai，xukai不可以Xukai可以
select * from  emp_xukai where ename='Xukai';
--使用lower()函数将数据转换为小写， 理解将数据取出ename全部改为小写在查询
select * from  emp_xukai where lower(ename)='xukai';
--upper()函数  将数据转换为大写
 select * from  emp_xukai where upper(ename)='XUKAI';

--总和
 select * from  emp_xukai where upper(ename)='XUKAI' or lower(ename)='xukai' ;
--
select ename ejob from emp_xukai where lower(ejob) in ('xukai','clerk','progammer');
--修改
update emp_xukai   set ejob='job2'   where emp_id =1006 ;

--between ... and ...关键字
  1)  在区间中：between 低值  and 高值
  2) 闭区间：［低值，高值］

例如：查询薪水大于5000并且小于10000的员工
	select * from emp_xukai where esalary >=5000 and esalary<10000;
--或则 select * from emp_xukai where esalary between 5000 and 10000;
--查询是否为空
select ename from emp_xukai where esalary is null;
--查询不能为空的
select ename from emp_xukai where ebonus is not null;
--显示数据库的用户名
	show user 
--查询当前用户所建的表数
 select count(*) from user_tables;

  COUNT(*)
----------
      2408
--连接
connect openlab/open123;

--模糊匹配like %
 1)  "%"  表示0到多个字符，跟like 匹配使用
 2）"_"下划线表示一个字符
例如：查找职位中包含job的员工
 select * from emp_xukai where lower(ejob) like '%job%'
--查找职位中第二个字符是o的员工数据
 select * from emp_xukai where ejob like'_o%';
--查找数据库中是以EMP开头的表的数量
select count(*) from user_tables where table_name like 'EMP%';
--查询数据库中全部的以 EMP 开头的表
select  table_name from user_tables where table_name like 'EMP%';
--循环删除表
select table_name from user_tables;
for(tab_name:table_name){
	drop table table_name;
}

小结：
DDL(Data Definition Language ):  create  /drop (操作表） alter 修改数据库对象 truncate 清空表数据
DML(Date Manipulation language): insert /update /delete （操作数据)
DQL(Date Query Language ):select
TCL(Transacion Control language) :commit
事务控制语句
commit 提交数据
rollback 数据回滚    只对DML：insert ,update ,delete有效
truncate删除表数据，保留表结构，（不能回滚）
savepoint 保存点

考试
－－DBA
  ocp    Oracle certification Professo
---java  程序员
scjp : sun
ocjp : oracle





第二天
1.round(m,n)四舍五入  m为数，n省略四舍五入小数点，
select ename ,salary,round(salary * 0.12345678 ) tax from emp_xukai;
ENAME     SALARY        TAX
----- ---------- ----------
wangj       5000        617
select ename ,salary,round(salary * 0.12345678 ,2) tax from emp_xukai;
ENAME     SALARY        TAX
----- ---------- ----------
wangj       5000     617.28
select ename ,salary,round(salary * 0.12345678,-1) tax from emp_xukai;
ENAME     SALARY        TAX
----- ---------- ----------
wangj       5000        620


2.
数字函数 trunc() 
trunc( 数字 , 小数点后的位数 )用于截取
 如果没有第二个参数 , 默认是0
select ename ,salary*0.12345678 s1 ,raound(salary*0.12345678,2) s2,trunc(salary*0.12345678,2) s3 from emp_xukais;

3.to_char()  --格式化显示时间
select ename ,hiredate, to_char(hiredate,'yyy-mm-dd') timeyyyymmdd from emp_xukai;

ENAME HIREDATE  TIMEYYYYM
----- --------- ---------
zhang 12-MAR-10 010-03-12
4.记时操作(如果安装了runstats可以不使用下面的方式)
set timing on 

 select count(*) from user_tables;  

  COUNT(*)
----------
      2421

Elapsed: 00:00:00.07

5.日期数据相减
select ename ,hiredate ,(sysdate-hiredate) days from emp_xukai; --两个日期之间的天数差 , 不足一天用小数表示
select ename ,hiredate,round(sysdate-hiredate) days from emp_xukai;--去除小数

6.日期函数 months_between()
例如：计算员工入职多少个月？小数
select  ename ,hiredate,months_between(sysdate,hiredate) months from emp_xukai;
--取除月份中的小数
select ename ,hiredate ,round(months_between(sysdate,hiredate)) as months from emp_xukai;

7.日期函数 add_months()
例如：计算12个月之前的时间点
select add_months(sysdate,-12) from dual;

8.
last_day()
例如：计算本月的最后一天
select last_day(sysdate) from dual;
9.日期格式 *
1) 常用日期格式
 yyyy 四位数字年 如：2011
 year 全拼的年 如：twenty eleven
 month 全拼的月 如：november或11月( 中文 )
 mm 两位数字月 如：11
 mon 简拼的月 如：nov( 中文没有简拼 )
 dd 两位数字日
 day 全拼的星期 如：tuesday
 dy 简拼的星期 如：tue
 am 上午/下午 如：am/pm

10.小结：转换函数to_date()和to_char()  
	to_date()和to_char()是时间处理的函数
  to_date 将字符串数据 按指定格式 转换为 日期数据
  to_char 将日期数据 按指定格式 转换为 字符串数据
		to_char		to_number
日期    -----------> 字符----------> 数字
	   <-----------         <----------
		to_date      to_char
10000--->$10,0000.00 ---->10000
数字         字符                          数字
--例如
 insert into emp_xukai(empno,ename,hiredate) values (1012,'amy',to_date('2011-10-10','yyyy-mm-dd'));
--插入一条数据 , 编号为1012 , 姓名为amy , 入职时间为当前系统时间 
insert into emp_xukai( empno , ename , hiredate ) values( 1012 , 'amy ' , sysdate )

11.数据库中的加
concat(concat('a1','a2'),'a3')
--或则 ：   'a'||'b'||'c'

12.按照指定的格式显示员工姓名和入职时间，显示格式为: 2013-08-15
select ename ,to_char(hiredate ,'yyyy-mm-dd') from emp_xukai;
ENAME                TO_CHAR(HI
-------------------- ----------
zhangwuji            2010-03-12
 
13. 其他的函数
13-1 . 函数coalesce(参数列表)
     返回参数列表中第一个非空参数，参数列表中最后一个值通常为常量
例如：
要求：
1) 如果bonus不是null , 发年终奖金额为bonus
2) 如果bonus是null , 发年终奖金额为salary * 0.5
3) 如果bonus和salary都是null, 发100元安慰一下
select ename ,bonus ,salary,coalesce(bonus,salary*0.5,100) bonus from emp_xukai;
ENAME                     BONUS     SALARY      BONUS
-------------------- ---------- ---------- ----------
zhangwuji                  2000      10000       2000

13-2. case语句
根据员工的职位 , 计算加薪后的薪水数据
要求：
1) 如果职位是Analyst：加薪10%
2) 如果职位是Programmer：加薪5%
3) 如果职位是clerk：加薪2%
4) 其他职位：薪水不变

select ename ,salary ,job,
case job when 'Analyst' then salary*1.1
when 'Programmer' then salary*1.05
when 'clerk' then salary*1.02
else salary
end new_salary  from emp_xukai;

				
13-3.  decode函数
decode()函数是Oracle中等价于case when语句的函数 , 作用同case语句相同。 
decode函数语法如下： decode(判断条件 , 匹配1 , 值1 , 匹配2 , 值2 , … , 默认值) 
表达的意思是：如果判断条件 = 匹配1 , 则迒回值1 判断条件 = 匹配2 , 则迒回值2
xukai
根据员工的职位 , 计算加薪后的薪水数据
要求：和case语句相同
1) 如果职位是Analyst：加薪10%
2) 如果职位是Programmexukair：加薪5%
3) 如果职位是clerk：加薪2%
4) 其他职位：薪水不变

select ename ,salary,job ,decode(
		job,'Analyst',salary*1.1,
	       'Programmer',salary*1.05,
			'clerk',salary*1.02,
				salary)
		new _salary  from emp_xukai;							

14.组函数
 count() avg() sum() max() min() mod()
与单行函数如round()、to_date()、to_char()、coalesce()等不同，
单行函数是每行数据返回结果，组函数是多行数据返回一行结果.
select count(*) from emp_xukai;
select sum(salary) from emp_xukai;
select mod(7.25,1) from dual;

create table ielts_xukai(
   name char(10),
   a1 number(2,1),
   a2 number(2,1),
   a3 number(2,1),
   a4 number(2,1) 
  );

select name ,a1,a2,a3,a4,(a1+a2+a3+a4)  from ielts_xukai;

整数位：trunc((a1+a2+a3+a4)/4)
小数位：mod((a1+a2+a3+a4)/4,1)return number
is

select name ,a1,a2,a3,a4,trunc((a1+a2+a3+a4)/4)+case when mod((a1+a2+a3+a4)/4,1) <0.25 then 0 when mod((a1+a2+a3+a4)/4,1)>=0.25 and  mod((a1+a2+a3+a4)/4,1)<0.75 then 0.5 when mod((a1+a2+a3+a4)/4,1)>=0.75 then 1 end from ielts_xukai;
--
select name ,a1,a2,a3,a4,
trunc((a1+a2+a3+a4)/4)+
case when 
mod((a1+a2+a3+a4)/4,1) <0.25
 then 0 
when mod((a1+a2+a3+a4)/4,1)>=0.25 
and  mod((a1+a2+a3+a4)/4,1)<0.75 
then 0.5 
when mod((a1+a2+a3+a4)/4,1)>=0.75 
then 1 
end 
from ielts_xukai;
 

15 .自定义函数　
create or replace function calculate_xukai(
	score number)
return number
is      
	i number;  
   j number; 
   result number;  
begin   
  i:=trunc(score) ;  
   j:=mod(score,1);
	if j<0.25 then
     result :=0;
  elsif j>=0.25 and j<0.75 then
      result :=0.5;
   elsif j>=0.75 then
     result :=1;	
   end if ;
	return i + result;
end;

 	
create or replace function calculate_xukai(
	score number)
return number 
is 
    i  number; 
    j  number; 
    result number; 
begin
  
 i :=trunc(score); 
 j :=mod(score,1); 
 if j<0.25 then
    result := 0 ;
  elsif j>=0.25 and j<0.75 then
    result :=0.5;
  elsif j>=0.75 then
    result :=1;
end if;
return i + result ;
 end;


select name ,a1,a2,a3,a4,(a1+a2+a3+a4)/a4 a5, calculate_xukai((a1+a2+a3+a4)/4) from ielts_xukai;

select name ,a1,a2,a3,a4,(a1+a2+a3+a4)/a4 a5, calculate_xukai((a1+a2+a3+a4)/4) from ielts_xukai;



select ename ,job,salary,case job when 'Clerk' then salary*1.05 when 'programmer' then salary*1.1 when 'analyt' then salary*1.15 else salary end as new_sal  from emp_xukai;

SQL> select count(*) from user_objects;

  COUNT(*)
----------
      5708

SQL> select count(*) from user_tables;

  COUNT(*)
----------
      2650


计算最早和最晚的员工入职时间
select max(hiredate) as max_hiredae,min(hiredate) as mnin_hiredate from emp_xukai;

MAX_HIRED MNIN_HIRE
--------- ---------
14-AUG-13 12-MAR-10

分组查询 group by **
group by 列名：表示按指定列分组查询(select 后的没有组查询的列都列在 group by 后面)

计算每个部门的 薪水总和 和 平均薪水？
select deptno ,sum(salary) sum_s ,avg(nvl(salary,0)) as avg_s from emp_xukai group by deptno;
 DEPTNO      SUM_S      AVG_S
---------- ---------- ----------
        30      19500       4875


按职位分组 , 每个职位的最高、最低薪水和人数？
select job ,max(salary) as max_s, min(salary) as min_s,count(*) as emp_count from emp_xukai group by job order by  emp_count;

JOB                       MAX_S      MIN_S  EMP_COUNT
-------------------- ---------- ---------- ----------
programmer                 5000       5000          1
pregress                   4000       4000          1
salesman                   5000       4500          2

select count(*) from emp_xukai where deptno is not null group by deptno;
 COUNT(*)
----------
         4
         2
         4
--查询各个部门中最多人数
select max (count(*)) from emp_xukai where deptno is not null group by deptno;
--哪个 部们的人数最多
select deptno ,count(*) from emp_xukai where deptno is not null group by deptno having count(*) =4;

    DEPTNO   COUNT(*)
---------- ----------
        30          4
        10          4


select deptno ,count(*) from emp_xukai where deptno is not null group by deptno having count(*) =(select max(count(*)) from emp_xukai where deptno is not null group by deptno);

---人数最多的部们的名字和工作地址
select dname ,location from dept_xukai where deptno=( select deptno from emp_xukai where deptno is not null group by deptno having count(*) =(select max(count(*)) from emp_xukai where deptno is not null group by deptno));

注意：
--表里有的数据，做条件用where
--表里没有的数据，需要计算的数据做条件，用having 
--所有的组函数做条件，必须使用having

select deptno ,avg(nvl(salary,0)) from emp_xukai group by deptno  having avg(nvl(salary,0))>(select avg(nvl(salary,0)) from emp_xukai);

select avg(nvl(salay,0)) from emp_xukai;

--哪个部们的人数超过5个人
select deptno ,count(*) from emp_xukai group by deptno having count(*) >5;

--哪个部们的薪水总和比部门20的薪水总和高？
select deptno ,sum(salary) from emp_xukai group by deptno having sum(salary) >(select sum(salary) from emp_xukai where deptno=20);
 
注意：
１.　组函数：count/avg/sum/max/min如果函数中写列名，默认忽略空值
２.avg/sum针对数字的操作
３.　max/min对所有数据类型都可以操作


查询语句的基本格式 *** 
SQL> select 字段1 , 字段2 , 字段3 , 表达式 , 函数 , 
from 表名 
where 条件 
group by 列名
having 带组函数的条件
order by 列名


1.2.1. 组函数：count / avg / sum / max / min 
记得：组函数忽略空值
1.2.2. 单行函数
1.2.2.1. 字符函数：upper / lower / initcap/length / lpad / rpad / replace / trim * -- l表示left ; r表示right
1) upper 转换为大写
2) lower 转换为小写
3) initcap 转换为首字母大写
4) length 取长度
5) lpad 左补丁
6) rpad 右补丁
7) replace 字符替换
8) trim 去除前后的空格
9) floor 取整
10）ceil 
将ename字段设置为10个长度 , 如果不够左边用“*”号补齐 
SQL> select lpad( ename , 10 , '*' ) from emp_xxx ;

ename字段设置为10个长度 , 如果不够右边用“#”号补齐
 SQL> select rpad( ename , 10 , '#' ) from emp_xxx ;

1.2.2.2. 数字函数： round / trunc / mod **
【案例3】求salary对5000取模 
SQL> select salary , mod( salary , 5000 ) from emp_xxx ;

1.2.2.3. 日期函数： months_between / add_months / last_day 
1) months_between 两个日期之间的月份数
2) add_months 给定一个日期 , 为该日期增加指定月份
3) last_day 找出参数时间点所在月份的最后一天

将amy的入职日期提前2个月
SQL> update emp_xxx set hiredate=add_months(hiredate , -2) where ename='amy';



子查询：

2.1. 单行比较运算符 > < >= <= = <>
注意
--比两条记录都大：all
--比任何一条大都行:any
  
--查询谁的薪水比所有叫tom的薪水都高
select ename from emp_xukai where salary >ALL(select salary from emp_xukai where ename='tom');
 --哪些和tom同部们的
select ename ,deptno from emp_xukai where deptno in (select deptno from emp_xukai where ename ='tom') and ename <> 'tom';
 --谁的薪水最高
select ename from emp_xukai where salary=( select max(salary) from emp_xukai);
--每个部们薪水最高的是谁
select ename ,salary ,deptno from emp_xukai where (deptno,salary  ) in (select deptno,max(salary) from emp_xukai group by deptno);

 
数据结构：  线性表 ，树，图，
范式： 1NF  2NF 3NF

 ＰＬ／ＳＱＬ　在数据库中编程
	包括：　funaction  函数
			procedure　过程
			package　　包
			trigger    触发器


=============================第三天==================================

select  distinct /列名/表达式/单行函数 /组函数
 from  表名  where 条件  (子查询) 1 or 条件2
				and   条件3
group  by 列名 
having  组函数的条件
order by 列名/列别名/表达式/组函数

select deptno ,count(*)  c  from emp_xukai group by  deptno 

一.子查询

二. 多表联合查询
 select emp_xukai.*,dept_xukai.* from emp_xukai join dept_xukai on emp_xukai.deptno =dept_xukai.deptno;
//使用别名简化 
 select e.*,d.* from emp_xukai e join dept_xukai d on e.deptno =d.deptno;

select e.ename,d.deptme,d.location from emp_xukai e join dept_xukai d on e.deptno=d.deptno;

 主键(PK) 和外键(FK)
 1) 主键(primary key ,简称Pk ) --主键要求不重复，不能是空值
 -- 主表/父表
 2) 外键（Foregign key ,简称 FK） --外键参照主键的数据
 --列值参照某个主键列值
 --从表/子表
 
 
 内连接 
  join关键字用于连接两个表
  -- 表1 join 表2 on 条件
  
  TOP－N  分析
  --薪水最高的三个人
 select empno ,ename ,salary from emp_xukai where salary is not null and rownum<4 order by salary desc;
  --rownum 伪列的作用
  --先排序，再取前三条
select * from (select empno, ename ,salary  from emp_xukai where salary is not null order by salary desc) where rownum<4;
--总分第一的学生
select stu.student_name ,sum(per.test_score) total_score
from t_student_xukai stu 
join t_performance_xukai per
on stu.student_id = per.student_id
where stu.class_id=1
group by stu.student_name
order by total_score desc;
--一班总分是第一的学生
select * from (select stu.student_name ,sum(per.test_score) total_score
from t_student_xukai stu 
join t_performance_xukai per
on stu.student_id = per.student_id
where stu.class_id=1
group by stu.student_name
order by total_score desc)where rownum<2;

--使用函数计算出一班总分的学生分数最高的分数
--v_total_score赋值为指定班的最高分
--赋值  :    值 into 变量
create or replace function maxScore_xukai(
p_class_id number
)
return number
is 
 v_total_score number;
begin
select total_score into v_total_score from (
select stu.student_name ,sum(per.test_score) total_score
from t_student_xukai stu 
join t_performance_xukai per
on stu.student_id = per.student_id
where stu.class_id=p_class_id
group by stu.student_name
order by total_score desc)where rownum<2;
	return v_total_score;
end;

输入 : / 提交函数
如果有错：show errors ;

使用： select maxScore_xukai(1) from dual;

--使用函数计算出一班总分的学生分数的那个人
select stu.student_name ,sum(per.test_score)
from t_student_xukai stu
join t_performance_xukai per
on stu.student_id = per.student_id
group by stu.student_name 
having sum(per.test_score)=maxscore_xukai(1);

--使用函数计算出一班总分的学生分数的那个人
create or replace function maxScore_xukai_id(
p_class_id number
)
return number
is 
 v_student_id number;
begin
select student_id into v_student_id from (
select stu.student_id , stu.student_name ,sum(per.test_score) total_score
from t_student_xukai stu 
join t_performance_xukai per
on stu.student_id = per.student_id
where stu.class_id=p_class_id
group by stu.student_id ,stu.student_name
order by total_score desc)where rownum<2;
	return v_student_id;
end;

select * from t_student_xukai where student_id=(select maxScore_xukai_id(1) from dual);

 
==============================第四天====================================================
一DML:
1.insert
完整语句：    insert into dept_xukai(deptno,dname,location) value (56,'research','beijing');
完整省略语句：insert into dept_xukai(55,'market','hangzhou');
复制表
1.复制全表
	create table 表名   as 查询语句;   (create  table table_name as select * from table_name_original;)
2.只复制表结构，不复制数据
	create table emp_xukai as select * from emp_xukai where 1<>1;
--或则 create table emp_xukai as select * from emp_xukai where 1=0;
3.复制一部分数据（给查询语句加条件）
如果复制表的查询语句中有表达式或者函数（包括单行函数和组函数），
必须指定新表中的列名指定方式：给列设置别名；或者在新表中设置列名
例如：--通过设置别名的方式，指定新表中的列名
create table emp_xukai_one as select empno,salary*12 year_sal --year_sal为新表的列名
from emp_xukai where deptno=10;

--清空表 ：delete from emp_xukai;
--查询一张表并插入到另一张复制了表结构的表
insert into emp_bak (select * from emp_xukai where deptno=20);
--复制一部分数据 
--通过在新表中设置列名的方式，指定新表中的列名
create table emp_xukai_one(did,emp_num) --新表的列名
 as select deptno,count(*) from emp_xukai grup by deptno;

--all_object表是数据库中本身就存在的表，记录这数据库中哪个帐户下一种建立什么表，
--对表的操作记录
SQL> desc all_objects;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 OWNER                                     NOT NULL VARCHAR2(30)
 OBJECT_NAME                               NOT NULL VARCHAR2(30)
 SUBOBJECT_NAME                                     VARCHAR2(30)
 OBJECT_ID                                 NOT NULL NUMBER
 DATA_OBJECT_ID                                     NUMBER
 OBJECT_TYPE                                        VARCHAR2(19)
 CREATED                                   NOT NULL DATE
 LAST_DDL_TIME                             NOT NULL DATE
 TIMESTAMP                                          VARCHAR2(19)
 STATUS                                             VARCHAR2(7)
 TEMPORARY                                          VARCHAR2(1)
 GENERATED                                          VARCHAR2(1)
 SECONDARY                                          VARCHAR2(1)

select count(*) from all_objects;

update(更新数据)
	update  表名  set 列名 = 新的列值 ，
      	 			 列名 ＝ 新的列值，
      	 			 ……
    where 条件 ； 
 
3.delete(删除数据) 
  delete tablename where condition(条件)
  注意：
  --如果删除语句中不加where 条件，将删除掉表中的全部记录
  --rollback回退,commit确认
  --drop table 会删除表结构和数据；truncate删除表数据,保留表结构.
  --drop和truncate都不可以回退。delete仅删除数据，可以回退
--去除重复的记录
	DROP TABLE emp_back_xukai;
  create table emp_back_xukai as select * from emp_xukai ;
  insert into emp_back_xukai (select * from emp_back_xukai); --创建有重复记录的表
  create table emp_back_xukai_new as (select  distinct * from emp_back_xukai );--没有重复数据的表
--数据的地址
 select empno, ename,salary,rowid from emp_xukai;

     EMPNO ENAME                    SALARY ROWID
---------- -------------------- ---------- ------------------
      1001 zhangwuji                 10000 AAAYkeAAEAADwykAAA
-- 按照行的地址排序，
select empno, ename,salary,max(rowid) from emp_back_xukai group by empno,ename,salary;
--将按照地址行排序的最大值以外的（重复的行数据）数据删除
delete emp_back_xukai where rowid not in(select max(rowid) from emp_back_xukai group by empno ,ename,salary);

rename 关键字
--将表名修改
rename emp_xukaituo to emp_xukaione;

rowid关键字 删除重复数据(比较简单，性能高)
1). rowid 是Oracle数据库的伪列，可以看作是一条数据库中的物理位置
2). rowid是Oracle数据独有的
select ename ,rowid from emp_xukai

========================事物========================
1) 事务是一组DML(insert/delete/update)操作的逻辑单元，用来保证数据的一致性。
2) 在一个事务内，，组成事物的这组DML操作，或者一起成功提交，或者一起销毁。
3）事务控制语言TCL(Transaction Control Language)
  commit     事物提交 将所有的数据改动提交
  rollback   事物回滚  回退到事物之初，数据的状态和事物开始之前完全一致
  savepoint  事物保存点(较不常用)
1.事物的开始和终止（事物边界）
1）事物的开始
   事物开始于上一个事物的终止的或者第一条DML语句
2) 事物终止
    事物终止于commit/rollback显示炒作（即控制台输入commit/rollback)
    如果连接关闭，事物（Transction)将隐式提交
    DDL操作(比如create) ,事物将隐式提交
    如果出现异常，事物将隐式回滚
2.事物中的数据状态
  1.如果多个会话操作同一张表的数据
  当用户与服务器建立连接成功后，服务器端Oracle将与客户端建立一个会话(Session)。
  客户端与Oracle的交互都是在这个会话环境中进行的
  Transaction演示
  步骤1:开启一个会话A，创建表并插入1条数据（注意：不提交）
  		(注意：测试时使用同一个用户在两个窗口中登录，比如openlab)
  步骤2:开启第2个会话B，在会话A进行commit之前，会话B只能查看表结构，查看不到数据
  步骤3:会话中进行commit操作后；会话B中就可以查找数据了
  步骤4:会话进行update 操作（没有commit),会话B看到的仍然是原先的数据
  步骤5:会话A提交 （commit)后，会话B看到被改变的结果
  步骤6:会话A进行update操作( 没有commit ) , 会话B进行delete操作时被挂起 , 因为试图操作相同的数据。
  步骤7:会话A提交( commit ) , 会话B结束阻塞状态 , 开始执行
  步骤8:会话A更新后进行回滚操作( rollback )
结论
1) 事务内部的数据改变只有在自己的会话中能够看到
2) 事务会对操作的数据加锁 , 不允许其它事务操作
3) 如果提交( commit )后 , 数据的改变被确认 , 则
   所有的会话都能看到被改变的结果 ;
   数据上的锁被释放 ;
   保存数据的临时空间被释放
4) 如果回滚( rollback ) , 则
   数据的改变被取消 ;
   数据上的锁被释放 ;
   临时空间被释放

Savepoint
设置保存点 , 可以回滚( rollback )到指定的保存点
例如：
SQL> create table mytemp_xxx( id number(4) ) ; --事务起点 
SQL> insert into mytemp_xxx values(3) ; 
SQL> savepoint A ; -- 设置保存点 , 名为A 
SQL> insert into mytemp_xxx values(4) ; 
SQL> savepoint B; -- 设置保存点 , 名为B 
SQL> insert into mytemp_xxx values(5) ;
SQL> rollback to A ; -- 回滚到保存点A , 注意：A之后的保存点全部被取消
 SQL> select * from mytemp_xxx ; --3被插入数据库 , 4、5没有被插入

 DDL操作
 数据定义语言DDL：create/drop/alter/truncate
 1.create(建表)
1).自定义表的列和数据类型
  create table 表名(
  	列名   列的数据类型，
  	……
  )
2).由一个现存的表复制表
create table 表名
as 查询语句;
2.drop( 删除结构和全部的表数据)
1)drop 语法结构:drop table  表名；

3.和表相关的数据字典
 1) user_tables 
    字段table_name    表名
 2) user_objects
 	字段created      表的创建时间
 例如：
 --找出所有11年12月7日后创建的表 
 SQL> select a.table_name,b.created from user_tables a join user_objects b on a.table_name = b.object_name where b.created > '7-DEC-11';
 --计算五个月之前创建的数据表的个数 
SQL> select count(a.table_name) from user_tables a join user_objects b on a.table_name = b.object_name where b.created < add_months(sysdate, -5);

4.truncate( 截取 , 截断 ) *
1) truncate保留表结构 , 删除表中所有数据
2) truncate操作不需提交( commit ) , 没有回退( rollback )的机会
3) 语法结构： truncate table 表名 ;
4) truncate不delete的区别：
   truncate在功能上等同于：delete + commit
   delete操作将删除数据存储到临时空间中 , 不直接删除 , 可以回退。
truncate操作直接删除 , 不占用临时空间 , 不能回退。

5.alter(修改结构)
1.add关键字
--添加列
alter table emp_xukai add(name char(10));

6.rename关键字
--将列名password修改为pwd  
alter table emp_xukai rename column password to pwd ;

7.modify关键字
--修改列的数据类型为pwd char(8)   
注意：--发大可以，如char(1)--->char(8)
	--缩小，需要考虑已经存在的数据的长度，不能小于该数
alter table emp_xukai modify(pwd char(8));
8.删除列
 alter table emp_xukai drop column pwd;
 
 -- 对表的修改列操作，需要rebuild 重够数据库，防止内存碎片
 设置数据库为自动提交
 set autocommit on
 SQL> insert into dept_xukai values(60,'a','b');
1 row created.
Commit complete.

 关闭自动提交 
 set autocommit off
 
 
======================DCL数据控制语言=========================== 
1) 当Oracle安装完毕 , 系统会提供2个默认账户： sys和system
	账户的密码在数据库安装时自定义输入
2) 数据库默认安装的账户( 做测试使用 )： scott账户 , 密码tiger
3) 中关村校区数据库账户： openlab/账户 , open123/密码
4) 数据库管理员可以新建若干账户 , 比如： exam/exam123

---------
scott/tiger --一般用户
system/manager --超级用户
sys/change-on-install --董事长

 --授权
 grant connect,resource to 用户名(userxukai) ;
 grant select on 表名  to 用户名(userxukai)
 --用户名(userxukai)查询又用户xukai授予的查看表 ，
 --select * from xukai.表名    ；  
 
 --取消授权
 revoke select on 表名 from 用户名(userxukai)
 --撤销权限
revoke dba from sd1209 ;
 
 
==================脚本文件===============
--文档
--源代码
--数据库脚本文件



--数据库的导入
1.windwos 操作系统
--在服务器端运行执行.sql脚步（脚本文件和sqlplus在同一台机器上）
sql> @ d:test.sql

2.Linux操作系统
1).--如果本地安装了sqlPlus时 
@ 192.168.0.23/tarena
 --使用 ＠加文件的路径文件
2).--如果本地没有安装sqlplus时
C:\>sqlplus openlab/open123@192.168.0.26:1521/tarena

登录orcale
sql>exit    --退出但是还连接数据库
或则：
--直接连接： telnet 192.168.0.23   
-- tarena/tarena   服务器的
[tarena@xstarena ~]$ vi xukai.sql
在vi中创建脚本文件
如建表语句
:wq   --保存退出
--注意：xukai.sql脚本在 orcale的服务器上
[tarena@xstarena ~]$ sqlplus
--登录oracle 数据库
SQL> @xukai.sql


--连接数据库的工具
--首选，命令行工具
   sqlplus
--图形化工具
pl/sql developer(非官方，免费)
toad(非官方，收费)
sql developer(官方，免费，11g以上)



====================================================
--补充练习：
procedure过程
PL/SQL:Procedure Language /SQL
函数：(function)
过程:(procedure)
包(package)
触发器(trigger)


--过程
--过程于函数的不同
   --函数不能独立运行，过程可以独立运行
   --关键字不同
   --函数必须有返回值
--实现：输入班号，输出最高分的学生名字和总成绩
create or replace procedure  cal_xukai(
	p_class_id in number,
	p_student_name out char,
	p_total_score out number
)
is
begin
select student_name ,total_score into p_student_name,p_total_score
 from (select stu.student_name ,sum(per.test_score) total_score
 from t_student_xukai stu join t_performance_xukai per on stu.student_id = per.student_id 
 where stu.class_id=p_class_id group by stu.student_name order by total_score desc)where rownum<2;
end ;
--使用
--匿名程序块，用来测试过程或函数
sql>set serveroutput on  --打开输出，默认值是off  
sql>declare
  p_student_name char(20);
  p_total_score number;
begin
    cal_xukai(1,p_student_name,p_total_score);
    dbms_output.put_line(p_student_name);
    dbms_output.put_line(p_total_score);
end ;

/
-- dbms_output.put_line(p_total_score);  与system.out.print("");

zhangsan
173

PL/SQL procedure successfully completed.


--替代变量可以使用&abc符号表示在运行时输入变量值
select * from emp_xukai where deptno=&abc;
--改进版，输入共多少班，输出每个班的最高成绩的学生姓名和总分
create or replace procedure  cal_xukai_procedure(
	p_class_num in number
)
is
p_student_name char(20);
p_total_score number;
begin
	for i in 1..p_class_num loop
select student_name ,total_score into p_student_name,p_total_score
 from (select stu.student_name ,sum(per.test_score) total_score
 from t_student_xukai stu join t_performance_xukai per on stu.student_id = per.student_id 
 where stu.class_id=i group by stu.student_name order by total_score desc)where rownum<2;
 dbms_output.put_line(p_student_name|| ', '|| p_total_score);
 end loop;
end;

sql>exec cal_xukai_procedure(2)


================================第5天======================================
约束条件
primary key   (PK)
foreign key   (FK)
not  null 简称  nn
unique 唯一   UK
check  检查  ck 

1.主键 --constraint
主键(Primary key,简称PK)
1)主键约束(primary key)=不能重复+不能为null
2)主键约束可以用两种方式定义:列级约束和表级约束
一.列级约束
  例如：
create table  student_xukai(
 id number(2) primary key ,
 name char(10)
);

--建表时，设置name列为not null约束
create table  student_xukai(
 id number(2) primary key ,
 name char(10) not null
);  

--创建时，给email 列创建唯一约束
drop table student_xukai;
create table  student_xukai(
 id number(2) primary key ,
 name char(10) not null,
 email char(30) unique
);
insert into student_xukai values(1,'xuikai','makegoodsecret@sina.com');
insert into student_xukai values(3,'xuikai','makegoodsecre@sina.com');
insert into student_xukai values(4,'xuikai','makegoodsect@sina.com');
insert into student_xukai values(5,'xuikai','makegoodset@sina.com');

drop table student_xukai;
create table  student_xukai(id number(2) primary key ,name char(10) not null,
email char(30) unique,
gender char(1) check (gender in('F','M')) --gender :性别，只允许:'M','F'
);
insert into student_xukai values (1,'xukai','xukai@sina.com','M');
--ok
insert into student_xukai values (2,'xukai','xukai1@sina.com','A');
--ORA-02290: check constraint (OPENLAB.SYS_C0074148) violated

某些数据库：主键自增长
			--mysql   /sql  server
orcale中实现主键发生器：序列

user_tables
user_objects
user_pro


--查看组建约束条件
select constraint_name constraint_type 
from user_constraints where table_name='STUDENT_XUKAI';
CONSTRAINT_NAME                C
------------------------------ -
SYS_C0074147                   C
SYS_C0074148                   C
SYS_C0074149                   P
SYS_C0074150                   U

--建表
 create table "Temp"(id number(1));   --在数据库中为 表Temp
 create table  temp (id number(2));   --在数据库中为表TEMP
 
drop table student_xukai;
--命名规则：表名_列名_约束条件的类型
--1.列级约束(约束条件由系统提供)
create table  student_xukai(
id number(2) constraint stu_xkqdh_id_pk primary key ,
name char(10) constraint stu_xkqdh_name_nn not null,
email char(30) constraint stu_xkqdh_email_uk unique,
gender char(1) constraint stu_xkqdh_gender_ck check (gender in('F','M'))
);
 
--2.建表时,建立表级约束
create table  student_xkqdh(
id number(2)   ,
name char(10) constraint stu_xkqdh_name_nn not null,
email char(30) ,
gender char(1) ,
constraint stu_xkqdh_id_pk primary key(id),
constraint stu_xkqdh_email_uk unique(email),
constraint stu_xkqdh_gender_ck check (gender in('F','M'))
);
--3.建表，除了非空以外的约束，全部放在建表后再建
drop table student_xkqdh;
create table  student_xkqdh(
id number(2)   ,
name char(10)  not null,
email char(30) ,
gender char(1) 
);
alter table student_xkqdh add constraint stu_xkqdh_id_pk primary key(id);
alter table student_xkqdh add constraint stu_xkqdh_email_uk unique(email);
alter table student_xkqdh add constraint stu_xkqdh_gender_ck check (gender in('F','M'));


--查询表的非空约束
select constraint_name ,constraint_type from user_constraints where table_name='STUDENT_XKQDH';

--专业表
create table major_xukai(
	id number(2) primary key,
	name char(20) not null
);

insert into major_xukai values(1,'java');
insert into major_xukai values(2,'web');
insert into major_xukai values(3,'android');
insert into major_xukai values(4,'C++');
insert into major_xukai values(5,'oracle');
commit;

create table student_xukais(
id number(4),
name char(10) not null,
mid number(2)
);
--添加pk
alter table student_xukais add constraint stu_xks_id_pk primary key (id);
--添加FK
alter table student_xukais add constraint stu_xks_mid_fk foreign key (mid) references major_xukai(id);
--删除FK
alter table student_xukais drop constraint stu_xks_mid_fk;

--把约束条件重建，加on delete set null
--当删除专业id=2时成功，把子表中所有专业2的学生，mid列设为空 ，该列设为null
alter table student_xukais add constraint stu_xks_mid_fk 
foreign key (mid) references major_xukai(id) on  delete set null ;
--删除主表中的数据级联删除子表中的数据
alter table student_xukais add constraint stu_xks_mid_fk 
foreign key (mid) references major_xukai(id) on  delete cascade ;

insert into student_xukais values(1,'xukai',1);
insert into student_xukais values(2,'x',2);
insert into student_xukais values(3,'xu',3);
--ok
insert into student_xukais values(6,'kai',6);
--ORA-02291: integrity constraint (OPENLAB.STU_XKS_MID_FK) violated - parent key not found

主键 PK  =Not Null +Unique
外键 FK :表间的一对多关系
非空  Not Null
唯一  Unique  (可以为空)
检查  Check
联合主键 
create table student_xukai_u(
	last_name char(20),
	first_name char(20),
	score number,
	age number(2)
);
--last_name,first_name的数据不唯一，但是这两列加在一起就唯一。
alter table student_xukai_u add constraint stu_ln_fn_pk_xukai primary key (last_name,first_name);

alter table student_xukai_u add constraint stu_age_ck_xukai check (age>17);


on  delete set null  
on delete cascade

--------------------begin--------------------------
1.删除所有的外键约束
alter table 表名 drop constraint 约束条件类型;
2.删除所有的表
 drop table 表名;
3.建表及建立约束
create tables 表名 .....
insert into 表名
alter table  表名   add  constraint.....
-------------------end----------------------------

1).table
2).view 视图
3).index 索引
4).Sequence序列

PL/SQL程序块
function  函数
procedure过程
package包(package和package body)
trigger  触发器

sysnonym同义词

1.视图
作用:
1).隐藏数据
2).简化查询
3).视图中不包含数据,只是基表的映射
--sql(select) 语句查询结果的映像
sql>create view v_emp_xukai as select deptno ,count(*) num from emp_xukai where deptno is not null group by deptno order by deptno;
--使用
sql>select * from v_emp_xukai;
--视图的使用(隐藏薪水)
create or replace view v_emp_xukai as select empno,ename,deptno,job from emp_xukai;
--创建试图,内容是每个部们的编号,名字,位置和在这个部们工作的员工人数
create or replace view v_emp_count_xukai as
select d.deptme,d.location ,count(e.empno) num 
from emp_xukai e join dept_xukai d on e.deptno=d.deptno group by d.deptme,d.location ;

select d.deptno,d.deptme,d.location,x.num
from dept_xukai d join(
 select deptno ,count(*) num from emp_xukai e group by deptno
) x
on d.deptno =x.deptno;
--删除视图
drop view v_emp_count_xukai;
2.索引 index
注意:
1.有利于查询,不利于插入和修改DML操作是阻碍作用
2.索引由 oracle Server自动维护
全表扫描 Full Table Scan (FTS)
1).如果某个列建立PK约束条件,索引自动建立
 CREATE TABLE student_xukai3(
id number PRIMARY KEY,
 name char(10)
)
--查找主键约束的名字
 select constraint_name from user_constraints where table_name='STUDENT_XUKAI3';

CONSTRAINT_NAME
------------------------------
SYS_C0075404
--索引自动创建,查找索引名字
select index_name from user_indexes where table_name ='STUDENT_XUKAI3';


--索引自动创建
insert into student_xukai values (1,'xukai');
建立如下结构的索引
id     地址
--------------
1      0XABCD
--如果按id查找,自动使用索引
select * from student_xukai where id=2;
--如果按id以外的列查,不会使用索引
select * from student_xukai where name='xukai';

2.手动创建索引
--经常做查询的列上手动创建索引
create index idx_stu_xukai3_name on student_xukai3(name);
insert into student_xukai3 values (1,'xukai');
3.删除索引
 drop index idx_stu_xukai3_name;
-------------------------------------------------------
3.序列   Sequence
create sequence seq_xukai;
select seq_xukai.nextval from dual;
insert into student_xukai3 values (seq_xukai.nextval,'xi');
--指定序列的开始位置
drop sequence seq_xukai;
create sequence seq_xukai start with 1000 increment by 9;
select seq_xukai.nextval from dual;
--  查询当前的序列值
select seq_xukai.currval from dual;

drop sequence mysequence;  
create sequence mysequence 
	   increment by 1 
	   start with  1  -- 起始位置
	   maxvalue   99999999999999999999   --系统能够产生的最大值是10^27
	   nocycle        -- 序列到达最大值也不循环到最小值
	   cache ;        -- 定义存放序列的内存块的大小，默认为20.对序列进行内存缓冲，可以改善序列的性能











