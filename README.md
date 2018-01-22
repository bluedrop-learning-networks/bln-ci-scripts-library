# Bluedrop Codeship Scripts

[![Codeship Status for coursepark/codeship-scripts](https://app.codeship.com/projects/6ceddeb0-e1d0-0135-6f5b-0e4144ab624b/status?branch=master)](https://app.codeship.com/projects/266735)

A collection of useful scripts for use on [Codeship](https://codeship.com/) and similar tools.

## Using the scripts

Each script includes a comment at the beginning detailing how to configure and use the script in your builds. Those
comments follow the format:

```
# Add the following environment variables to your project configuration (otherwise the defaults below will be used)
# * DATABASE_URL
#
# The following commands are required:
# * psql
#
# Include in your builds via
# \curl -sSL https://bitbucket.org/coursepark/codeship-scripts/raw/master/utilities/wait-for-postgres.bash | bash -s
```

**It is important that you follow those instructions and not simply copy / paste the scripts into your Codeship project configuration.**

## Scripts

### Utilities

* [Wait for postgres to start](utilities/wait-for-postgres.bash)

## Testing

### BATS

Run the BATS test. Requires BATS to be installed.

```
./scripts/bats.bash
```

### Shellcheck

Run linting with Shellcheck. Requires Shellcheck to be installed.

```
./scripts/shellcheck.bash
```

### All

All tests can be run as well, assuming above requirements are available.

```
./scripts/test.bash
```

### Docker

All tests can also run using the docker image.

```
docker build -t bluedrop-codeship-scripts .
docker run --name bluedrop-codeship-scripts-tests --rm -i -t bluedrop-codeship-scripts ./test/test.bash
```

### Codeship CLI

Assuming the Codeship CLI tool is installed.

```
jet steps
```
