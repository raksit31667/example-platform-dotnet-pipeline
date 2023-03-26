FROM koalaman/shellcheck-alpine:v0.9.0

RUN apk add --no-cache bash=5.2.15-r0

COPY shellcheck.sh /usr/local/bin

RUN chmod +x /usr/local/bin/shellcheck.sh
