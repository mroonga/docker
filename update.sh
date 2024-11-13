#!/bin/bash

set -eu

if [ $# != 3 ]; then
  echo "Usage: $0 MYSQL_VERSION MROONGA_VERSION GROONGA_VERSION"
  echo " e.g.: $0 8.0.30 12.06 12.0.6"
  exit 1
fi

mysql_version=$1
mroonga_version=$2
groonga_version=$3

if type gsed > /dev/null 2>&1; then
  SED=gsed
else
  SED=sed
fi

case $mysql_version in
  8.0.*)
    docker_file=mysql-8.0/Dockerfile
    ;;
esac

${SED} \
  -i'' \
  -r \
  -e "s/mysql:[0-9.]*/mysql:${mysql_version}/g" \
  -e "s/mroonga_version=[0-9.]*/mroonga_version=${mroonga_version}/g" \
  -e "s/groonga_version=[0-9.]*/groonga_version=${groonga_version}/g" \
  ${docker_file}
git add ${docker_file}

ruby "$(dirname "$0")/update-tag-list.rb" "$@"
git add README.md

tag="mysql-${mysql_version}-${mroonga_version}"
message="MySQL ${mysql_version} and Mroonga ${mroonga_version}"
git commit -m "${message}"
git tag -a -m "${message}" ${tag}
