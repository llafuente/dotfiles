# values

```ps1
$true
$false
$null
```

# variables

```ps1
# variables starts with dollar
# if type lhs type is enforced
[int]$number = 10;
$number.getType() # Int32
[float]$number = 10;
$number.getType() # Single
$str = "abcdef"; # [String]
$arr = @(1,2,3) # Object[]
# class instance
$obj = [class]::New(1,2,3) # class
# array to multiple variables assignament
$a, $b = "Hello","Bye"
#declare the variable globally
$global:xxx = 1
```

# string interpolation

```ps1
$person = [pscustomobject]@{Name= "xxx";}
$a = 10;
$b = 5;
```

## single value

```ps1
Write-Host $person
Write-Host $person.Name
```

## string interpolation

```ps1
Write-Host "Name: $($person.Name)"
```

## math is allowed

```ps1
Write-Host "$($a - $b)"
```

## command execution / expression

```ps1
Write-Host "$(Get-Item .)"
Write-Host "$(if ($true) { Get-Item . }  else { $null })"
```

## execute a command and then pick something

```ps1
Write-Host "$($(Get-ChildItem)[0])"
Write-Host "$($(Get-ChildItem)[0].Name)"
```

## Discovering objects, properties, and methods

More: https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/03-discovering-objects?view=powershell-7.4

```ps1
# list all members
$obj | Get-Member

# list members by type
$obj | Get-Member -MemberType Method
$obj | Get-Member -MemberType Property
# MemberType: AliasProperty | CodeProperty | Property | NoteProperty | ScriptProperty | Properties | PropertySet | Method | CodeMethod | ScriptMethod | Methods | ParameterizedProperty | MemberSet | Event | Dynamic | All}

# Filter properties
$obj | Select-Object -Property a,b,c
$obj | Select-Object -Property get*
```

# string

## single line

```ps1
$str = "hello world"
# escape
$str = "`r`n"
```
## multi line
```ps1
$str = @'
Here you can type whatever!
new lines allowed!
'@
```

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

# switch

* multiple matches
* `continue` will process the next item (`continue` is not `fallthough`)
* `break` exit switch


parameters: -CaseSensitive, -Wildcard, -Regex, -File

```ps1
# equality
$day = 3
$result = switch ( $day )
{
    0 { 'Sunday' }
    # ...
    6 { 'Saturday' }
    default { 'Unknown' }
}
#contains
$roles = @('WEB','Database')
switch ( $roles ) {
    'Database'   { 'Configure SQL' }
    'WEB'        { 'Configure IIS' }
    'FileServer' { 'Configure Share' }
}
# string matching (wildcard)
$Message = 'Warning, out of disk space'
switch -Wildcard ( $message )
{
    'Error*' {}
    'Warning*' {}
    default {}
}
# regex matching
switch -Regex ( $message )
{
    '^Error' {}
    '^Warning' {}
    '(?<SSN>\d\d\d-\d\d-\d\d\d\d)'
    {
        Write-Warning "message contains a SSN: $($matches.SSN)"
    }
    default {}
}
# enum
enum Context {
    Component
    Role
    Location
}

$item = [Context]::Role
switch ($item )
{
    ([Context]::Component)
    {
        'is a component'
    }
    ([Context]::Role)
    {
        'is a role'
    }
    ([Context]::Location)
    {
        'is a location'
    }
}
# case as command
$age = 37

switch ( $age )
{
    {$PSItem -le 18}
    {
        'child'
    }
    {$PSItem -gt 18}
    {
        'adult'
    }
}
```

[https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-switch?view=powershell-7.4](Everything you ever wanted to know about the switch statement)

# loops

```ps1
foreach ($element in $collection) {
  $element
}

foreach ($h in $hash.GetEnumerator()) {
    Write-Host "$($h.Name): $($h.Value)"
}
# NoteProperty | Property | whatever!
foreach ($h in $sourceRdaJson | Get-Member -MemberType NoteProperty) {
    Write-Host "$($h.Name): $($sourceRdaJson.$h)"
}

for ($i=0; $i -lt 10; $i++) { }
for (($i = 0), ($j = 0); $i -lt 10; $i++)
{
    "`$i:$i"
    "`$j:$j"
}

do {
} while($true)

while($true) {
}
```

# arrays, collections, objects, hashes

## static arrays

```ps1
# getType() = System.Array
$numbers = @(1, 2, 3, 4)
# add (it will create another array)
$numbers += 5

# array of arrays
$myItems =  ("Joe",32,"something about him"), ("Sue",29,"something about her")

# array of objects, based on a CSV input
$numbers = "1","2","3","4"
numbers = $numbers | ConvertFrom-Csv -Header value
```

## Dynamic array (list)

```ps1
$list = [System.Collections.ArrayList]@()
$list[0]            # Access array element
$list.Count         # Get array length
$list.Add($item)    # (push / append) Add item to array
$list.Remove($item) # Remove item from array

```

## hashes

```ps1
$hash = @{
  key1 = 'value1';
  key2 = 'value2';
}
$hash.key1	                # Access hash key
$hash.key2 = 'new value'	# Assign value to hash key
$hash.Add('key3', 'value')	# Add key-value pair
$hash.Remove('key2')	    # Remove key-value pair
```

## declare custom objects

```ps1
# literal
$P = "production"
[pscustomobject]@{hostname="computer007"; user="James"; env=$P;info="RDA"}
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

# Instancing
$a = [Base]::new()
$a -is [Base] # $true
$b = [Child]::new()
# Array instancing: type is necessary or Object[] will be used!
[Base[]] $list = @($a, $b)

# Print type
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

# escape char: tab, new line

```ps1
ConvertFrom-Csv  .\test.csv -Delimiter "`t"

Write-Host -NoNewLine Say
Write-Host -NoNewLine Hello`r`n
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
$hostname = "localhost variable"
# send a function to remote
$functionDef = ${function:Custom-Function}
$result = Invoke-Command -Session $session -ScriptBlock {
  # it will print remote hostname
  Write-Host $(hostname)
  # prints: localhost variable
  Write-Host $using:hostname

  # define Custom-Function
  ${function:Custom-Function} = $using:functionDef
  # now you can call it
  Custom-Function
  ...
  Write-Output -NoEnumerate $output
}
# $result will hold $output but there are some type changes/conversion
# for example enum will no longer be "string comparable"
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

## Execute remote as task

Some commands shall be executed in the interactive session, for those you create a sheduler task and execute

```ps1
$Process = Invoke-Command -ComputerName "ComputerName" -ScriptBlock {

    $script = @"

    `$Process = Get-Process | Select-Object Name, MainWindowTitle

    `$Process | Export-Csv "`$(`$env:TMP)\process.csv" -NoTypeInformation
"@

    $script | Out-File "C:\Users\username\documents\process.ps1"

    $action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument `
    '-WindowStyle Hidden -file "C:\Users\username\documents\process.ps1"'

    Register-ScheduledTask -TaskName Get-Services -Action $action | Start-ScheduledTask
    Start-Sleep -Seconds 10
    Unregister-ScheduledTask -TaskName Get-Services -Confirm:$False
    $Process = Import-Csv "$($env:TMP)\process.csv"
    Get-ChildItem "C:\Users\username\documents\" | Remove-Item -Recurse
    $Process

}
```

# Check promnt has administrator priviledges / is admin

```ps1
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
```

# Force my script to require admin priviledges

https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_requires

```ps1
#Requires -RunAsAdministrator
```

# Active directory / kerberos / login / session information

Asorted information

```ps1
[System.DirectoryServices.ActiveDirectory.Domain]::GetComputerDomain()
[System.Security.Principal.WindowsIdentity]::GetCurrent()
```

# rtf -> clipboard

```ps1
Add-Type -AssemblyName "System.Windows.Forms" | Out-Null
$contents = (Get-Content -Raw "C:\path\to\file.rtf")

[Windows.Forms.Clipboard]::SetDataObject([Windows.Forms.DataObject]::new([Windows.Forms.DataFormats]::Rtf,$contents))
```
