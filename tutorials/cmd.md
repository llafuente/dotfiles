# download file

## win10

```cmd
curl
```

## pre win10

```cmd
bitsadmin /Create DownloadDumpData
bitsadmin /SetCredentials DownloadDumpData target scheme username password
bitsadmin /AddFile DownloadDumpData http://1.1.1.1:8080/job/dump_data/ws/dump_data.zip %WORKSPACE%\dump_data.zip
bitsadmin /SetPriority DownloadDumpData "FOREGROUND"
bitsadmin /Resume DownloadDumpData
:WAIT_DUMP_DATA_DOWNLOAD_LOOP_START
    @rem state thanks to http://ss64.com/nt/bitsadmin.html & http://serverfault.com/a/646948/93281
    call bitsadmin /info DownloadDumpData /verbose | find "STATE: TRANSFERRED"
    if %ERRORLEVEL% equ 0 goto WAIT_DUMP_DATA_DOWNLOAD_LOOP_END
    call bitsadmin /RawReturn /GetBytesTransferred DownloadDumpData
    @rem sleep thanks to http://stackoverflow.com/a/1672375/535203
    timeout 2
    goto WAIT_DUMP_DATA_DOWNLOAD_LOOP_START
:WAIT_DUMP_DATA_DOWNLOAD_LOOP_END
call bitsadmin /Complete DownloadDumpData
```
