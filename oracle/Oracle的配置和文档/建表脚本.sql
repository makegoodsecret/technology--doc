drop table t_student_xukai;
drop table t_assess_rule_xukai;
drop table t_subject_xukai;
drop table t_performance_xukai;

create table t_student_xukai(
student_id number(1) primary key,
class_id number(1),
student_name char(20)
);

create table t_assess_rule_xukai(
rule_id  number(1) primary key,
class_id number(1),
assess_type char(20),
scale number(2),desc1 char(20)
);

create table t_subject_xukai(
subject_id number(1) primary key,
subject_name char(10)
);

create table t_performance_xukai(
performance_id number(2) primary key ,
student_id number(1),
subject_id number(1),
test_score number(3),
check_in number(3),
task_scale number(3),
task_score number(3)
);
insert into t_student_xukai values(1,1,'liuyi');
insert into t_student_xukai values(2,1,'chengshan');
insert into t_student_xukai values(3,1,'zhangsan');
insert into t_student_xukai values(4,1,'lisi');
insert into t_student_xukai values(5,2,'wangwu');
insert into t_student_xukai values(6,2,'zhaoliu');
insert into  t_assess_rule_xukai values(1,1,'test_score',70,'chengji(guding)');
insert into  t_assess_rule_xukai values(2,1,'check_in',10,'kaoqing');
insert into  t_assess_rule_xukai values(3,1,'task_scale',10,'zuoyewenchenglv');
insert into  t_assess_rule_xukai values(4,1,'task_score',10,'zuoyechengji');
insert into  t_assess_rule_xukai values(5,2,'test_score',70,'chengji(guding)');
insert into  t_assess_rule_xukai values(6,2,'check_in',15,'kaoqing');
insert into  t_assess_rule_xukai values(7,2,'task_scale',15,'zuoyewenchenglv');
insert into  t_subject_xukai values(1,'yuwen');
insert into  t_subject_xukai values(2,'shuxue');
insert into t_performance_xukai values(1,1,1,90,100,100,90);
insert into t_performance_xukai values(2,1,2,67,100,100,78);
insert into t_performance_xukai values(3,2,1,71,100,100,80);
insert into t_performance_xukai values(4,2,2,100,100,100,95);
insert into t_performance_xukai values(5,3,1,85,100,100,90);
insert into t_performance_xukai values(6,3,2,88,100,100,90);
insert into t_performance_xukai values(7,4,1,81,100,100,90);
insert into t_performance_xukai values(8,4,2,78,100,100,88);
insert into t_performance_xukai values(9,5,1,63,95,100,66);
insert into t_performance_xukai values(10,5,2,87,95,100,90);
insert into t_performance_xukai values(11,6,1,84,91,100,82);
insert into t_performance_xukai values(12,6,2,72,91,100,70);
commit;



1.每班的人数
select class_id, count(*) from t_student_xukai group by class_id;
1.1 查询班级人数大于2的
select class_id ,count(*) from t_student_xukai group by class_id having  count(*)>2;
2. 每个班的成绩比例加起来是否＝100
select class_id ,sum(scale) as sums_cale from t_assess_rule_xukai group by class_id;
3.每个同学的总分？按总分由高到低排序 
select student_id , sum(test_score) as student_scale 
from t_performance_xukai group by student_id  order by student_scale desc;

 
一.子查询
--谁的总成绩比1号同学的总成绩高
select student_id ,sum(test_score) from t_performance_xukai group by student_id having sum(test_score)>(
select sum(test_score)  from t_performance_xukai where student_id  =1
);
 
--谁的薪水比公司的平均薪水低
select ename ,salary from emp_xukai where salary <(select avg(nvl(salary,0)) from emp_xukai );

--谁的薪水比本部门的平均薪水低
--关联子查询
select ename ,salary ,deptno from emp_xukai x where salary <(
	select avg(nvl(salary,0)) from emp_xukai where deptno =x.deptno
);
--谁的薪水比同经理的平均薪水低
select ename ,salary ,manager from emp_xukai x where salary<(
		select avg(nvl(salary,0)) from emp_xukai where manager  =x.manager
);
--哪些员工是别人的经理     exists
exists 关键字判断子查询有没有数据返回，有则为true ,没有则为false
exists 不关心子查询的结果，所以子查询中select后面写什么都可以
select empno, ename from emp_xukai x where exists (select ename from emp_xukai where manager =x.empno);

--哪些部们没有员工？
select deptno ,deptme,location from dept_xukai x where not exists (
	select 1 from emp_xukai where deptno =x.deptno
);

集合操作: union /union all
集合的交集：intersect
集合的差集：minus
select ename ,salary ,deptno from emp_xukai where deptno=10 union select ename, salary ,deptno from emp_xukai where salary >8000;

二. 多表联合查询
 t_student_xukai;
 t_assess_rule_xukai;
 t_subject_xukai;
 t_performance_xukai;
--查询学生的名字和成绩
select stu.student_name ,per.test_score
 from t_student_xukai stu join t_performance_xukai per 
 				on stu.student_id=per.student_id;
--查询学生名字和成绩和科目(三表主键关联查询)
select stu.student_name ,per.test_score,sb.subject_name
 from t_student_xukai stu join t_performance_xukai per 
 				on stu.student_id=per.student_id
 				join t_subject sb 
 				on per.subject_id=sb.subject_id;
 	
--查询1班学生的成绩
select stu.student_name ,per.test_score
 from t_student_xukai stu join t_performance_xukai per 
 				on stu.student_id=per.student_id where stu.class_id=1;				
--  一班学生的成绩的总分，并排序
select stu.student_name,
    sum(per.test_score) total_score 
from t_student_xukai stu 
    join t_performance_xukai per 
    on stu.student_id=per.student_id 
where stu.class_id=1 
   group by stu.student_name 
   order by total_score desc;
 --某个员工的上司的名字
select bmworker.ename ,bmmanager.ename
from emp_xukai  bmworker
join emp_xukai  bmmanager
on bmworker.manager =bmmanager.empno;
 				
 update emp_xukai set deptno=null   where ename='tom';
 				
 --内连接
 
 驱动表和匹配表
  表1 join  表2  on 条件
  1) 表1 叫做驱动表，表2叫做匹配表
  2) 等值连接方式下，驱动表和匹配表位置可以互换，不影响结果集 
  3）执行方式：不论谁做驱动表，都会遍历表，在匹配表中查找匹配数据
 				
外连接
1) 左外连接语法结构：表1 left outer join 表2 on 条件
2)右外连接语法结构：表1 right outer join 表2 on 条件
3）外连接的特征
   如果驱动表在匹配表中找不到匹配记录，则匹配一行空行
   外连接的结果集 ＝ 内连接的结果集＋驱动表在匹配表中匹配不上的记录和空值
   外连接的本质是驱动表中的数据一个都不能少
   			left outer join 以左边的表为驱动表
   			right outer join 以右边的表为驱动表
左外连接( 显示全部的 e.name)
select e.ename,d.deptme from emp_xukai e left outer join dept_xukai d on e.deptno =d.deptno;
右外连接
select e.ename,d.deptme from dept_xukai d right outer join emp_xukai e on e.deptno =d.deptno;
( 显示全部的 e.deptme)
select e.ename ,d.deptme from emp_xukai e right outer join dept_xukai d on e.deptno= d.deptno;
--外连接
--查询出部们表中没有员工的记录
select e.empno,e.ename,d.deptno,d.deptme,d.location 
from emp_xukai e
right outer join
dept_xukai d 
on e.deptno  =d.deptno 
where e.empno is null;


















