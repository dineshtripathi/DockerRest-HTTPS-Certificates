### To Build Docker
```<language>
docker build --pull -t dockerrestapitest .

```
### To Run the dockerrestapitest ( as its Https based so certificates needs to be created)

```<language>
docker run --rm -it -p 8000:80 -p 8001:443 -e ASPNETCORE_URLS="https://+;http://+" -e ASPNETCORE_HTTPS_PORT=8001 -e ASPNETCORE_ENVIRONMENT=Development -v %APPDATA%\microsoft\UserSecrets\:C:\Users\Administrator\AppData\Roaming\microsoft\UserSecrets -v %USERPROFILE%\.aspnet\https:C:\Users\Administrator\AppData\Roaming\ASP.NET\Https dockerrestapitest
```
```<language>
docker run --rm -it -p 5000:80 -p 44334:443 -e ASPNETCORE_URLS="https://+;http://+" -e ASPNETCORE_HTTPS_PORT=443 -e ASPNETCORE_ENVIRONMENT=Development -v %APPDATA%\microsoft\UserSecrets\:C:\Users\Administrator\AppData\Roaming\microsoft\UserSecrets -v %USERPROFILE%\.aspnet\https:C:\Users\Administrator\AppData\Roaming\ASP.NET\Https dockerrestapitest
```