@echo off

rem
rem You can use this script to start JConsole with the client keystore that
rem contains the client certificate. This script is to be used in situations
rem when the client certificate authentication is enabled in the JMX server.
rem

if not "%JAVA_HOME%" == "" goto gotJavaHome
echo You must set JAVA_HOME to point at your Java Development Kit installation
goto end

:gotJavaHome

echo JAVA_HOME=%JAVA_HOME%
"%JAVA_HOME%\bin\jconsole.exe" -J-Djavax.net.debug=ssl -J-Djavax.net.ssl.trustStore=output\jmx-client-truststore.p12 -J-Djavax.net.ssl.trustStorePassword=password123 -J-Djavax.net.ssl.keyStore=output\jmx-client-keystore.p12 -J-Djavax.net.ssl.keyStorePassword=password123

:end
