# syntax=docker/dockerfile:1.5
FROM alpine AS build-layer
ARG STATUS_CODE
RUN apk --no-cache add gcc musl-dev make upx || apk --no-cache add gcc musl-dev make
COPY src/http.c src/httpserver.h /build/
WORKDIR /build
RUN gcc -o http -s -O2 -DSTATUS_CODE=${STATUS_CODE} -static http.c && strip -x http 
RUN which upx && upx http || true
COPY src/http.c /dist/src/http.c
COPY Dockerfile /dist/src/Dockerfile
COPY Makefile /dist/src/Makefile
RUN cp http /dist/http

FROM scratch
COPY --from=build-layer /dist/ /
USER 50000:50000
EXPOSE 8000
ENTRYPOINT [ "/http" ]
