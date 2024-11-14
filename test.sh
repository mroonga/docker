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

sudo docker container run \
  -d \
  -p 33061:3306 \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
  --name $container_name \
  $image_name
### Should test.
while true ; do
  mysqladmin -h 127.0.0.1 -P 33061 -uroot ping && break
  sleep 1
done
(echo -e "mroonga_libgroonga_version\t${groonga_version}"; \
 echo -e "mroonga_version\t${mroonga_version}"; \
 echo -e "version\t${mysql_version}") \
  > /tmp/expected.txt
mysql_e="mysql -h 127.0.0.1 -P 33061 -uroot -sse"
($mysql_e "SHOW VARIABLES LIKE 'mroonga_libgroonga_version'"; \
 $mysql_e "SHOW VARIABLES LIKE 'mroonga_version'"; \
 $mysql_e "SHOW VARIABLES LIKE 'version'") \
  > /tmp/actual.txt
set +e
diff -u /tmp/expected.txt /tmp/actual.txt
success=$?
set -e
sudo docker container stop $container_name
sudo docker container logs $container_name
sudo docker container rm $container_name
exit $success
