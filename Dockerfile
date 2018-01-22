FROM alpine

# install base system
RUN apk --no-cache add \
	bash \
	build-base \
	cabal \
	curl \
	tar \
	wget \
	ghc

ENV PATH="/root/bin/:${PATH}"

RUN mkdir -p "/root/cache/"
RUN mkdir -p "/root/bin/"

WORKDIR /app

COPY test/setup.bash /app/test/setup.bash

RUN ./test/setup.bash

# install additional libraries used in scripts
RUN apk --no-cache add \
	postgresql-client

COPY . /app/
