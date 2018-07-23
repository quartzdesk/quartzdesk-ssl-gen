#!/bin/sh

# Creates JMX server and client keystores and trustrores in JKS format.

#
# !!! PLEASE MODIFY SERVER AND CLIENT KEY DISTINGUISHED NAMES AND KEYSTORE AND TRUSTSTORE PASSWORDS !!!
#

SERVER_KEY_DN="CN=JMX Server, O=Foo Inc., L=San Francisco, S=CA, C=US"
SERVER_KEYSTORE_PASSWD="password123"
SERVER_TRUSTSTORE_PASSWD="password123"

CLIENT_KEY_DN="CN=JMX Client, O=Foo Inc., L=San Francisco, S=CA, C=US"
CLIENT_KEYSTORE_PASSWD="password123"
CLIENT_TRUSTSTORE_PASSWD="password123"

echo JAVA_HOME=${JAVA_HOME}

if [ -z "${JAVA_HOME}" ]; then
    echo "You must set JAVA_HOME to point at your Java Development Kit installation"
else
    echo JAVA_HOME=${JAVA_HOME}

    #
    # CREATE SERVER RSA KEYPAIR AND EXPORT THE CERTIFICATE
    #

    echo "Generating JMX server key in file output/jmx-server-keystore.jks"
    "${JAVA_HOME}/bin/keytool" -genkey -validity 1827 -alias jmx-server -dname "${SERVER_KEY_DN}" -keyalg RSA -keypass "${SERVER_KEYSTORE_PASSWD}" -storepass "${SERVER_KEYSTORE_PASSWD}" -keystore output/jmx-server-keystore.jks

    echo "Exporting self-signed JMX server cert into output/jmx-server.crt"
    "${JAVA_HOME}/bin/keytool" -export -alias jmx-server -file output/jmx-server.crt -storepass "${SERVER_KEYSTORE_PASSWD}" -keystore output/jmx-server-keystore.jks


    #
    # CREATE CLIENT RSA KEYPAIR AND EXPORT THE CERTIFICATE
    #

    echo "Generating JMX client key in file output/jmx-client-keystore.jks"
    "${JAVA_HOME}/bin/keytool" -genkey -validity 1827 -alias jmx-client -dname "${CLIENT_KEY_DN}" -keyalg RSA -keypass "${CLIENT_KEYSTORE_PASSWD}" -storepass "${CLIENT_KEYSTORE_PASSWD}" -keystore output/jmx-client-keystore.jks

    echo "Exporting self-signed JMX client cert into output/jmx-client.crt"
    "${JAVA_HOME}/bin/keytool" -export -alias jmx-client -file output/jmx-client.crt -storepass "${CLIENT_KEYSTORE_PASSWD}" -keystore output/jmx-client-keystore.jks


    #
    # IMPORT SERVER CERTIFICATE INTO CLIENT TRUSTORE
    #
    echo "Importing self-signed JMX server cert into output/jmx-client-truststore.jks (as trustcacert entry)"
    "${JAVA_HOME}/bin/keytool" -import -v -trustcacerts -alias jmx-server -file output/jmx-server.crt -keystore output/jmx-client-truststore.jks -keypass "${CLIENT_TRUSTSTORE_PASSWD}" -storepass "${CLIENT_TRUSTSTORE_PASSWD}"

    #
    # IMPORT CLIENT CERTIFICATE INTO SERVER TRUSTORE
    #
    echo "Importing self-signed JMX client cert into output/jmx-server-truststore.jks (as trustcacert entry)"
    "${JAVA_HOME}/bin/keytool" -import -v -trustcacerts -alias jmx-client -file output/jmx-client.crt -keystore output/jmx-server-truststore.jks -keypass "${SERVER_TRUSTSTORE_PASSWD}" -storepass "${SERVER_TRUSTSTORE_PASSWD}"


    #
    # IMPORT SERVER CERTIFICATE INTO SERVER TRUSTORE
    # (required because the JMX server certificate is self-signed and the server would not be able to verify it by using root CA certs stored in %JAVA_HOME%/jre/lib/security/cacerts).
    #
    echo "Importing self-signed JMX server cert into output/jmx-server-truststore.jks (as trustcacert entry)"
    "${JAVA_HOME}/bin/keytool" -import -v -trustcacerts -alias jmx-server -file output/jmx-server.crt -keystore output/jmx-server-truststore.jks -keypass "${SERVER_TRUSTSTORE_PASSWD}" -storepass "${SERVER_TRUSTSTORE_PASSWD}"
fi
