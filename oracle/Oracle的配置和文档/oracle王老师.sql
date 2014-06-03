

 --创建用户
create user xukai identified by m123 ;

--授权
grant connect,resource to xukai ;
grant select on emp to xukai ;

--连接
connect wy/m123 ;

--查询别人的表
select * from sd1209.emp ;

--复制别人的表
create table emp as select * from sd1209.emp ;

scott/tiger --一般用户
system/manager --超级用户
sys/change-on-install --董事长

--撤销权限
revoke dba from sd1209 ;

--查询当前用户拥有什么表
select * from tab where tabtype='TABLE' ;

create  --创建
alter   --修改
drop    --删除

第一范式
纯二维表

第二范式
消除了非主键依赖关系

第三范式
消除了函数依赖关系

--创建表
--字符串  char(10) varchar2(10) clob
--数字 number(10) number(5 , 2)
--日期 date
blob



create table student 
	(id varchar2(10) primary key, 
	name varchar2(10) not null , 
	sex char(2) check (sex in ('男', '女')), 
	birthday date , 
	sum number(3) check (sum>=0 and sum<=100),
	tid varchar2(10) references teacher(tid)
)

create table teacher (tid varchar2(10) primary key ,
	name varchar2(10) not null)


--查看表结构
desc emp ;

--修改表
--加一列
alter table employee add(job varchar2(3)) ;
alter table employee add constraint emp_pri primary key(eid) ;

--删一列
alter table employee drop column sss ;

--修改长度
alter table employee modify sss varchar2(20) ;

--修改数据类型(表中不能有记录)
alter table employee modify sss number(20) ;

--删除表
drop table employee ;

--插入数据
insert into teacher (tid ,name) values ('t001' , 'zhang3') ;
insert into student (id , name , sex , birthday ,tid) values ('s0001' , 'li4' ,'男','1995-02-02','t001') ;

哑元
dual 

函数
to_date
D------一周中的天
DAY---星期几
DD----一个月中的天
DDD--一年中的天
HH----小时
HH24--24小时
MI-----分钟
MM----月
MON---月的名字缩写
MONTH--月的名字
SS-------秒
YYYY---年

sysdate
to_char
to_number


select 列名(*) 
from 表名
where 条件
group by 列


条件
1=1

列 比 值
> < >= <=  between like

and or

列 in (多个返回值) not in  >all >any

查找没有参加培训的人员
查找参加培训的人员名单
查找java成绩在60到80分之间的人员名单
查找姓李的人（模糊查询）
select name from employee where name like '李%' ;
查找Java成绩最高的人

聚合函数
MAX
MIN
SUM
AVG
COUNT--忽略null
distinct消除重复

查找java成绩大于java平均成绩的人员
select name from employee where eid in 
	(select eid from training where course='java' and grade >
	(select AVG(grade) from training where course='java')) ;


统计每种工作的工资总额是多少？
显示平均工资大于2000的工作是什么？
找出每个部门的最高和最低工资？
找出每个工作的最高和最低工资？
选择部门30的雇员
列出所有办事员的姓名，编号和部门
找出佣金高于薪金的雇员
找出佣金高于薪金的60%的雇员
找出部门10中所有的经理和部门20中所有的办事员的详细资料
找出部门10中所有经理，部门20中所有办事员以及既不是经理又不是办事员但其薪金大于或等于2000的所有雇员的详细资料
找出收取佣金的雇员的不同工作

to_char
to_number
to_date

max
min
sum
avg
count

nvl  nvl2(cc , '1' , '0')

sysdate
add_months
last_day  某月的最后一天
months_between 两个日期之间的月数

create user
create table 
create sequence myseq
create synonym eee for emp ;
修改
update empp set sal=1000 where empno = 7369 ;

事务
行锁
select * from empp where empno = 7369 for update of sal ;
select * from empp where empno = 7369 for update of sal wait 10 ;
select * from empp where empno = 7369 for update of sal nowait ;

create table empp as select empno , ename ,job,sal from emp ;

表锁
--共享锁
lock table emp in share mode ;
--排他锁
lock table emp in exclusive mode ;
--共享更新锁
lock table emp in share update mode ;

数学函数
ABS  --绝对值
ceil   --天花板
floor --地板
round --中间
trunc --舍尾
mod  --%
power  --方

--视图
create view empview as select empno , ename , job , sal , deptno from emp ;
create view empview as select empno , ename , job , sal , deptno from emp with read only ;
create force view wyview as select *from abcd ;
create or replace view emp10 as select * from emp where deptno=10 with check option ;

--字符串函数
concat 或 ||  --字符串连接
length --字符串长度
initcap  lower  upper
lpad  rpad
trim   ltrim  rtrim
replace
translate
substr   instr
ACSII

--索引组织表
cretae table  ........organization index ---必须有主键
create index index1 on emp2(sal) ; --索引
create unique index index2 on emp2(ename) ; --唯一索引
create index index3 on emp2(job , ename) ;--组合索引
create index index4 on emp2(ename) reverse ; --反向索引，和索引组织表不能同时使用
create index index5 on emp2(ename) pctfree 30 ; B+树索引
create bitmap index index 6 on emp(deptno) ; --位图索引

----------------------------------SQL-92------------------------------------------------------------------------------
------------------------------PL/SQL---------------------------------------------------------------------------------
-- 九九乘法表
declare
i number ;
j number ;

begin
i := 1 ;

line varchar2(100) ;
loop 
	line := '' ;
	exit when i = 10 ;
	
	j := 1 ;
	loop 
	exit when j = 10 ;
	line := line || j ||'*'||i||'='||(i*j)||'  ' ;
	j := j + 1 ;
	end loop ;
	dbms_output.put_line(line) ;
	i := i + 1 ;
end loop ;
end ;
/

--系统异常
declare
mempno emp.empno%type ;
mdeptno emp.deptno%type ;

begin
mempno := '&empno' ;
select deptno into mdeptno from emp where empno = mempno ;

exception
when no_data_found then
	dbms_output.put_line('查询无返回值') ;
when too_many_rows then
	dbms_output.put_line('查询返回多个值') ;
when value_error then
	dbms_output.put_line('返回值和变量的类型不一致') ;
when others then
	dbms_output.put_line('其他错误') ;
end ;
/

--存储过程
create or replace procedure testpro(mempno emp.empno%type) is 
	mename emp.ename%type ;
	msal emp.sal%type ;
begin
	select ename , sal into mename , msal from emp where empno = mempno ;
	dbms_output.put_line(mename || '的工资是' || msal) ;
end ;
/

--执行
execute testpro(7369) ;

--使用行变量的存储过程
create or replace procedure testpro1(mempno emp.empno%type) is
	memprow emp%rowtype ;
begin
	select * into memprow from emp where empno = mempno ;
	dbms_output.put_line(memprow.ename || '的工资是' || memprow.sal) ;
end ;
/

--使用传出参数
create or replace procedure testpro2(mempno in emp.empno%type , mename out emp.ename%type , 
	msal out emp.sal%type) is
begin
	select ename , sal into mename , msal from emp where empno = mempno ;
end ;
/

--调用带传出参数的存储过程
declare 
	mename emp.ename%type ;
	msal emp.sal%type ;
begin
	testpro2(7369 , mename , msal) ;
	dbms_output.put_line(mename || '的工资是' || msal) ;
end ;
/

--存储函数
create or replace function testfunc(mempno emp.empno%type) return number is
	msal emp.sal%type ;
begin
	select sal into msal from emp where empno = mempno ;
	return msal ;
end ;
/

--调用存储函数
declare 
	msal emp.sal%type ;
begin
	msal := testfunc(7369) ;
	dbms_output.put_line(msal) ;
end ;
/

-- 游标
declare
	cursor mycur is select ename , sal from emp ;
	mename emp.ename%type ;
	msal emp.sal%type ;
begin
	if mycur%isopen then
		null ;
	else 
		open mycur ;
	end if ;
	fetch mycur into mename , msal ;
	while mycur%found
	loop
		dbms_output.put_line(mename ||'的工资是'||msal) ;
		fetch mycur into mename , msal ;
	end loop ;
	close mycur ;
end ;
/

--使用for访问游标
declare
	cursor mycur is select * from emp ;
begin
	for i in mycur 
	loop
		dbms_output.put_line(i.ename||'的工资是'||i.sal) ;
	end loop ;
end ;
/






