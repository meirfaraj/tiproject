call taskkill /f /im "TI-Nspire CAS Student Software.exe"
call "%JDK_HOME%\bin\java" -cp "exportDoc-0.0.1-SNAPSHOT-jar-with-dependencies.jar" tiproject.ExportDoc
call luacompile ../finance/src/finance.lua
del /F ..\finance.tns
copy /Y \tmp\finance.tns ..
pause
