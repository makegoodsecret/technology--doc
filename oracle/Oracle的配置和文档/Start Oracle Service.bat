@echo off
@ ECHO ���� Oracle 11g ����
net start "OracleDBConsoleorcl"
net start "OracleOraDb11g_home1TNSListener"
net start "OracleServiceORCL"
@ ECHO ������� �����������
pause
exit