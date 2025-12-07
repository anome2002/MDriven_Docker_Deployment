# Use official .NET 8 ASP.NET runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Install required dependencies
RUN apt-get update && \
    apt-get install -y curl unzip findutils locales libgdiplus && \
    rm -rf /var/lib/apt/lists/*

# Configure locale
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Set working directory
WORKDIR /app

# Download and extract the latest MDriven Turnkey package
RUN echo "Downloading MDriven Turnkey Core Linux..." && \
    curl -L -O https://downloads.mdriven.net/releases/MDrivenTurnkeyCoreLinux_20251112.zip && \
    unzip -q MDrivenTurnkeyCoreLinux_20251112.zip -d /tmp/mdriventurnkey && \
    DLL_PATH=$(find /tmp/mdriventurnkey -type f -name "StreaminAppCoreWebApp.dll" | head -n 1) && \
    echo "Found DLL at: $DLL_PATH" && \
    cp -r "$(dirname "$DLL_PATH")"/* /app/ && \
    rm -rf /tmp/mdriventurnkey MDrivenTurnkeyCoreLinux_20251112.zip

# Expose HTTP port
EXPOSE 5050

# Environment variables (HTTP-only)
ENV ASPNETCORE_URLS=http://+:5050 \
    ASPNETCORE_ENVIRONMENT=Development \
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    MDrivenServerUrl=http://mdriven-server:5010/__MDrivenServer/ \
    TURNKEY_MDRIVEN_SERVER_URL=http://mdriven-server:5010/__MDrivenServer/



COPY appsettings.json /app/appsettings.json

COPY MDrivenServerOverride.xml /app/App_Data/MDrivenServerOverride.xml

# Entry point (disable HTTPS explicitly)
ENTRYPOINT ["dotnet", "StreaminAppCoreWebApp.dll", "-nohttps"]
