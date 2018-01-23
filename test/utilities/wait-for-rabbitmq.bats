#!/usr/bin/env bats

setup() {
	export RABBITMQ_URL="${RABBITMQ_URL:-amqp://guest:guest@localhost:5672/}"
}

@test "[utilities/wait-for-rabbitmq.bash] Check if rabbitmq is available" {
	run ./utilities/wait-for-rabbitmq.bash
	[ "$status" -eq 0 ]
}

@test "[utilities/wait-for-rabbitmq.bash] Check if rabbitmq is not available" {
	MAX_ATTEMPTS=1 \
	DATABASE_URL=amqp://guest:guest@does-not-exist:5672/ \
	run ./utilities/wait-for-rabbitmq.bash
	[ "$status" -ne 1 ]
}
