FROM centos:7
MAINTAINER groonga

RUN yum upgrade -y && \
    yum install -y \
      which \
      http://packages.groonga.org/centos/groonga-release-latest.noarch.rpm \
      http://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm && \
    yum clean all

ENV groonga_version=10.1.0 \
    mroonga_version=10.10 \
    mysql_version=8.0.22

RUN yum install -y \
      --disablerepo=mysql56-community \
      --disablerepo=mysql57-community \
      --enablerepo=mysql80-community \
      mysql-community-client-${mysql_version} \
      mysql-community-server-${mysql_version} \
      mysql80-community-mroonga-${mroonga_version} \
      groonga-${groonga_version} \
      groonga-tokenizer-mecab-${groonga_version} \
      groonga-normalizer-mysql && \
    yum clean all
COPY my.cnf /etc/my.cnf

RUN mysqld \
      --no-defaults \
      --initialize-insecure \
      --basedir=/usr \
      --datadir=/var/lib/mysql \
      --user=mysql && \
    /usr/sbin/mysqld --user=mysql --daemonize && \
    mysql -e "CREATE USER root@'%'; GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION" && \
    mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql mysql && \
    mysql < /usr/share/mroonga/install.sql && \
    mysqladmin shutdown && \
    rm /var/lib/mysql/auto.cnf /var/lib/mysql/groonga.log
COPY entrypoint.sh /root/entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/root/entrypoint.sh"]
