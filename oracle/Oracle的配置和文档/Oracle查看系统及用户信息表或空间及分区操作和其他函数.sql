--查询系统日志文件
SQL> select * from v$logfile;

--查询系统控制文件
SQL> select * from V$controlfile;

--查询系统数据文件
SQL> select * from v$datafile;

--查询日志文件状态
SQL> select * from v$log;

--查看日志归档模式
SQL> archive log list;

--查看后台进程
SQL> select * from v$bgprocess;
--查看回滚段的名称和大小
select segment_name, tablespace_name, r.status, 
(initial_extent/1024) InitialExtent,(next_extent/1024) NextExtent, 
max_extents, v.curext CurExtent
From dba_rollback_segs r, v$rollstat v
Where r.segment_id = v.usn(+)
order by segment_name ;

--查看正在使用的后台进程
SQL> select * from v$bgprocess where paddr<>'00';
--查看当前用户
SQL> show user;

--查看数据库所有的角色
SQL> select * from dba_roles;

--查看当前用户的角色(oracle9i2数据库sys初始角色27行)
SQL> select * from user_role_privs;

--查看当前用户的系统权限(oracle9i2数据库sys初始系统权限139行)
SQL> select * from user_sys_privs;

--查看当前用户的表级权限(oracle9i2数据库sys初始表级权限11834行)
SQL>select * from user_tab_privs;

--查看当前用户所有的表
SQL>select * from user_tables;

--查看数据库版本
SQL> select version from product_component_version where substr(PRODUCT,1,6)='Oracle';

--查看当前有多少数据库连接(以管理员身份查询)
SQL> select username,sid from v$session where serial#>1;

--查看系统日期
SQL> select sysdate from dual;

--查看当前有那些用户从那台机器连接到数据库
SQL> select machine,username,terminal from v$session order by machine;

--查看数据库SID
SQL> select name from v$database;
SQL>select instance_name from v$instance;

--查询数据库中所有的对象
SQL> select * from dba_objects;

--查看所有的数据库(管理员身份)
SQL> select * from v$database;

--查看当前用户对象
SQL> select * from user_objects;

--查看当前用户下所有表
SQL> select * from user_Objects where Object_type='TABLE';

--查看数据库创建日期和归档方式
SQL> Select Created, Log_Mode, Log_Mode From V$Database;

--查看数据库中所有的过程，函数和程序包
SQL> select object_name,object_type from user_objects 
2 where object_type in('PROCEDURE','FUNCTION','PACKAGE');
------------------------------------------------------
--Orcale标量函数与分析函数
------------------------------------------------------

---------------------日期函数------------------------

--返回当前日间加上指定月数后的日期值
SQL> select add_months(sysdate,2) from dual;

--返回两个日期之间的月数(如果两个时间的日期相同则返回整数，否则为小数，也可能是负数)
SQL> select months_between(sysdate,to_date('2006-6-27','yy-mm-dd')) from dual;

--返回指定日期所在月份的最后一天
SQL> select last_day(sysdate) from dual;

--返回指定日期的四舍五入值(四舍五入到最近的星期日)
--如果将参数‘day’该为‘year’将四舍五入到最近的年份如果晚于7月1日将到下一个年份
--如果将参数‘day’该为‘month’将四舍五入到最近的月份如果晚于15日将到下一个月份
SQL> select round(sysdate,'day') from dual;

--返回指定的下一个星期几的日期
SQL> select next_day(sysdate,'星期日') from dual;

--返回指定日期的特定部分
SQL> select extract(year from sysdate) from dual;

-- 修改会话的默认日期格式
ALTER SESSION SET nls_date_format = 'YYYY-MM-DD';

-- 显示日期和时间部分
ALTER SESSION SET nls_date_format = 'YYYY-MM-DD HH24:MI:SS';

-- 临时改变一下会话的默认语言, 以识别类似 '12-MAY-05' 的日期格式
alter session set nls_date_language = 'AMERICAN';

-- 改回简体中文语言：
alter session set nls_date_language = 'SIMPLIFIED CHINESE';

---------------------字符串函数------------------------

--首字母大写
SQL> select initcap('hello') from dual; Hello

--转换成小写
SQL> select lower('YangJuQi') from dual; yangjuqi

--转换成大写
SQL> select upper('Yangjuqi') from dual; YANGJUQI

--左裁剪
SQL> select ltrim('yangjuqi','yang') from dual; juqi

--右裁剪
SQL> select rtrim('yangjuqi','qi') from dual; yangju

--替换指定字符串中指定的字符 
SQL> select replace('yangjuqi','yang','aaaaa') from dual; aaaaajuqi

--查找字符位置
SQL> select instr('yangjuqi','j') from dual; 5

--取出指定位置的字符串
SQL> select substr('yangjuqi',5,2) from dual; ju

--连接两个字符串
SQL> select concat('accp','yangjjuqi') from dual; accpyangjuqi

---------------------数学函数------------------------

--返回绝对值
SQL> select abs(25.25) from dual;

--向上取整
SQL> select ceil(45.256) from dual;

--向下取整
SQL> select floor(125.365) from dual;

--正旋
SQL> select sin(2) from dual;

--余旋
SQL> select cos(2) from dual;

--m的n次方
SQL> select power(4,4) from dual;

--取余数
SQL> select mod(10,3) from dual;

--四舍五入(后面的参数是小数保留的位数，该例保留两位小数)
SQL> select round(120.258,2) from dual;

--截断(将小数位截断并不进行四舍五入，用法同上)
SQL> select trunc(120.268,2) from dual;

--开方
SQL> select sqrt(2) from dual;

--指数运算
Declare
I int;
Begin
I := 4**2; --指数运算
dbms_output.put_line(I);
End;

---------------------转换函数------------------------

--完整显示日期和时间
SQL> select to_char(sysdate,'YYYY"年"fmMM"月"fmDD"日" HH24:MI:SS') from dual;

--如果将空值转换成指定的值(如果第一个为null,返回第二个值)
SQL> select nvl(null,0) from dual;

--如果第一个值不为空返回第二个值，否则返回第三个值
SQL> select NVL2('A',0,1) from dual;

--如果两个值相等返回空值，否则返回第一个值
SQL> select nullif('a','b') from dual;

---------------------聚合函数------------------------

--平均值
SQL> select avg(empid) from tblemp;

--最大值
SQL> select max(empid) from tblemp;

--最小值
SQL> select min(empid) from tblemp;

--总合值
SQL> select sum(empid) from tblemp;

--总行数
SQL> select count(*) from tblemp;

---------------------分析函数------------------------

--根据某列排序并显示序号row_number() over(order by 列名 desc)
SQL> select t.*,row_number() over(order by empage desc) as 序号 from emp t;

--计算一个值在一组值中的排位rank() over (partition by 列名 order by 列名 desc) rank
SQL> select t.*,rank() over (partition by empsex order by empage desc) rank from emp t;

--分类排名dense_rank() over(partition by 列名 order by 列名 desc) 
SQL> select t.*, dense_rank() over (partition by class order by subject1 desc) 分类排名 from students t;

--将可能出现的空值通过nvl(列名,0)转换
SQL> select roll_no,name,class,nvl(subject1,0) subject1,nvl(subject2,0) subject2,nvl(subject3,0) subject3 from students;

-----------------------------------------------------------------------------------------
--oracle表空间及分区操作
-----------------------------------------------------------------------------------------
--创建表空间
create tablespace tp1
datafile 'd:\aa.dbf' size 5M
extent management local
uniform size 1M
;

--创建表空间
create tablespace myspace
datafile 'd:\aa.dbf' size 5M
extent management dictionary
default storage(
initial 100k
next 100k
pctincrease 10)
;

--创建一个名为stephen的用户,密码为stephen,使用的表空间为USERS
create user stephen 
identified by stephen
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

--删除表空间(表空间必须没有存储数据，如果有数据需要先删除数据)
drop tablespace myspace including contents and datafiles;

--查看表空间名称和大小及
SQL> select tablespace_name, file_name,
2 round(bytes/(1024*1024),0) total_space
3 from dba_data_files
4 order by tablespace_name
5 ;

--查看表空间
SQL> select * from dba_tablespaces;

--查看表空间的使用情况
select sum(bytes)/(1024*1024) as free_space,tablespace_name 
from dba_free_space
group by tablespace_name;

--范围分区
create table ta
(
aid number(2),
adate date not null,
aaddr varchar2(50)
)
PARTITION BY RANGE(adate)
( 
PARTITION sd1 VALUES LESS THAN (to_date('2001-01-01','yyyy-mm-dd')) tablespace tp1,
PARTITION sd2 VALUES LESS THAN (to_date('2002-01-01','yyyy-mm-dd')) tablespace tp2,
PARTITION sd3 VALUES LESS THAN (to_date('2003-01-01','yyyy-mm-dd')) tablespace tp3,
PARTITION sd4 VALUES LESS THAN (to_date('2004-01-01','yyyy-mm-dd')) tablespace tp4
)
;

--散列分区(hash分区)
CREATE TABLE tb
(
EmpID VARCHAR2 (5),
EmpName VARCHAR2 (15),
Department VARCHAR2 (10)
)
PARTITION BY HASH (EmpID)
(
PARTITION e1 tablespace tp1,
PARTITION e2 tablespace tp2,
PARTITION e3 tablespace tp3
);

--列表分区
CREATE TABLE tc
(
DepID varchar2 (5),
Dept_Name varchar2 (20)
)
PARTITION BY LIST (Dept_Name)
(
Partition D1 values ('会计部') tablespace tp1,
Partition D2 values ('管理层') tablespace tp2,
Partition D3 values ('人力资源部') tablespace tp3
);

--复合分区(范围分区和散列分区的结合)
CREATE TABLE td
(
Branch_ID varchar2 (5) not null,
Branch_name varchar2(10) not null,
Address varchar2(20)
)
PARTITION BY RANGE (Branch_Id)
SUBPARTITION BY HASH (Branch_name)
SUBPARTITIONS 2
(
PARTITION S1 values LESS THAN ('B005')
(SUBPARTITION sd1,SUBPARTITION sd2),
PARTITION S2 VALUES LESS THAN ('B010')
(SUBPARTITION sd3,SUBPARTITION sd4),
PARTITION S3 VALUES LESS THAN ('B015')
(SUBPARTITION sd5,SUBPARTITION sd6),
PARTITION S4 VALUES LESS THAN ('B020')
(SUBPARTITION sd7,SUBPARTITION sd8)
);

--根据表空间查询数据
SQL> select * from ta partition(sd1);