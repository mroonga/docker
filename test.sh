#!/bin/bash

set -eu

if [ $# != 2 ]; then
  echo "Usage: $0 CONTEXT IMAGE_NAME"
  echo " e.g.: $0 mysql-8.0 mysql80-mroonga"
  exit 1
fi

cd $(dirname $0)

context=$1
image_name=$2

timestamp=$(date +%s)
container_name="mroonga_build_test_${timestamp}"

eval $(grep -E -o '[a-z]+_version=[0-9.]+' $context/Dockerfile)
mysql_version=$(head -n1 $context/Dockerfile | grep -E -o '[0-9.]{2,}')

function run_sql() {
  sql="$1"
  docker container exec "${container_name}" mysql -uroot -sse "${sql}"
}

function assert() {
  expected="$1"
  actual="$2"
  if [ "${expected}" = "${actual}" ]; then
    return 0
  fi
  echo -e "Not match.\nexpected: <${expected}>\nactual  : <${actual}>"
  return 1
}

sudo docker container run \
  -d \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
  --name $container_name \
  $image_name
### Should test.
while true ; do
  docker container exec "${container_name}" mysqladmin -uroot ping && break
  sleep 1
done

for i in {1..30}; do
  # Need to wait a bit until Mroonga is available.
  run_sql "SELECT mroonga_command('status')" > /dev/null 2>&1 && break
  sleep 1
done

set +e
echo -e "$(run_sql "SELECT JSON_PRETTY(mroonga_command('status'))")" && \
assert \
  "\"${groonga_version}\"" \
  "$(run_sql "SELECT JSON_EXTRACT(mroonga_command('status'), '$.version')")" && \
assert \
  "mroonga_libgroonga_version ${groonga_version}" \
  "$(run_sql "SHOW VARIABLES LIKE 'mroonga_libgroonga_version'")" && \
assert \
 "mroonga_version ${mroonga_version}" \
  "$(run_sql "SHOW VARIABLES LIKE 'mroonga_version'")" && \
assert \
  "version ${mysql_version}" \
  "$(run_sql "SHOW VARIABLES LIKE 'version'")"
success=$?

set -e
sudo docker container stop $container_name
sudo docker container logs $container_name
sudo docker container rm $container_name
exit $success
