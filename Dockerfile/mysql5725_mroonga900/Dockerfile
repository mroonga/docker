FROM centos:centos6.9
MAINTAINER groonga

RUN yum upgrade -y && yum clean all
RUN yum install -y which && yum clean all
RUN yum install -y http://packages.groonga.org/centos/groonga-release-1.4.0-1.noarch.rpm && yum clean all
RUN yum install -y https://dev.mysql.com/get/mysql80-community-release-el6-1.noarch.rpm && yum clean all
RUN yum install --enablerepo=mysql57-community --disablerepo=mysql80-community -y mysql-community-client-5.7.25 mysql-community-server-5.7.25 && yum clean all
RUN mysqld --no-defaults --initialize-insecure --basedir=/usr --datadir=/var/lib/mysql --user=mysql
COPY my.cnf /etc/my.cnf
RUN chown -R mysql. /var/lib/mysql ; yum install -y mysql57-community-mroonga-9.00 groonga-9.0.0 groonga-tokenizer-mecab-9.0.0 groonga-normalizer-mysql && yum clean all
RUN chown -R mysql. /var/lib/mysql ; service mysqld start && mysql -e "CREATE USER root@'%'; GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION" && mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql mysql && service mysqld stop
RUN rpm -q --scripts mysql57-community-mroonga | sed -n '/^postinstall scriptlet/,/^[a-z][a-z]* scriptlet/p' | tail -n +2 | head -n -1 > /root/postinstall.sh
RUN rm /var/lib/mysql/auto.cnf /var/lib/mysql/groonga.log
COPY entrypoint.sh /root/entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/root/entrypoint.sh"]
