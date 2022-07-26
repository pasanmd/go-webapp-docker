FROM twiny/go-alpine-gcc:1.17.1

ENV GO111MODULE=on

RUN apk update
RUN apk add git

RUN mkdir /build

RUN git clone https://github.com/pasanmd/go-webapp-docker.git

WORKDIR go-webapp-sample

RUN echo $(go env)
RUN echo $(ls)
RUN go get
RUN go mod download
RUN go build main.go
RUN ls -l
RUN pwd
#STAGE 2

FROM alpine:3.16

RUN mkdir /app

WORKDIR /app

COPY --from=0 ./go/go-webapp-sample/main .
COPY --from=0 ./go/go-webapp-sample/zaplogger.develop.yml .

ENTRYPOINT ./main