function Test-Scope
{
    $a = "Vor Function"
    function Test-SubScope
    {
        param(
            [string]$Eingabe
        )

        $global:a = $Eingabe
        Write-Host -ForegroundColor Magenta -Object $a
    }

Test-SubScope -Eingabe "Funktion"
Write-Host -Object $a -ForegroundColor DarkCyan

}

function Test-Scope2
{
    Write-Host -Object $a -ForegroundColor Green
}

function Test-Datei
{
    [cmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Dateiname
    )

    try 
    {
        if((Test-Path -Path $Dateiname -ErrorAction Stop    ) -ne $true)
        {
            throw "Einen Terminierenden Fehler"

            #Wenn bei Write-Error die Error Action auf Stop festgelegt wird, ist es ebenfalls ein terminierenden Fehler
            Write-Error -Message "Einen nicht terminierenden Fehler"

        }
    }
    catch 
    {
        "Fehler ist aufgetreten"
    }
}