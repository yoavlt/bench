#!/bin/sh

MIX_ENV=prod mix do deps.get, compile
MIX_ENV=prod elixir -pa _build/prod/consolidated -S mix server
