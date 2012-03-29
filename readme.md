Primer-DSL
==========

Overview
--------

Adds a set of Powershell Cmdlets to set up projects and web applications.

Installation
------------

    install.ps1

Or copy Primer-DSL.psm1 to $home\Documents\WindowsPowerShell\Modules\Primer-DSL.
In your script import the module:

    Import-Module Primer-DSL

Reference
---------

    Get-SubversionSource($SourceControlPath, $PhysicalPath)

Performs a subversion checkout or update.

    New-WebApplication($PhysicalPath, $Domain, $Description, $Framework = "v4.0", $Pipeline = "Integrated")

Creates a web application in IIS.

    Add-Host($Domain, $IP= "127.0.0.1")

Attempts to modify the host file to add the domain and ip address

    Invoke-Browser($Domain)

Promtes the user to launches the browser

Dependencies
------------
The cmdlets that create app pools and sites require IIS Web Administration Snap-in. These are available as default on Windows 7 but if you have an older os then you might need to [install them](http://learn.iis.net/page.aspx/429/installing-the-iis-powershell-snap-in/).