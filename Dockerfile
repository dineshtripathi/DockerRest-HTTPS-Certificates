#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-sac2016 AS base
WORKDIR /app
EXPOSE 33684
EXPOSE 443

FROM microsoft/dotnet:2.1-sdk-nanoserver-sac2016 AS build
WORKDIR /src
COPY ["WebAPI/DockerRestAPI/DockerRestAPI.csproj", "WebAPI/DockerRestAPI/"]
COPY ["RestModel/RestModel.csproj", "RestModel/"]
RUN dotnet restore "WebAPI/DockerRestAPI/DockerRestAPI.csproj"
COPY . .
WORKDIR "/src/WebAPI/DockerRestAPI"
RUN dotnet build "DockerRestAPI.csproj" -c Release -o /app

ENV certPassword "crypticpassword"



# Expose port 443 for the application.
EXPOSE 443
FROM build AS publish
RUN dotnet publish "DockerRestAPI.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "DockerRestAPI.dll"]

#WORKDIR "D:\OpenSSL-Win64\bin"
# Use opnssl to generate a self signed certificate cert.pfx with password $env:certPassword
CMD .\openssl.exe genrsa -des3 -passout pass:"crypticpassword" -out server.key 2048
CMD .\openssl.exe rsa -passin pass:"crypticpassword" -in server.key -out server.key
CMD .\openssl.exe req -sha256 -new -key server.key -out server.csr -subj '/CN=localhost'
CMD .\openssl.exe x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
CMD .\openssl.exe pkcs12 -export -out DockerRestAPI.pfx -inkey server.key -in server.crt -certfile DockerRestAPI.crt -passout pass:"crypticpassword"