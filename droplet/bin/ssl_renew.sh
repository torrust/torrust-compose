#!/bin/bash

COMPOSE="/usr/bin/docker compose --ansi never"
DOCKER="/usr/bin/docker"

cd /home/torrust/github/torrust/torrust-compose/droplet || exit

# Run this just for testing purposes
#$COMPOSE run certbot renew --dry-run && $COMPOSE kill -s SIGHUP proxy

# Renew certificates that are close to expiring and restart proxy server
# to reload Nginx congiuration.
$COMPOSE run certbot renew && $COMPOSE --ansi never restart proxy

$DOCKER system prune -af
