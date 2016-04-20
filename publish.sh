#!/usr/bin/env bash

./build.sh
cd build
git init .
git remote add origin git@github.com:joelmccracken/idyll-farm.git
git checkout -b gh-pages
git add .
git commit -m 'automatic build'
git push origin -f gh-pages
