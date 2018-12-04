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
| latest               | 5.7.24 | 8.09    | 8.0.9   |
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
| mysql5634_mroonga609 | 5.6.34 | 6.09    | 6.0.9   |
| mysql5634_mroonga610 | 5.6.34 | 6.10    | 6.1.0   |
| mysql5635_mroonga611 | 5.6.35 | 6.11    | 6.1.1   |
| mysql5635_mroonga613 | 5.6.35 | 6.13    | 6.1.5   |
| mysql5635_mroonga700 | 5.6.35 | 7.00    | 7.0.0   |
| mysql5635_mroonga701 | 5.6.35 | 7.01    | 7.0.1   |
| mysql5636_mroonga702 | 5.6.36 | 7.02    | 7.0.2   |
| mysql5636_mroonga703 | 5.6.36 | 7.03    | 7.0.3   |
| mysql5636_mroonga704 | 5.6.36 | 7.04    | 7.0.4   |
| mysql5637_mroonga705 | 5.6.37 | 7.05    | 7.0.5   |
| mysql5637_mroonga706 | 5.6.37 | 7.06    | 7.0.6   |
| mysql5637_mroonga707 | 5.6.37 | 7.07    | 7.0.7   |
| mysql5638_mroonga708 | 5.6.38 | 7.08    | 7.0.8   |
| mysql5638_mroonga709 | 5.6.38 | 7.09    | 7.0.9   |
| mysql5638_mroonga710 | 5.6.38 | 7.10    | 7.1.0   |
| mysql5639_mroonga711 | 5.6.39 | 7.11    | 7.1.1   |
| mysql5639_mroonga800 | 5.6.39 | 8.00    | 8.0.0   |
| mysql5639_mroonga801 | 5.6.39 | 8.01    | 8.0.1   |
| mysql5640_mroonga802 | 5.6.40 | 8.02    | 8.0.2   |
| mysql5640_mroonga803 | 5.6.40 | 8.03    | 8.0.3   |
| mysql5641_mroonga806 | 5.6.41 | 8.06    | 8.0.6   |
| mysql5641_mroonga807 | 5.6.41 | 8.07    | 8.0.7   |
| mysql5642_mroonga809 | 5.6.42 | 8.09    | 8.0.9   |
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
| mysql5715_mroonga608 | 5.7.15 | 6.08    | 6.0.8   |
| mysql5716_mroonga609 | 5.7.16 | 6.09    | 6.0.9   |
| mysql5716_mroonga610 | 5.7.16 | 6.10    | 6.1.0   |
| mysql5716_mroonga611 | 5.7.16 | 6.11    | 6.1.1   |
| mysql5717_mroonga613 | 5.7.17 | 6.13    | 6.1.5   |
| mysql5717_mroonga700 | 5.7.17 | 7.00    | 7.0.0   |
| mysql5717_mroonga701 | 5.7.17 | 7.01    | 7.0.1   |
| mysql5718_mroonga702 | 5.7.18 | 7.02    | 7.0.2   |
| mysql5718_mroonga703 | 5.7.18 | 7.03    | 7.0.3   |
| mysql5718_mroonga704 | 5.7.18 | 7.04    | 7.0.4   |
| mysql5719_mroonga705 | 5.7.19 | 7.05    | 7.0.5   |
| mysql5719_mroonga706 | 5.7.19 | 7.06    | 7.0.6   |
| mysql5719_mroonga707 | 5.7.19 | 7.07    | 7.0.7   |
| mysql5720_mroonga708 | 5.7.20 | 7.08    | 7.0.8   |
| mysql5720_mroonga709 | 5.7.20 | 7.09    | 7.0.9   |
| mysql5720_mroonga710 | 5.7.20 | 7.10    | 7.1.0   |
| mysql5721_mroonga711 | 5.7.21 | 7.11    | 7.1.1   |
| mysql5721_mroonga800 | 5.7.21 | 8.00    | 8.0.0   |
| mysql5721_mroonga801 | 5.7.21 | 8.01    | 8.0.1   |
| mysql5722_mroonga802 | 5.7.22 | 8.02    | 8.0.2   |
| mysql5722_mroonga803 | 5.7.22 | 8.03    | 8.0.3   |
| mysql5723_mroonga806 | 5.7.23 | 8.06    | 8.0.6   |
| mysql5723_mroonga807 | 5.7.23 | 8.07    | 8.0.7   |
| mysql5724_mroonga809 | 5.7.24 | 8.09    | 8.0.9   |


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

