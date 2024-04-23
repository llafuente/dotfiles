# hide promnt

```
function prompt { " `b" }
function prompt { echo " `b" }
```

When running scripts
```
powershell -NoExit -Command "function prompt { echo " &#x60;b" }"
```

# hide echo command (@echo off)

All commands
```
Set-PSDebug -Off
```

just one
```
@something
```

# stderr to stdout

2>&1

# stdout to stderr

1>&2

# tab char

> ConvertFrom-Csv  .\test.csv -Delimiter "`t"

# RDP shadow

$server = 

$session = (query session /SERVER:$server) -replace '\s{2,}', ',' | ConvertFrom-Csv | Select-Object -Property SESSIONNAME,USERNAME,ID,STATE,TYPE,DEVICE |Out-GridView -PassThru
mstsc /shadow: $session.ID /control /v: $server

# Execute a process wait and kill a process

Expect the process to die/errored before the kill.

Stop on the first error (exitCode != 0)

```powershell
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

```powershell
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

> New-Item -Path . -Name "testfile1.txt" -ItemType "file" -Value "This is a text string."

# Create folder / directory

> New-Item -Path "c:\" -Name "logfiles" -ItemType "directory"