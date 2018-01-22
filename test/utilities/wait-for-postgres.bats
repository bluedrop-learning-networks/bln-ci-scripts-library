#!/usr/bin/env bats

setup() {
	export MAX_ATTEMPTS=60
	export PGCONNECT_TIMEOUT=5
	export DATABASE_URL="${DATABASE_URL:-postgres://postgres@localhost:5432/postgres}"
}

@test "[utilities/wait-for-postgres.bash] Check if postgres is available" {
	run ./utilities/wait-for-postgres.bash
	echo "status = ${status}"
	echo "output = ${output}"
	[ "$status" -eq 0 ]
}

@test "[utilities/wait-for-postgres.bash] Check if postgres is not available" {
	export MAX_ATTEMPTS=1
	DATABASE_URL=postgres://does-not-exist run ./utilities/wait-for-postgres.bash
	[ "$status" -eq 1 ]
}
