FROM golang:1.9.2-alpine3.7 as build
COPY main.go go/main.go
RUN cd go && go build -o /run-test
FROM scratch
COPY --from=build /run-test /
CMD [ "/run-test" ]