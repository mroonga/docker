FROM mysql:8.0.42-oraclelinux9

# TODO
# Remove `--setopt=apache-arrow-almalinux.gpgcheck=0` option.
# It is specified because the installation fails with the following error.
# ```
# (microdnf:544): libdnf-WARNING **: 04:37:39.459: failed to parse public key for /etc/pki/rpm-gpg/RPM-GPG-KEY-Apache-Arrow
# error: failed to parse public key for /var/cache/yum/metadata/apache-arrow-almalinux-9-x86_64/RPM-GPG-KEY-Apache-Arrow
# ```

ENV groonga_version=15.1.1 \
    mroonga_version=15.11

RUN mkdir -p /etc/mysql/mysql.conf.d && \
    touch /etc/mysql/mysql.conf.d/default-auth-override.cnf && \
    touch /etc/mysql/mysql.conf.d/lowercase-table-names.cnf && \
    microdnf install -y \
      'dnf-command(config-manager)' \
      epel-release && \
    rpm -i https://packages.groonga.org/almalinux/9/groonga-release-latest.noarch.rpm && \
    rpm -i https://apache.jfrog.io/artifactory/arrow/almalinux/9/apache-arrow-release-latest.rpm && \
    microdnf install -y \
      --setopt=apache-arrow-almalinux.gpgcheck=0 \
      groonga-tokenizer-mecab-${groonga_version}-1.el9.x86_64 \
      mysql-community-minimal-8.0-mroonga-${mroonga_version}-1.el9.x86_64 && \
    microdnf clean all

RUN mkdir -p /docker-entrypoint-mroonga-initdb.d && \
    cp /usr/share/mroonga/install.sql \
       /docker-entrypoint-mroonga-initdb.d/00-install.sql && \
    sed \
      -i'' \
      -e 's,docker_process_init_files /,docker_process_init_files /docker-entrypoint-mroonga-initdb.d/* /,g' \
      /usr/local/bin/docker-entrypoint.sh

# mysql:8.0.42 image has DB in /var/lib/mysql/.
# This clears /var/lib/mysql/ to ensure creating a new DB on "docker run".
VOLUME ["/var/lib/mysql"]
