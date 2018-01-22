#!/usr/bin/env bash

debug() { echo -e "\033[0;37m$*\033[0m"; }
info() { echo -e "\033[0;36m$*\033[0m"; }
error() { >&2  echo -e "\033[0;31m$*\033[0m"; }
fail() { error ${1}; exit ${2:-1}; }

set -euo pipefail

info "Installing Bats"
# bats installs to ${HOME}/bats/bin
export PATH="${HOME}/bats/bin/:${PATH}"
\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/bats.sh | bash -s
ln -sf "${HOME}/bats/bin/"* "${HOME}/bin/"

echo ${PATH}
info "Installing Shellcheck"
\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/shellcheck.sh | bash -s


