#!/usr/bin/env bats

setup() {
	export DATABASE_URL="${DATABASE_URL:-postgres://postgres:postgres@localhost:5432/postgres}"
}

@test "[utilities/wait-for-postgres.bash] Check if postgres is available" {
	run ./utilities/wait-for-postgres.bash
	echo "status = ${status}"
	echo "output = ${output}"
	[ "$status" -eq 0 ]
}

@test "[utilities/wait-for-postgres.bash] Check if postgres is not available" {
	MAX_ATTEMPTS=1 \
	DATABASE_URL=postgres://does-not-exist \
	run ./utilities/wait-for-postgres.bash
	[ "$status" -eq 1 ]
}
