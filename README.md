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

### For MySQL 5.7

| tag                    | MySQL  | Mroonga | Groonga |
|------------------------|--------|---------|---------|
| latest                 | 5.7.33 | 11.00   | 11.0.0  |
| mysql5733\_mroonga1100 | 5.7.33 | 11.00   | 11.0.0  |
| mysql5733\_mroonga1011 | 5.7.33 | 10.11   | 10.1.1  |
| mysql5732\_mroonga1010 | 5.7.32 | 10.10   | 10.1.0  |
| mysql5729\_mroonga1001 | 5.7.29 | 10.01   | 10.0.1  |
| mysql5729\_mroonga912  | 5.7.29 | 9.12    | 9.1.2   |
| mysql5728\_mroonga909  | 5.7.28 | 9.09    | 9.0.9   |
| mysql5727\_mroonga907  | 5.7.27 | 9.07    | 9.0.7   |
| mysql5727\_mroonga905  | 5.7.27 | 9.05    | 9.0.5   |
| mysql5726\_mroonga904  | 5.7.26 | 9.04    | 9.0.4   |
| mysql5726\_mroonga903  | 5.7.26 | 9.03    | 9.0.3   |
| mysql5726\_mroonga901  | 5.7.26 | 9.01    | 9.0.2   |
| mysql5725\_mroonga900  | 5.7.25 | 9.00    | 9.0.0   |
| mysql5724\_mroonga809  | 5.7.24 | 8.09    | 8.0.9   |
| mysql5723\_mroonga807  | 5.7.23 | 8.07    | 8.0.7   |
| mysql5723\_mroonga806  | 5.7.23 | 8.06    | 8.0.6   |
| mysql5722\_mroonga803  | 5.7.22 | 8.03    | 8.0.3   |
| mysql5722\_mroonga802  | 5.7.22 | 8.02    | 8.0.2   |
| mysql5721\_mroonga801  | 5.7.21 | 8.01    | 8.0.1   |
| mysql5721\_mroonga800  | 5.7.21 | 8.00    | 8.0.0   |
| mysql5721\_mroonga711  | 5.7.21 | 7.11    | 7.1.1   |
| mysql5720\_mroonga710  | 5.7.20 | 7.10    | 7.1.0   |
| mysql5720\_mroonga709  | 5.7.20 | 7.09    | 7.0.9   |
| mysql5720\_mroonga708  | 5.7.20 | 7.08    | 7.0.8   |
| mysql5719\_mroonga707  | 5.7.19 | 7.07    | 7.0.7   |
| mysql5719\_mroonga706  | 5.7.19 | 7.06    | 7.0.6   |
| mysql5719\_mroonga705  | 5.7.19 | 7.05    | 7.0.5   |
| mysql5718\_mroonga704  | 5.7.18 | 7.04    | 7.0.4   |
| mysql5718\_mroonga703  | 5.7.18 | 7.03    | 7.0.3   |
| mysql5718\_mroonga702  | 5.7.18 | 7.02    | 7.0.2   |
| mysql5717\_mroonga701  | 5.7.17 | 7.01    | 7.0.1   |
| mysql5717\_mroonga700  | 5.7.17 | 7.00    | 7.0.0   |
| mysql5717\_mroonga613  | 5.7.17 | 6.13    | 6.1.5   |
| mysql5716\_mroonga611  | 5.7.16 | 6.11    | 6.1.1   |
| mysql5716\_mroonga610  | 5.7.16 | 6.10    | 6.1.0   |
| mysql5716\_mroonga609  | 5.7.16 | 6.09    | 6.0.9   |
| mysql5715\_mroonga608  | 5.7.15 | 6.08    | 6.0.8   |
| mysql5714\_mroonga607  | 5.7.14 | 6.07    | 6.0.7   |
| mysql5713\_mroonga606  | 5.7.13 | 6.06    | 6.0.5   |
| mysql5713\_mroonga605  | 5.7.13 | 6.05    | 6.0.5   |
| mysql5713\_mroonga603  | 5.7.13 | 6.03    | 6.0.4   |
| mysql5712\_mroonga602  | 5.7.12 | 6.02    | 6.0.2   |
| mysql5711\_mroonga601  | 5.7.11 | 6.01    | 6.0.1   |
| mysql5711\_mroonga600  | 5.7.11 | 6.00    | 6.0.0   |
| mysql5711\_mroonga512  | 5.7.11 | 5.12    | 5.1.2   |
| mysql5710\_mroonga511  | 5.7.10 | 5.11    | 5.1.1   |
| mysql5710\_mroonga510  | 5.7.10 | 5.10    | 5.1.0   |
| mysql579\_mroonga509   | 5.7.9  | 5.09    | 5.0.9   |

### For MySQL 8.0

| tag                    | MySQL  | Mroonga | Groonga |
|------------------------|--------|---------|---------|
| mysql80-latest         | 8.0.23 | 11.00   | 11.0.0  |
| mysql8023\_mroonga1100 | 8.0.23 | 11.00   | 11.0.0  |
| mysql8023\_mroonga1011 | 8.0.23 | 10.11   | 10.1.1  |
| mysql8022\_mroonga1010 | 8.0.22 | 10.10   | 10.1.0  |
| mysql8019\_mroonga1001 | 8.0.19 | 10.01   | 10.0.1  |
| mysql8019\_mroonga912  | 8.0.18 | 9.12    | 9.1.2   |
| mysql8018\_mroonga909  | 8.0.18 | 9.09    | 9.0.9   |
| mysql8017\_mroonga907  | 8.0.17 | 9.07    | 9.0.7   |
| mysql8017\_mroonga905  | 8.0.17 | 9.05    | 9.0.5   |
| mysql8016\_mroonga904  | 8.0.16 | 9.04    | 9.0.4   |

### For MySQL 5.6

EOL

| tag                    | MySQL  | Mroonga | Groonga |
|------------------------|--------|---------|---------|
| mysql56-latest         | 5.6.50 | 10.10   | 10.1.0  |
| mysql5650\_mroonga1010 | 5.6.50 | 10.10   | 10.1.0  |
| mysql5647\_mroonga1001 | 5.6.47 | 10.01   | 10.0.1  |
| mysql5647\_mroonga912  | 5.6.47 | 9.12    | 9.1.2   |
| mysql5646\_mroonga909  | 5.6.46 | 9.09    | 9.0.9   |
| mysql5645\_mroonga907  | 5.6.45 | 9.07    | 9.0.7   |
| mysql5645\_mroonga905  | 5.6.45 | 9.05    | 9.0.5   |
| mysql5644\_mroonga904  | 5.6.44 | 9.04    | 9.0.4   |
| mysql5644\_mroonga903  | 5.6.44 | 9.03    | 9.0.3   |
| mysql5644\_mroonga901  | 5.6.44 | 9.01    | 9.0.2   |
| mysql5643\_mroonga900  | 5.6.43 | 9.00    | 9.0.0   |
| mysql5642\_mroonga809  | 5.6.42 | 8.09    | 8.0.9   |
| mysql5641\_mroonga807  | 5.6.41 | 8.07    | 8.0.7   |
| mysql5641\_mroonga806  | 5.6.41 | 8.06    | 8.0.6   |
| mysql5640\_mroonga803  | 5.6.40 | 8.03    | 8.0.3   |
| mysql5640\_mroonga802  | 5.6.40 | 8.02    | 8.0.2   |
| mysql5639\_mroonga801  | 5.6.39 | 8.01    | 8.0.1   |
| mysql5639\_mroonga800  | 5.6.39 | 8.00    | 8.0.0   |
| mysql5639\_mroonga711  | 5.6.39 | 7.11    | 7.1.1   |
| mysql5638\_mroonga710  | 5.6.38 | 7.10    | 7.1.0   |
| mysql5638\_mroonga709  | 5.6.38 | 7.09    | 7.0.9   |
| mysql5638\_mroonga708  | 5.6.38 | 7.08    | 7.0.8   |
| mysql5637\_mroonga707  | 5.6.37 | 7.07    | 7.0.7   |
| mysql5637\_mroonga706  | 5.6.37 | 7.06    | 7.0.6   |
| mysql5637\_mroonga705  | 5.6.37 | 7.05    | 7.0.5   |
| mysql5636\_mroonga704  | 5.6.36 | 7.04    | 7.0.4   |
| mysql5636\_mroonga703  | 5.6.36 | 7.03    | 7.0.3   |
| mysql5636\_mroonga702  | 5.6.36 | 7.02    | 7.0.2   |
| mysql5635\_mroonga701  | 5.6.35 | 7.01    | 7.0.1   |
| mysql5635\_mroonga700  | 5.6.35 | 7.00    | 7.0.0   |
| mysql5635\_mroonga613  | 5.6.35 | 6.13    | 6.1.5   |
| mysql5635\_mroonga611  | 5.6.35 | 6.11    | 6.1.1   |
| mysql5634\_mroonga610  | 5.6.34 | 6.10    | 6.1.0   |
| mysql5634\_mroonga609  | 5.6.34 | 6.09    | 6.0.9   |
| mysql5633\_mroonga608  | 5.6.33 | 6.08    | 6.0.8   |
| mysql5632\_mroonga607  | 5.6.32 | 6.07    | 6.0.7   |
| mysql5631\_mroonga606  | 5.6.31 | 6.06    | 6.0.5   |
| mysql5631\_mroonga605  | 5.6.31 | 6.05    | 6.0.5   |
| mysql5631\_mroonga603  | 5.6.31 | 6.03    | 6.0.4   |
| mysql5630\_mroonga602  | 5.6.30 | 6.02    | 6.0.2   |
| mysql5629\_mroonga601  | 5.6.29 | 6.01    | 6.0.1   |
| mysql5629\_mroonga600  | 5.6.29 | 6.00    | 6.0.0   |
| mysql5628\_mroonga512  | 5.6.28 | 5.12    | 5.1.2   |
| mysql5628\_mroonga511  | 5.6.28 | 5.11    | 5.1.1   |
| mysql5628\_mroonga510  | 5.6.28 | 5.10    | 5.1.0   |
| mysql5627\_mroonga509  | 5.6.27 | 5.09    | 5.0.9   |
| mysql5627\_mroonga508  | 5.6.27 | 5.08    | 5.0.8   |
| mysql5626\_mroonga506  | 5.6.26 | 5.06    | 5.0.6   |
| mysql5623\_mroonga410  | 5.6.23 | 4.10    | 4.1.1   |

## How to build Mroonga image

* Dockerfile for some couples of MySQL and Mroonga are under "Dockerfile" directory.

```shell
$ git clone https://github.com/mroonga/docker mroonga_docker
$ cd mroonga_docker
$ sudo docker build -t mysql57-mroonga mysql57
$ sudo docker build -t mysql80-mroonga mysql80
```

## How to test

```shell
$ git clone https://github.com/mroonga/docker mroonga_docker
$ cd mroonga_docker
$ test/build.sh mysql57
$ test/build.sh mysql80
```

## How to release

```shell
$ ./update.sh ${MYSQL_VERSION} ${MROONGA_VERSION} ${GROONGA_VERSION}
(./update.sh 5.7.26 9.04 9.0.4)
$ git push
$ git push --tags
```

## Contribution

* Patches welcome both test-script and Dockerfile.
