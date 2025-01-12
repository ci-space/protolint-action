FROM alpine:3.21.2 as builder

RUN apk add curl unzip

RUN mkdir /usr/local/bin/protolint-plugins

RUN curl -L https://github.com/ci-space/protostyle/releases/download/v0.1.0/protostyle-linux-amd64.zip -o /usr/local/bin/protolint-plugins/protostyle.zip && \
      cd /usr/local/bin/protolint-plugins && \
      unzip protostyle.zip protostyle && \
      rm protostyle.zip

###############################################

FROM alpine:3.21.2

COPY --from=yoheimuta/protolint:0.52.0 /usr/local/bin/protolint /usr/local/bin/protolint
COPY --from=builder /usr/local/bin/protolint-plugins/protostyle /usr/local/bin/protolint-plugins/protostyle

#ENTRYPOINT ["ls", "-l"]

CMD ["ls", "-l", "/usr/local/bin/protolint-plugins"]

#ENTRYPOINT ["/usr/local/bin/protolint-plugins/protostyle"]

#ENTRYPOINT ["/usr/local/bin/protolint", "-plugin", "/usr/local/bin/protolint-plugins/protostyle"]
