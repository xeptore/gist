#!/usr/bin/env bash

# - Logs the command and arguments
# - Runs directly (no extra shell)
# - Exits on any failure
# Best for: straightforward commands without complex shell syntax

run() {
  echo "+ $*"
  "$@" || { echo 'Error executing command, exiting'; exit 1; }
}
