FROM mcr.microsoft.com/dotnet/aspnet:7.0@sha256:b40c64517d276945021988717f4ce79fdbb58b87210b94323929b06676c18091
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV ASPNETCORE_URLS=http://*:8080

RUN addgroup --group app --gid 2000 \
    && adduser --uid 2000 --gid 2000 app
