#!/usr/bin/env bash

debug() { echo -e "\033[0;37m$*\033[0m"; }
info() { echo -e "\033[0;36m$*\033[0m"; }
error() { >&2  echo -e "\033[0;31m$*\033[0m"; }
fail() { error ${1}; exit ${2:-1}; }

set -euo pipefail

info "Running Bash Automated Testing System..."
info "...on utilities scripts"
${HOME}/bin/bats test/utilities/*
