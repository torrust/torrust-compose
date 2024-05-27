#!/bin/bash

# Generate the .env file if it does not exist
if ! [ -f "./.env" ]; then
	# Copy .env file from development template
	cp dot.env.local .env
fi

# Generate storage directory if it does not exist
mkdir -p "./storage"

# Storage dir for Tracker
mkdir -p ./storage/tracker/etc
mkdir -p ./storage/tracker/lib/database
mkdir -p ./storage/tracker/lib/tls
mkdir -p ./storage/tracker/lib/log

# Storage dir for Index
mkdir -p ./storage/index/etc
mkdir -p ./storage/index/lib/database
mkdir -p ./storage/index/lib/tls
mkdir -p ./storage/index/log

# Generate the sqlite database for the Index if it does not exist
if ! [ -f "./storage/index/lib/database/torrust_index_demo.db" ]; then
	touch ./storage/index/lib/database/torrust_index_demo.db
	echo ";" | sqlite3 ./storage/index/lib/database/torrust_index_demo.db
fi

# Generate the sqlite database for the Tracker if it does not exist
if ! [ -f "./storage/tracker/lib/database/torrust_tracker_demo.db" ]; then
	touch ./storage/tracker/lib/database/torrust_tracker_demo.db
	echo ";" | sqlite3 ./storage/tracker/lib/database/torrust_tracker_demo.db
fi
