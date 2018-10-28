FROM golang

RUN go get github.com/YuriyKischenko/k8s-helloname/go/helloname
RUN go get gopkg.in/yaml.v2
RUN go install github.com/YuriyKischenko/k8s-helloname/go/helloname

# Run the command by default when the container starts.
ENTRYPOINT /go/bin/helloname

# Document that the service listens on port 8080.
EXPOSE 8080
