FROM golang:1.22-alpine AS builder
WORKDIR /app

COPY src ./src

RUN apk add --no-cache ca-certificates && \
    cd src && \
    go build -ldflags="-s -w" -o /app/audiomass audiomass-server.go

FROM alpine:3.20
WORKDIR /app

COPY --from=builder /app/audiomass /usr/local/bin/audiomass
COPY src /app/src

WORKDIR /app/src

EXPOSE 5055
CMD ["/usr/local/bin/audiomass"]
