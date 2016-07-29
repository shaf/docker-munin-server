# Munin (server)

Docker container for [munin][1] monitoring
Primarily created for unRAID server but has other use cases

#### Contents
   - munin
   - munin node
   - lm-sensors (assumes host drivers are loaded)
   - apache

#### Environment

- TZ : Timezone (default: Europe/London)
- HOSTNAME : Rename Munin local hostname (default: unRAID)
- ALLOWED_HOSTS : CIPR notation eg 192.168.1.0/24(class C) or 192.168.0.3/32(single host). Use If intending to monitor this host from an enternal munin server (default: 127.0.0.1/32)

#### Ports

80 : Apache
4949 : munin-node (optional) 

#### Make

```sh
docker build -t shaf/munin-server .
```

#### Usage

```sh
# Modify env variables to suit your needs
# Remove appdata volumes if historic data is not needed
docker run -d --name=munin-server --net="bridge" -e ALLOWED_HOSTS="0/0" -e HOSTNAME="unRAID" -e TZ="Europe/London" -p 8888:80/tcp -p 4949:4949/tcp -v "/mnt/user/appdata/munin-server/www":"/var/cache/munin/www":rw -v "/mnt/user/appdata/munin-server/rrd":"/var/lib/munin":rw -v "/":"/rootfs":ro -v "/sys":"/sys":ro shaf/munin-server

# Barebones no data retention
docker run -d --name=munin-server --net="bridge" -p 8888:80/tcp -v "/":"/rootfs":ro -v "/sys":"/sys":ro shaf/munin-server
```

Munin interface accessible via http://host:8888/

#### To Do

- Write better documentation
- Enable more pluggins
- Remove or move logging (apache,munin)
- Slimstream, remove services cron/apache2

[1]: http://munin-monitoring.org/