
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
choco install -y nvm
```

En una nueva ventana cmd

```
nvm proxy 10.113.55.36:8080
nvm list available
nvm install 10.17.0
nvm use 10.17.0
```


# cmder (git)

```
choco install -y cmder

cmder
# anclar
git config --global http.proxy http://10.113.55.36:8080
```

# SublimeText 3

```
# this will install sublimetext without git support, for faster version, the new one is slower, much slower
choco install -y sublimetext3 --version=3.1.1

cd "%APPDATA%\Sublime Text 3\Packages"
git clone --depth 1 https://github.com/Microsoft/TypeScript-Sublime-Plugin.git TypeScript

```

# Chrome, Firefox

```
choco install -y googlechrome
choco install -y firefox
```
