#!/bin/bash

set -eu

if [ $# != 3 ]; then
  echo "Usage: $0 MYSQL_VERSION MROONGA_VERSION GROONGA_VERSION"
  echo " e.g.: $0 5.7.26 9.01 9.0.2"
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
  5.6.*)
    docker_file=mysql56/Dockerfile
    ;;
  5.7.*)
    docker_file=mysql57/Dockerfile
    ;;
  8.0.*)
    docker_file=mysql80/Dockerfile
    ;;
esac

${SED} \
  -i'' \
  -r \
  -e "s/mysql_version=[0-9.]*/mysql_version=${mysql_version}/g" \
  -e "s/mroonga_version=[0-9.]*/mroonga_version=${mroonga_version}/g" \
  -e "s/groonga_version=[0-9.]*/groonga_version=${groonga_version}/g" \
  ${docker_file}
git add ${docker_file}

ruby "$(dirname "$0")/update-tag-list.rb" "$@"
git add README.md

tag=$(echo "mysql${mysql_version}_mroonga${mroonga_version}" | \
        ${SED} -r -e 's/[.]//g')
message="MySQL ${mysql_version} and Mroonga ${mroonga_version}"
git commit -m "${message}"
git tag -a -m "${message}" ${tag}
