class Vehicle
{
    [string]$Color
    [string]$Manufacturer
    [string]$Modell
}

class Car : Vehicle
{
    #Properties
    [int]$MaxSpeed
    [int]$PS
    [int]$Tires
    [Motortyp]$Motortyp

    # Konstruktoren werden "ausgeführt" beim erstellen einer neuen Instanz der Klasse
    Car()
    {
        #Default Konstruktor wird verwendet wenn keine Werte übergeben werden
    }
    Car([string]$Manufacturer)
    {
        $this.Manufacturer = $Manufacturer
    }
    Car([string]$Manufacturer,[string]$Modell)
    {
        $this.Manufacturer = $Manufacturer
        $this.Modell = $Modell
    }

    #Methoden 
    [void]Drive([int]$Distance)
    {
        [int]$Speed = 0
        [string]$Road = "🚗"

        for($i = 1; $i -le $Distance; $i++)
        {
            $Road = "-" + $Road
            if($Speed -lt $this.MaxSpeed)
            {
                $Speed += 15
            }
            Start-Sleep -Milliseconds (300 - $Speed)
            Clear-Host
            Write-Host -Object $Road
        }
    }


    #Bestehende Standard Methoden überschreiben
    [string]ToString()
    {
        [string]$Return = "[ " + $this.Manufacturer + " : " + $this.Modell + " ]"
        return $Return
    }

    [string]ToString([string]$InformationLevel)
    {
        [string]$Return = ""
        switch($InformationLevel)
        {
            Detailed {$Return = "[ " + $this.Manufacturer + " : " + $this.Modell + " : " + $this.Color + " ]"}
            CSV {$Return = $this | ConvertTo-Csv}
            JSON {$Return = $this | ConvertTo-Json}
            Default {$Return = $this.ToString()}
        }
        return $Return
    }
}

enum Motortyp
{
    Sonstiges
    Benzin
    Diesel
    Elektrisch
    Hybrid
    Wasserstoff
    Kinetisch
}


#$Auto = [Car]::new()
$Auto = [Car]::new("BMW","G21")
$Auto.Color = "Schwarz"
$Auto.Motortyp = [Motortyp]::Hybrid
#$Auto.Manufacturer = "BMW"
#$Auto.Modell = "G21"
$Auto.MaxSpeed = 252
$Auto.PS = 252
$Auto.Tires = 4

$Auto.Drive(100)