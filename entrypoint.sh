#!/usr/bin/env bash
set -euo pipefail

/usr/sbin/nginx && uwsgi --ini /opt/datawire/pokemon/config/uwsgi.ini
