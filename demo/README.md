# Demo configuration

It uses the latest `develop` branches. It's only intended to test the Torrust Index, not to be used in production or development environments. Please, refer to each project's README for more information about how to run them using docker.

## Requirements

- Docker version 24.0.3, build 3713ee1.
- GNU bash, version 5.2.15(1)-release (x86_64-pc-linux-gnu).

## Install

```s
mkdir ~/Tmp && cd ~/Tmp \
  && git clone git@github.com:torrust/torrust-compose.git \
  && cd torrust-compose/demo \
  && ./bin/install.sh
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
CONTAINER ID   IMAGE                       COMMAND                  CREATED         STATUS                            PORTS                                                                                                      NAMES
a8bf2370e427   torrust/index-gui:develop   "/usr/local/bin/entrypoint.sh"   5 seconds ago   Up 3 seconds (health: starting)   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp, 0.0.0.0:24678->24678/tcp, :::24678->24678/tcp                   torrust-index-gui-1
302fe5775c8e   torrust/index:develop       "/usr/local/bin/entrypoint.sh"   5 seconds ago   Up 3 seconds (health: starting)   0.0.0.0:3001->3001/tcp, :::3001->3001/tcp                                                                  torrust-index-1
911d250a5cd6   torrust/tracker:develop     "/usr/local/bin/entrypoint.sh"   5 seconds ago   Up 4 seconds (health: starting)   1313/tcp, 0.0.0.0:1212->1212/tcp, :::1212->1212/tcp, 7070/tcp, 0.0.0.0:6969->6969/udp, :::6969->6969/udp   torrust-tracker-1
9e72b195abf1   mysql:8.0                   "docker-entrypoint.s…"   5 seconds ago   Up 4 seconds (healthy)            0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp                                                       torrust-mysql-1
dd8db76545eb   dockage/mailcatcher:0.8.2   "entrypoint mailcatcher"   5 seconds ago   Up 4 seconds                      0.0.0.0:1025->1025/tcp, :::1025->1025/tcp, 0.0.0.0:1080->1080/tcp, :::1080->1080/tcp                       torrust-mailcatcher-1
```
