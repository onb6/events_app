#!/bin/bash

export MIX_ENV=prod
export PORT=5678

CFGD=$(readlink -f ~/.config/events)

if [ ! -e "$CFGD/base" ]; then
    echo "run deploy first"
    exit 1
fi

SECRET_KEY_BASE=$(cat "$CFGD/base")
export SECRET_KEY_BASE

export DATABASE_URL=ecto://events_app:r5!r96F\\@localhost/events_app_prod

_build/prod/rel/events_app/bin/events_app start
