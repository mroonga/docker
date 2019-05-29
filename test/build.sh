#!/bin/bash

cd $(dirname $0)

timestamp=$(date +%s)
image_name="test_mroonga_${timestamp}"
container_name="name_${image_name}"

sudo docker build -t $image_name ../Dockerfile
sudo docker run -d -p 33061:3306 --name $container_name $image_name
### Should test.
while true ; do
  /usr/mysql/5.6.43/bin/mysqladmin -h 127.0.0.1 -P 33061 -uroot ping && break
  sleep 1
done
mysql -h 127.0.0.1 -P 33061 -uroot -v -sse "SHOW VARIABLES LIKE '%version'"
sudo docker stop $container_name
sudo docker logs $container_name
sudo docker rm $container_name
sudo docker rmi $image_name
