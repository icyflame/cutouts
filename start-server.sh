#!/bin/bash

if [ ! -d /node/bin ];
then
  echo "Node must be present at node/bin"
  exit 42
fi

export PATH="$PATH:/node/bin"
cd /src
bundle exec puma --preload -t 8:32 --port 8081
