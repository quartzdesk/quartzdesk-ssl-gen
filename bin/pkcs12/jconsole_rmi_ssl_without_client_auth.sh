#!/bin/sh

#
# You can use this script to start JConsole without the client keystore that
# contains the client certificate. This script is to be used in situations
# when the client certificate authentication is disabled in the JMX server
# and you only want JConsole to establish an SSL-secured connection.
#

if [ -z "${JAVA_HOME}" ]; then
    echo "You must set JAVA_HOME to point at your Java Development Kit installation"
else
    echo JAVA_HOME=${JAVA_HOME}
    "${JAVA_HOME}/bin/jconsole" -J-Djavax.net.debug=ssl -J-Djavax.net.ssl.trustStore=output/jmx-client-truststore.p12 -J-Djavax.net.ssl.trustStorePassword=password123
fi
