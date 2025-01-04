# GENERATE GO BINARY
FROM golang:1.23.2-alpine3.20 as builder

# Copy the code from the host and compile it
WORKDIR $GOPATH/src/ms-test-server
COPY . ./
RUN go generate /ms-test-server
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /ms-test-server
RUN apk update && apk add --no-cache git
# RUNNING GO BINARY
# Running go binary from compiler on the machine
FROM alpine:latest

#add curl
RUN apk --no-cache add curl
# SET TZ
RUN apk add -U tzdata
RUN cp /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# copy env from the host & copy go binary from the compiler

COPY --from=builder /ms-test-server ./
COPY . .

ENTRYPOINT ["/ms-test-server"]