FROM mysql:8.0.32-oracle
MAINTAINER groonga

ENV groonga_version=13.0.1 \
    mroonga_version=13.01 \

RUN mkdir -p /etc/mysql/mysql.conf.d && \
    touch /etc/mysql/mysql.conf.d/default-auth-override.cnf && \
    touch /etc/mysql/mysql.conf.d/lowercase-table-names.cnf && \
    major_version=$(cut -d: -f5 /etc/system-release-cpe | grep -o "^[0-9]") && \
    microdnf install -y \
      epel-release && \
    microdnf install -y \
      wget && \
    microdnf install -y \
      cmake-filesystem \
      lz4 \
      msgpack \
      re2 \
      snappy \
      xxhash-libs && \
    powertools_base=https://repo.almalinux.org/almalinux/${major_version}/PowerTools/x86_64/os/Packages && \
    wget ${powertools_base}/glog-0.3.5-3.el8.x86_64.rpm && \
    wget ${powertools_base}/gflags-devel-2.1.2-6.el8.x86_64.rpm && \
    wget ${powertools_base}/gflags-2.1.2-6.el8.x86_64.rpm && \
    apache_arrow_base=https://apache.jfrog.io/artifactory/arrow/almalinux/${major_version}/x86_64/Packages && \
    wget ${apache_arrow_base}/arrow11-libs-11.0.0-1.el8.x86_64.rpm && \
    groonga_base=http://packages.groonga.org/almalinux/${major_version}/x86_64/Packages && \
    wget ${groonga_base}/mysql-community-minimal-8.0-mroonga-13.01-1.el8.x86_64.rpm && \
    wget ${groonga_base}/groonga-libs-13.0.1-1.el8.x86_64.rpm && \
    wget ${groonga_base}/groonga-normalizer-mysql-1.2.1-1.el8.x86_64.rpm && \
    rpm -ivh ./*.rpm && \

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
