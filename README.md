# Dockerfile for Mroonga

* Source Dockerfiles for [groonga/mroonga](https://hub.docker.com/r/groonga/mroonga/)

## Quick start

You can start Mroonga as
```
$ sudo docker run -d groonga/mroonga
$ mysql -h <container's ipaddr> -u root
```

MySQL root account doesn't set any password and isn't limited by connecting host.
(This mean root was created by "GRANT ALL ON \*.\* TO root@'%' WITH GRANT OPTION")


## Mount host directory as Mroonga's datadir

Now, we support to mount datadir from host machine like this.

```
$ sudo docker run -d -v /path/to/datadir:/var/lib/mysql groonga/mroonga
```

If your /path/to/datadir has ibdata1, container decides using datadir as is.
If your /path/to/datadir doesn't have ibdata1, container decides to re-initialize datadir for installing Mroonga.


## Supported versions

Currently, groonga/mroonga provides these couples of versions.
([tags](https://hub.docker.com/r/groonga/mroonga/tags/) cannot display all of them..)

|tag                 |MySQL |Mroonga|
|--------------------|------|-------|
|latest              |5.6.31|6.03   |
|mysql5623_mroonga410|5.6.23|4.10   |
|mysql5626_mroonga506|5.6.26|5.06   |
|mysql5627_mroonga508|5.6.27|5.08   |
|mysql5627_mroonga509|5.6.27|5.09   |
|mysql5628_mroonga510|5.6.28|5.10   |
|mysql5628_mroonga511|5.6.28|5.11   |
|mysql5628_mroonga512|5.6.28|5.12   |
|mysql5629_mroonga600|5.6.29|6.00   |
|mysql5629_mroonga601|5.6.29|6.01   |
|mysql5630_mroonga602|5.6.30|6.02   |
|mysql5631_mroonga603|5.6.31|6.03   |
|mysql579_mroonga509 |5.7.9 |5.09   |
|mysql5710_mroonga510|5.7.10|5.10   |
|mysql5710_mroonga511|5.7.10|5.11   |
|mysql5711_mroonga512|5.7.11|5.12   |
|mysql5711_mroonga600|5.7.11|6.00   |
|mysql5711_mroonga601|5.7.11|6.01   |
|mysql5712_mroonga602|5.7.12|6.02   |
|mysql5712_mroonga603|5.7.12|6.03   |


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

