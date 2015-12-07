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

