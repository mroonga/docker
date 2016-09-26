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

| tag                  | MySQL  | Mroonga | Groonga |
|----------------------|--------|---------|---------|
| latest               | 5.6.32 | 6.08    | 6.0.8   |
| mysql5623_mroonga410 | 5.6.23 | 4.10    | 4.1.1   |
| mysql5626_mroonga506 | 5.6.26 | 5.06    | 5.0.6   |
| mysql5627_mroonga508 | 5.6.27 | 5.08    | 5.0.8   |
| mysql5627_mroonga509 | 5.6.27 | 5.09    | 5.0.9   |
| mysql5628_mroonga510 | 5.6.28 | 5.10    | 5.1.0   |
| mysql5628_mroonga511 | 5.6.28 | 5.11    | 5.1.1   |
| mysql5628_mroonga512 | 5.6.28 | 5.12    | 5.1.2   |
| mysql5629_mroonga600 | 5.6.29 | 6.00    | 6.0.0   |
| mysql5629_mroonga601 | 5.6.29 | 6.01    | 6.0.1   |
| mysql5630_mroonga602 | 5.6.30 | 6.02    | 6.0.2   |
| mysql5631_mroonga603 | 5.6.31 | 6.03    | 6.0.4   |
| mysql5631_mroonga605 | 5.6.31 | 6.05    | 6.0.5   |
| mysql5631_mroonga606 | 5.6.31 | 6.06    | 6.0.5   |
| mysql5632_mroonga607 | 5.6.32 | 6.07    | 6.0.7   |
| mysql5633_mroonga608 | 5.6.33 | 6.08    | 6.0.8   |
| mysql579_mroonga509  | 5.7.9  | 5.09    | 5.0.9   |
| mysql5710_mroonga510 | 5.7.10 | 5.10    | 5.1.0   |
| mysql5710_mroonga511 | 5.7.10 | 5.11    | 5.1.1   |
| mysql5711_mroonga512 | 5.7.11 | 5.12    | 5.1.2   |
| mysql5711_mroonga600 | 5.7.11 | 6.00    | 6.0.0   |
| mysql5711_mroonga601 | 5.7.11 | 6.01    | 6.0.1   |
| mysql5712_mroonga602 | 5.7.12 | 6.02    | 6.0.2   |
| mysql5713_mroonga603 | 5.7.13 | 6.03    | 6.0.4   |
| mysql5713_mroonga605 | 5.7.13 | 6.05    | 6.0.5   |
| mysql5713_mroonga606 | 5.7.13 | 6.06    | 6.0.5   |
| mysql5714_mroonga607 | 5.7.14 | 6.07    | 6.0.7   |


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

