# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        unzip \
        net-tools \
        libgdiplus \
        jq \
    && rm -rf /var/lib/apt/lists/* \
    && cd /usr/lib \
    && ln -s libgdiplus.so gdiplus.dll

WORKDIR /app

#ARG TK_URL

# Download and extract MDriven Turnkey
RUN curl -L -o MDrivenTurnkey.zip "https://downloads.mdriven.net/releases/MDrivenTurnkeyCoreLinux_20251112.zip" \
    && unzip MDrivenTurnkey.zip -d /app \
    && rm -f MDrivenTurnkey.zip \
    && ls /app/*.dll | head -5

ENTRYPOINT ["dotnet", "StreaminAppCoreWebApp.dll", "--port=5050", "--nohttps"]
