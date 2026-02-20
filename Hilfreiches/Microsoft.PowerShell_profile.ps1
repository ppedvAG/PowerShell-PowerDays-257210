function Get-MotD
{
    $ergebnis = Invoke-RestMethod -Uri https://bofh-api.bombeck.io/v1/excuses/random/ 
    "MotD: $($ergebnis.GetEnumerator().quote)"
}

Get-MotD

function prompt 
{
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.principal.WindowsPrincipal] $identity
    $adminrole = [Security.Principal.WindowsBuiltInRole]::Administrator
    $prefix = ""
    if($principal.IsInRole($adminrole))
    {
        $Prefix += "[ADMIN]"
    }

    $prefix += $PWD.Path 
    if($PWD.Path.Length -gt 25)
    {
        Write-Host -Object $prefix

        if($NestedPromptLevel -ge 1)
        {
            Write-Host -Object ">>" -NoNewline
        }
        else
        {
            Write-Host -Object ">" -NoNewline
        }
    }
    else
    {
        if($NestedPromptLevel -ge 1)
        {
            $prefix += ">>" 
        }
        else
        {
            $prefix += ">"
        }
        Write-Host -Object $prefix -NoNewline
    }
}