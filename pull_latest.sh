#!/bin/bash
cd ~/chromium/src
git fetch
git reset --hard
git pull
gclient sync
cp ../automotive.patch .
git apply automotive.patch
rm automotive.patch
# Shouldn't have to run "gn args out/Release" 
gclient runhooks
