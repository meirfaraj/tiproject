call 
"%JDK_HOME%\bin\java" -cp "exportDoc-0.0.1-SNAPSHOT" tiproject.ExportDoc
call luacompile ../finance/src/finance.lua
copy /Y \tmp\finance.tns ..
pause
