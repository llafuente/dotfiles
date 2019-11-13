
# chocolatey

with admin powershell

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
$env:chocolateyProxyLocation = 'http://10.113.55.36:8080'
# ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
.\install.ps1

choco config set proxy 'http://10.113.55.36:8080'
```

# node.js

```
choco install nvm
nvm proxy 10.113.55.36:8080
nvm list available
nvm install 10.17.0
```


# cmder

```
choco install cmder
```

# SublimeText 3

```
# this will install sublimetext without git support, for faster version, the new one is slower, much slower
choco install sublimetext3 --version=3.1.1
```
