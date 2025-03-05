#!/bin/bash
# Script to recover the build_release.sh script from line 70 onwards

# Default source path
SRC="/mnt/f/sources/chromium/src"
BUILD_FOLDER="Release_arm64"

# Sign
AAB_FILE="${SRC}/out/${BUILD_FOLDER}/apks/MonochromePublic6432.aab"

if [[ -f ${AAB_FILE} ]]; then
    echo "Signing AAB file: ${AAB_FILE}"
    apksigner sign --ks ~/KeyStore/store.jks --min-sdk-version 24 ${AAB_FILE}
    if [[ $? -eq 0 ]]; then
        echo "Signing completed successfully."
    else
        echo "Signing failed! You can retry signing without rebuilding by running:"
        echo "  apksigner sign --ks ~/KeyStore/store.jks --min-sdk-version 24 ${AAB_FILE}"
        exit 1
    fi
else
    echo "ERROR: AAB file not found at ${AAB_FILE}. Exiting."
    exit 1
fi

echo "Script execution completed successfully!"
