echo compile %1

"%JDK_HOME%\bin\java" -jar "luac-0.0.1-SNAPSHOT-jar-with-dependencies.jar" -i %1
