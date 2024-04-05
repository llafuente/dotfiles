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

# Rundll32 commands

```
About Windows                                            Rundll32.exe shell32.dll,ShellAbout
Add Network Location Wizard                                    Rundll32 %SystemRoot%\system32\shwebsvc.dll,AddNetPlaceRunDll
Add Printer Wizard                                          Rundll32.exe shell32.dll,SHHelpShortcuts_RunDLL AddPrinter
Add Standard TCP/IP Printer Port Wizard                           Rundll32.exe tcpmonui.dll,LocalAddPortUI
Control Panel                                            Rundll32.exe shell32.dll,Control_RunDLL
Date and Time                                            Rundll32.exe shell32.dll,Control_RunDLL timedate.cpl
Date and Time - Additional Clocks tab                          Rundll32.exe shell32.dll,Control_RunDLL timedate.cpl,,1
Desktop Icon Settings                                       Rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0
Device Installation Settings                                Rundll32.exe %SystemRoot%\System32\newdev.dll,DeviceInternetSettingUi
Device Manager                                           Rundll32.exe devmgr.dll DeviceManager_Execute
Display Settings                                         Rundll32.exe shell32.dll,Control_RunDLL desk.cpl
Ease of Access Center                                       Rundll32.exe shell32.dll,Control_RunDLL access.cpl
Environment Variables                                       Rundll32.exe sysdm.cpl,EditEnvironmentVariables
File Explorer Options - General tab                            Rundll32.exe shell32.dll,Options_RunDLL 0
File Explorer Options - Search tab                             Rundll32.exe shell32.dll,Options_RunDLL 2
File Explorer Options - View tab                            Rundll32.exe shell32.dll,Options_RunDLL 7
Fonts folder                                             Rundll32.exe shell32.dll,SHHelpShortcuts_RunDLL FontsFolder
Forgotten Password Wizard                                   Rundll32.exe keymgr.dll,PRShowSaveWizardExW
Game Controllers                                         Rundll32.exe shell32.dll,Control_RunDLL joy.cpl
Hibernate or Sleep                                          Rundll32.exe powrprof.dll,SetSuspendState
Indexing Options                                         Rundll32.exe shell32.dll,Control_RunDLL srchadmin.dll
Infared                                                  Rundll32.exe shell32.dll,Control_RunDLL irprops.cpl
Internet Explorer - delete all browsing history                   Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 255
Internet Explorer - delete all browsing history and add-ons history     Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 4351
Internet Explorer - delete cookies and website data                  Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
Internet Explorer - delete download history                       Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 16384
Internet Explorer - delete form data                           Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 16
Internet Explorer - delete history                             Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 1
Internet Explorer - delete passwords                           Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 32
Internet Explorer - delete temporary Internet files and website files   Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
Internet Explorer - Organize Favorites                         Rundll32.exe shdocvw.dll,DoOrganizeFavDlg
Internet Properties - General tab                              Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl
Internet Properties - Security tab                             Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,1
Internet Properties - Privacy tab                              Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,2
Internet Properties - Content tab                              Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,3
Internet Properties - Connections tab                          Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,4
Internet Properties - Programs tab                             Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,5
Internet Properties - Advanced tab                             Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,6
Keyboard Properties                                         Rundll32.exe shell32.dll,Control_RunDLL main.cpl @1
Lock PC                                                  Rundll32.exe user32.dll,LockWorkStation
Map Network Drive wizard                                    Rundll32.exe shell32.dll,SHHelpShortcuts_RunDLL Connect
Mouse Button swap left and right button function                  Rundll32.exe user32.dll,SwapMouseButton
Mouse Properties - Buttons tab                                 Rundll32.exe shell32.dll,Control_RunDLL main.cpl
Mouse Properties - Pointers tab                                Rundll32.exe shell32.dll,Control_RunDLL main.cpl,,1
Mouse Properties - Pointer Options tab                         Rundll32.exe shell32.dll,Control_RunDLL main.cpl,,2
Mouse Properties - Wheel tab                                Rundll32.exe shell32.dll,Control_RunDLL main.cpl,,3
Mouse Properties - Hardware tab                                Rundll32.exe shell32.dll,Control_RunDLL main.cpl,,4
Network Connections                                         Rundll32.exe shell32.dll,Control_RunDLL ncpa.cpl
ODBC Data Source Administrator                                 Rundll32.exe shell32.dll,Control_RunDLL odbccp32.cpl
Offline Files (General tab)                                    Rundll32.exe Shell32.dll,Control_RunDLL cscui.dll,,0
Offline Files (Disk Usage tab)                                 Rundll32.exe Shell32.dll,Control_RunDLL cscui.dll,,1
Offline Files (Encryption tab)                                 Rundll32.exe Shell32.dll,Control_RunDLL cscui.dll,,2
Offline Files (Network tab)                                    Rundll32.exe Shell32.dll,Control_RunDLL cscui.dll,,3
Pen and Touch                                            Rundll32.exe shell32.dll,Control_RunDLL tabletpc.cpl
Personalization - Background Settings                          Rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,2
Power Options                                            Rundll32.exe shell32.dll,Control_RunDLL powercfg.cpl
Printer User Interface                                      Rundll32.exe Printui.dll,PrintUIEntry /?
Printers folder                                             Rundll32.exe shell32.dll,SHHelpShortcuts_RunDLL PrintersFolder
Process idle tasks                                          Rundll32.exe advapi32.dll,ProcessIdleTasks
Programs and Features                                       Rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl,,0
Region - Formats tab                                     Rundll32.exe shell32.dll,Control_RunDLL Intl.cpl,,0
Region - Location tab                                       Rundll32.exe shell32.dll,Control_RunDLL Intl.cpl,,1
Region - Administrative tab                                    Rundll32.exe shell32.dll,Control_RunDLL Intl.cpl,,2
Safely Remove Hardware                                      Rundll32.exe shell32.dll,Control_RunDLL HotPlug.dll
Screen Saver Settings                                       Rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,1
Security and Maintenance                                    Rundll32.exe shell32.dll,Control_RunDLL wscui.cpl
Set Program Access and Computer Defaults                       Rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl,,3
Set Up a Network wizard                                     Rundll32.exe shell32.dll,Control_RunDLL NetSetup.cpl
Sleep or Hibernate                                          Rundll32.exe powrprof.dll,SetSuspendState
Sound - Playback tab                                     Rundll32.exe shell32.dll,Control_RunDLL Mmsys.cpl,,0
Sound - Recording tab                                       Rundll32.exe shell32.dll,Control_RunDLL Mmsys.cpl,,1
Sound - Sounds tab                                          Rundll32.exe shell32.dll,Control_RunDLL Mmsys.cpl,,2
Sound - Communications tab                                  Rundll32.exe shell32.dll,Control_RunDLL Mmsys.cpl,,3
Speech Properties - Text to Speech tab                         Rundll32.exe shell32.dll,Control_RunDLL %SystemRoot%\System32\Speech\SpeechUX\sapi.cpl,,1
Start Settings                                           Rundll32.exe shell32.dll,Options_RunDLL 3
Stored User Names and Passwords                                Rundll32.exe keymgr.dll,KRShowKeyMgr
System Properties - Computer Name tab                          Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,1
System Properties - Hardware tab                            Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,2
System Properties - Advanced tab                            Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,3
System Properties - System Protection tab                      Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,4
System Properties - Remote tab                                 Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,5
Taskbar Settings                                         Rundll32.exe shell32.dll,Options_RunDLL 1
Text Services and Input Languages                              Rundll32.exe Shell32.dll,Control_RunDLL input.dll,,{C07337D3-DB2C-4D0B-9A93-B722A6C106E2}
User Accounts                                            Rundll32.exe shell32.dll,Control_RunDLL nusrmgr.cpl
Windows Features                                         Rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl,,2
Windows Firewall                                         Rundll32.exe shell32.dll,Control_RunDLL firewall.cpl
Windows To Go Startup Options                               Rundll32.exe pwlauncher.dll,ShowPortableWorkspaceLauncherConfigurationUX
```


# Display all installed software

```powershell
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object -Property DisplayName -Descending | Format-Table -AutoSize

# name,version should be ok
wmic product get *
```

# Get global environment variables

Common to all users

```cmd
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
```

Specific to current user session

```cmd
reg query "HKCU\Environment"
reg query "HKCU\Volatile Environment"
```
# Get current process environment variables

"current" -> console

```powershell
$x = [Environment]::GetEnvironmentVariables()
Get-child $x

# alternative
Get-ChildItem env:

```

```cmd
env
```

# get all users priviledges

NOTE user: accesschk
```powershell
gwmi Win32_UserProfile | foreach-object {
 $sid = New-Object System.Security.Principal.SecurityIdentifier($_.SID)
 $user = $sid.Translate([System.Security.Principal.NTAccount])
 $username = $user.Value
 $username
 $chkCmd = "accesschk """ + $username + """ -a * -q"
 iex $chkCmd
 ""
}
```

# get user priviledges

```cmd
whoami /priv
```


        $lsa = New-Object PS_LSA.LsaWrapper('W8120CVROB16')
        foreach ($Acct in $Account) {
            $output = @{'Account'=$Acct; 'Right'=$lsa.EnumerateAccountPrivileges($Acct); }
            Write-Output (New-Object -Typename PSObject -Prop $output)
        }


accesschk64.exe -p -f 16784 -l -i -s


# Query Windows Events

```cmd
$StartTime = (get-date).AddHours(-1)
$EndTime = (get-date)
$EventData = Get-WinEvent -FilterHashtable @{}

$EventData | ConvertTo-Json

$EventData | Format-Table 

$EventData | Foreach{$_.ToXml()}

$EventData | ForEach {
    [PScustomObject]@{
        TimeCreated=(Get-Date ($_.TimeCreated) -Format 'yyyy-MM-dd hh:mm:ss');
        Message=$_.Message
    }
}

```
## Shutdowns

```
@{ProviderName='User32';StartTime=$StartTime;EndTime=$EndTime;Id=1074}
```

## RDP Logins

```
@{LogName='Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational';StartTime=$StartTime;EndTime=$EndTime;ID=1149}
```