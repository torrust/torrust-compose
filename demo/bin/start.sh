#!/bin/bash

USER_ID=${USER_ID:-1000} \
	TORRUST_INDEX_CONFIG_TOML=$(cat config-index.local.toml) \
	TORRUST_TRACKER_CONFIG_TOML=$(cat config-tracker.local.toml) \
	TORRUST_TRACKER_CONFIG_OVERRIDE_HTTP_API__ACCESS_TOKENS__ADMIN=${TORRUST_TRACKER_CONFIG_OVERRIDE_HTTP_API__ACCESS_TOKENS__ADMIN:-MyAccessToken} \
	docker compose up --build -d


