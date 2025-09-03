#!/bin/bash

run() {
  local snippet
  if (($#)); then
    snippet="$*"
  else
    snippet="$(cat)"  # read from stdin (heredoc)
  fi

  # Preview: substitute environment variables for display only (no $(...))
  if command -v envsubst >/dev/null 2>&1; then
    printf '+ %s\n' "$(envsubst <<<"$snippet")" >&2
  else
    # Fallback preview if envsubst isn't available
    printf '+ %s\n' "$snippet" >&2
  fi

  # Execute in current shell so sourced functions/vars are visible
  # Temporarily enable pipefail and then restore previous shell options
  local _saved_opts
  _saved_opts="$(set +o)"          # capture current option states
  set -o pipefail

  eval "$snippet"
  local rc=$?

  eval "$_saved_opts"              # restore options exactly as they were
  return "$rc"
}
