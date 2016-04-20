#!/usr/bin/env bash

mkdir -p build
elm-make Game.elm --output build/index.html
