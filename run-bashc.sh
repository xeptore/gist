#!/usr/bin/env bash

# - Logs the command string
# - Always executes via "bash -c"
# - Exits on failure
# Best for: complex shell one-liners (pipes, &&, ||, subshells, etc.)

run() {
  echo "+ $1"
  bash -c "$1" || { echo 'Error executing command, exiting'; exit 1; }
}
