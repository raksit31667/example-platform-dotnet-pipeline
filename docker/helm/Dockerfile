FROM alpine/helm:3.12.1@sha256:7b386b479951c15e59ecf4ba224069fa57123209b650b1081c6526ba9e78414f

RUN apk add --no-cache bash=5.2.15-r5

COPY helm_*.sh /

SHELL [ "/bin/bash", "-o", "pipefail" ]

ENTRYPOINT [ "/bin/bash", "-c" ]
