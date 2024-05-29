#!/bin/bash

if ! [ -f "./.env" ]; then
	echo "Creating compose .env './.env'"
	cp .env.production .env
fi

## Proxy

mkdir -p ./storage/proxy/etc/nginx-conf
mkdir -p ./storage/proxy/webroot
mkdir -p ./storage/dhparam

if ! [ -f "./storage/proxy/etc/nginx-conf/nginx.conf" ]; then
	echo "Creating proxy config file: './storage/proxy/etc/nginx-conf/nginx.conf'"
	cp ./share/container/default/config/nginx.conf ./storage/proxy/etc/nginx-conf/nginx.conf
fi

## Certbot

mkdir -p ./storage/certbot/etc
mkdir -p ./storage/certbot/lib

## Index

mkdir -p ./storage/index/etc
mkdir -p ./storage/index/lib/database
mkdir -p ./storage/index/lib/tls
mkdir -p ./storage/index/log

# Generate the Index sqlite database directory and file if it does not exist

if ! [ -f "./storage/index/lib/database/sqlite3.db" ]; then
	echo "Creating index database: './storage/index/lib/database/sqlite3.db'"
	sqlite3 "./storage/index/lib/database/sqlite3.db" "VACUUM;"
fi

mkdir -p ./storage/index/etc

if ! [ -f "./storage/index/etc/index.prod.container.sqlite3.toml" ]; then
	echo "Creating index configuration: './storage/index/etc/index.toml'"
	cp ./share/container/default/config/index.prod.container.sqlite3.toml ./storage/index/etc/index.toml
fi

## Tracker

mkdir -p ./storage/tracker/etc
mkdir -p ./storage/tracker/lib/database
mkdir -p ./storage/tracker/lib/tls
mkdir -p ./storage/tracker/lib/log

# Generate the Tracker sqlite database directory and file if it does not exist

if ! [ -f "./storage/tracker/lib/database/sqlite3.db" ]; then
	echo "Creating tracker database: './storage/tracker/lib/database/sqlite3.db'"
	sqlite3 "./storage/tracker/lib/database/sqlite3.db" "VACUUM;"
fi

mkdir -p ./storage/tracker/etc

if ! [ -f "./storage/tracker/etc/tracker.prod.container.sqlite3.toml" ]; then
	echo "Creating tracker configuration: './storage/tracker/etc/tracker.toml'"
	cp ./share/container/default/config/tracker.prod.container.sqlite3.toml ./storage/tracker/etc/tracker.toml
fi
