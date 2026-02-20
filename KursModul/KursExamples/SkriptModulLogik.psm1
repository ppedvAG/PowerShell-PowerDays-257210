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

function Test-PipeLineInput
{
[cmdletBinding()]
param(
[Parameter(ValueFromPipeLine = $true, ValueFromPipeLineByPropertyName = $true)]
[string]$Name,

[Parameter(ValueFromPipeLineByPropertyName = $true)]
[string]$Status
)

    "Name: $Name Status:$Status" 

}

function Test-BeginProcessEnd
{
param(
[Parameter(ValueFromPipeLine = $true, ValueFromPipeLineByPropertyName = $true)]
[string]$Name,

[Parameter(ValueFromPipeLineByPropertyName = $true)]
[string]$Status
)
    Begin
    {
        Write-Verbose -Message "Der Begin Block wird einmal zum Start ausgeführt und kann verwendet werden z.B. zum initialiseren von Variablen oder Importieren von Modulen. "
    }
    Process
    {
        #Wird für jedes übergebene Objekt ausgeführt
        "Name: $Name Status:$Status" 
    }
    End
    {
        Write-Verbose -Message "Wird einmal zum Schluss ausgeführt"
    }
}

function Out-Voice
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true,ValueFromPipeLine = $true)]
[string]$Message
)

    Begin
    {
        Add-Type -AssemblyName System.Speech
        $speaker = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer

        $audiosrv = Get-Service -Name Audiosrv
        if($audiosrv.Status -ne "Running")
        {
            $audiosrv.Start()
        }
        $speaker.SelectVoice("Microsoft Zira Desktop")
    }
    Process
    {
        $speaker.Rate
        $speaker.Speak($Message)
    }
    End
    {
        $speaker.Dispose()
    }
}
