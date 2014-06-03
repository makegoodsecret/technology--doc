1.不要用"*"代替所有列名。
原因：Oracle系统会通过查询数据字典来将“*”转换成表的所有列名，这自然消耗系统时间。

2.用truncate 代替delete 

3.尽量减少表的查询次数
例1：不同语句效率的比较，查询同一表的情况
-- 低效率的select语句，子查询执行了两次，导致系统两次访问同一个表
select tab_name from table where 
 tab_name  =  (select tab_name from tab_colummns where version =604 ) 
 and 
 db_var = (select db_var from tab_columns where version =604) ;
-- 高效的select语句，将子查询合并在一起一次执行
select tab_name from tables where (tab_name,db_ver) = 
(select tab_name,db_ver from tab_columns where version  =604);
例2：update语句更新多个列的情况 
-- 低效的update语句，所更新的两个分别执行了两次子查询，所以效率低
update emp set 
emp_cat = (select max(category) from emp_categories) 
sal_range = (select max(sal_range) from emp_categories) 
where emp_dept = 0020;
-- 高效的update语句，将更新两个列合并在一起，由一个子查询完成
update emp set (emp_cat ,sal_range)  = (select max(category),max(sql_range ) from emp_categories ) where emp_dept=0020;

4.用not exists 替代not in 
在子查询中，not in 子句将执行一个内部的排序和合并，无论在哪种情况下，not in都是最低消的，
因为它对值查询中的表执行了一个全表便利。为了避免使用not in ,我们可以把它改写成外连接(outter joins) 或者使用not exists子句。
例子:使用not exists代替not in
select * from emp where  deptno not in 
 (select deptno from dept where dname like 'A%');

5.用exists替代distinct
-- distinct 语句
select distinct d.deptno ,d.dname from dept d,emp e where d.deptno  =e.deptno;
-- exists语句
select deptno ,dname from dept d 
where exists (select 'x'  from emp e where e.deptno  =d.deptno);


6.有效利用贡献游标
oracle数据库的贡献游标存在如下主要的优点。
1).降低和减少Oracle对SQL的解析数量;
2).动态调整内存；
3).提高内存的使用率;
sql语句的执行顺序
Open --> Parse  -->  Bind --> Execute --> Fetch --> Close 
			|			|		|		  |__|
			|			|	    |____________|
			|			|____________________|
			|________________________________|			

  在Parse阶段，数据库系统总是先到Share  Pool中查找需要执行的sql语句是否已经被缓存，
  因此在编写SQL语句时，相同查询范围和条件的SQL语句可能统一SQL语句的语法，包括SQL语句的大小写和空格及注释。
  完全相同的SQL语句被不同的数据库用户调用也将Oracle视为不同的SQL语句而被分别缓存。
  因此，我们推进啊==具有相同查询范围和结果以及条件的查询条件SQL语句。
  










