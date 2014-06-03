一. 常用的两种逻辑备份
1）.（数据的不一致性）生成insert语句(为了数据库中数据的完整性，需要将网站关闭)  --   这种方式可以将数据生成可以完全重现当前数据库中数据的insert语句
一般通过mysql自带的工具程序mysqldump来申明insert语句的备份文件
语法：
 Dumping definition and data mysql database or table
Usage: mysqldump [OPTIONS] database [tables]
OR mysqldump [OPTIONS] --databases [OPTIONS] DB1 [DB2 DB3...]
OR mysqldump [OPTIONS] --all-databases [OPTIONS]

当通过 mysqldump 生成 INSERT 语句的逻辑备份文件的时候，有一个非常有用的选项可以供我们使用，
那就是 “--master-data[=value]”。当添加了 “--master-data=1”的时候，
mysqldump 会将当前 MySQL 使用到 binlog 日志的名称和位置记录到 dump 文件中，并且是被以 CHANGE_MASTER 语句的形式记录，
如果仅仅只是使用“--master-data”或者“--masterdata＝2”，则 CHANGE_MASTER 语句会以注释的形式存在。
这个选项在实施 slave 的在线搭建的时候是非常有用的，即使不是进行在线搭建 slave，也可以在某些情况下做恢复的过程中通过备份的 binlog 做进一步恢复操作。
在某些场景下，我们可能只是为了将某些特殊的数据导出到其他数据库中，而又不希望通过先建临时表的方式来实现，
我们还可以在通过 mysqldump 程序的“—where='wherecondition'”来实现，但只能在仅 dump 一个表的情况下使用。
其实除了以上一些使用诀窍之外， mysqldump 还提供了其他很多有用的选项供大家在不
同的场景下只用，如通过 “--no-data”仅仅 dump 数据库结构创建脚本，通过 “--no-createinfo”去掉 dump 文件中创建表结构的命令等等，感兴趣的读者朋友可以详细阅读 mysqldump
程序的使用介绍再自行测试。


2）. (数据库中数据的一致性)

1.同一时刻取出所有数据
实现原理：在同一个事务中，数据库是可以做到所读取的数据是出于同一个时间点。
          所以，对于事务支持的存储引擎，如Innodb或者BDB等，我们就可以通过控制将整个备份过程控制在同一个事务中，来达到备份数据的一致性和完整
性，而且 mysqldump 程序也给我们提供了相关的参数选项来支持该功能，就是通过 “--single-transaction”选项，可以不影响数据库的任何正常服务。
2.数据库中的数据处于静止状态
实现原理：将需要备份的表锁定，只允许读取而不允许写入。
		mysqldump 程序自己也提供了相关选项如“--lock-tables”和“--lock-all-tables”，
		在执行之前会锁定表，执行结束后自动释放锁定。
 		“--lock-tables” --- 每次仅仅锁定一个数据库的表
 		“--lock-all-tables” -- 锁定多个不同的数据库

三. (生成特定格式的纯文本备份数据文件备份)
 缺点是在同一个备份文件中不能存在多个表的备份数据，没有数据库结构的重
建命令。对于备份集需要多个文件，对我们产生的影响无非就是文件多了维护和恢复成本增
加，但这些基本上都可以通过编写一些简单的脚本来实现
1、通过执行 SELECT ... TO OUTFILE FROM ...命令来实现
a. 实现字符转义功能的“FIELDS ESCAPED BY ['name']” 将 SQL 语句中需要转义的字符进行转义；
b. 可以将字段的内容“包装”起来的“FIELDS [OPTIONALLY] ENCLOSED BY 'name'”，
c. 通过"FIELDS TERMINATED BY"可以设定每两个字段之间的分隔符
d. 通过“LINES TERMINATED BY”则会告诉 MySQL 输出文件在每条记录结束的时候需要添加什么字符。
语句如下，windows下测试语句没有问题，但是就是看不到文件
SELECT * INTO OUTFILE 'G:\Users\windows7\Desktop\smi.txt' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' FROM user limit 100;

二. 物理备份