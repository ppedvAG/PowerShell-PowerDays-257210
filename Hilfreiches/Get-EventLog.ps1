<#
.SYNOPSIS
 Kurzbeschreibung: Abfrage von Anmelde / Abmelde Events
.DESCRIPTION
 Lange Beschreibung der Aufgaben des Skriptes. 
.PARAMETER EventId
 4624 Anmeldeevents
 4625 Fehlgeschlagene Anmeldungen
 4634 Abmeldungen
.EXAMPLE
Get-EventLog.ps1  -EventId 4624

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  932034 Feb 19 11:21  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  932031 Feb 19 11:21  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  932028 Feb 19 11:21  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  932025 Feb 19 11:20  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  932022 Feb 19 11:19  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  932019 Feb 19 11:18  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  932016 Feb 19 11:18  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  932014 Feb 19 11:17  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  932009 Feb 19 11:17  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  932006 Feb 19 11:17  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
.LINK
 https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1#syntax-for-comment-based-help-in-scripts
#>
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[ValidateSet(4624,4625,4634)]
[int]$EventId,

[ValidateRange(5,20)]
[int]$Newest = 3,

[string]$Computername = "localhost"
)
Write-Verbose -Message "Verbose Ausgaben sind optionale Ausgabe"
Write-Verbose -Message "Vor der Abfrage"
Write-Verbose -Message "Es wurden folgende Werte verwendet EventID:$EventId Newest:$Newest Computername:$Computername"

Write-Debug -Message "DebugHaltepunkt vor der Abfrage"

Get-EventLog -LogName Security -ComputerName $Computername | Where-Object -FilterScript {$PSItem.EventID -eq $EventId} | Select-Object -First $Newest

