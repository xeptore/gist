#!/usr/bin/env bash

# Same as run-hybrid.sh, but never exits automatically on failure
# Best for: flexible logging without forced exit

run() {
  echo "+ $*"
  if [ "$#" -eq 1 ] && [[ $1 =~ [\&\|\;\<\>\(\)\$\`] ]]; then
    bash -c "$1"
  else
    "$@"
  fi
}
