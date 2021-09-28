FROM golang:1.16 AS builder
WORKDIR /go/src/github.com/diegokrule1/hello-world/
RUN go get -d -v golang.org/x/net/html
COPY main.go    ./
COPY go.mod ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:3.13.6
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/diegokrule1/hello-world/app ./
CMD ["./app"]
