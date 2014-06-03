1.导入数据库
sql>set echo on --显示导入原始文件中的内容
sql>@text.sql   
sql>start text.sql
2.当前目录
例如：c:\Users\windos7\Desktop>sqlplus --那么当前目录就在桌面
案例：如果有一个脚本文件oracel_main.sql
oracel_main.sql文件中有如下脚本
/***********************************************************/
rem  filename:This is oracle_sql.sql --以rem 开头的行是注释行
@@oracle_a.sql
@@oracle_b.sql
/***********************************************************/
sql>d:\oracel_main.sql  --在桌面启动sqlplus  当前目录在桌面
执行后，会打开文件oracel_main.sql,‘@@’的作用是把当前路径切换成d盘
3.sql*plus当前会话中的各种设置的值
sql>set all   --查看当前会话的各种设置的值
4.sql*plus支持两种各自独立的变量类型：defines和绑定变量
1).define变量
sql>define x ="the answer is 42"  --自定义设置x
sql>define x                      --查看自定义是x
sql>select '&x' from dual         --如果变量是个字符串直接量，就需要在周围加上""
--(sql>define y=1 sql>select &y from sual) 
2).绑定变量
sql>variable  x varchar2(10)    --先声明变量
sql>begin                       --对变量赋值
:x :='hello';
end;
/
sql>print :x                    --使用print输出变量
--在这里有两个不同的变量"x" ,一个是定义出来的，一个是声明出来的
sql>select :x ,'&x' from dual;   -- 查看这两个变量

5.保存sql*plus当前会话sql命令到文件中
sql>spool report.sql --在当前的会话环境中创建一个report.sql的保存文件
sql>sql操作
sql>spool  off        --保存并写入report.sql文件中

6.退出数据库但是不退出 SQL*plus
sql>disconnect

7.调用编辑器(一旦你保存文件并推出编辑器，sql*plus会话会把编辑后的最新文件读到缓存中)
sql>edit   --默认会打开一个文件名叫afiedt.buf的文件（默认打开sql*plus最后一条语句）
sql>edit   abc.txt  --自己打开一个
--在这里oracle使用的外部编辑器
1).UNIX、Linux相关系统使用ed;
2).windos下使用的是写字板 （notepad）

8.数据库中显示错误的信息
sql>show errors
sql>sho err
sql>sho err errors for function 函数名  --指定出错的函数
sql>show errors function 函数名

SELECT ENAME ,JOB ,DNAME  FROM SCOTT.EMP,SCOTT.DEPT 
WHERE SAL BETWEEN 3000 AND 5000 AND EMP.DEPTNO = DEPT.DEPTNO;

select ename ,DNAME  from scott.emp ,scott.dept 
where dname in ('SALES' ,'RESEARCH')  AND EMP.DEPTNO = DEPT.DEPTNO;


 










