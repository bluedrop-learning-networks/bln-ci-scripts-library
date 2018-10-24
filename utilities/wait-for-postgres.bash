#!/usr/bin/env bash

# Add the following environment variables to your project configuration
# * DATABASE_URL: The postgres connection url
# * MAX_ATTEMPTS: The number of attempts to make before giving up, each attempt is about 3-4 seconds
# * PGCONNECT_TIMEOUT: The connection timeout parameter for psql
#
# The following commands are required:
# * psql
#
# Include in your builds via
# \curl -sSL https://bitbucket.org/coursepark/codeship-scripts/raw/master/utilities/wait-for-postgres.bash | bash -s

if [[ -z "${DATABASE_URL:-}" ]]; then
	>&2 echo "DATABASE_URL is not set, cannot continue"
	exit 1
fi

if ! command -v psql &> /dev/null; then
	>&2 echo "psql command not found"
	exit 0
fi

# set connection timeout for psql
export PGCONNECT_TIMEOUT="${PGCONNECT_TIMEOUT:-1}"

max_attempts="${MAX_ATTEMPTS:-100}"
attempt_count=0
while ! psql -d "${DATABASE_URL}" -c '\q' &> /dev/null; do
	sleep 1
	attempt_count=$((attempt_count + 1))
	if [[ "${attempt_count}" -gt "$max_attempts" ]]; then
		>&2 echo "Postgres didn't become ready in time"
		exit 1
	fi
done
