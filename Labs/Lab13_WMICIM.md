# Lösung zu Lab WMI CIM

1. 
```powershell
Get-WmiObject -NameSpace root\cimv2 -list
```
oder halt über CIM
```powershell
Get-CimClass -NameSpace root\Cimv2
``` 

2.
```powershell
Get-WmiObject -Class <ClassName>
```
oder halt über CIM
```powershell
Get-CimInstance -ClassName <ClassName>
```

3.
```powershell
Get-WmiObject -Class Win32_OperatingSystem | Format-List -Property *
```
oder mit CIM
```powershell
Get-CimInstance -ClassName Win32_OperatingSystem | Format-List -Property *
```
Alternativ ohne Format Kommando 
```powershell
Get-CimInstance -ClassName win32_OperatingSystem -Property *
```