#! /bin/bash

bin/rails wasmify:build:core
bin/rails wasmify:pack:core
bin/rails wasmify:pack
