# Dockerfile for Mroonga

* Source Dockerfiles for [groonga/mroonga](https://hub.docker.com/r/groonga/mroonga/)

## How to build Mroonga image

* Dockerfile for some couples of MySQL and Mroonga are under "Dockerfile" directory.

```
$ git clone https://github.com/mroonga/docker mroonga_docker
$ cd mroonga_docker
$ sudo docker build -t mroonga_docker Dockerfile/mysql5627_mroonga508
```


## How to create test environment

* If you doesn't run `docker` command without sudo, add "--sudo" option for script.
* Test script is written by Perl5. You should install `cpanm`.

```
$ git clone https://github.com/mroonga/docker mroonga_docker
$ cd mroonga_docker/test
$ cpanm --installdeps .
$ ./build.pl
```

## Contribution

* Patches welcome both test-script and Dockerfile.
