# Droplet configuration

It's a sample production configuration to deploy the Index on a Digital Ocean droplet.

Please, refer to each project's README for more information about how to run them using docker.

## Requirements

- Docker version 24.0.7, build afdd53b.
- Docker Compose version v2.3.3.
- GNU bash, version 5.2.15(1)-release (x86_64-pc-linux-gnu).

## Install

Follow instructions from: <https://www.digitalocean.com/community/tutorials/how-to-secure-a-containerized-node-js-application-with-nginx-let-s-encrypt-and-docker-compose>.

We will publish an article on the <https://torrust.com/blog> with a detailed description of
the installation process.

```console
mkdir ~/Tmp && cd ~/Tmp
git clone git@github.com:torrust/torrust-compose.git
cd torrust-compose/droplet
./bin/install.sh
```

Edit the `.env` file to change the default Tracker API token:

```console
TORRUST_INDEX_TRACKER_API_TOKEN="your_secret_token"
TORRUST_TRACKER_API_ADMIN_TOKEN="your_secret_token"
```

### HTTPS

Get certificates:

Log into the `certbot` container:

```console
docker com1pose run --entrypoint /bin/sh certbot
```

Get staging certificates:

```console
certbot certonly --webroot --webroot-path=/var/www/html --email your@email.com --agree-tos --no-eff-email --staging -d index.torrust-demo.com
certbot certonly --webroot --webroot-path=/var/www/html --email your@email.com --agree-tos --no-eff-email --staging -d tracker.torrust-demo.com
```

Get production certificates:

```console
certbot certonly --webroot --webroot-path=/var/www/html --email your@email.com --agree-tos --no-eff-email --force-renewal -d index.torrust-demo.com
certbot certonly --webroot --webroot-path=/var/www/html --email your@email.com --agree-tos --no-eff-email --force-renewal -d tracker.torrust-demo.com
```

Check that the proxy can see the certificates:

```console
docker compose exec proxy ls -la /etc/letsencrypt/live
```

Generate your key with the openssl command:

```console
sudo openssl dhparam -out /home/torrust/github/torrust/torrust-compose/droplet/storage/dhparam/dhparam-2048.pem 2048
```

Edit the Nginx config file:

```console
vim ./storage/proxy/etc/nginx-conf/nginx.conf
```

Uncomment the lines for HTTPS servers and recreate the proxy with:

```console
docker compose up -d --force-recreate --no-deps proxy
```

Edit the `.env` file changing the API base URL to use HTTPS:

```console
TORRUST_INDEX_GUI_API_BASE_URL='https://index.torrust-demo.com/api/v1'
```

Add the following cronjob with `sudo crontab -e` to auto-renew certificates:

```text
0 12 * * * /home/torrust/github/torrust/torrust-compose/droplet/bin/ssl_renew.sh >> /var/log/cron.log 2>&1
```

You can check the cronjob output with `tail -n 200  /var/log/cron.log`.

### Storage

This is how the storage folder is configured after installation (including HTTPS).

```console
$ sudo tree storage
storage
├── certbot
│   ├── etc
│   │   ├── accounts
│   │   │   ├── acme-staging-v02.api.letsencrypt.org
│   │   │   │   └── directory
│   │   │   │       └── b39c03e978384cf4e136df8366ab6539
│   │   │   │           ├── meta.json
│   │   │   │           ├── private_key.json
│   │   │   │           └── regr.json
│   │   │   └── acme-v02.api.letsencrypt.org
│   │   │       └── directory
│   │   │           └── 441a435b0f8057dfd96cc6dd22f34468
│   │   │               ├── meta.json
│   │   │               ├── private_key.json
│   │   │               └── regr.json
│   │   ├── archive
│   │   │   ├── index.torrust-demo.com
│   │   │   │   ├── cert1.pem
│   │   │   │   ├── chain1.pem
│   │   │   │   ├── fullchain1.pem
│   │   │   │   └── privkey1.pem
│   │   │   ├── index.torrust-demo.com-0001
│   │   │   │   ├── cert1.pem
│   │   │   │   ├── cert2.pem
│   │   │   │   ├── chain1.pem
│   │   │   │   ├── chain2.pem
│   │   │   │   ├── fullchain1.pem
│   │   │   │   ├── fullchain2.pem
│   │   │   │   ├── privkey1.pem
│   │   │   │   └── privkey2.pem
│   │   │   └── tracker.torrust-demo.com
│   │   │       ├── cert1.pem
│   │   │       ├── cert2.pem
│   │   │       ├── cert3.pem
│   │   │       ├── chain1.pem
│   │   │       ├── chain2.pem
│   │   │       ├── chain3.pem
│   │   │       ├── fullchain1.pem
│   │   │       ├── fullchain2.pem
│   │   │       ├── fullchain3.pem
│   │   │       ├── privkey1.pem
│   │   │       ├── privkey2.pem
│   │   │       └── privkey3.pem
│   │   ├── live
│   │   │   ├── README
│   │   │   ├── index.torrust-demo.com
│   │   │   │   ├── README
│   │   │   │   ├── cert.pem -> ../../archive/index.torrust-demo.com/cert1.pem
│   │   │   │   ├── chain.pem -> ../../archive/index.torrust-demo.com/chain1.pem
│   │   │   │   ├── fullchain.pem -> ../../archive/index.torrust-demo.com/fullchain1.pem
│   │   │   │   └── privkey.pem -> ../../archive/index.torrust-demo.com/privkey1.pem
│   │   │   ├── index.torrust-demo.com-0001
│   │   │   │   ├── README
│   │   │   │   ├── cert.pem -> ../../archive/index.torrust-demo.com-0001/cert2.pem
│   │   │   │   ├── chain.pem -> ../../archive/index.torrust-demo.com-0001/chain2.pem
│   │   │   │   ├── fullchain.pem -> ../../archive/index.torrust-demo.com-0001/fullchain2.pem
│   │   │   │   └── privkey.pem -> ../../archive/index.torrust-demo.com-0001/privkey2.pem
│   │   │   └── tracker.torrust-demo.com
│   │   │       ├── README
│   │   │       ├── cert.pem -> ../../archive/tracker.torrust-demo.com/cert3.pem
│   │   │       ├── chain.pem -> ../../archive/tracker.torrust-demo.com/chain3.pem
│   │   │       ├── fullchain.pem -> ../../archive/tracker.torrust-demo.com/fullchain3.pem
│   │   │       └── privkey.pem -> ../../archive/tracker.torrust-demo.com/privkey3.pem
│   │   ├── renewal
│   │   │   ├── index.torrust-demo.com-0001.conf
│   │   │   ├── index.torrust-demo.com.conf
│   │   │   └── tracker.torrust-demo.com.conf
│   │   └── renewal-hooks
│   │       ├── deploy
│   │       ├── post
│   │       └── pre
│   └── lib
├── dhparam
│   └── dhparam-2048.pem
├── index
│   ├── etc
│   │   └── index.toml
│   ├── lib
│   │   └── database
│   │       └── sqlite3.db
│   └── log
├── index-gui
│   └── log
├── proxy
│   ├── etc
│   │   └── nginx-conf
│   │       ├── nginx.conf
│   │       └── nginx.conf.bak
│   └── webroot
└── tracker
    ├── etc
    │   └── tracker.toml
    ├── lib
    │   └── database
    │       └── sqlite3.db
    └── log

40 directories, 56 files
```

## Usage

To start the application:

```s
docker compose up --build --detach
```

To stop the application:

```s
docker compose down
```

By default, the application will:

- Be available at <http://localhost:3000>.
- Use the `./storage` directory to store the data.
- Use SQLite as the database engine.

After starting the application you should see these running containers:

```s
$ docker ps
CONTAINER ID   IMAGE                       COMMAND                  CREATED         STATUS                   PORTS                                                                                                                                       NAMES
fbed1b994c7a   nginx:mainline-alpine       "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes             0.0.0.0:80->80/tcp, :::80->80/tcp, 0.0.0.0:443->443/tcp, :::443->443/tcp                                                                    proxy
5d8e6fb74102   torrust/index-gui:develop   "/usr/local/bin/entr…"   4 minutes ago   Up 4 minutes (healthy)   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp                                                                                                   index-gui
60854e389bb7   torrust/index:develop       "/usr/local/bin/entr…"   4 minutes ago   Up 4 minutes (healthy)   0.0.0.0:3001->3001/tcp, :::3001->3001/tcp                                                                                                   index
16b1a40d96f9   torrust/tracker:develop     "/usr/local/bin/entr…"   4 minutes ago   Up 4 minutes (healthy)   0.0.0.0:1212->1212/tcp, :::1212->1212/tcp, 0.0.0.0:7070->7070/tcp, :::7070->7070/tcp, 1313/tcp, 0.0.0.0:6969->6969/udp, :::6969->6969/udp   tracker
```

Other commands are:

Restart all (reloading env vars from `.env` file by forcing recreation):

```console
docker compose up -d --force-recreate
```

Restart proxy (to reload Nginx configuration):

```console
docker compose --ansi never restart proxy
```

Update container images (to upgrade the services):

```console
docker compose down
docker compose pull
docker compose up --build --detach
```
