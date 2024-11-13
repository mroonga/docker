FROM mysql:8.0.40-debian

ENV groonga_version=14.1.0 \
    mroonga_version=14.10

RUN mkdir -p /etc/mysql/mysql.conf.d && \
    touch /etc/mysql/mysql.conf.d/default-auth-override.cnf && \
    touch /etc/mysql/mysql.conf.d/lowercase-table-names.cnf && \
    apt update && \
    apt install -y -V --no-install-recommends \
      ca-certificates \
      lsb-release \
      wget && \
    code_name=$(lsb_release --codename --short) && \
    wget https://packages.groonga.org/debian/groonga-apt-source-latest-${code_name}.deb && \
    apt install -y -V --no-install-recommends \
      ./groonga-apt-source-latest-${code_name}.deb && \
    rm groonga-apt-source-latest-${code_name}.deb && \
    apt update && \
    apt install -y -V --no-install-recommends \
      groonga-bin=${groonga_version}-1 \
      groonga-normalizer-mysql \
      groonga-tokenizer-mecab=${groonga_version}-1 \
      mysql-community-8.0-mroonga=${mroonga_version}-1 && \
    rm -rf /var/lib/mysql && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-mroonga-initdb.d && \
    cp /usr/share/mroonga/install.sql \
       /docker-entrypoint-mroonga-initdb.d/00-install.sql && \
    sed \
      -i'' \
      -e 's,docker_process_init_files /,docker_process_init_files /docker-entrypoint-mroonga-initdb.d/* /,g' \
      /usr/local/bin/docker-entrypoint.sh

# mysql:8.0.40 image has DB in /var/lib/mysql/.
# This clears /var/lib/mysql/ to ensure creating a new DB on "docker run".
VOLUME ["/var/lib/mysql"]
