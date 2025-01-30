#!/bin/bash

set -eu

target_mysqls=(
  "8.0"
  "8.4"
)

mroonga_version=$(curl https://api.github.com/repos/mroonga/mroonga/releases/latest \
                    | jq -r '.["tag_name"]' | sed 's/^v//')
groonga_version=$(curl https://api.github.com/repos/groonga/groonga/releases/latest \
                    | jq -r '.["tag_name"]' | sed 's/^v//')

if type gsed > /dev/null 2>&1; then
  SED=gsed
else
  SED=sed
fi

for target_mysql in "${target_mysqls[@]}"; do
  docker_file="mysql-${target_mysql}/Dockerfile"
  case $target_mysql in
    8.0)
      mysql_version=$(curl https://raw.githubusercontent.com/docker-library/mysql/refs/heads/master/versions.json \
                        | jq -r '.["8.0"]["version"]')
      ;;
    8.4)
      mysql_version=$(curl https://raw.githubusercontent.com/docker-library/mysql/refs/heads/master/versions.json \
                        | jq -r '.["8.4"]["version"]')
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

  ruby "$(dirname "$0")/update-tag-list.rb" \
       "${mysql_version}" \
       "${mroonga_version}" \
       "${groonga_version}"
  git add README.md

  tag="mysql-${mysql_version}-${mroonga_version}"
  message="MySQL ${mysql_version} and Mroonga ${mroonga_version}"
  git commit -m "${message}"
  git tag -a -m "${message}" ${tag}
done
