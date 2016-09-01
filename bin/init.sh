#!/usr/bin/env bash
set -e

# Copyright 2016 Datawire. All rights reserved.

IGNORE_INIT=false

init() {
  if [ -d .terraform ]; then
    if [ -e .terraform/terraform.tfstate ]; then
      printf "%s\n" "Remote state already exist!"
      if [ "$IGNORE_INIT" = false ]; then
        exit 0
      fi
    fi
  fi

  terraform remote config \
    -backend=gcs \
    -backend-config="project=${google_project}" \
    -backend-config="bucket=${state_bucket}" \
    -backend-config="path=${state_path}" \
    -backend-config="region=${state_region}"
}

while getopts "i" opt; do
  case "$opt" in
    i)
      IGNORE_INIT=true
      ;;
  esac
done

shift $((OPTIND-1))

init