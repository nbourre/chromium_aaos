#!/bin/bash
cd ~/chromium/src

ARCHITECTURE=arm64   # arm64 / x64 / emulator 

if [[ "$ARCHITECTURE" == "arm64" ]]; then
   echo "Building for arm64"
   BUILD_FOLDER="Release_arm64"
elif [[ "$ARCHITECTURE" == "x64" ]]; then
   echo "Building for x64"
   BUILD_FOLDER+="Release_X64"
else
   echo "unknown architecture; EXITING"
   exit 1
fi

VERSON_FILE=~/chromium/src/chrome/VERSION
# Bump Version
cp ~/chromium/VERSION ${VERSON_FILE}
MAJOR=$(head -n 1 ${VERSON_FILE})
version=${MAJOR#*_}
version=$((version + 1))
sed -i "1s/.*/MAJOR=${version}/" ${VERSON_FILE}
cp ${VERSON_FILE} ~/chromium/VERSION
cat ${VERSON_FILE}

# build
autoninja -C out/${BUILD_FOLDER} monochrome_public_bundle
# sign
$HOME/Android/Sdk/build-tools/35.0.0/apksigner sign --ks $HOME/Documents/KeyStore/store.jks --min-sdk-version 24 $HOME/chromium/src/out/${BUILD_FOLDER}/apks/MonochromePublic6432.aab
