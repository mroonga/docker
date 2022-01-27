FROM mysql:8.0.27
MAINTAINER groonga

ENV groonga_version=11.1.1 \
    mroonga_version=11.11

RUN mkdir -p /etc/mysql/mysql.conf.d && \
    touch /etc/mysql/mysql.conf.d/default-auth-override.cnf && \
    touch /etc/mysql/mysql.conf.d/lowercase-table-names.cnf && \
    apt update && \
    apt install -y -V --no-install-recommends \
      ca-certificates \
      wget && \
    wget https://packages.groonga.org/debian/groonga-apt-source-latest-buster.deb && \
    apt install -y -V --no-install-recommends \
      ./groonga-apt-source-latest-buster.deb && \
    rm groonga-apt-source-latest-buster.deb && \
    apt update && \
    apt install -y -V --no-install-recommends \
      groonga-bin=${groonga_version}-1 \
      groonga-normalizer-mysql \
      groonga-tokenizer-mecab=${groonga_version}-1 \
      mysql-community-8.0-mroonga=${mroonga_version}-1 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-mroonga-initdb.d && \
    cp /usr/share/mroonga/install.sql \
       /docker-entrypoint-mroonga-initdb.d/00-install.sql && \
    sed \
      -i'' \
      -e 's,docker_process_init_files /,docker_process_init_files /docker-entrypoint-mroonga-initdb.d/* /,g' \
      /usr/local/bin/docker-entrypoint.sh
