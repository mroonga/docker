FROM mysql:8.0.32-oracle
MAINTAINER groonga

ENV groonga_version=13.0.1 \
    mroonga_version=13.01

RUN mkdir -p /etc/mysql/mysql.conf.d && \
    touch /etc/mysql/mysql.conf.d/default-auth-override.cnf && \
    touch /etc/mysql/mysql.conf.d/lowercase-table-names.cnf && \
    major_version=$(cut -d: -f5 /etc/system-release-cpe | grep -o "^[0-9]") && \
    microdnf install -y \
      wget && \
    microdnf install -y \
      epel-release && \
    wget https://apache.jfrog.io/artifactory/arrow/almalinux/$(cut -d: -f5 /etc/system-release-cpe | cut -d. -f1)/apache-arrow-release-latest.rpm && \
    rpm -Uvh apache-arrow-release-latest.rpm && \
    sed -i'' -e '26d' /etc/pki/rpm-gpg/RPM-GPG-KEY-Apache-Arrow && \
    wget https://packages.groonga.org/almalinux/$(cut -d: -f5 /etc/system-release-cpe | cut -d. -f1)/groonga-release-latest.noarch.rpm && \
    rpm -Uvh groonga-release-latest.noarch.rpm && \
    microdnf install -y
      --enablerepo=ol$(cut -d: -f5 /etc/system-release-cpe | cut -d. -f1)_codeready_builder \
      --enablerepo=groonga-almalinux \
      groonga-normalizer-mysql \
      groonga-tokenizer-mecab \
      mysql-community-minimal-8.0-mroonga && \

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
