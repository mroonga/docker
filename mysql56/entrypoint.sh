#!/bin/bash

original_owner=$(stat --format=%u /var/lib/mysql)
original_group=$(stat --format=%g /var/lib/mysql)

if [ ! -e /var/lib/mysql/ibdata1 ] ; then
  ### If overroded my.cnf is there, rename and restore it.
  ### See https://github.com/mroonga/docker/issues/59
  [[ -e /etc/my.cnf ]] && mv -n /etc/my.cnf /etc/my.cnf.save

  chown -R mysql: /var/lib/mysql
  mysql-systemd-start pre
  /usr/sbin/mysqld --basedir=/usr --user=mysql &
  mysql-systemd-start post
  mysql -e "GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION"
  mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql mysql
  mysql < /usr/share/mroonga/install.sql
  mysqladmin shutdown

  ### Restore my.cnf
  [[ -e /etc/my.cnf.save ]] && mv /etc/my.cnf.save /etc/my.cnf
fi

chown -R mysql: /var/lib/mysql
/usr/sbin/mysqld --user=mysql "$@"

chown -R $original_owner:$original_group /var/lib/mysql
