@echo off

rem
rem You can use this script to start JConsole with the client keystore that
rem contains the generated client certificate. This assumes the client certificate
rem has been imported into the server's truststore.
rem
rem This script starts JConsole with the JMXMP library JAR on the classpath. Without
rem this extra library on the classpath, JConsole is unable to open JMXMP connections.
rem

if not "%JAVA_HOME%" == "" goto gotJavaHome
echo You must set JAVA_HOME to point at your Java Development Kit installation
goto end
:gotJavaHome

echo JAVA_HOME=%JAVA_HOME%
"%JAVA_HOME%\bin\jconsole.exe" -J-Djavax.net.debug=ssl -J-Djava.class.path=%JAVA_HOME%\lib\jconsole.jar;..\..\lib\jmxremote_optional-1.0.1_04.jar -J-Djavax.net.ssl.trustStore=output\jmx-client-truststore.jks -J-Djavax.net.ssl.trustStorePassword=password123 -J-Djavax.net.ssl.keyStore=output\jmx-client-keystore.jks -J-Djavax.net.ssl.keyStorePassword=password123

:end
