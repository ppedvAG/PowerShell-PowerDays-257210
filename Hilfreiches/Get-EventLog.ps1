param(
[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 10,

[string]$Computername = "localhost"
)

Get-EventLog -LogName Security -ComputerName $Computername | Where-Object -FilterScript {$PSItem.EventID -eq $EventId} | Select-Object -First $Newest

