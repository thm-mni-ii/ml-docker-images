#!/bin/bash

curl() {
    micromamba -n base run curl $@
    return $?
}

unzip() {
    micromamba -n base run unzip $@
    return $?
}

pip() {
    micromamba -n base run pip $@
    return $?
}

mkdir -p ~/gdds/
cd ~/gdds/

URL="https://git.thm.de/jhws42/ai-tutor-plugin/-/jobs/artifacts/master/download?job=build_gdds"
LAST_LOCATION_FILE="last_artifact.txt"
ZIP_FILE="artifacts.zip"

LOCATION=$(curl -Is "$URL" | grep -i "^Location:" | awk '{print $2}' | tr -d '\r\n')

if [[ -z "$LOCATION" ]]; then
    echo "Could not get gdds artifact redirect location."
    exit 1
fi

if [[ -f "$LAST_LOCATION_FILE" ]]; then
    LAST_LOCATION=$(cat "$LAST_LOCATION_FILE")
else
    LAST_LOCATION=""
fi

if [[ "$LOCATION" == "$LAST_LOCATION" ]]; then
    echo "No new gdds artifact found."
    exit 0
fi

echo "New gdds artifact found, downloading from $LOCATION ..."
curl -L "$LOCATION" -o "$ZIP_FILE"

if [[ $? -eq 0 ]]; then
    echo "$LOCATION" > "$LAST_LOCATION_FILE"
    echo "Downloaded new gdds artifact to $ZIP_FILE."
else
    echo "Failed to download ggs artifact."
    exit 1
fi

echo "Installing new gdds artifact..."
unzip "$ZIP_FILE"
cd dist
pip install *.whl
cd ..
rm -r dist
