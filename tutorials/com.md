# browse COMObject

```powershell
$obj = New-Object -ComObject Selenium.ChromeDriver
# list properties
$obj | Select-Object -Property *
$obj | Get-Member -MemberType Property
# list members / functions
$obj | Get-Member -MemberType Method
```

# list all COM objects registered

Could be more...

```powershell
Get-ChildItem -Path 'HKLM:\Software\Classes' -ErrorAction SilentlyContinue | 
Where-Object {$PSItem.PSChildName -match '^\w+\.\w+$' -and
(Get-ItemProperty "$($PSItem.PSPath)\CLSID" -ErrorAction SilentlyContinue)} | 
Format-Table PSChildName -AutoSize
```


