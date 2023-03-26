FROM hadolint/hadolint:v2.12.0-alpine

RUN apk add --no-cache bash=5.1.16-r0

COPY hadolint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/hadolint.sh
