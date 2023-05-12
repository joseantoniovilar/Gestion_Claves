
function CreaPassAleatorio {
    <#
.SYNOPSIS
 Genera un password aleatorio

.DESCRIPTION
Permite genera password aleatorio con : miniscula, mayuscula, número y simbolos

.PARAMETER Longitud
El tamaño del password
 
.EXAMPLE
CrearPassAleatorio 

  .EXAMPLE
CrearPassAleatorio -Tamano 25

.NOTES
   Requiere Windows PowerShell 6.1 or later.
   Ultima actualización: 15/11/2021 (joseantonio.vilar@upm.es)
  #>

    [OutputType([String])]

    param(
        #https://es.wikipedia.org/wiki/Seguridad_de_la_contrase%C3%B1a
        #H = 70 simbolos, L = logintud de la contraseña, H = entropia
        #70^15, H=L*(Log N/Log 2)= 15*(Log 70/Log 2)
        [int] $Longitud = 15
    )

    $simbolos = '!=$%&?*¿'.ToCharArray()
    $numeros = '0123456789'.ToCharArray()
    $caracteres = [char]'a'..[char]'z' + [char]'A'..[char]'Z' | % { [char]$_ } 
    $characterList = $caracteres + $numeros + $simbolos

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-random?view=powershell-7.2
    do {
        $password = -join (0..$Longitud | % { $characterList | Get-Random })
        [int]$hasMinChar = $password -cmatch '[a-z]'
        [int]$hasMayChar = $password -cmatch '[A-Z]'
        [int]$hasDigito = $password -match '[0-9]'
        [int]$hasSimbolo = $password.IndexOfAny($simbolos) -ne -1
  
    }
    until (($hasMinChar + $hasMayChar + $hasDigito + $hasSimbolo) -ge 3)
  
    #$secureString = $password | ConvertTo-SecureString -AsPlainText
    return $password
}