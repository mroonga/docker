FROM mysql:8.0.30
MAINTAINER groonga

ENV groonga_version=12.0.8 \
    mroonga_version=12.08

RUN mkdir -p /etc/mysql/mysql.conf.d && \
    touch /etc/mysql/mysql.conf.d/default-auth-override.cnf && \
    touch /etc/mysql/mysql.conf.d/lowercase-table-names.cnf && \
    microdnf update -y && \
    microdnf install -y dnf && \
    microdnf clean all && \
    dnf install -y \
      ca-certificates \
      redhat-lsb \
      wget && \
    code_name=$(lsb_release --codename --short) && \
    dnf install -y https://packages.groonga.org/almalinux/8/groonga-release-latest.noarch.rpm && \
    dnf update -y && \
    dnf install -y \
      groonga-bin=${groonga_version}-1 \
      groonga-normalizer-mysql \
      groonga-tokenizer-mecab=${groonga_version}-1 \
      mysql-community-8.0-mroonga=${mroonga_version}-1 && \
    dnf clean all && \

RUN mkdir -p /docker-entrypoint-mroonga-initdb.d && \
    cp /usr/share/mroonga/install.sql \
       /docker-entrypoint-mroonga-initdb.d/00-install.sql && \
    sed \
      -i'' \
      -e 's,docker_process_init_files /,docker_process_init_files /docker-entrypoint-mroonga-initdb.d/* /,g' \
      /usr/local/bin/docker-entrypoint.sh

# mysql:8.0.30 image has DB in /var/lib/mysql/.
# This clears /var/lib/mysql/ to ensure creating a new DB on "docker run".
VOLUME [/var/lib/mysql]
