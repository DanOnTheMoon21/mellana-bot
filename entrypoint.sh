#!/bin/sh

if [ -z "$BOTLOGIN_FILE" ]; then
  BOTLOGIN_FILE="/phantombot/config/botlogin.txt"
fi

if [ -z "$BOTLAUNCH_FILE" ]; then
  BOTLAUNCH_FILE="/phantombot/launch-service.sh"
fi

if [ -n "$PHANTOMBOT_APIOAUTH" ]; then
  echo "apioauth=oauth\:$PHANTOMBOT_APIOAUTH" >> $BOTLOGIN_FILE
fi

if [ -n "$PHANTOMBOT_CHANNEL" ]; then
  echo "channel=$PHANTOMBOT_CHANNEL" >> $BOTLOGIN_FILE
else
  echo "PHANTOMBOT_CHANNEL is required."
  exit 1
fi

if [ -n "$PHANTOMBOT_OAUTH" ]; then
  echo "oauth=oauth\:$PHANTOMBOT_OAUTH" >> $BOTLOGIN_FILE
else
  echo "PHANTOMBOT_OAUTH is required."
  exit 1
fi

if [ -n "$PHANTOMBOT_OWNER" ]; then
  echo "owner=$PHANTOMBOT_OWNER" >> $BOTLOGIN_FILE
else
  echo "PHANTOMBOT_OWNER is required."
  exit 1
fi

if [ -z "$PHANTOMBOT_PANELPASSWORD" ]; then
  PHANTOMBOT_PANELPASSWORD="admin"
fi
echo "panelpassword=$PHANTOMBOT_PANELPASSWORD" >> $BOTLOGIN_FILE

if [ -z "$PHANTOMBOT_PANELUSER" ]; then
  PHANTOMBOT_PANELUSER="admin"
fi
echo "paneluser=$PHANTOMBOT_PANELUSER" >> $BOTLOGIN_FILE

if [ -n "$PHANTOMBOT_USER" ]; then
  echo "user=$PHANTOMBOT_USER" >> $BOTLOGIN_FILE
else
  echo "PHANTOMBOT_USER is required."
  exit 1
fi

exec /bin/sh $BOTLAUNCH_FILE
