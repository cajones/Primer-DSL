
function Get-SubversionSource($SourceControlPath, $PhysicalPath) {

    if(-not (Test-Path $PhysicalPath)) {
        svn checkout $SourceControlPath, $PhysicalPath
    } else {
        svn up $PhysicalPath
    }
    return $PhysicalPath
}
Export-ModuleMember -function Get-SubversionSource

function Invoke-Browser($Domain) {

    $response = Read-Host "View http://$Domain now?`n[Y] Yes [N] No"
    if($response -match "Y") {
        start "http://$Domain"
    }
}
Export-ModuleMember -function Invoke-Browser

function Add-Host($Domain, $IP= "127.0.0.1") {
    
    $hosts  = "$env:windir\System32\drivers\etc\hosts";
    if(-not ((gc $hosts) -match "\s+$Domain")) {
        ac $hosts "`n$IP`t`t$Domain`n"    
        Write-Host "$Domain has been added to your hosts file"
    } else {
        Write-Host "$Domain already in hosts files"
    }
    return $Domain
}
Export-ModuleMember -function Add-Host

function New-WebApplication($PhysicalPath, $Domain, $Description, $Framework = "v4.0", $Pipeline = "Integrated") {
    if($Description -eq $Null) {
        $Description = $Domain
    }

    if($Pipeline -match "Integrated") {
        $Pipeline = 0
    }
    if($Pipeline -match "Classic") {
        $Pipeline = 1
    }

    if(-not (Test-Path IIS:\)) {
        Import-Module WebAdministration  
    }

    if(-not (Test-Path IIS:\AppPools\$Description)) {
        New-Item IIS:\AppPools\$Description
        Set-ItemProperty IIS:\AppPools\$Description -name managedRuntimeVersion -value $Framework
        Set-ItemProperty IIS:\AppPools\$Description -name managedPipelineMode -value $Pipeline
    }

    if(-not (Test-Path IIS:\Sites\$Description)) {
        New-Item IIS:\Sites\$Description -Bindings (@{Protocol="http";BindingInformation="*:80:$Domain"}) -PhysicalPath $PhysicalPath
        Set-ItemProperty IIS:\Sites\$Description -name ApplicationPool -value $Description
    }
    Write-Host "$Description web site is setup on your machine.`n"
    return $Domain
}
Export-ModuleMember -function New-WebApplication
