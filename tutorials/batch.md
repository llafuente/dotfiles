# References

https://www.robvanderwoude.com/battech.php

# Execution

## execution two command (or)

```bat
(command1 & command2)
```

## execution first command and the next if success (and)

```bat
(command1 && command2)
```

## start a process in background (fg)

```bat
start /B process.exe
```

## exit, exitcode

```bat
exit 1
```

# Output redirection

## Redirect stdout

```bat
dir 1> a.txt
```

## Redirect stderr

```bat
dir 2> a.txt
```

## Redirect stdout & stderr

```bat
dir > a.txt 2>&1
```

## \*.bat self redirect stdout & stderr

```bat
>update.bat.log.txt 2>&1 (
  @rem here the output will be redirected
)
```

## Chain processes

A process output is the other processs input. Use pipe character.

```bat
dir | find "xxx"
```

# Process output to a variable

Note: setlocal and set failed for me when used the bat for the first time.

```bat
  FOR /F "tokens=*" %%g IN ('xxx.exe "double quotes allowed" --quiet') do (
    echo %%g
  )
```


# if

## check process exitcode

```bat
dir
IF ERRORLEVEL 1 (
  echo "dir failed"
) ELSE (
  echo "dir sucess"
)
```
## equal always string with quotes

```bat
set "x=11"
@rem without quotes fail!
IF "%x%"=="11" (
  echo "equal!"
) ELSE (
  echo "not equal!"
)
```

## case-insensitive

```bat
set "x=abc"
@rem without quotes fail!
IF /i "%x%"=="ABC" (
  echo "case-insensitive equal!"
) ELSE (
  echo "case-insensitive not equal!"
)
```

## empty string

```bat
IF [%1] == [] ()
```
## file/folder exists

```bat
(if not exist .\\docs\\html mkdir .\\docs\\html)
```

# input confirmation

```bat
@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=Are you sure (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

echo ... rest of file ...


:END
endlocal
```

```bat
@echo off
choice /C YN /M "Do you want to continue [Yes/No]"
if errorlevel 255 (
    echo Error
  ) else if errorlevel 2 (
    @REM N
  ) else if errorlevel 1 (
    @REM Y
  ) else if errorlevel 0 (
    @REM CTRL+C
  )
```