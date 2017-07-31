#!/bin/bash

if [ ! -e /var/lib/mysql/ibdata1 ] ; then
  rm -r /var/lib/mysql/*
  mysqld --no-defaults --initialize-insecure --basedir=/usr --datadir=/var/lib/mysql --user=mysql
  bash /root/postinstall.sh
  service mysqld start && mysql -e "CREATE USER root@'%'; GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION" && service mysqld stop
  rm /var/lib/mysql/auto.cnf /var/lib/mysql/groonga.log
fi

oldowner=$(ls -ln /var/lib/mysql/ibdata1 | awk '{print $3}')
oldgroup=$(ls -ln /var/lib/mysql/ibdata1 | awk '{print $4}')

chown -R mysql. /var/lib/mysql
/usr/sbin/mysqld --user=mysql "$@"

chown -R $oldowner.$oldgroup /var/lib/mysql
