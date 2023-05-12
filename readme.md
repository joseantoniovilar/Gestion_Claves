# Prueba de concepto para la gestión de claves aleatorias automatizadas

Se trata de una prueba de concepto para crear un procedimiento para la generación, automatización y gestión de las contraseña de los usuarios administradores en los equipos de la empresa:
1. Un método para la generación de una contraseña aleatoria  para cada usuario administrador de los equipos gestionados.
2. Automatizar de la contraseña aleatoria y almacenamiento en el despliegue de las imágenes en los equipos.
3. Gestionar las contraseñas de los distintos equipos desde un una base de datos centralizada para permitir las consultas y cambios por parte del personal IT.
4. Automatizar el despliegue de software y actualizaciones de los equipos masivamente con este nuevo sistema de contraseña única y aleatoria por equipo gestionado.
5. Incrementar la seguridad en la infraestructura de equipos

# Tecnologías y herramientas para la solución del problema

Para abordar al problema de crear y gestionar la contraseñas aleatorias se va a utilizar una serie de tecnologías y herramientas que se detallan en lo siguientes puntos.

## 2.1 - Gestor de contraseñas keepass

Para gestionar las contraseñas de los equipos utilizaremos KeePass  es un gestor de contraseñas que permite proteger las distintas contraseñas de forma segura. Para ello, se introducen las distintas contraseñas en una base de datos y quedan protegidas por una única llave maestra (master key) y un archivo de claves (key file) (Protección dos factores). Para acceder a la bóveda de contraseñas necesitas la master key y key file. La base de datos está cifrada usando la llave maestra (master key). Si se olvida ó pierde alguno de los componentes de la llave maestra ó la key file se perderán todos los datos almacenados en la base de datos. No hay puerta trasera ni clave universal que pueda abrir la base de datos. 

Su licencia es del tipo "GNU GENERAL PUBLIC LICENSE". Cuenta con bastantes complementos que permiten aumentar sus capacidades. Esta disponibles para las plataformas Windows y superior, Linux y macOS.

Este programa nos permite crear una bóveda para almacenar las  contraseñas de los administradores de los equipos que podremos en una carpeta compartida para poder acceder a ella desde el propio programa, como desde powershell  para la gestión de equipos y despliegue de software.

Para gestionar la bóveda se pueden  utilizar el propio programa Keepass.  También se podría utilizar una llave usb con un Google Chrome portable con la extensión KeePass Tusk - Password Access and Autofill, etc.  La Rest API también nos permite la consulta de la contraseña.  Hay aplicaciones para IOS y Android que pueden utilizar bóvedas keepass.

## 2.2 - Powershell

Para la implementación y  como herramienta DevOps utilizaremos Powershell que desde la versión 6 es multiplataforma, orientado a objectos, con una gran cantidad de cmdlets disponibles, acceso al framework .NET, diferentes formas de acceso remoto para le ejecución de script remotos.

Durante varios meses, los equipos de Microsoft han estado trabajando en el desarrollo de un módulo de PowerShell llamado SecretManagement. Este módulo ofrece una nueva forma de administrar las *credenciales* con PowerShell en bóvedas keepass.  Además, y muy importante,  cuenta con un módulo para interactuar con la bóvedas keepass

> Los módulos **Secret Management** y **Secret Store** son multiplataforma, también, funcionan en Linux y macOS 

Esta herramienta nos permitirá automatizar y gestionar la infraestructura de equipos.

# Organización del poryecto

Gestion_Claves
    |   readme.md
    |   
    +---codigo
    |       Set-claveBoveda.ps1 <- automatiza el procceso de generar una clave aleatoria,  almacenarla en una boveda keepass y  asignarla al usuario                                     administrador del equipo.
    |       
    \---modulos
            CrearPassAleatorio.psm1 <- fichero CrearPassAleatorio.psm1  generar una clave aleatoria

## Contributing

Es libre de utilizar este software. La mejoras y aportaciones son bienvenidas


## Authors

- [Jose Antonio Vilar](joseantonio.vilar@upm.es)


## License

[MIT](https://choosealicense.com/licenses/mit/)
