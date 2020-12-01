#!/usr/bin/env bash

set -x

./test/setup.bash

# deprecated in favor of dedicated github actions Step
# or add conditional logic so human operators can run that step on their workstations if they wish
# ./test/shellcheck.bash

./test/bats.bash
