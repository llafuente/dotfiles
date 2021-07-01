# get proxy (no pac file)

    netsh winhttp show proxy

# Autologon

HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon

# PsExec

https://docs.microsoft.com/en-us/sysinternals/downloads/psexec
https://www.itprotoday.com/compute-engines/psexec

# Remote Desktop (rdp)

## keep rdp alive

https://github.com/telerik/teststudio/blob/e26ba1284083a2a51e03893905bc9067a89ca2e8/docs/knowledge-base/scheduling-kb/keep-active-session.md

https://github.com/rcmdnk/vim_ahk/blob/25b5313add0f0b6d3743f1ec59a843d243bbcf17/tests/appveyor_setup.ahk

https://github.com/automagica/automagica/blob/a581ca5b89fa7de4e89641de8816725a5af65a5f/docs/source/unattended.md
https://github.com/TheScylla/AutoConnect/blob/cbead47dfb3388ac6754d9e2e9addd7a997a8c07/FlatyBot/AutoConnect_Web/leaveSession.bat

https://github.com/mcavallo-git/Coding/blob/2604c3a861ff86e075fc88fbc07372fe6fc6475a/jenkins/jenkinsfiles/RDP-Set-Automation-Policies/Jenkinsfile

tscon
https://support.smartbear.com/testcomplete/docs/testing-with/running/via-rdp/keeping-computer-unlocked.html




```
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization /v NoLockScreen /d 0 /f /t REG_DWORD
# This command will create the required registry entry to prevent RDP clients from suppressing the remote system when the client is minimised.

reg add "HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client" /v RemoteDesktop_SuppressWhenMinimized /t REG_DWORD /d 2
reg add "HKEY_CURRENT_USER\Software\Wow6432Node\Microsoft\Terminal Server Client" /v RemoteDesktop_SuppressWhenMinimized /t REG_DWORD /d 2

```

## rdp files

```powershell
("pwd" | ConvertTo-SecureString -AsPlainText -Force) | ConvertFrom-SecureString;
```
*xxx.rdp*
```
full address:s:<server>
prompt for credentials:i:0
username:s:<user>
domain:s:<domain>
password 51:b:<password>
```

## Remote Desktop Prompt

\\HKCU\Software\Microsoft\Terminal Server Client\AuthenticationLevelOverride


• 0 This value corresponds to "No authentication."
• 1 This value corresponds to "Require authentication."
• 2 This value corresponds to "Attempt authentication."


# get desktop session id

```
$desktopSession = query user | Select-String -Pattern Active
$desktopSessionId = ($desktopSession -split '\s+')[3]

# execute something in that session
# -d \\$client
$user=
$pwd=
.\PsExec.exe -i $desktopSessionId -u $user -p $pwd "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
```



```
# First you need to allow PowerShell remoting on remote computer
psexec.exe \\$servername -u os\$username -p $password -w c:\temp -d -h  powershell.exe "Enable-PSRemoting -Force"

# Query server open sessions using psexec
$DirtyQwinstaArray = (qwinsta /SERVER:{remoteserver}| Where-Object -FilterScript {$_ -match "{username}"}) -split (" ")
# "DirtyQwinstaArray" contains array items that are just whitespace, these needs to be cleaned up.

$CleanQwinstaArray = @()
$DirtyQwinstaArray | ForEach-Object {

    if ($_ -eq $DirtyQwinstaArray[2]){
       # "null found"
    }
    else {
       $CleanQwinstaArray += $_
    }
}

$RDPsessionID = $CleanQwinstaArray[2]

# Then we can start the process on current UI session with the obtained id
.\psexec -accepteula -i $RDPsessionID "\\computername" -u "domain\username" -p "password" "calc.exe"
```

## force rdp resolution

Edit rdp file, and overwrite

```
screen mode id:i:1
desktopwidth:i:1960
desktopheight:i:1080
```

# Task scheduler

## cmd

```
SCHTASKS /CREATE /TN "bde-mon-1" /SC WEEKLY /D MON /ST 04:15 /TR "C:\\Users\\%USERNAME%\\Desktop\\rda\\bot-runner.exe /runbot bot-bde --  /silent /configfile bin/bde-mon-1.ini" /RU "DOMAIN\USERNAME" /RP "password"

```

## powershell

```powershell
$action = New-ScheduledTaskAction -Execute "C:\\yyy.exe" -Argument "xxx" -WorkingDirectory "C:\\"
$trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek Monday -At 4:30am
# -LogonType ServiceAccount
$principal = New-ScheduledTaskPrincipal -UserID "domain\user" -LogonType S4U -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -MultipleInstances Parallel

Register-ScheduledTask -TaskName "xxx/yyy" -TaskPath "C:\\" -Action $action -Trigger $trigger -Settings $settings -Principal $principal
```

# credential manager

## add to credential manager

```
#not working..., maybe ConvertFrom-SecureString is not necesary?
$Password=("xxx" | ConvertTo-SecureString -AsPlainText -Force) | ConvertFrom-SecureString;

# working
$Password = Read-Host "Password" -AsSecureString
$userName="IMM0966"

cmdkey /add:domain-no-port /user:$userName /pass:$Password
```


# How to map network drives with multiple credentials per file server?

```
net use <driveletter>: \\<server1>\<sharename> /User:UserA PasswordA
net use <driveletter>: \\<server2>\<sharename> /User:UserB PasswordB

net use \\<server2>\<sharename> /del
net use <driveletter>: /del

@rem /PERSISTENT:YES

notepad c:\windows\system32\drivers\etc\hosts
@rem add
server1 server2
```
