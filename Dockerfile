FROM golang:1.22.5 AS base

WORKDIR /usr/src/app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/base

WORKDIR /usr/src/app

COPY --from=base /usr/src/app/main .

COPY static ./static

EXPOSE 8080

CMD ["./main"]