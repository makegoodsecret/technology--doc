��װ���XUkai0628
�û���scott  ����: ORACLE628xukai
��ʼ��Ӧ�ó����е� "Oracle 11g" -> "Ӧ�ó��򿪷�" -> "Sql Developer ��Sql Plus" ���ӡ�
1.  sql Developer
G:\oracle\app\windows7\product\11.2.0\dbhome_1\jdk\jre\bin\java.exe

���ɹ�����(Wallet Manager)
����:Walletoracle0



--Oracle��������
--sys(��װʱû����������)��������Ա��¼
sql>conn sys/aaa as sysdba
c:> sqlplus "/ as sysdba"
sql>connect /as sysdba
--��ͨ�û���¼
scott ���� :ORACLE628xukai
--ʹ��sqlplus,ֻ���룬���������ݿ�
sqlplus /nolog
-- ��ʾ��ǰ�û�
sql> show user
-- ��ʾOracleȫ���Ŀɰ���ѡ��
sql> help index
-- ����
sql>clear screen
--spool�����Ļ����ʾ�����ָ�����ļ���
sql>spool D:\log.txt
sql>select table_name from user_tables;
sql>spool off  
--ʹ��Ĭ�ϵ�oracle sqlplus�л������һ��sql
sql>r
��
sql>/
-- @�����ƶ�λ�õ�sql�Ų�
sql>@D:\sql.sql
sql>@%oracle_home%\rdbms\admin\utlxplan.sql
-- @@Ϊ�������·����
-- save ����ǰsqplus�������ڵ�sql��䱣�ֵ�ָ�����ļ���
sql>save D:\sql.sql
--get��sqlplus�е�sql�����뵽sqlplus������
sql>get c:\sql.sql
--  �༭��ǰ�����������cd ��edit



-- ������ռ� ��ȷ��·�����ڣ�
/*������ʱ��ռ�*/
create temporary tablespace tbs_temp tempfile 'D:\Databases\Oracle\tabledbf\orcl\tbs_temp.dbf' size 50m autoextend on  next 50m maxsize 20480m extent management local;
/*�������ݱ�ռ�*/
create tablespace tbs_ptss 
datafile 'D:\Databases\Oracle\app\makesecret\oradata\orcl\tbs_ptss.dbf'
size 50m
autoextend on
next 50m maxsize 20480m
extent management local ;
/*�����û����ƶ���ռ�*/
create user hsdbo2 identified by hsjt1113 
default tablespace tbs_ptss 
temporary tablespace tbs_temp ;
/*���û���Ȩ*/
grant connect ,resource ,dba to hsdbo2 ;
	
--�����û�
create user xukai identified by secret; 
 --��Ȩ(�����û�����û����ȨĬ�ϻ�Ѹ��û���ס)
 --connect(��������) ��resource(���򿪷�)
grant connect,resource to xukai ;

--1��ϵͳȨ�޷��ࣺ
--DBA: ӵ��ȫ����Ȩ����ϵͳ���Ȩ�ޣ�ֻ��DBA�ſ��Դ������ݿ�ṹ��
--RESOURCE:ӵ��ResourceȨ�޵��û�ֻ���Դ���ʵ�壬�����Դ������ݿ�ṹ��
--CONNECT:ӵ��ConnectȨ�޵��û�ֻ���Ե�¼Oracle�������Դ���ʵ�壬�����Դ������ݿ�ṹ��
--������ͨ�û�������connect, resourceȨ�ޡ�
--����DBA�����û�������connect��resource, dbaȨ�ޡ�

--����tblemp�����в���Ȩ������aaa�û�
SQL> grant all on tblemp to aaa;
grant create session to xiufeng; ��¼����
grant create table to xiufeng; ������
grant unlimited tablespace to xiufeng; ʹ�ñ�ռ�
----�ջط�����û���Ȩ��
SQL> revoke connect,resource from xukai;
--ɾ���û�xukai���Թ���Ա���)
drop user xukai cascade; 
--�û�test����Զ�����ݿ�ʵ��ABC(���ӱ���ȥ��@ABC)
conn test/abc
--ǿ��ϵͳ��־�л�
SQL> alter system switch logfile
ж��:
1,�ر�oracle���еķ���
��ע���regedit
��·����
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\
ɾ����·���µ�������oracle��ʼ�ķ�������

 

2,��ע���
·����
HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE
ɾ����oracleĿ¼

3,ɾ��ע����й���oracle���¼���־ע���
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Application\
ɾ����oracle��ͷ����������

4,ɾ����������path�й���oracle�����ݡ�
������������ϵͳ
ɾ��Oracle_Home�µ���������
ɾ��C:\Program Files��oracleĿ¼

5,ɾ����ʼ�˵���oracle��
C:\Documents and Settings\All Users\����ʼ���˵�\����\Oracle - Ora92

--Orcale������ر�
------------------------------------------------------

--����oracle���ݿ����
net start oracleserviceora92

--����oracle��������
lsnrctl start

--ֹͣoracle��������
lsnrctl stop

--ֹͣoracle���ݿ����
net stop oracleserviceora92

--�������ݿ�
SQL> startup;

--�ҽ����ݿ⣨ֻ���������ļ������ܽ������ݿ⣩����ʾSGA��system global area Oracle���ڴ�ռ�ṹ��
SQL> startup nomount;

--���ؿ����ļ�������ת����־�ļ���
SQL> alter database mount;

--��ȫ�����ݿ�
SQL> alter database open;

--ǿ���������ݿ�
SQL> startup force;

--�ر�Oracleϵͳ����
SQL>shutdown;

--�ر����ݿ�(�ȴ��������)
SQL> shutdown immediate;

--ֱ�ӹر����ݿ�(����ȫ�ر����ݿ�)
SQL> shutdown abort;

--�Ͽ���ǰ����
SQL> disconnect;

--������
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
--��������
insert into tblemp values ("XUKAI"."seq_emp".nextval,'xukai','makegoodsecret@sina.com',to_date('1991-06-27','yy-mm-dd'),1);

--�ύ(����ɾ ���ĵ�ʱ����Ҫ�ύ)
commit;
--�޸�����
SQL> update tbl_1 set semail='110' where sid=1;
--ɾ������
SQL> delete from tbl_1 where sid=1;
--ɾ�����е�ȫ������(�ͷű�ռ�)
truncate table tblstudent;
--�鿴��ṹ
SQL> desc tblstudent;
--Ϊ�����������(Ϊtbl_1�����age��,��������number)
SQL> alter table tbl_1 add(age number(3));
--�޸Ļ����ж���
SQL> alter table tbl_1 modify(age number(2));
--ɾ����tbl_1�������е�Լ������
drop table tbl_1 cascade constraints;
--ִ���ļ�(д�õ�sql����)
SQL> @C:\1.sql execute;
--�����е�����д���ļ�(���ָ�����ļ������ڣ�ϵͳ���½��ļ�)
SQL> spool c:\1.txt
SQL> select * from tt;
SQL> spool off
--�ڲ�ѯ��Ϣ�� �г�α��rowid(�е��ڴ��ַ)
SQL> select rowid,t.* from (select * from tblemp) t;

--��ҳ��ѯ����(��ѯ��6,7,8,9,10��5����¼)
SQL> select * from (select rownum rid,t.* from tblemp t where rownum <=10) where rid>5;

--��һ�����в�����һ����ļ�¼
SQL> insert into t select * from tblemp;

--���ûع���
SQL> savepoint tl;

--�ع�����
SQL> rollback;

--�����ַ���
SQL> select '�й���'||'��Ҳ��' from dual;

--���Ʊ�ṹ
SQL> create table ttt as select * from emp where 1=2;
--��ѯ�����û��ı�
SQL> select * from yangjuqi.tblemp;

--����ͬ���aaa_tblemp   ��ҪsysdbaȨ��
SQL> create synonym aaa_tblemp for yangjuqi.tblemp;

--ͨ��ͬ��ʲ�ѯ��tblemp
SQL> select * from aaa_tblemp;

--ɾ��ͬ���
SQL> drop synonym aaa_tblemp;

--��������
SQL> create sequence ssl;

--��������(��100001��ʼÿ�μ�1)
SQL> create sequence list_1
2 start with 100001
3 increment by 1;

--��������
create sequence mysequence
increment by 2 --�����ķ���
start with 1 --����
maxvalue 20 --���ֵ
cycle --����ѭ��
cache 2 --ʹ�û���

--�鿴���еĵ�ǰֵ
SQL> select ssl.currval from dual;

--�鿴���е���һ��ֵ
SQL> select ssl.nextval from dual;

--ɾ������
SQL> drop sequence ssl;

--������ͼ
SQL> create or replace view view_1
2 as
3 select empname,empsex,empdate,empaddr,depname
4 from tblemp a,tbldep b
5 where a.depid=b.depid;

--���±�����ͼ(����ͼ�޸ĺ�)
SQL> alter view view_1 compile;

--ɾ����ͼ
SQL> drop view view_emp;

--����Ψһ����
SQL> create index index_s on tblss(ssdate);

--�����������
SQL> create index index_s1 on tblss(ssname,ssdate);

--����λͼ����
SQL> create bitmap index bit_sex on tblss(sex);

--ɾ������
SQL> drop index index_s;

--ʹ��%rowcount�����޸ĺ�ɾ����ͳ��
begin
update aaa set aaname='accp'
where aaid='1';
Dbms_Output.put_line('������' || sql%rowcount || '��');
end;
commit;
--����ʱ�����������
declare
date_1 timestamp with time zone; --����һ������Ϊʱ�������
begin
date_1:=to_timestamp_tz('2006-09-30 09:02:01','yyyy-mm-dd hh:mi:ss');
dbms_output.put_line(date_1); --������
end;

--���ַ�����clob����
create table tblb
(
bid number(4),
bname varchar(20),
bmsg clob
)

insert into tblb values (2,'aaa','�Ұ����������Ϻ�');
commit

declare
str clob;
strs varchar2(255); --����һ���ַ������ͱ��������ڴ��clob���͵�����
length int:=255; --��ȡ255���ַ�������
startfrom int:=1; --һ�ζ�ȡһ���ַ�
begin
select bmsg into str from tblb where bid=2;
--ʹ��dbms_lob.read()������ȡclob����
dbms_lob.read(str,length,startfrom,strs);
dbms_output.put_line(strs);
end;

--�Զ������͵�ʹ��(�������)
create or replace type ADDRESS_1 as object(
shengfen varchar2(20),
chengshi varchar2(20),
jiedao varchar2(20)
)

declare
a address_1:=address_1('����ʡ','������','�϶�������');
begin
dbms_output.put_line('ʡ��(shengfen):' || a.shengfen);
dbms_output.put_line('����(chengshi):' || a.chengshi);
dbms_output.put_line('�ֵ�(jiedao):' || a.jiedao);
end;

--��������(%type)������
declare
name_1 tblemp.empname%type;--ָ������name_1��tblemp.empname��ͬһ�����ͣ���������ô����������
begin
select empname into name_1 from tblemp where empid=7;
dbms_output.put_line(name_1);
end;

--��������(%rowtype)������
declare
cursor my_cur is select * from tblemp;
--cursor���������ʽ�α꣬�ֶ��򿪹رգ�sql����ʽ�α꣬�Զ��򿪹ر�()
myrs tblemp%rowtype;--myrs��һ�����󣬰���һ������ĳһ�еĸ��ֶε�ֵ
begin
open my_cur;
loop
fetch my_cur into myrs;--���α꽫ָ��ļ�¼�ĸ��ֶ�ֵ����myrs
dbms_output.put_line(myrs.empname);--���myrs��empname���Ե�ֵ
exit when my_cur%notfound;--loopѭ���е����������˳�ѭ�����
end loop;
dbms_output.put_line('The count of rs are:' || my_cur%rowcount);--rowcountΪ�α��ĸ�����֮һ
close my_cur;
end;

--�쳣����
declare
empname tblemp.empname%type;
begin
--��ѯһ�������ڵļ�¼����ֵ����ֵʧ��
select empname into empname from tblemp where empid=200; 
--�����Ľ������������򳬹�1����¼�򱨴���ΪҪ�Ѽ�¼��ĳһ�ֶε�ֵ��������
exception
when no_data_found then--�����쳣
dbms_output.put_line('û���ҵ���¼����ֵʧ��!');
end;

--�Զ����쳣
declare
money tblemp.money%type;
myexp exception;--�Զ����쳣����
begin
select money into money from tblemp where empid=100;
if money<5000 then 
raise myexp;--raise�ؼ����������쳣
end if;
exception--�쳣����ʹ���
when no_data_found then--�쳣����no_data_found
dbms_output.put_line('û���ҵ�����!');
when myexp then--�쳣����myexp
dbms_output.put_line('money��ֵ̫С!');
end;

--�Զ����쳣���
declare
null_money exception; --�����Զ����쳣
pragma exception_init(null_money,-20001);--���Զ����쳣���쳣��Ű�
begin
declare
c_money number;
begin
select money into c_money from tblemp where empid=&empid;--�Ӽ��̻�ȡ����
if c_money is null then
--�����ѯ���Ϊ�գ��׳��쳣
raise_application_error(-20001,'error');
else
dbms_output.put_line('�й���');
end if;
end;
exception
when null_money then
dbms_output.put_line('��֪������');
end;

--��ʽ�α�(sql%)--�ص㣺1�Զ��򿪣��Զ��ر� 2ֻӦ���ڲ�ѯ��� 3��sql%notfound sql%found sql%isopen sql%rowcount ��������
begin
delete from tblemp where empid=15;
if sql%notfound then
dbms_output.put_line('û���ҵ�����');
else
dbms_output.put_line('�ҵ���ɾ����');
end if;
end;

declare
money tblemp.money%type;
begin
select money into money from tblemp where empid=14;
if sql%rowcount=1 then
dbms_output.put_line('�����ǣ�' || money);
else
dbms_output.put_line('��ѯ��������¼��');
end if;
exception
when no_data_found then
dbms_output.put_line('û���κ����ݣ�');
end;

--��ʽ�α�
declare
addmoney int:=100;
cursor myemp is select empname from tblemp; --�����α�
myname tblemp.empname%type;
begin
open myemp; --���α�
loop
fetch myemp into myname; --ʹ���α�ѭ����������
update tblemp set money=money+addmoney where empname=myname;
--addmoney:=addmoney+100;
exit when myemp%notfound;
end loop;
dbms_output.put_line('�����Ѿ��������£�');
close myemp; --�ر��α�
end;

commit

declare
cursor test is select * from tblemp where empname='����';
myrs tblemp%rowtype; --�������ͣ�������
begin
open test;
loop
fetch test into myrs;
exit when test%notfound;
end loop;
dbms_output.put_line('���й��У�'||test%rowcount);
close test;
end;

--ѭ���α�(�Զ��򿪺͹ر�)
declare 
cursor mycur is select depid from tblemp; 
ind number:=0;
begin
for rsc in mycur
loop
ind:=ind+1;
end loop;
dbms_output.put_line('�ܹ��м�¼:'||ind);
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

--������(��������)
create or replace trigger mytrigger
before insert or update of money --����������Ӱ�쵽money�е�ʱ�򴥷�
on tblemp
referencing old as old_value --old��new ��oracle��������൱��sqlserver��inserted ��deleted
new as new_value
for each row
when (new_value.empid>10)
begin
dbms_output.put_line('��ӡһ�仰');
end;

update tblemp set money=2900 where empid=12

--������(���룬���£�ɾ��)
create or replace trigger trigger_2
before insert or update or delete
on tblemp
referencing new as new_value
for each row --ÿִ��һ�ж�����
begin
dbms_output.put_line(:new_value.empname);--��������
dbms_output.put_line(:old.empname); 
end;

select * from tblemp;

insert into tblemp values (17,'��С��',1,to_date('1979-10-25','yyyy-mm-dd'),'����ʡ������',4,2680);
update tblemp set money=5600 where empid=15;
delete from tblemp where empid=17

--������(�ж��û�Ȩ��)
create or replace trigger trigger_3
before insert or update or delete
on tblemp
begin
if user not in('YANGJUQI') then --�����ǰ�û�����YANGJUQI���׳�ϵͳ�쳣
raise_application_error(-20008,'����Ȩ�޸ĸñ��¼!');
end if;
end;

update tblemp set money=5800 where empid=15;

--ɾ��������
drop trigger trigger_1;

--����
alter trigger trigger_1 disable;

--����
alter trigger trigger_1 enable;

--����һ�ű��ϵ����д�����
alter table tblemp disable all triggers;

--����һ��������д�����
alter table tblemp enable all triggers;

--�鿴�����û���������Ϣ
select * from user_triggers;

--�����α�(ref �޷���ֵ)
declare
type r1_cur is ref cursor;--����һ���α�����
var1 r1_cur;--����һ���α����
ono varchar2(30);
no number;
qord number;
begin
no:='&no';--�Ӽ��̽���ֵ
if no=1 then

open var1 for select empname from tblemp where empid=14;--���α��sql����
fetch var1 into ono;
dbms_output.put_line('������:'||ono);
close var1;
else 
open var1 for select money from tblemp where empid=12;

loop
fetch var1 into qord;
exit when var1%notfound;
dbms_output.put_line('�����ǣ�'||qord);
end loop; 
close var1;
end if;
end;

--�����α�(ref �з���ֵ)
declare
--����һ����¼����
type ordertype is record(
depid number(2),
dname varchar(14));
order_rec ordertype;

type ordercur is ref cursor return tbldep%rowtype;
order_cv ordercur;

begin 
--ͨ���α꽫��ѯ���Ľ����������ʾ����
open order_cv for
select * from tbldep
where depid=3;
loop
fetch order_cv into order_rec;
exit when order_cv%notfound;
dbms_output.put_line('��Щֵ��'|| order_rec.depid ||' ' || order_rec.dname );
end loop;
close order_cv;
end;

--����(�޷���ֵ)
create or replace procedure UpdateMoney(per number,var_empid number)
is 
empname tblemp.empname%type;
money tblemp.money%type;
oldmoney tblemp.money%type;
begin
--����ԭ���Ĺ���
select money into oldmoney from tblemp where empid=var_empid;
--���ݲ�������Ա���Ĺ���
update tblemp set money=money+(money*per) where empid=var_empid;
--��ø��º�Ĺ���
select empname,money into empname,money from tblemp where empid=var_empid;
--���ԭ���Ĺ��ʺ͸��º�Ĺ���
dbms_output.put_line(empname || 'ԭ���Ĺ����ǣ���'|| oldmoney || ',���º�Ĺ����ǣ���'|| money);
exception 
when no_data_found then
dbms_output.put_line('û���ҵ�����!');
end;

--(�������)ִ�й���
execute UpdateMoney(0.2,1);

--����(�з���ֵ���ұ��뷵��ֵ)
create or replace function 
fhanshu(a out int,b int) return int
as
begin
a:=a+1;
return b+1;
end fhanshu;

--ִ�к���
declare
a int:=10;
c int;
begin
c:=fhanshu(a,10);
dbms_output.put_line(c);
dbms_output.put_line('a>>'||a);
end;

--������Ĵ�����ʹ��

--�������������-----------��һ��
create or replace package testpak 
is
n int:=10;
procedure mysub(n int);
function myfunc(n int) return varchar2;
end testpak;

--������������壬�����е���Դ����˽�е�----------�ڶ���
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

--���ð��еĹ��̺ͷ���----------������
declare
begin
testpak.mysub(10);
end;

--���ð��еĺ���---------------���Ĳ�
declare
c varchar2(20);
begin
c:=testpak.myfunc(2);
dbms_output.put_line(c);
end;

--�����α�(�����⣬��Ҫ����)
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

--dbms_output��
declare 
buf varchar2(255);
st integer;
begin
--dbms_output.enable(100000);--��������С
--dbms_output.put_line('welcome');
--dbms_output.put('to');
--dbms_output.put('xf');
--dbms_output.new_line; --�������(��궨λ����һ��)
--dbms_output.put_line('center'); 
--dbms_output.get_line(buf,st); 
--dbms_output.put_line(buf);
--dbms_output.put_line(st);
end;

------------------------------------------------------------------------------------------
-- Oracle���̿���
------------------------------------------------------------------------------------------

--�������(if)
--ʹ��(���� �������ͣ�=ֵ)�ķ�����ֵ
--ʹ��(���� || '�ַ�')�����������ַ���
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

--�������(case)
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
else dbms_output.put_line('���ܼ���');
end case;
end;

--ʹ���������case��������
SELECT avg(case 
when a.money > 3000 THEN a.money
when a.money > 4000 then 4000
when a.money > 5000 then 5000 
else 0
end) "ƽ������" 
from tblemp a

--ѭ�����(for)
declare 
i int:=1;
n int:=0;
begin
for i in reverse 1..10--����reverse����˼��i��ȡֵ������������10��1(���Բ�ʹ��)
loop
n:=n+1;
dbms_output.put_line(n);
end loop;
end;

--ѭ�����(loop)
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

--ѭ�����(while)
declare
a number:=100;
begin
while a<250
loop
a:=a+25;
end loop;
dbms_output.put_line(to_char(a));
end;

