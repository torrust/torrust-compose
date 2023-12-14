#!/bin/bash

TORRUST_INDEX_CONFIG_PATH=$(cat ./storage/index/etc/index.toml) \
TORRUST_TRACKER_CONFIG_PATH=$(cat ./storage/tracker/etc/tracker.toml) \
TORRUST_TRACKER_API_ADMIN_TOKEN=${TORRUST_TRACKER_API_ADMIN_TOKEN:-MyAccessToken} \
TORRUST_INDEX_TRACKER_API_TOKEN=${TORRUST_INDEX_TRACKER_API_TOKEN:-MyAccessToken} \
	docker compose --ansi never restart proxy
