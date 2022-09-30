#!/usr/bin/env bash

EXTENSION=$1
RELEASE=$2

TAR_URL=$(curl -s "https://www.mediawiki.org/w/api.php?action=query&list=extdistbranches&edbexts=$EXTENSION&formatversion=2&format=json" | jq -r ".query.extdistbranches.extensions.$EXTENSION.REL${RELEASE}")
echo -n "Downloading $1 from $TAR_URL..."
curl -s "$TAR_URL" -o "$EXTENSION".tar.gz
echo " OK"
echo -n "Unpacking..."
tar xzf "$EXTENSION".tar.gz && rm "$EXTENSION".tar.gz
echo " OK"

# This script automatically downloads the right tarball for a specific version of Mediwiki.
# Script copied from https://github.com/wmde/wikibase-docker/blob/master/wikibase/1.34/bundle/download-extension.sh