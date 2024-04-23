
# chocolatey

with admin powershell

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
$env:chocolateyProxyLocation = 'http://xxx:xxx@proxy:8080'

$proxy = new-object System.Net.WebProxy
$proxy.Address = 'http://xxx:xxx@proxy:8080'
# use the same as windows?
#$proxy.Address = (get-itemproperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\InternetSettings').ProxyServer

$wc = new-object system.net.WebClient
$wc.proxy = $proxy

iex $wc.DownloadString('https://chocolatey.org/install.ps1')
# .\install.ps1

choco config set proxy 'http://proxy:8080'
choco config set proxyUser xxx
choco config set proxyPassword yyy
```

# node.js

```
choco install -y nvm
```

En una nueva ventana cmd

```
nvm proxy xxx:xxx@proxy:8080
nvm list available
nvm install 10.17.0
nvm use 10.17.0
```

El proxy de npm se configura en %HOME%\.npmrc

```ini
proxy=http://xxx:xxx@proxy:8080/
https-proxy=http://xxx:xxx@proxy:8080/
strict-ssl=false
```

# cmder (git)

```
choco install -y cmder
```

En una nueva ventana cmd

```
cmder
# anclar
git config --global http.proxy http://xxx:xxx@proxy:8080
```

# SublimeText 3

```
# this will install sublimetext without git support, for faster version, the new one is slower, much slower
choco install -y sublimetext3 --version=3.1.1

https://packagecontrol.io/Package%20Control.sublime-package

cd "%APPDATA%\Sublime Text 3\Packages"

# Typescript autocomplete
git clone --depth 1 https://github.com/Microsoft/TypeScript-Sublime-Plugin.git TypeScript

# AHK Highlight and snippet/autocomplete
git clone --depth 1 https://github.com/ahkscript/SublimeAutoHotkey.git AutoHotkey

# Copy as HTML
# Copy as RTF
git clone --depth 1 --branch python3 https://github.com/n1k0/SublimeHighlight.git SublimeHighlight
```

# Others: Chrome, Firefox

```
choco install -y googlechrome
choco install -y firefox
choco install -y 7zip.install
choco install -y vlc
choco install -y virtualbox
choco install -y vscode
choco install -y sourcetree
choco install -y javaruntime
choco install -y python2
choco install -y awscli
```


