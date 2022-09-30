#!/bin/bash

docker build ./mediawiki -t wikibase:1.37-wbsg
docker build ./wikibase-bundle -t wikibase-bundle:1.37-wbsg
