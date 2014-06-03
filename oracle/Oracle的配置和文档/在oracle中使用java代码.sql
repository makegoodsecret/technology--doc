1.在pl/sql 创建java代码
create or replace and compile java source named hello as
public class Hello
{
  public static String entry()
  {
  return "你好世界!";
  }
}
 2. 创建函数调用
create or replace function AA return varchar2 is LANGUAGE JAVA NAME 'Hello.entry() return java.lang.String';
3.select AA from dual;
