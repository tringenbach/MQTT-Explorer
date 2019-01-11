#!/bin/bash

DIR=build/clean

rm -rf "$DIR"
mkdir -p "$DIR"
git clone .git "$DIR"

ORIGINAL_DIR=`pwd`
cd $DIR
cd app && npm install; cd ..
cd backend && npm install; cd ..
npm run build
rm -rf app/node_modules
cd "$ORIGINAL_DIR"

node_modules/.bin/ts-node build.ts
exit 0
docker run --rm -ti \
 --env ELECTRON_CACHE="/root/.cache/electron" \
 --env ELECTRON_BUILDER_CACHE="/root/.cache/electron-builder" \
 --env GH_TOKEN="$GH_TOKEN" \
 -v ${PWD}:/project \
 -v ~/.cache/electron:/root/.cache/electron \
 -v ~/.cache/electron-builder:/root/.cache/electron-builder \
 electronuserland/builder:wine node_modules/.bin/ts-node build.ts