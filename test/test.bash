#!/usr/bin/env bash

set -x

./test/setup.bash
./test/shellcheck.bash
./test/bats.bash
