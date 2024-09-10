
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
# SublimeText 3 (Portable)

```ps1
# v4 ?
# Invoke-WebRequest -Uri https://download.sublimetext.com/sublime_text_build_4180_x64.zip -OutFile sublime_text.zip
Invoke-WebRequest -Uri "https://download.sublimetext.com/Sublime%20Text%20Build%203211%20x64.zip" -OutFile "sublime_text.zip"
New-Item sublime_text -ItemType Directory
Expand-Archive sublime_text.zip -DestinationPath .\sublime_text
Remove-Item sublime_text.zip

cd "sublime_text\Data\Packages"

function sublime-download-lugin($uri, $folder, $name) {
	# Typescript autocomplete
	Invoke-WebRequest -Uri "$uri" -OutFile tmp.zip
	Expand-Archive tmp.zip -DestinationPath .
	Remove-Item tmp.zip
        sleep 1
	Move-Item $folder $name
}

# Typescript autocomplete
sublime-download-lugin "https://github.com/microsoft/TypeScript-Sublime-Plugin/archive/refs/heads/master.zip" "TypeScript-Sublime-Plugin-master" "TypeScript"

# AHK Highlight and snippet/autocomplete
sublime-download-lugin "https://github.com/ahkscript/SublimeAutoHotkey/archive/refs/heads/master.zip" "SublimeAutoHotkey-master" "SublimeAutoHotkey"

# Copy as HTML
# Copy as RTF
sublime-download-lugin "https://github.com/n1k0/SublimeHighlight/archive/refs/heads/python3.zip" "SublimeHighlight-python3" "SublimeHighlight"

sublime-download-lugin "https://github.com/SublimeText/PowerShell/archive/refs/heads/master.zip" "PowerShell-master" "PowerShell"
```

# SublimeText 3 (Local)

```
# this will install sublimetext without git support, for faster version, the new one is slower, much slower
choco install -y sublimetext3 --version=3.1.1

https://packagecontrol.io/Package%20Control.sublime-package

cd "%APPDATA%\Sublime Text 3\Data\Packages"

# Typescript autocomplete
git clone --depth 1 https://github.com/Microsoft/TypeScript-Sublime-Plugin.git TypeScript

# AHK Highlight and snippet/autocomplete
git clone --depth 1 https://github.com/ahkscript/SublimeAutoHotkey.git AutoHotkey

# Copy as HTML
# Copy as RTF
git clone --depth 1 --branch python3 https://github.com/n1k0/SublimeHighlight.git SublimeHighlight

# Powershell plugin
git clone --depth 1 https://github.com/SublimeText/PowerShell.git PowerShell
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


