FROM centos:centos6.9
MAINTAINER groonga

RUN yum upgrade -y
RUN yum install -y which
RUN yum install -y http://packages.groonga.org/centos/groonga-release-1.4.0-1.noarch.rpm && yum clean all
RUN yum install -y https://dev.mysql.com/get/mysql80-community-release-el6-1.noarch.rpm && yum clean all
RUN yum install --enablerepo=mysql56-community --disablerepo=mysql57-community --disablerepo=mysql80-community -y mysql-community-client-5.6.43 mysql-community-server-5.6.43 && yum clean all
RUN yum install -y mysql-community-mroonga-9.00 groonga-9.0.0 groonga-tokenizer-mecab-9.0.0 groonga-normalizer-mysql && yum clean all
RUN chown -R mysql. /var/lib/mysql ; service mysqld start && mysql -e "GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION" && mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql mysql && service mysqld stop
COPY my.cnf /etc/my.cnf
RUN rpm -q --scripts mysql-community-mroonga | sed -n '/^postinstall scriptlet/,/^[a-z][a-z]* scriptlet/p' | tail -n +2 | head -n -1 > /root/postinstall.sh
RUN rm /var/lib/mysql/auto.cnf /var/lib/mysql/groonga.log
COPY entrypoint.sh /root/entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/root/entrypoint.sh"]
