# Short description

Mroonga is Storage Engine for MySQL Full Text Search. Repository is maintained by Groonga Dev Team


# Full Description

Details about Mroonga is described at http://mroonga.org/docs/characteristic.html


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
|latest              |5.6.28|5.12   |
|mysql5623_mroonga410|5.6.23|4.10   |
|mysql5626_mroonga506|5.6.26|5.06   |
|mysql5627_mroonga508|5.6.27|5.08   |
|mysql5627_mroonga509|5.6.27|5.09   |
|mysql5628_mroonga510|5.6.28|5.10   |
|mysql5628_mroonga511|5.6.28|5.11   |
|mysql5628_mroonga512|5.6.28|5.12   |
|mysql579_mroonga509 |5.7.9 |5.09   |
|mysql5710_mroonga510|5.7.10|5.10   |
|mysql5710_mroonga511|5.7.10|5.11   |
|mysql5710_mroonga512|5.7.10|5.12   |
