#!/bin/bash

# this is a file named so that Github Codespaces can find it
# and run it automatically when the container is created
# https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-codespaces-for-your-account#automatically-running-a-script-when-a-codespace-is-created

DIRNAME=$(dirname "$0")
pushd "$DIRNAME" || exit
./copy-shared
popd || exit