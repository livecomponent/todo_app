## LiveComponent Todo App

This repository contains a simple todo Rails application built using [LiveComponent](https://livecomponent.org). It is meant to showcase LiveComponent's functionality rather than actually be a good todo app :)

### Running Locally

In order to deploy the app to GitHub pages, it is compiled into a WASM module using the wasmify-rails gem. Normally you'd be able to run it locally as well, but due to a wasmify-rails [bug](https://github.com/palkan/wasmify-rails/pull/8) this is currently not possible.

To get things running locally:

1. Comment out the wasmify-rails dependency in the Gemfile
2. Comment out `require "wasmify/rails/shim"` in config/application.rb
3. Run `bin/rails db:schema:load`
3. Run `bin/dev`
4. Rejoice, for the app is running. Visit http://localhost:3000 in your browser.

### Deploying

Run `script/deploy.sh`.

### License

MIT

### Authors

* Cameron C. Dutro ([@camertron](https://github.com/camertron))
