#!/usr/bin/env bash

# Install ShellCheck - http://www.shellcheck.net/
#
# The following packages are required:
# - wget
# - tar
# - xz
#
# Use following environment variables to your project configuration as needed
# * SHELLCHECK_VERSION: The bats version to install (default stable)
#
# Include in your builds via
# \curl -sSL https://bitbucket.org/coursepark/codeship-scripts/raw/master/utilities/shellcheck-install.bash | bash -s

set -e

SHELLCHECK_VERSION="${SHELLCHECK_VERSION:-stable}"
wget "https://storage.googleapis.com/shellcheck/shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz"
tar --xz -xvf "shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz"
cp shellcheck-"${SHELLCHECK_VERSION}"/shellcheck "${HOME}/bin/"
shellcheck --version
