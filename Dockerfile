FROM registry.access.redhat.com/ubi9/go-toolset:9.8 AS builder
WORKDIR /opt/app-root/src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -buildvcs=false -o /opt/app-root/bin/server .

FROM registry.access.redhat.com/ubi9/ubi-minimal:latest
COPY --from=builder /opt/app-root/bin/server /usr/local/bin/server
EXPOSE 8080
USER 1001
ENTRYPOINT ["/usr/local/bin/server"]
