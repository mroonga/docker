FROM centos:centos6.6
MAINTAINER groonga

RUN yum upgrade -y
RUN yum install -y which
RUN yum install -y http://packages.groonga.org/centos/groonga-release-1.2.0-1.noarch.rpm
RUN yum install -y http://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm
RUN yum install -y mysql-community-client-5.7.16 mysql-community-server-5.7.16 && yum clean all
RUN yum install -y mysql57-community-mroonga-6.11 groonga-6.1.1 groonga-tokenizer-mecab-6.1.1 && yum clean all
RUN awk '/root@localhost/{print $NF}' /var/log/mysqld.log > /root/mysql_password
COPY my.cnf /etc/my.cnf
RUN service mysqld start && mysql -p$(cat /root/mysql_password) --connect-expired-password -e "ALTER USER user() IDENTIFIED BY ''; CREATE USER root@'%'; GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION" && service mysqld stop
RUN rpm -q --scripts mysql57-community-mroonga | sed -n '/^postinstall scriptlet/,/^[a-z][a-z]* scriptlet/p' | tail -n +2 | head -n -1 > /root/postinstall.sh
RUN rm /var/lib/mysql/auto.cnf /var/lib/mysql/groonga.log
COPY entrypoint.sh /root/entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/root/entrypoint.sh"]
