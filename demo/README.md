# Demo configuration

It uses the latest `develop` branches. It's only intended to test the Torrust Index, not to be used in production or development environments. Please, refer to each project's README for more information about how to run them using docker.

## Requirements

- Docker version 24.0.3, build 3713ee1.
- GNU bash, version 5.2.15(1)-release (x86_64-pc-linux-gnu).

## Install

```s
mkdir ~/Tmp && cd ~/Tmp
git clone git@github.com:torrust/torrust-compose.git
cd torrust-compose/demo
./bin/install.sh
```

## Usage

To start the application:

```s
./bin/start.sh
```

To stop the application:

```s
./bin/stop.sh
```

By default, the application will:

- Be available at <http://localhost:3000>.
- Use the `./storage/database` directory to store the data.
- Use SQLite as the database engine.

After starting the application you should see these running containers:

```s
$ docker ps
CONTAINER ID   IMAGE                            COMMAND                  CREATED          STATUS                    PORTS                                                                                            NAMES
3e2549e339fc   torrust/index-frontend:develop   "docker-entrypoint.s…"   7 seconds ago    Up 6 seconds              0.0.0.0:3000->3000/tcp, :::3000->3000/tcp, 0.0.0.0:24678->24678/tcp, :::24678->24678/tcp         torrust-idx-fron-1
b2c61c3cfd2a   torrust/index-backend:develop    "/app/main"              18 seconds ago   Up 6 seconds              3000/tcp, 0.0.0.0:3001->3001/tcp, :::3001->3001/tcp                                              torrust-idx-back-1
2b06456f2ecf   torrust/tracker:develop          "/app/torrust-tracker"   28 seconds ago   Up 6 seconds              0.0.0.0:1212->1212/tcp, :::1212->1212/tcp, 0.0.0.0:6969->6969/udp, :::6969->6969/udp, 7070/tcp   torrust-tracker-1
6c08728d8e91   mysql:8.0                        "docker-entrypoint.s…"   3 hours ago      Up 59 minutes (healthy)   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp                                             torrust-mysql-1
ca3da0894712   dockage/mailcatcher:0.8.2        "entrypoint mailcatc…"   3 hours ago      Up 59 minutes             0.0.0.0:1025->1025/tcp, :::1025->1025/tcp, 0.0.0.0:1080->1080/tcp, :::1080->1080/tcp             torrust-mailcatcher-1
```
