#!/usr/bin/env bash

debug() { echo -e "\033[0;37m$*\033[0m"; }
info() { echo -e "\033[0;36m$*\033[0m"; }
error() { >&2  echo -e "\033[0;31m$*\033[0m"; }
fail() { error ${1}; exit ${2:-1}; }

set -euo pipefail

info "Installing Bats"
# bats installs to ${HOME}/bats/bin
export PATH="${HOME}/bats/bin/:${PATH}"
bash ./utilities/bats-install.bash
ln -sf "${HOME}/bats/bin/"* "${HOME}/bin/"

# deprecated in favor of dedicated github actions Step
# or add conditional logic so human operators can run that step on their workstations if they wish
# info "Installing Shellcheck"
# bash ./utilities/shellcheck-install.bash
