ARG BASE_IMAGE

# BASE_IMAGE should have the explicit version
# hadolint ignore=DL3006
FROM $BASE_IMAGE

ARG DLL_ENTRYPOINT
ENV ENTRYPOINT=$DLL_ENTRYPOINT

WORKDIR /app

COPY app .

RUN chown app:app  /app

USER app:app

ENTRYPOINT ["sh", "-c", "dotnet ${ENTRYPOINT}"]
