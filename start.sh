#!/bin/sh
cd /usr/lib/jboss/default/

echo "========================================================================="
echo
echo "  Startup script: /usr/lib/jboss/default/bin/standalone.sh $STARTUP_OPTS"

if [ "$FLUSH_ON_START" == "1" ] || [ "$FLUSH_ON_START" == "true" ] || [ "$FLUSH_ON_START" == "on" ]; then
	profile=standalone
	echo "  Flushing dumpfiles..."
	rm -f bin/hs_err_pid*log
	echo "  Flushing tmp..."
	rm -rf $profile/tmp/*
	echo "  Flushing data..."
	rm -rf $profile/data/*
	echo "  Flushing deployments..."
	rm -rf $profile/deployments/*
	echo "  Flushing log..."
	rm -rf $profile/log/*
	touch $profile/log/server.log
	echo "  Flushing XML files..."
	sed -i '/<deployments>/,/<\/deployments>/d' $profile/configuration/*.xml
	echo "  Flushing indices..."
	rm -rf /store/ppay-web/indexes/*
else
	echo "  FLUSH_ON_START not set. Not flushing directories."
fi

echo -n "  JAVA_VERSION: "
$JAVA_HOME/bin/java -version 2>&1 | head -n 1
echo
echo "========================================================================="

/usr/lib/jboss/default/bin/standalone.sh $STARTUP_OPTS
