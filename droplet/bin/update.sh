#!/bin/bash

./bin/stop.sh
docker compose pull
./bin/start.sh
