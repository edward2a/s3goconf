code = s3goconf

all:
	go build -ldflags '-s -w' ${code}.go

multi_arch:
	GOOS=linux GOARCH=amd64 go build -ldflags '-s -w' ${code}.go
	GOOS=darwin GOARCH=amd64 go build -ldflags '-s -w' ${code}.go
	GOOS=windows GOARCH=amd64 go build -ldflags '-s -w' ${code}.go

clean:
	rm -f ${code}

cleanall:
	rm -f ${code}
	rm -f ${code}.osx
	rm -f ${code}.exe
