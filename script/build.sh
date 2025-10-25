#! /bin/bash

bin/rails wasmify:build:core
bin/rails wasmify:pack:core
bin/rails wasmify:pack

pushd pwa
yarn install
yarn build
popd

git checkout gh-pages
git pull origin refs/heads/gh-pages
# docs is the only allowed directory (aside from the root) for GitHub Pages
rm -rf docs
mkdir docs
echo "todo-app.livecomponent.org" > docs/CNAME
cp -R pwa/dist/ ./docs/
git add -A docs
git commit -m "Release"
git push origin gh-pages
git checkout -
