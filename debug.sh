#!/bin/bash

dlv debug src/torb/app.go --headless --listen=:$REMOTE_DEBUG_PORT --accept-multiclient --continue