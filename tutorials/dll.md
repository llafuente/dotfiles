# display dot net runtime used by dll

```
$fullpath = "C:\Some.dll"
$x = [Reflection.Assembly]::ReflectionOnlyLoadFrom($fullpath)

# expected runtime version
$x.ImageRuntimeVersion

# ?
$x.CustomAttributes |
Where-Object {$_.AttributeType.Name -eq "TargetFrameworkAttribute" } | 
Select-Object -ExpandProperty ConstructorArguments | 
Select-Object -ExpandProperty value

# ?
$x.ManifestModule.CustomAttributes |
Where-Object {$_.AttributeType.Name -eq "TargetFrameworkAttribute" } | 
Select-Object -ExpandProperty ConstructorArguments | 
Select-Object -ExpandProperty value
```
