# Short description

Mroonga is Storage Engine for MySQL Full Text Search. Repository is maintained by Groonga Dev Team


# Full Description

Details about Mroonga is described at http://mroonga.org/docs/characteristic.html

You can start Mroonga as
```
$ sudo docker run -d groonga/mroonga
$ mysql -h <container's ipaddr> -u root
```

MySQL root account doesn't set any password and isn't limited by connecting host.
(This mean root was created by "GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION")


Now, we support to mount datadir from host machine like this.

```
$ sudo docker run -d -v /path/to/datadir:/var/lib/mysql groonga/mroonga
```

If your /path/to/datadir has ibdata1, container decides using datadir as is.
If your /path/to/datadir doesn't have ibdata1, container decides to re-initialize datadir for installing Mroonga.
