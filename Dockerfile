# GENERATE GO BINARY
FROM golang:latest-alpine as builder

# Copy the code from the host and compile it
WORKDIR /app
COPY . .
RUN go generate ./...
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /ms-test-server
# RUNNING GO BINARY
# Running go binary from compiler on the machine
FROM alpine:latest

#add curl
RUN apk --no-cache add curl
# SET TZ
RUN apk add -U tzdata
RUN cp /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# copy env from the host & copy go binary from the compiler

COPY --from=builder /ms-test-server /ms-test-server

ENTRYPOINT ["/ms-test-server"]