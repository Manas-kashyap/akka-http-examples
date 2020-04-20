#!/bin/bash
if [ $(dpkg-query -W -f='${Status}' sbt 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
  curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
  sudo apt-get update
  sudo apt-get install sbt scala  -y
fi