#!/bin/sh

#
# You can use this script to start JConsole with the client keystore that
# contains the generated client certificate. This assumes the client certificate
# has been imported into the server's truststore.
#
# This script starts JConsole with the JMXMP library JAR on the classpath. Without
# this extra library on the classpath, JConsole is unable to open JMXMP connections.
#

if [ -z "${JAVA_HOME}" ]; then
    echo "You must set JAVA_HOME to point at your Java Development Kit installation"
else
    echo JAVA_HOME=${JAVA_HOME}
    "${JAVA_HOME}/bin/jconsole" -J-Djavax.net.debug=ssl -J-Djava.class.path=%JAVA_HOME%/lib/jconsole.jar:../../lib/jmxremote_optional-1.0.1_04.jar -J-Djavax.net.ssl.trustStore=output/jmx-client-truststore.pk12 -J-Djavax.net.ssl.trustStorePassword=password123 -J-Djavax.net.ssl.keyStore=output/jmx-client-keystore.pk12 -J-Djavax.net.ssl.keyStorePassword=password123
fi
