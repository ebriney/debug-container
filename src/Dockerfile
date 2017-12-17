FROM golang:1.9.2-alpine3.7 as build
COPY main.go go/main.go
RUN cd go && go build -o /contExt
RUN ldd /bin/ps
FROM ubuntu:xenial
COPY --from=build /contExt /
CMD [ "/contExt" ]