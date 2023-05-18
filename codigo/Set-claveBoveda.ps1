<#
.SYNOPSIS
Genera una contraseña aleatoria y la guarda en una bóveda keepass 

.DESCRIPTION
Este script permite generar la clave aleatoria utlizando el modulo CrearPassAleatorio.psm1, 
Microsoft.PowerShell.SecretManagement y guardarla en una boveda de keepass.
También, necesita una bovedad keepass *.kdbx para almacenar la paswword

.EXAMPLE
	 Set-claveBoveda.ps1 

.NOTES
   Requiere Windows PowerShell 6.1 or later, el modulo CrearPassAleatorio.psm1, Microsoft.PowerShell.SecretManagement
   y una boveda keepass.
   Ultima actualización: 22/11/2021 (joseantonio.vilar@upm.es)
#> 
[CmdletBinding()]
param(
    [Parameter(Position = 0,
        ValueFromPipelineByPropertyName
    )]
    #Valor por defecto upm
    [string]$userAdmin = "Nombre usuario admin"
)

Import-Module ..\modulos\CrearPassAleatorio.psm1

#Instalamos los modulos necesarios para gestionar bovedas de seguridad keepass
Install-Module -Name Microsoft.PowerShell.SecretManagement
Install-Module SecretManagement.KeePass

#Ruta del la boveda .kdbx"
$vaultPath = "ruta boveda *.kdbx"
#Ruta del fichero .keyx"
$vaulKeyPath = ""
$masterPassword = ""

$host = $Env:COMPUTERNAME

$clave = CreaPassAleatorio

write-host "Registrando la bóveda $vaultPath"
Register-SecretVault -Name "KeePass_Hosts" -ModuleName "SecretManagement.Keepass" -VaultParameters @{
    Path              = $vaultPath
    UseMasterPassword = $true
    MasterPassword    = $masterPassword
    #KeyPath           = $vaulKeyPath
}

Write-host "La bóveda se ha registrado: " -NoNewline
Test-SecretVault -Name KeePass_Hosts
Unregister-SecretVault KeePass_Hosts
#Almacenamos la clave en una bd de keepass en una unidad compartida
Set-Secret -Vault KeePass_Hosts -Name $host -Secret $clave 
Write-host "La password del equipo $hostes: "  -NoNewline
Get-Secret -Vault KeePass_Hosts -Name $host -AsPlainText

Write-host Estableciendo la clave del usuario administrador del equipo: $clave 
$cuentaAdmin = Get-LocalUser -Name $userAdmin
$cuentaAdmin | Set-LocalUser -Password $clave  -PasswordNeverExpires
