#!/usr/bin/env bash

COMPOSER_LINE=$1

IFS=':' read -r -a SPLIT <<< "$COMPOSER_LINE"
EXTENSION="${SPLIT[0]}"
RELEASE="${SPLIT[1]}"

COMPOSER=composer.local.json composer require --no-update "$EXTENSION:$RELEASE";
composer update "$EXTENSION" --no-dev -o
