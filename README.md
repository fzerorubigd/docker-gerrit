# docker-gerrit
dockerized gerrit

## Run it

```
docker run -ti -v /docker-data/gerrit:/home/gerrit/data  fzerorubigd/gerrit 

```

Also you can forward ssh port 29418 to port 22 (using -p 22:29418 ) and use this in your configuration:

```
[sshd]
        listenAddress = *:29418
        advertisedAddress = gerrit.example.com
```

## gitweb 

git web is installed in container just add this to your git config : 

```
[gitweb]
        cgi = /usr/lib/cgi-bin/gitweb.cgi
```

## If you use the version >7 of OpenSSH 

must add this into your client ssh config (a workaround, witing for new version of gerrit to fix) :

~/.ssh/config
```
Host gerrit.example.com
    KexAlgorithms +diffie-hellman-group1-sha1
```
