configuration MyWebServer
{
    # Zum Abrufen der Knotenliste können Ausdrücke ausgewertet werden.
    # Beispiel: $AllNodes.Where("Role -eq Web").NodeName
    node ("Member1")
    {
        # Ressourcenanbieter aufrufen
        # Beispiel: WindowsFeature, File
        WindowsFeature WebService
        {
           Ensure = "Present"
           Name   = "Web-Server"
        }

        Service WWW-Dienst
        {
            Name = "w3svc"
            StartUpType ="Automatic"
        }

        Group WebAdmins
        {
            Ensure =  "Present"
            Groupname = "WebAdministratoren"
        }     
    }
}

[DSCLocalConfigurationManager()]
configuration LCMConfig
{
    Node Member1
    {
        Settings
        {
            ConfigurationMode = "ApplyAndAutoCorrect"
            ConfigurationModeFrequencyMins = 15
        }
    }
}

$Path = "C:\KursRepo\Hilfreiches\DSC\"
#Anwenden der eigentlichen Konfig bzw Erzeugung der MOF Dateien
MyWebServer -OutputPath $Path
Start-DscConfiguration -Wait -Verbose -Path $Path

#Anwenden der LCM Konfig
LCMConfig -OutputPath $Path
Set-DscLocalConfigurationManager -Path $Path -Verbose