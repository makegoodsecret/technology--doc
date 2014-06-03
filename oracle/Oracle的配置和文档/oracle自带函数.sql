字符函数

1.ASCLL(c1)    c1为字符串，返回c1第一个字母的ASCII吗。
select ASCII('A')  BIG_A  from scott.emp;
---结果--
BIG_A
65

2.CHR(i)
i表示一个数字，该函数返回十进制表示的字符
select  CHR(65)  from scott.emp;
--结果--
A

3.CONCAT  (c1,c2)
c1,c2均为字符串，该函数将c2连接到c1的后面，如果两个都为null则返回null.

4.INITCAP(c1)
c1为字符串,该函数将每个单词的第一字母大写，其他字母小写返回。单词由空格、空字符、标点符号限制。
select  INITCAP('veni,vedi,vici') Ceasar  from dual ;
-------Ceasar-----------------------------------------
Veni,Veni,Vici 

5.INSTR(c1,c2,[,i[,j]])
c1,c2均为字符，ij为整数。该函数返回c2在c1中第j次出现的位置，搜索从c1的第i个字符开始。
当没有发现所需要的字符时，则返回0；如果i为负数，那么搜索将从右到左进行，i和j的默认只为1.
select INSTR('Mississippi','i',3,3) from dual;
---------------------结果 11

6.INSTRB(c1,c2,[,i[,j]])   只是这里返回的是字节，对于单字节。

7.LENGTH(c1)
如果c1为字符串，则返回c1的长度；如果c1为null,那么将返回null。
select  LENGTH('Ipso Facto') ergo from dual ; ---10

8.LENGTHB()返回字节

9.LOWER(c)  返回c的小写字符，经常出现在where子串中。

10. LPAD(c1,i,c2)  
c1,c2均为字符串，i为整数。在c1的左侧用c2字符串补足长度i,可多次重复，如果i小c1的长度，
那么只返回长度为i的c1字符，其他的将被截去。
select  LPAD(job ,7 ,'abcdefg')  ,job    from scott.emp;
--LPAD(job ,7 ,'abcdefg')-----------------JOB---
abCLERK                               CLERK
SALESMA                               SALESMAN

11.LTRIM(c1,c2)
将c1中最左边的字符去掉，使其第一个字符不在c2中，如果没有c2，则c1就不会改变。
select  LTRIM('Mississippi','Mis') from dual ;
-----------------------ppi

12.RPAD(c1,i,c2)
在c1的右侧用c2字符串补足长度i,可以重复多次，如果i小于c1的长度，那么只返回长度为i的c1字符，
其他的将被截去。c2的默认值为单空格，其他的与LPAD相似。

13.RTRIM(c1[,c2])
将c1中最右边的字符去掉，使其最后一个字符不在c2中，如果没有c2，则c1就不会改变。

14.REPLACE(c1,[c2,c3])
c1,c2,c3都是字符串，此函数用c3代替出现在c1中c2后返回。
select REPLACE('uptown','up','down') from dual;

15.SUBSTR(c1,i[,j])
c1为一个字符串，i,j整数，从c1的第i位开始返回长度为j的字符串，如果j为空，则直到串的尾部。
select SUBSTR('MEssage' ,1,4)  from dual;

16.SUBSTRB(c1,i[,j])  只是i,j是以字节计算的。

17.SOUNDEX(c1)
返回与c1发音相似的词。
select  SOUNDEX('dawes') Dawes ,SOUNDEX('daws') Daws,SOUNDEX('dawson') Dawson  from dual;
Dawes   DAWS   DAWSON
------------------
D200    D200   D250

18.TRANSLATE(c1,c2,c3)
将c1中与c2相同的字符以c3代替。

19.TRIM(c1 from c2)
该函数用于从字符串的头部、尾部或两端截断特定字符，参数c1为要截去的字符，c2是源字符串。
select TRIM('A' from  'ABCDEF')  from dual;
-----BCDEF----
20.UPPER(c1) 
返回c1的大写，常出现在WHERE子串中。

数字函数(oracle数据库没有自定义的弧度计算公式)
1.ABS(n)
返回n的绝对值

2.ACOS(n)
反余弦函数，返回-1 到1之间的数，n表示弧度

3.ASIN(n)
反正弦函数，返回-1到1之间的数，表示弧度。

4.ATAN(n)
反正切函数，返回nd 反正切值，n表示弧度

5.CEIL(n)
返回大于或等于n的最小整数

6.COS(n)
返回n的余弦值，n为弧度

7.COSH(n)
返回n的双曲余弦值，n为数字
select COSH(1.4) from dual;

8.EXP(n)
返回e的n次幕，e=2.71828183。

9.FLOOR(n)
返回小于等于n的最大整数。

10.LN(n)
返回n的自然数对数，n必须大于0.

11.LOG(n1,n2)
返回以n1为底n2的对数。

12.MOD(n1,n2)
返回n1除以n2的余数

13.POWER(n1,n2)
返回n1的n2次方

14.ROUND(n1,n2)
返回舍入小数点右边n2位的n1的值，n2的默认值为0，返回与小数点最接近的整数，n2必须是整数。

15.SIGN(n)
如果n为负数，则返回-1,如果n为正数，则返回1;n=0返回0；

16.SIN(n)
返回n的正切值。n为弧度

17.SINH(n)
返回n的双曲正弦值

18.SQRT(n)
返回n的平方根，n表示弧度

19.TAN(n)
20.TANH(n)
21.TRUNC(n1,n2)
返回截尾到n2位小数的n1的值，n2默认设置为0，会将n1截尾为整数；
如果n2为负值，就截尾在小数点左边相应的位上。


日期函数
1.ADD_MONTHS(d,i)
返回日期d加上i个月后的结果，i可以是任意整数。如果i为小数，数据库会自动转换成整数，截去小数点后面的部分。
2.LAST_DAY(d)
此函数返回包含日期d月份的最后一天。
3.MONTHS_BETWEEN(d1,d2)
返回d1和d2之间月的数目，如果d1和d2的日期相同，或者都是该月的最后一天，那么将返回个整数；否则，返回的结果将包含一个分数。
4.NEW_TIME(da,tz1,tz2)
d1是日期数据类型，当时区 tz1中的日期和时间是d时，返回时区tz2中的日期和时间。tz1和tz2字符串。
5.NEXT_DAY(d,char)
该函数用于返回制定日期后的第一个工作日（由char指定）所对应的日期.
select next_day(sysdate,'星期一') from dual;
-----------18-11月-13-----------------
6.sysdate
此函数没有参数，返回当前日期和日期。
7.TRUNC(d,[fmt])
返回由fmt指定的单位的日期d.
(
1.select trunc(sysdate) from dual  --2011-3-18  今天的日期为2011-3-18
2.select trunc(sysdate, 'mm')   from   dual  --2011-3-1    返回当月第一天.
3.select trunc(sysdate,'yy') from dual  --2011-1-1       返回当年第一天
4.select trunc(sysdate,'dd') from dual  --2011-3-18    返回当前年月日
5.select trunc(sysdate,'yyyy') from dual  --2011-1-1   返回当年第一天
6.select trunc(sysdate,'d') from dual  --2011-3-13 (星期天)返回当前星期的第一天
7.select trunc(sysdate, 'hh') from dual   --2011-3-18 14:00:00   当前时间为14:41   
8.select trunc(sysdate, 'mi') from dual  --2011-3-18 14:41:00   TRUNC()函数没有秒的精确
)

组函数
1.AVG(column)           返回某列的平均值 
2.COUNT(column)         返回某列的行数（不包括 NULL 值） 
3.COUNT(*)              返回被选行数 
4.FIRST(column)         返回在指定的域中第一个记录的值 
5.LAST(column)          返回在指定的域中最后一个记录的值 
6.MAX(column)           返回某列的最高值 
7.MIN(column)           返回某列的最低值 
8.STDEV(column)         返回选择列表项目的标准差，所谓标准差是方差的平方根。
9.STDEVP(column)   
10.SUM(column) 			返回某列的总和 
11.VAR(column)   
12.VARP(column) 
13.VARIANCE(column)     返回选择列表项目的统计方差。

 
===============================复杂SELECT语句的使用=======================
集合操作
1.UNION 和UNION ALL操作
UNION 操作符用于获取两个或多个结果集的并集，当使用该操作符时，会自动去掉结果集中的重复行。
UNION ALL 返回查询所检索出的所有的行，包括重复的行。
例如：
查询销售部门(SALES)所有雇员的姓名(ENAME)和职位(JOB),以及职位是经理(MANAGER)的所有雇员的姓名和所在的部门（DNAME）。
select ename ,dname ,job from scott.emp e,  scott.dept d 
where e.deptno  = d.deptno 
and  dname  ='SALES'
UNION  
select ename ,dname ,job from scott.emp e  ,scott.dept d 
where e.deptno  =  d.deptno
and job  ='MANAGER'
order by dname;

2.(INTERSECT)操作
INTERSECT用于获取两个结果集的交集。当使用该操作时，只会显示同时存在于两个结果集中的数据。
select ename ,sal,job from scott.emp where sal>2500
INTERSECT
select ename ,sal,job from scott.emp where job='MANAGER'; 

3.差(MINUS)
MINUS 获取结果集的差集。
select ename ,sal, job  from scott.emp  where sal >2500 
MINUS
select ename ,sal  ,job from scott.emp where job  =  'MANAGER';

=============表的链接==================

1.基本的表连接

在from 子句中指定两张表，则这两张表就会合并在一起进行查询。
两张表的合并算法叫做笛卡尔乘积。
select dname from scott.emp e ,scott.dept d  
where e.ename = 'SMITH';
其笛卡尔乘积总所形成的行数等于两张表的行数相乘。
select count(*) from scott.emp;  ----14
select count(*) from scott.dept; ---4
select count(*) from scott.emp ,scott.dept; --56
注意：如果为表制定了别名，那么语句中的所有子句都必须使用别名，而不允许再使用实际的表名。

2.使用join链接

a.内连接   ---- inner join  可以忽略inner关键字  ,join关键字表示内连接。
使用内连接查询多个表时，在from子句中除了join关键字外，还必须定义一个on,
on子句指定内连接操作列出与连接条件的数据行。
例如：使用内连接查询 工作为CLERK的雇员信息和雇员所在的部门名称
select e.empno,e.job, e.ename ,d.dname
from scott.emp  e inner join scott.dept d  
on e.deptno  =  d.deptno  where e.job='CLERK' ; 

b.自然链接
自然连接与内连接的功能类似，在使用自然连接查询多个表时，oracle会将第一个表中的
那些列于第二个表中具有相同名称的列进行连接。在自然连接中，用户不需要明确指定进行连接的列，系统会自动完成这一任务。
使用关键字(natural join )
select e.empno ,e.job ,e.ename,d.dname 
from scott.emp e natural join scott.dept d 
where e.job ='CLERK';
注意：自然连接在实际的应用中很少，因为它有一个限制条件，即连接的各个表之间必须有相同名称的列，
而这在实际应用中可能和应用的实际含义发生矛盾。

c.外连接
使用内连接进行多表查询时，返回的查询结果集中仅包含符合查询条件
(where 搜索条件或having 条件)和连接条件的行。内连接消除了与另一个表中的任何行不
匹配的行，而外连接扩展了内连接的结果集，除返回所有匹配的行外，还会返回一部分或全部不匹配的行，这主要取决于外连接的种类。
外连接不只列出与连接条件相匹配的行，还列出左表（左外连接时)、右表（右外连接时）或两个表(全外连接时)
中所有符合搜索条件的数据行。
(去掉主外键约束)
INSERT INTO "SCOTT"."DEPT" VALUES ('2', 'OPERATIONS', 'hz');
INSERT INTO "SCOTT"."EMP" VALUES ('7939', 'MILLER', 'CLERK', '7782', TO_DATE('1982-01-23 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1300', null, '2');
delete from scott.dept  where deptno = '2'; 

c-1.左外连接(left outer join  或 left join)
select e.empno ,e.job ,e.ename,d.dname 
from scott.emp e left join scott.dept d 
on e.deptno  = d.deptno 
where e.job ='CLERK'; 
//会查出工作为CLERK的所有信息，而不管该员工是否有部门。

c-2.右外连接(right outer join 或 right join)
INSERT INTO "SCOTT"."DEPT" VALUES ('1', 'OPERATIONS', 'hz');
select e.empno ,e.job ,e.ename,d.dname 
from scott.emp e right join scott.dept d 
on e.deptno  = d.deptno 
where d.loc ='hz'; 
//会查询出所有的部门在hz的部门，不管该部门表中是否有员工

c-3.全外连接(full outer join  或 full join)
select e.empno ,e.job ,e.ename,d.dname 
from scott.emp e full join scott.dept d 
on e.deptno  = d.deptno 
where d.loc ='hz' or e.job ='CLERK'; 
//查询所有部门在hz，工作为clerk,二不管匹配表中是否有对应的数据.

c-4自连接
有时候，用户可能会拥有自引用式外键。自引用外键意味着表中的一列可以是
该表主键的一个外键。例如：员工的上级的id也与员工表存在相同的一列。
DROP TABLE "SCOTT"."EMPS";
CREATE TABLE "SCOTT"."EMPS" (
"EMPSNO" NUMBER(4) NOT NULL ,
"ENAMES" VARCHAR2(10 BYTE) NULL ,
"JOBS" VARCHAR2(9 BYTE) NULL ,
"MANAGERNO" NUMBER(4)   ,
"DEPTNO" NUMBER(2) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE
;
INSERT INTO "SCOTT"."EMPS" VALUES ('1', 'CUO', '总经理', '',  '10');
INSERT INTO "SCOTT"."EMPS" VALUES ('2', 'MILLE', 'jav开发', '1',  '10');
INSERT INTO "SCOTT"."EMPS" VALUES ('3', 'xukai', 'web开发', '2',  '10');

select e1.enames ,e1.managerno,e2.enames managername
from scott.emps e1  left join scott.emps e2
on   e2.empsno = e1.managerno  ;

子查询 
1.IN关键字
select  empsno 
from emps 
where empsno in( select empsno from emps where deptno = 10 );