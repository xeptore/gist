#!/usr/bin/env bash

# - Logs the command
# - If a single argument contains shell metacharacters, runs via "bash -c"
# - Otherwise runs directly
# - Exits on failure
# Best for: mixed scripts with both simple commands and complex shell lines

run() {
  echo "+ $*"
  if [ "$#" -eq 1 ] && [[ $1 =~ [\&\|\;\<\>\(\)\$\`] ]]; then
    bash -c "$1" || { echo 'Error executing command, exiting'; exit 1; }
  else
    "$@" || { echo 'Error executing command, exiting'; exit 1; }
  fi
}
