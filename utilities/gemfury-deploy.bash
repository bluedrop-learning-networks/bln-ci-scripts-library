#!/usr/bin/env bash

# GemFury Deploy
#
# The following packages are required:
# - npm
# - curl
#
# Use following environment variables to your project configuration as needed
# * GEM_FURY_API_KEY: The GemFury API key
#
# Include in your builds via
# \curl -sSL https://bitbucket.org/coursepark/codeship-scripts/raw/master/utilities/gemfury-deploy.bash | bash -s

set -e
set -u
set -o pipefail

if [[ -z "${GEM_FURY_API_KEY:-}" ]]; then
	message "$(highlight "GEM_FURY_API_KEY") is not set, cannot continue"
	exit 1
fi

cd "$(npm prefix)"

package_name="$( (npm ls --depth=0  || true) | head -n 1 | sed 's/\(.*\)@.*/\1/')"
package_version="$( (npm ls --depth=0  || true) | head -n 1 | grep -o -e '[0-9]*\.[0-9]*\.[0-9]*')"
remote_version="$(npm view --@bluedrop:registry="https://npm.fury.io/${GEM_FURY_API_KEY}/bluedrop/" "${package_name}" version || : '')"

echo "Remote Version: $remote_version; Local Version: $package_version"

if [[ "${package_version}" != "${remote_version}" ]]; then
	echo "Package version bumped, releasing"
	curl -F "package=@$(npm pack)" "https://${GEM_FURY_API_KEY}@push.fury.io/bluedrop/"
fi
