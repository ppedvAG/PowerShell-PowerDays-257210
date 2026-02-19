[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 10,

[string]$Computername = "localhost"
)
Write-Verbose -Message "Verbose Ausgaben sind optionale Ausgabe"
Write-Verbose -Message "Vor der Abfrage"
Write-Verbose -Message "Es wurden folgende Werte verwendet EventID:$EventId Newest:$Newest Computername:$Computername"

Write-Debug -Message "DebugHaltepunkt vor der Abfrage"

Get-EventLog -LogName Security -ComputerName $Computername | Where-Object -FilterScript {$PSItem.EventID -eq $EventId} | Select-Object -First $Newest

