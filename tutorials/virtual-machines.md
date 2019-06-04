# Troubleshooting

Raw-mode is unavailable courtesy of Hyper-V. (VERR_SUPDRV_NO_RAW_MODE_HYPER_V_ROOT).

> bcdedit

```
hypervisorlaunchtype    Auto
```

> Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All

> bcdedit /set hypervisorlaunchtype off

rollback

> Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

> bcdedit /set hypervisorlaunchtype auto
