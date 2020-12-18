#!/usr/bin/env bash

# Install Bats - https://github.com/bats-core/bats-core
#
# The following commands are required:
# - wget
# - tar
#
# Use following environment variables to your project configuration as needed
# * BATS_VERSION: The bats version to install (default 1.1.0)
#
# Include in your builds via
# \curl -sSL https://bitbucket.org/coursepark/codeship-scripts/raw/master/utilities/bats-install.bash | bash -s
set -e

BATS_VERSION="${BATS_VERSION:-1.1.0}"
CACHED_DOWNLOAD="${HOME}/cache/bats-core-${BATS_VERSION}.tar.gz"

wget --continue --output-document "${CACHED_DOWNLOAD}" "https://github.com/bats-core/bats-core/archive/v${BATS_VERSION}.tar.gz"
tar -xaf "${CACHED_DOWNLOAD}" --directory "${HOME}"
mkdir -p "${HOME}/bats"
(
  cd "${HOME}/bats-core-${BATS_VERSION}"
  ./install.sh "${HOME}/bats"
)
rm -rf "${HOME}/bats-core-${BATS_VERSION}"
ln -fs "${HOME}/bats/bin/bats" "${HOME}/bin/"

"${HOME}"/bin/bats --version
