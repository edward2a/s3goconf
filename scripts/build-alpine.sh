#!/bin/sh

apk update
apk add git make gcc musl-dev
go get -v github.com/aws/aws-sdk-go/aws
make build
[ -z "${CALLER_UID}" ] || chown ${CALLER_UID} s3goconf
