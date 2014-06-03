安装口令：XUkai0628
用户：scott  口令: ORACLE628xukai
开始，应用程序中的 "Oracle 11g" -> "应用程序开发" -> "Sql Developer 或Sql Plus" 连接。
1.  sql Developer
G:\oracle\app\windows7\product\11.2.0\dbhome_1\jdk\jre\bin\java.exe

集成管理工具(Wallet Manager)
口令:Walletoracle0



--Oracle基本命令
--sys(安装时没有设置密码)超级管理员登录
sql>conn sys/aaa as sysdba
c:> sqlplus "/ as sysdba"
sql>connect /as sysdba
--普通用户登录
scott 密码 :ORACLE628xukai
--使用sqlplus,只进入，不连接数据库
sqlplus /nolog
-- 显示当前用户
sql> show user
-- 显示Oracle全部的可帮助选项
sql> help index
-- 清屏
sql>clear screen
--spool命令将屏幕的显示输出到指定的文件中
sql>spool D:\log.txt
sql>select table_name from user_tables;
sql>spool off  
--使用默认的oracle sqlplus中缓存最后一条sql
sql>r
或
sql>/
-- @运行制定位置的sql脚步
sql>@D:\sql.sql
sql>@%oracle_home%\rdbms\admin\utlxplan.sql
-- @@为运行相对路径下
-- save 将当前sqplus缓冲区内的sql语句保持到指定的文件中
sql>save D:\sql.sql
--get将sqlplus中的sql语句插入到sqlplus缓冲区
sql>get c:\sql.sql
--  编辑当前缓冲区的语句cd 或edit



-- 创建表空间 （确保路径存在）
/*创建临时表空间*/
create temporary tablespace tbs_temp tempfile 'D:\Databases\Oracle\tabledbf\orcl\tbs_temp.dbf' size 50m autoextend on  next 50m maxsize 20480m extent management local;
/*创建数据表空间*/
create tablespace tbs_ptss 
datafile 'D:\Databases\Oracle\app\makesecret\oradata\orcl\tbs_ptss.dbf'
size 50m
autoextend on
next 50m maxsize 20480m
extent management local ;
/*创建用户并制定表空间*/
create user hsdbo2 identified by hsjt1113 
default tablespace tbs_ptss 
temporary tablespace tbs_temp ;
/*给用户授权*/
grant connect ,resource ,dba to hsdbo2 ;
	
--创建用户
create user xukai identified by secret; 
 --授权(创建用户但是没有授权默认会把该用户锁住)
 --connect(基本链接) 和resource(程序开发)
grant connect,resource to xukai ;

--1、系统权限分类：
--DBA: 拥有全部特权，是系统最高权限，只有DBA才可以创建数据库结构。
--RESOURCE:拥有Resource权限的用户只可以创建实体，不可以创建数据库结构。
--CONNECT:拥有Connect权限的用户只可以登录Oracle，不可以创建实体，不可以创建数据库结构。
--对于普通用户：授予connect, resource权限。
--对于DBA管理用户：授予connect，resource, dba权限。

--将表tblemp的所有操作权限授于aaa用户
SQL> grant all on tblemp to aaa;
grant create session to xiufeng; 登录窗口
grant create table to xiufeng; 创建表
grant unlimited tablespace to xiufeng; 使用表空间
----收回分配给用户的权限
SQL> revoke connect,resource from xukai;
--删除用户xukai（以管理员身份)
drop user xukai cascade; 
--用户test访问远程数据库实例ABC(连接本机去掉@ABC)
conn test/abc
--强制系统日志切换
SQL> alter system switch logfile
卸载:
1,关闭oracle所有的服务。
打开注册表：regedit
打开路径：
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\
删除该路径下的所有以oracle开始的服务名称

 

2,打开注册表
路径：
HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE
删除该oracle目录

3,删除注册表中关于oracle的事件日志注册项：
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Application\
删除以oracle开头的所有内容

4,删除环境变量path中关于oracle的内容。
重新启动操作系统
删除Oracle_Home下的所有数据
删除C:\Program Files下oracle目录

5,删除开始菜单下oracle项
C:\Documents and Settings\All Users\「开始」菜单\程序\Oracle - Ora92

--Orcale启动与关闭
------------------------------------------------------

--启动oracle数据库服务
net start oracleserviceora92

--启动oracle监听服务
lsnrctl start

--停止oracle监听服务
lsnrctl stop

--停止oracle数据库服务
net stop oracleserviceora92

--启动数据库
SQL> startup;

--挂接数据库（只启动参数文件，不能建立数据库）并显示SGA（system global area Oracle的内存空间结构）
SQL> startup nomount;

--加载控制文件（可以转存日志文件）
SQL> alter database mount;

--完全打开数据库
SQL> alter database open;

--强制启动数据库
SQL> startup force;

--关闭Oracle系统服务
SQL>shutdown;

--关闭数据库(等待事务完毕)
SQL> shutdown immediate;

--直接关闭数据库(不安全关闭数据库)
SQL> shutdown abort;

--断开当前连接
SQL> disconnect;

--创建表
SQL> create table tblemp (
 empid number(8,0) primary key,
 empname varchar2(30 char) not null,
 empemail varchar2(50 char) not null,
 empdate date,
 levelid number(8 ,0)
 )logging
nocompress
nocache; 
create sequence "XUKAI"."seq_emp" minvalue 0 maxvalue 100 increment by 1 start with 1 nocache noorder nocycle ; 
--插入数据
insert into tblemp values ("XUKAI"."seq_emp".nextval,'xukai','makegoodsecret@sina.com',to_date('1991-06-27','yy-mm-dd'),1);

--提交(增，删 ，改的时候需要提交)
commit;
--修改数据
SQL> update tbl_1 set semail='110' where sid=1;
--删除数据
SQL> delete from tbl_1 where sid=1;
--删除表中的全部数据(释放表空间)
truncate table tblstudent;
--查看表结构
SQL> desc tblstudent;
--为基表添加新列(为tbl_1表添加age列,数据类型number)
SQL> alter table tbl_1 add(age number(3));
--修改基表列定义
SQL> alter table tbl_1 modify(age number(2));
--删除表tbl_1及其所有的约束条件
drop table tbl_1 cascade constraints;
--执行文件(写好的sql代码)
SQL> @C:\1.sql execute;
--将表中的数据写入文件(如果指定的文件不存在，系统将新建文件)
SQL> spool c:\1.txt
SQL> select * from tt;
SQL> spool off
--在查询信息中 列出伪列rowid(行的内存地址)
SQL> select rowid,t.* from (select * from tblemp) t;

--分页查询数据(查询第6,7,8,9,10共5条记录)
SQL> select * from (select rownum rid,t.* from tblemp t where rownum <=10) where rid>5;

--向一个表中插入另一个表的记录
SQL> insert into t select * from tblemp;

--设置回滚点
SQL> savepoint tl;

--回滚事务
SQL> rollback;

--连接字符串
SQL> select '中国人'||'我也是' from dual;

--复制表结构
SQL> create table ttt as select * from emp where 1=2;
--查询其他用户的表
SQL> select * from yangjuqi.tblemp;

--创建同义词aaa_tblemp   需要sysdba权限
SQL> create synonym aaa_tblemp for yangjuqi.tblemp;

--通过同义词查询表tblemp
SQL> select * from aaa_tblemp;

--删除同义词
SQL> drop synonym aaa_tblemp;

--创建序列
SQL> create sequence ssl;

--创建序列(从100001开始每次加1)
SQL> create sequence list_1
2 start with 100001
3 increment by 1;

--创建序列
create sequence mysequence
increment by 2 --增长的幅度
start with 1 --基数
maxvalue 20 --最大值
cycle --允许循环
cache 2 --使用缓存

--查看序列的当前值
SQL> select ssl.currval from dual;

--查看序列的下一个值
SQL> select ssl.nextval from dual;

--删除序列
SQL> drop sequence ssl;

--创建视图
SQL> create or replace view view_1
2 as
3 select empname,empsex,empdate,empaddr,depname
4 from tblemp a,tbldep b
5 where a.depid=b.depid;

--重新编译视图(在视图修改后)
SQL> alter view view_1 compile;

--删除视图
SQL> drop view view_emp;

--创建唯一索引
SQL> create index index_s on tblss(ssdate);

--创建组合索引
SQL> create index index_s1 on tblss(ssname,ssdate);

--创建位图索引
SQL> create bitmap index bit_sex on tblss(sex);

--删除索引
SQL> drop index index_s;

--使用%rowcount进行修改和删除行统计
begin
update aaa set aaname='accp'
where aaid='1';
Dbms_Output.put_line('更新了' || sql%rowcount || '行');
end;
commit;
--定义时间戳类型数据
declare
date_1 timestamp with time zone; --声明一个变量为时间戳类型
begin
date_1:=to_timestamp_tz('2006-09-30 09:02:01','yyyy-mm-dd hh:mi:ss');
dbms_output.put_line(date_1); --输出语句
end;

--大字符类型clob操作
create table tblb
(
bid number(4),
bname varchar(20),
bmsg clob
)

insert into tblb values (2,'aaa','我爱你美丽的上海');
commit

declare
str clob;
strs varchar2(255); --定义一个字符串类型变量，用于存放clob类型的内容
length int:=255; --读取255个字符的数据
startfrom int:=1; --一次读取一个字符
begin
select bmsg into str from tblb where bid=2;
--使用dbms_lob.read()方法读取clob数据
dbms_lob.read(str,length,startfrom,strs);
dbms_output.put_line(strs);
end;

--自定义类型的使用(面向对象)
create or replace type ADDRESS_1 as object(
shengfen varchar2(20),
chengshi varchar2(20),
jiedao varchar2(20)
)

declare
a address_1:=address_1('陕西省','西安市','南二环东段');
begin
dbms_output.put_line('省份(shengfen):' || a.shengfen);
dbms_output.put_line('城市(chengshi):' || a.chengshi);
dbms_output.put_line('街道(jiedao):' || a.jiedao);
end;

--引用类型(%type)列引用
declare
name_1 tblemp.empname%type;--指定变量name_1和tblemp.empname是同一个类型，具体是是么类型则不声明
begin
select empname into name_1 from tblemp where empid=7;
dbms_output.put_line(name_1);
end;

--引用类型(%rowtype)行引用
declare
cursor my_cur is select * from tblemp;
--cursor定义的是显式游标，手动打开关闭；sql是隐式游标，自动打开关闭()
myrs tblemp%rowtype;--myrs是一个对象，包含一个表中某一行的各字段的值
begin
open my_cur;
loop
fetch my_cur into myrs;--用游标将指向的记录的各字段值赋给myrs
dbms_output.put_line(myrs.empname);--输出myrs的empname属性的值
exit when my_cur%notfound;--loop循环中的满足条件退出循环语句
end loop;
dbms_output.put_line('The count of rs are:' || my_cur%rowcount);--rowcount为游标四个属性之一
close my_cur;
end;

--异常处理
declare
empname tblemp.empname%type;
begin
--查询一条不存在的记录并赋值，赋值失败
select empname into empname from tblemp where empid=200; 
--本语句的结果集中若不足或超过1条记录则报错，因为要把记录的某一字段的值赋给变量
exception
when no_data_found then--捕获异常
dbms_output.put_line('没有找到记录，赋值失败!');
end;

--自定义异常
declare
money tblemp.money%type;
myexp exception;--自定义异常类型
begin
select money into money from tblemp where empid=100;
if money<5000 then 
raise myexp;--raise关键字用于抛异常
end if;
exception--异常捕获和处理
when no_data_found then--异常类型no_data_found
dbms_output.put_line('没有找到数据!');
when myexp then--异常类型myexp
dbms_output.put_line('money的值太小!');
end;

--自定义异常编号
declare
null_money exception; --声明自定义异常
pragma exception_init(null_money,-20001);--将自定义异常和异常编号绑定
begin
declare
c_money number;
begin
select money into c_money from tblemp where empid=&empid;--从键盘获取参数
if c_money is null then
--如果查询结果为空，抛出异常
raise_application_error(-20001,'error');
else
dbms_output.put_line('有工资');
end if;
end;
exception
when null_money then
dbms_output.put_line('不知道工资');
end;

--隐式游标(sql%)--特点：1自动打开，自动关闭 2只应用于查询语句 3有sql%notfound sql%found sql%isopen sql%rowcount 四种属性
begin
delete from tblemp where empid=15;
if sql%notfound then
dbms_output.put_line('没有找到数据');
else
dbms_output.put_line('找到并删除！');
end if;
end;

declare
money tblemp.money%type;
begin
select money into money from tblemp where empid=14;
if sql%rowcount=1 then
dbms_output.put_line('工资是：' || money);
else
dbms_output.put_line('查询出多条记录！');
end if;
exception
when no_data_found then
dbms_output.put_line('没有任何数据！');
end;

--显式游标
declare
addmoney int:=100;
cursor myemp is select empname from tblemp; --声明游标
myname tblemp.empname%type;
begin
open myemp; --打开游标
loop
fetch myemp into myname; --使用游标循环更新数据
update tblemp set money=money+addmoney where empname=myname;
--addmoney:=addmoney+100;
exit when myemp%notfound;
end loop;
dbms_output.put_line('工资已经递增更新！');
close myemp; --关闭游标
end;

commit

declare
cursor test is select * from tblemp where empname='寇勇';
myrs tblemp%rowtype; --引用类型，行类型
begin
open test;
loop
fetch test into myrs;
exit when test%notfound;
end loop;
dbms_output.put_line('表中共有：'||test%rowcount);
close test;
end;

--循环游标(自动打开和关闭)
declare 
cursor mycur is select depid from tblemp; 
ind number:=0;
begin
for rsc in mycur
loop
ind:=ind+1;
end loop;
dbms_output.put_line('总共有记录:'||ind);
end;

create table temp
(
empid number(4),
empname varchar2(30),
money number
)

declare
cursor emp_cur is select empid,empname,money from tblemp;
begin 
for ss in emp_cur loop
insert into temp values(ss.empid,ss.empname,ss.money);
end loop;
end;

select * from temp;

--触发器(表级触发器)
create or replace trigger mytrigger
before insert or update of money --当插入或更新影响到money列的时候触发
on tblemp
referencing old as old_value --old和new 是oracle的特殊表相当于sqlserver的inserted 和deleted
new as new_value
for each row
when (new_value.empid>10)
begin
dbms_output.put_line('打印一句话');
end;

update tblemp set money=2900 where empid=12

--触发器(插入，更新，删除)
create or replace trigger trigger_2
before insert or update or delete
on tblemp
referencing new as new_value
for each row --每执行一行都触发
begin
dbms_output.put_line(:new_value.empname);--宿主变量
dbms_output.put_line(:old.empname); 
end;

select * from tblemp;

insert into tblemp values (17,'党小东',1,to_date('1979-10-25','yyyy-mm-dd'),'陕西省周至县',4,2680);
update tblemp set money=5600 where empid=15;
delete from tblemp where empid=17

--触发器(判断用户权限)
create or replace trigger trigger_3
before insert or update or delete
on tblemp
begin
if user not in('YANGJUQI') then --如果当前用户不是YANGJUQI就抛出系统异常
raise_application_error(-20008,'您无权修改该表记录!');
end if;
end;

update tblemp set money=5800 where empid=15;

--删除触发器
drop trigger trigger_1;

--禁用
alter trigger trigger_1 disable;

--启用
alter trigger trigger_1 enable;

--禁用一张表上的所有触发器
alter table tblemp disable all triggers;

--启用一个表的所有触发器
alter table tblemp enable all triggers;

--查看所有用户触发器信息
select * from user_triggers;

--引用游标(ref 无返回值)
declare
type r1_cur is ref cursor;--定义一个游标类型
var1 r1_cur;--定义一个游标对象
ono varchar2(30);
no number;
qord number;
begin
no:='&no';--从键盘接收值
if no=1 then

open var1 for select empname from tblemp where empid=14;--将游标和sql语句绑定
fetch var1 into ono;
dbms_output.put_line('姓名是:'||ono);
close var1;
else 
open var1 for select money from tblemp where empid=12;

loop
fetch var1 into qord;
exit when var1%notfound;
dbms_output.put_line('工资是：'||qord);
end loop; 
close var1;
end if;
end;

--引用游标(ref 有返回值)
declare
--定义一个记录类型
type ordertype is record(
depid number(2),
dname varchar(14));
order_rec ordertype;

type ordercur is ref cursor return tbldep%rowtype;
order_cv ordercur;

begin 
--通过游标将查询出的结果便利并显示出来
open order_cv for
select * from tbldep
where depid=3;
loop
fetch order_cv into order_rec;
exit when order_cv%notfound;
dbms_output.put_line('这些值是'|| order_rec.depid ||' ' || order_rec.dname );
end loop;
close order_cv;
end;

--过程(无返回值)
create or replace procedure UpdateMoney(per number,var_empid number)
is 
empname tblemp.empname%type;
money tblemp.money%type;
oldmoney tblemp.money%type;
begin
--保存原来的工资
select money into oldmoney from tblemp where empid=var_empid;
--根据参数更新员工的工资
update tblemp set money=money+(money*per) where empid=var_empid;
--获得更新后的工资
select empname,money into empname,money from tblemp where empid=var_empid;
--输出原来的工资和更新后的工资
dbms_output.put_line(empname || '原来的工资是：￥'|| oldmoney || ',更新后的工资是：￥'|| money);
exception 
when no_data_found then
dbms_output.put_line('没有找到数据!');
end;

--(在命令窗口)执行过程
execute UpdateMoney(0.2,1);

--函数(有返回值而且必须返回值)
create or replace function 
fhanshu(a out int,b int) return int
as
begin
a:=a+1;
return b+1;
end fhanshu;

--执行函数
declare
a int:=10;
c int;
begin
c:=fhanshu(a,10);
dbms_output.put_line(c);
dbms_output.put_line('a>>'||a);
end;

--程序包的创建和使用

--创建程序包主体-----------第一步
create or replace package testpak 
is
n int:=10;
procedure mysub(n int);
function myfunc(n int) return varchar2;
end testpak;

--创建程序包主体，包体中的资源都是私有的----------第二步
create or replace package body testpak
as
procedure mysub(n int)
is
begin
dbms_output.put_line(n*n);
end mysub;

function myfunc(n int) return varchar2
is
begin
return n+1;
end myfunc;
end testpak;

--调用包中的过程和方法----------第三步
declare
begin
testpak.mysub(10);
end;

--调用包中的函数---------------第四步
declare
c varchar2(20);
begin
c:=testpak.myfunc(2);
dbms_output.put_line(c);
end;

--基于游标(有问题，需要处理)
create or replace package cur_pack is
cursor tbldep_cur return tbldep%rowtype;
procedure showNo(var_tbldepno int);
end cur_pack;
/

create or replace package body cur_pack
is
cursor tbldep_cur return tbldep%rowtype is select * from tbldep;
procedure showNo(var_tbldepno int) is
tbldep tbldep%rowtype;
begin
open tbldep_cur;
loop
fetch tbldep_cur into tbldep;
exit when tbldep_cur%notfound;
dbms_output.put_line(tbldep.dname);
end loop;
end showNo;
end cur_pack;
/

exec cur_pack.showNo(1);
/

--dbms_output包
declare 
buf varchar2(255);
st integer;
begin
--dbms_output.enable(100000);--缓冲区大小
--dbms_output.put_line('welcome');
--dbms_output.put('to');
--dbms_output.put('xf');
--dbms_output.new_line; --换行输出(光标定位于下一行)
--dbms_output.put_line('center'); 
--dbms_output.get_line(buf,st); 
--dbms_output.put_line(buf);
--dbms_output.put_line(st);
end;

------------------------------------------------------------------------------------------
-- Oracle流程控制
------------------------------------------------------------------------------------------

--条件语句(if)
--使用(变量 数据类型：=值)的方法赋值
--使用(变量 || '字符')的类型连接字符串
declare
n1 int:=10;
n2 int:=5;
begin
if n1>n2 then
dbms_output.put_line(n1 || '>' || n2);
else
dbms_output.put_line(n1 || '<' || n2);
end if;
end;

--条件语句(case)
declare
a int:=100;
b int:=200;
po char:='/';
begin
case po
when '*' then dbms_output.put_line(a*b);
when '/' then dbms_output.put_line(a/b);
when '+' then dbms_output.put_line(a+b);
when '-' then dbms_output.put_line(a-b);
else dbms_output.put_line('不能计算');
end case;
end;

--使用条件语句case返回数据
SELECT avg(case 
when a.money > 3000 THEN a.money
when a.money > 4000 then 4000
when a.money > 5000 then 5000 
else 0
end) "平均工资" 
from tblemp a

--循环语句(for)
declare 
i int:=1;
n int:=0;
begin
for i in reverse 1..10--这里reverse的意思是i的取值反过来，即从10到1(可以不使用)
loop
n:=n+1;
dbms_output.put_line(n);
end loop;
end;

--循环语句(loop)
declare
i number:=100;
begin
loop
i:=i+10;
dbms_output.put_line(i);
exit when i=200;
end loop;
dbms_output.put_line('---------');
dbms_output.put_line(i);
end;

--循环语句(while)
declare
a number:=100;
begin
while a<250
loop
a:=a+25;
end loop;
dbms_output.put_line(to_char(a));
end;

