code = s3goconf
ldflags = '-s -w -linkmode external -extldflags "-static"'

# build in alpine with musl
build-static:
	docker run -ti --rm -v "$$PWD:/app" -w /app --env CALLER_UID=$(shell id -u) golang:1.11.1-alpine3.8 /app/scripts/build-alpine.sh

build:
	go build -ldflags ${ldflags} ${code}.go

multi_arch:
	GOOS=linux GOARCH=amd64 go build -ldflags ${ldflags} ${code}.go
	GOOS=darwin GOARCH=amd64 go build -ldflags ${ldflags} ${code}.go
	GOOS=windows GOARCH=amd64 go build -ldflags ${ldflags} ${code}.go

clean:
	rm -f ${code}

cleanall:
	rm -f ${code}
	rm -f ${code}.osx
	rm -f ${code}.exe
