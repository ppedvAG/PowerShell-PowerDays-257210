<#
.Synopsis
   Erstellung eines Testfilesverzeichnisses
.DESCRIPTION
   Dieses Skript erstellt TestFiles in einem angegebenen Verzeichnis. Die Anzahl kann angegeben werden.
.PARAMETER Path
 Dieser Parameter gibt an unter welchem Pfad der TestFiles Ordner angelegt wird.
#>
[cmdletBinding()]
param(
[ValidateScript({Test-Path -Path $PSItem -Pathtype Container})]
[Parameter(Mandatory=$true)]
[string]$Path,

[ValidateRange(0,99)]
[int]$DirCount = 2,

[ValidateRange(1,99)]
[int]$FileCount = 9,

[Validatelength(3,20)]
[string]$Name = "Testfiles1",

[switch]$Force
)
#Funktionsdeklaration
function New-TestFiles 
{
[cmdletBinding()]
param(
[ValidateScript({Test-Path -Path $PSItem -Pathtype Container})]
[Parameter(Mandatory=$true)]
[string]$Path,

[ValidateRange(1,99)]
[int]$FileCount = 9,

[Validatelength(3,20)]
[string]$Name = "File"
)

    for($i = 1; $i -le $FileCount; $i++)
    {
        $FileName = $Name + ("{0:D2}" -f $i) + ".txt"
        New-Item -Path $Path -Name $FileName -ItemType File
    }

}
#Ende Funktionsdeklaration


#Prüfung ob Ordner vorhanden
$TestFilesDirPath = Join-Path -Path $Path -ChildPath $Name
if(Test-Path -Path $TestFilesDirPath -PathType Container)
{
    if($Force)
    {
        Remove-Item -Path $TestFilesDirPath -Recurse -Force
    }
    else
    {
        #ToDo: schöner machen
        Write-Host -ForegroundColor Red -Object "Ordner bereits vorhanden"
        exit
    }
}

$TestFilesDir = New-Item -ItemType Directory -Path $Path -Name $Name 

New-TestFiles -Path $TestFilesDir.FullName -FileCount $FileCount
<# Ersetzt durch Funktion
for($i = 1; $i -le $FileCount; $i++)
{
    $FileName = "File" + ("{0:D2}" -f $i) + ".txt"
    New-Item -Path $TestFilesDir.FullName -Name $FileName -ItemType File
}#>

for($i = 1; $i -le $DirCount; $i++)
{
    $DirName = "Dir" + ("{0:D2}" -f $i) 
    $subdir = New-Item -Path $TestFilesDir.FullName -Name $DirName -ItemType Directory

    New-TestFiles -Path $subdir.FullName -Name "$DirName-File" -FileCount $FileCount
    <# Ersetzt durch Funktion
    for($j = 1; $j -le $FileCount; $j++)
    {
        $FileName = "$DirName-File" + ("{0:D2}" -f $j) + ".txt"
        New-Item -Path $subdir.FullName -Name $FileName -ItemType File
    }#>
}