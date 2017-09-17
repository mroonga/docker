#!/bin/bash

if [ ! -e /var/lib/mysql/ibdata1 ] ; then
  chown -R mysql. /var/lib/mysql
  bash /root/postinstall.sh
  service mysqld start && mysql -e "GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION" && service mysqld stop
fi

oldowner=$(ls -ln /var/lib/mysql/ibdata1 | awk '{print $3}')
oldgroup=$(ls -ln /var/lib/mysql/ibdata1 | awk '{print $4}')

chown -R mysql. /var/lib/mysql
/usr/sbin/mysqld --user=mysql "$@"

chown -R $oldowner.$oldgroup /var/lib/mysql
