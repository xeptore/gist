#!/usr/bin/env bash
# run-nobail.sh
# ----------------------------
# Logs the command and arguments
# Runs directly (no extra shell)
# Does NOT exit on failure — caller must handle error code
# Best for: scripts where errors are expected and handled manually

run() { echo "+ $*"; "$@"; }
