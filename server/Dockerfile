# -----------------------------------------
# MDriven Server Core (Linux x64)
# Version: MDrivenServerCoreLinux_20251112
# -----------------------------------------

FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

# Install needed tools
RUN apt-get update \
    && apt-get install -y curl unzip \
    && apt-get clean

# Download the exact build you want
RUN echo "Downloading MDriven Server Core Linux 20251112..." \
    && curl -L -o MDrivenServerCoreLinux.zip \
       https://downloads.mdriven.net/releases/MDrivenServerCoreLinux_20251112.zip \
    && unzip MDrivenServerCoreLinux.zip -d /app \
    && rm MDrivenServerCoreLinux.zip

# Expose server port
EXPOSE 5010

# Start server
ENTRYPOINT ["dotnet", "AppCompleteGenericCore.dll", "-port=5010", "-nohttps"]
