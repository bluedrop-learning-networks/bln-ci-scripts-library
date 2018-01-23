#!/usr/bin/env bash

# Add the following environment variables to your project configuration
# * RABBITMQ_URL: The full rabbitmq connection url including port and vhost
# * RABBITMQ_TIMEOUT: The connection timeout parameter for
# * MAX_ATTEMPTS: The number of attempts to make before giving up, each attempt takes 1-4 seconds
#
# The following commands are required:
# * curl
#
# This script assumes that the RabbitMQ server has the `rabbitmq_management` plugin enabled
#
# Include in your builds via
# \curl -sSL https://bitbucket.org/coursepark/codeship-scripts/raw/master/utilities/wait-for-rabbitmq.bash | bash -s

shopt -s extglob

if [[ -z "${RABBITMQ_URL:-}" ]]; then
	>&2 echo "RABBITMQ_URL is not set, cannot continue"
	exit 1
fi

# remove amqp://
RABBITMQ_URL="${RABBITMQ_URL/amqp:\/\//}"
# remove query params
RABBITMQ_URL="${RABBITMQ_URL/\?*/}"
# replace port with admin port
RABBITMQ_URL="${RABBITMQ_URL/:+([[:digit:]])/:15672}"

if ! command -v curl &> /dev/null; then
	>&2 echo "curl command not found"
	exit 1
fi

max_attempts="${MAX_ATTEMPTS:-50}"
attempt_count=0
while ! curl --max-time "${RABBITMQ_TIMEOUT:-3}" -i "http://${RABBITMQ_URL}api/overview" &> /dev/null; do
	sleep 1
	attempt_count=$((attempt_count + 1))
	if [[ "${attempt_count}" -gt "$max_attempts" ]]; then
		>&2 echo "RabbitMQ didn't become ready in time"
		exit 1
	fi
done
