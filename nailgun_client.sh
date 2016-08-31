#!/bin/bash -ex

# Forward Ctrl-C to nailgun server
trap 'ps aux | grep java | grep nailgun | awk "{print \$2}" | xargs kill -s INT' INT

time jruby --ng hello_jdbc.rb
