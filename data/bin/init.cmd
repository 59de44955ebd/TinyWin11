@echo off

REM wpeinit

for %%a in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%a:\shell\ set SHELLDRIVE=%%a
start /wait "" %SHELLDRIVE%:\shell\shell.exe
