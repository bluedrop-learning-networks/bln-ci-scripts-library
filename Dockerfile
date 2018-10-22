FROM alpine

# install base system
RUN apk --no-cache add \
	bash \
	curl \
	tar \
	wget \
	postgresql-client \
	xz

ENV PATH="/root/bin/:${PATH}"

RUN mkdir -p "/root/cache/"
RUN mkdir -p "/root/bin/"

WORKDIR /app

COPY . /app/

RUN ./test/setup.bash
