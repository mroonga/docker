#!/bin/bash

if [ ! -e /var/lib/mysql/ibdata1 ] ; then
  ### If overroded my.cnf is there, rename and restore it.
  ### See https://github.com/mroonga/docker/issues/59
  [[ -e /etc/my.cnf ]] && mv -n /etc/my.cnf /etc/my.cnf.save
  rm -r /var/lib/mysql/*
  mysqld --no-defaults --initialize-insecure --basedir=/usr --datadir=/var/lib/mysql --user=mysql
  chown -R mysql. /var/lib/mysql
  bash /root/postinstall.sh
  service mysqld start
  mysql -e "CREATE USER root@'%'; GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION"
  mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql mysql
  service mysqld stop
  ### Restore my.cnf
  [[ -e /etc/my.cnf.save ]] && mv /etc/my.cnf.save /etc/my.cnf
  rm /var/lib/mysql/auto.cnf /var/lib/mysql/groonga.log
fi

oldowner=$(ls -ln /var/lib/mysql/ibdata1 | awk '{print $3}')
oldgroup=$(ls -ln /var/lib/mysql/ibdata1 | awk '{print $4}')

chown -R mysql. /var/lib/mysql
/usr/sbin/mysqld --user=mysql "$@"

chown -R $oldowner.$oldgroup /var/lib/mysql
