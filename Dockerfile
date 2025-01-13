# syntax=docker/dockerfile:1

FROM alpine:3.20.2 AS builder

ARG TARGETPLATFORM

RUN printf "I'm building for TARGETPLATFORM=$TARGETPLATFORM"

RUN apk -U --no-cache upgrade; /bin/rm -rf /var/cache/apk/*

RUN apk add curl unzip

RUN mkdir /protolint-plugins

RUN TP=${TARGETPLATFORM:-linux/amd64} TP_SLUG=${TP//\//-} \
    DOWNLOAD_URL=https://github.com/ci-space/protostyle/releases/download/v0.1.0/protostyle-"$TP_SLUG".zip && \
      echo "DOWNLOAD_URL=$DOWNLOAD_URL" && \
    curl -L $DOWNLOAD_URL -o /protolint-plugins/protostyle.zip && \
    cd /protolint-plugins && \
    unzip protostyle.zip protostyle && \
    rm protostyle.zip

################################################

FROM alpine:3.20.2

RUN apk -U --no-cache upgrade; /bin/rm -rf /var/cache/apk/* ; apk add gcompat

RUN mkdir /protolint-plugins

COPY --from=yoheimuta/protolint:0.52.0 /usr/local/bin/protolint /usr/local/bin/protolint
COPY --from=builder /protolint-plugins/protostyle /protolint-plugins/protostyle

RUN chmod +x /protolint-plugins/protostyle

ENTRYPOINT ["/usr/local/bin/protolint", "-plugin", "/protolint-plugins/protostyle"]
