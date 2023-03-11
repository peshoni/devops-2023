#!/bin/bash

/vagrant/goprom/runner.sh http://192.168.99.102:8081 &>/tmp/runner8082.log &
/vagrant/goprom/runner.sh http://192.168.99.102:8082 &>/tmp/runner8082.log &
