# if

More: https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.4

## Operators

| operators | Description                                       |
| --------- | ------------------------------------------------- |
| -eq, -ieq | equal case insensitive                            |
| -ceq      | equal case insensitive                            |
| -ne, -ine | not equal case insensitive                        |
| -cne      | not equal case sensitive                          |
| -gt, -igt | greater than case insensitive                     |
| -cgt      | greater than case sensitive                       |
| -ge, -ige | greater or equal than case insensitive            |
| -cge      | greater or equal than case sensitive              |
| -lt, -ilt | less than case insensitive                        |
| -clt      | less than case sensitive                          |
| -le, -ile | less or equal than case insensitive               |
| -cle      | less or equal than case sensitive                 |

## like 
| operators           | Description                             |
| ------------------- | --------------------------------------- |
| -like, -ilike       | case-insensitive wildcard               |
| -clike              | case-sensitive wildcard                 |
| -notlike, -inotlike | case-insensitive wildcard not matched   |
| -cnotlike           | case-sensitive wildcard not matched     |

> ? matches any single character

> * matches any number of characters

```ps1
$value = 'S-ATX-SQL01'
if ( $value -like 'S-???-*')
{
    # do something
}
```

## regex

| operators             | Description                           |
| --------------------- | ------------------------------------- |
| -match, -imatch       | case-insensitive regex                |
| -cmatch               | case-sensitive regex                  |
| -notmatch, -inotmatch | case-insensitive regex not matched    |
| -cnotmatch            | case-sensitive regex not matched      |

```ps1
$value = 'S-ATX-SQL01'
if ( $value -match '^S.*$')
{
    # do something
}
```

## type 

| operators             | Description                           |
| --------------------- | ------------------------------------- |
| -is                   | of type                               |
| -isnot                | not of type                           |

```ps1
if ( $Service -isnot [System.ServiceProcess.ServiceController] )
{
    $Service = Get-Service -Name $Service
}
```

# arrays & objects

## declare array

```ps1
$numbers = @(1, 2, 3, 4)
# add
$numbers += 5

# array of arrays
$myItems =  ("Joe",32,"something about him"), ("Sue",29,"something about her")

# array of objects, based on a CSV input
$numbers = "1","2","3","4"
numbers = $numbers | ConvertFrom-Csv -Header value
```

## loop

```ps1
foreach ($element in $numbers) {
  $element
}
```

## declare custom objects

```ps1
# literal
[pscustomobject]@{hostname="W8120CVROB15";user=$XXX;env=$P;info="RDA"}
# iterative
$object = New-Object -TypeName PSObject
$object | Add-Member -Name 'Name' -MemberType Noteproperty -Value 'Joe'
```

# classes
```ps1
class Base {
  [Type] $xxx
  Base() {}
  Base([Type] $xxx) {
    $this.xxx = $xxx
  }
  [void] method([Type] $A, [Type] $B) {}
}
class Child: Base {
    Child() : Base() {}
}

#instancing
$a = [Base]::new()
$b = [Child]::new()
# type is necessary or Object[] will be used!
[Base[]] $list = @($a, $b)

# print type
Write-Host ($a.GetType() | Format-Table | Out-String)
```

# hide promnt

```ps1
function prompt { " `b" }
function prompt { echo " `b" }
```

When running scripts
```ps1
powershell -NoExit -Command "function prompt { echo " &#x60;b" }"
```

# hide echo command (@echo off)

All commands
```ps1
Set-PSDebug -Off
```

just one
```ps1
@something
```

# stderr to stdout

2>&1

# stdout to stderr

1>&2

# tab char

```ps1
ConvertFrom-Csv  .\test.csv -Delimiter "`t"
```

# RDP shadow

```ps1
$server = "W8120CVROB10"
$session = (query session /SERVER:$server) -replace '\s{2,}', ',' | ConvertFrom-Csv | Select-Object -Property SESSIONNAME,USERNAME,ID,STATE,TYPE,DEVICE | Out-GridView  -OutputMode Single
#pure shadow
mstsc /shadow: $session.ID /noConsentPrompt /v: $server
# shadow + control
# mstsc /shadow: $session.ID /control /v: $server
```

# Execute a process wait and kill a process

Expect the process to die/errored before the kill.

Stop on the first error (exitCode != 0)

```ps1
# script config
$pwd = Get-Location
$cwd = "C:\Program Files\SeleniumBasic"
$binary = "chromedriver.exe"

$max_iterations = 1
$max_execution_time = 2

# internal
$stdout_file = "$pwd\stdout.txt"
$stderr_file = "$pwd\stderr.txt"

for ($i=0; $i -le $max_iterations; $i++)
{
    $port = get-random -min 50000 -max 60000
    echo $port
    $argument_list = "--port=$port --verbose --append-log --log-path=.\log.log"

    $proc = Start-Process -filePath $binary -ArgumentList $argument_list -WorkingDirectory $cwd -RedirectStandardOutput "$pwd\stdout.txt" -RedirectStandardError "$pwd\stderr.txt" -PassThru

    $action = { Write-Host $EventArgs.Data  }
    Register-ObjectEvent -InputObject $proc -EventName OutputDataReceived -Action $action | Out-Null


    # wait up to x seconds for normal termination
    $proc | Wait-Process -Timeout $max_execution_time -ErrorAction SilentlyContinue -ErrorVariable timeouted

    if ($timeouted)
    {
        # terminate the process
        $proc | kill

        # update internal error counter
    }
    elseif ($proc.ExitCode -ne 0)
    {
        # update internal error counter
        date
        Write-Host "STDERR: " + (Get-Content $stderr_file)
        Write-Host "STDOUT: " + (Get-Content $stdout_file)
        $i = $max_iterations
        Write-Host "exit code: " + $proc.ExitCode
    }
    Write-Host "STDERR: " + (Get-Content $stderr_file)
    Write-Host "STDOUT: " + (Get-Content $stdout_file)
}
```

# execute a process until it fails

```ps1
# script config
$pwd = Get-Location
$cwd = "C:\Users\USR_RDACIB\Desktop\"
$binary = "C:\Users\USR_RDACIB\Desktop\runner\bot-test\lib\@rda\autohotkey\SciTE\..\AutoHotkeyU64.exe"
$argument_list = "/ErrorStdOut ""C:\Users\USR_RDACIB\Desktop\test.ahk"""

$max_iterations = 100
$max_execution_time = 10

# internal
$stdout_file = "$pwd\stdout.txt"
$stderr_file = "$pwd\stderr.txt"

for ($i=0; $i -le $max_iterations; $i++)
{
    echo "Iteration: $i"

    $proc = Start-Process -filePath $binary -ArgumentList $argument_list -WorkingDirectory $cwd -RedirectStandardOutput $stdout_file -RedirectStandardError $stderr_file -PassThru

    $action = { Write-Host $EventArgs.Data  }
    Register-ObjectEvent -InputObject $proc -EventName OutputDataReceived -Action $action | Out-Null


    # wait up to x seconds for normal termination
    $proc | Wait-Process -Timeout $max_execution_time -ErrorAction SilentlyContinue -ErrorVariable timeout

    if ($timeout)
    {
        # terminate the process
        $proc | kill

        # update internal error counter
    }
    elseif ($proc.ExitCode -ne 0)
    {
        # update internal error counter
        date
        #Write-Host "STDOUT: " + echo $proc.StandardOutput.ReadToEnd()
        #Write-Host "STDERR: " + echo $proc.StandardError.ReadToEnd()
        Write-Host "STDERR: " + (Get-Content $stderr_file)
        Write-Host "STDOUT: " + (Get-Content $stdout_file)
        $i = $max_iterations
        Write-Host "exit code: " + $proc.ExitCode
    }
    Write-Host "STDERR: " + (Get-Content $stderr_file)
    Write-Host "STDOUT: " + (Get-Content $stdout_file)
}
```

# Create file

```ps1
New-Item -Path . -Name "testfile1.txt" -ItemType "file" -Value "This is a text string."
```

# Create folder / directory

```ps1
New-Item -Path "c:\" -Name "logfiles" -ItemType "directory"
```

# Enable remote session

```ps1
Enable-PSRemoting
```

## troubleshooting

Check firewall

```ps1
Get-NetFirewallRule -Name *winrm*
```

Check service

```ps1
get-service winrm
```

Check configuration

```ps1
winrm g winrm/config
```

## Connecting

```ps1
$computers = "COMP01", "COMP02", "COMP03"
$user = "DOMAIN\USER"
$cred = Get-Credential -UserName $user -Message "Credenciales $user"
$session = New-PSSession -ComputerName $computers -Credential $cred
```

## Disconnecting

```ps1
Remove-PSSession $session
```

## remote execute command

Multiple computers (using session)

```ps1
Invoke-Command -Session $session { <command [;]> }
```

Single computer execution

```ps1
Invoke-Command -ComputerName Computer -ScriptBlock { Get-UICulture }
```

## Copy from local to remote

```ps1
Copy-Item "<from-local>" -Destination "<to-remote>" -ToSession $session
```

## Copy from remote to local

```ps1
Copy-Item "<from-remote>" -Destination "<to-local>" -FROMSession $session
```

# Check promnt has administrator priviledges / is admin

```ps1
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
```ps1

# Force my script to require admin priviledges

https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_requires

```ps1
#Requires -RunAsAdministrator
```

