#!/bin/bash

if [ ! -e /var/lib/mysql/ibdata1 ] ; then
  chown -R mysql. /var/lib/mysql
  rm /var/log/mysqld.log
  bash /root/postinstall.sh
  awk '/root@localhost/{print $NF}' /var/log/mysqld.log > /root/mysql_password
  service mysqld start && mysql -p$(cat /root/mysql_password) --connect-expired-password -e "ALTER USER user() IDENTIFIED BY ''; CREATE USER root@'%'; GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION" && service mysqld stop
fi

oldowner=$(ls -ln /var/lib/mysql/ibdata1 | awk '{print $3}')
oldgroup=$(ls -ln /var/lib/mysql/ibdata1 | awk '{print $4}')

chown -R mysql. /var/lib/mysql
/usr/sbin/mysqld --user=mysql "$@"

chown -R $oldowner.$oldgroup /var/lib/mysql
