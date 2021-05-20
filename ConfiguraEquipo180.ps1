# Habilita la opcion de ejecutar scripts
Set-ExecutionPolicy RemoteSigned -Force

clear
Write-Output 'Bienvenid@, Empezaremos a configurar el equipo'
Write-Output ''
Write-Output 'NOTA: ELIJA CON CUIDADO LA OPCIÓN DESEADA'
Write-Output ''

    $Domain = 'bbva-impulse.itq'
    $Usuario = 'soporte'
    $HostnameActual = $env:COMPUTERNAME
    $Mascara = '22'
    $Gateway = '172.24.75.201'
    $DNS1 = '172.24.74.180'
    $DNS2 = ''
    $ipanterior = (Get-NetIPAddress -PrefixOrigin Manual).IPAddress
    $adaptador = (Get-NetAdapter).Name
    $dnsanterior = ((Get-NetIPConfiguration).DNSServer).ServerAddresses
    $gatewayanterior = ((Get-NetIPConfiguration).IPv4DefaultGateway).NextHop

    Write-Output 'OPCIONES GENERALES'
    Write-Output ''
    $opcion = Read-Host '1) INSTALA TODO  2)DOMINIO  3) RED  4)DESINSTALA CHECK-LIST 5) SALIR'
    Write-Output ''

    switch($opcion){
        1{
            clear
            
            $ruta  = 'C:\Users\Administrador\Documents\Relacion-nave-b.txt'
            $ruta1 = 'C:\Users\Administrador\Documents\info\test.txt'
            $ruta2 = 'C:\Users\Administrador\Documents\info\'
            $ruta3 = 'C:\Users\Administrador\Documents\info\infodns.txt'
            $doc   = 'C:\Users\Administrador\Documents\info\inf'
            $docdns   = 'C:\Users\Administrador\Documents\info\dns'
            $ext = '.txt'
            
            rm -Force -Recurse $ruta2
            Write-Output 'Se esta eliminando la informacion para realizar la configuracion C:\Users\Administrador\Documents\info\'
            mkdir $ruta2
            Write-Output ''
            Write-Output 'Se esta eliminando la informacion para realizar la configuracion C:\Users\Administrador\Documents\info\'

            Write-Output 'Bienvenid@, estás a punto de configurar el equipo'
            Write-Output ''
            Write-Output $HostnameActual' <- Tu nuevo hostname debe ser diferente a este'
            Write-Output ''
            Write-Output "PARA CONFIGURAR EL HOSTNAME DEL EQUIPO`nCOLOQUE LOS 4 DIGITOS DE LA EXTENSION `nEXTENSION A CONFIFURAR"
            $buscaextension = Read-Host 'EJEMPLO: 7201'
            Write-Output ''
            $busca = Get-Content -Path $ruta | Select-String -Pattern $buscaextension
            Write-Output $busca

            <# Extracion y busca de extension para configurar red #>

            $busca > $ruta1
            
            $letterarray = Get-Content -Path $ruta1
            -split $letterarray > $ruta1
            $letterarray = Get-Content -Path $ruta1

            $i = 0
            $j = 0

            foreach ($letter in $letterarray){
                if($letter -match $regex){        
                    $letter > $doc$i$ext
                    $i = $i + 1
                }
            }

            <# Extraccion de dns #>

            $dnsanterior > $ruta3
            
            $letterarray = Get-Content -Path $ruta3
            -split $letterarray > $ruta3
            $letterarray = Get-Content -Path $ruta3

            $i = 0
            $j = 0

            foreach ($letter in $letterarray){
                if($letter -match $regex){        
                    $letter > $docdns$i$ext
                    $i = $i + 1
                }
            }


            #clear
            $HostnameNuevo = Get-Content -Path 'C:\Users\Administrador\Documents\info\inf1.txt'
            $Ip = Get-Content -Path 'C:\Users\Administrador\Documents\info\inf5.txt'

            Rename-Computer $HostnameNuevo
            Write-Output ''
            Write-Host 'Se renombro el nombre del equipo a'$HostnameNuevo
            Write-Output ''
            Add-computer -domainname $Domain -Credential $Usuario -newname $HostnameNuevo -Restart -Force
            Write-Output ''
            Write-Output 'Se subio a dominio el equipo'
            Write-Output ''                      
            Write-Output 'SE MODIFICARA COMPLETAMENTE LOS PARAMETROS DE LA RED'
            Write-Output ''
            Write-Output "La Extension es"$buscaextension "`nLe corresponde la IP"$Ip "`nLa Mascara correspondiente es"$Mascara "`nEl Gateway es:"$Gateway "`nEl DNS 1 es"$DNS1 "`nEl DNS 2 es"$DNS2
            
            Write-Output ''
            #Write-Output 'Ejemplo de prueba para la eliminacion de ip'
            #Write-Output $ipanterior' '$gatewayanterior
            Remove-NetIPAddress –IPAddress $ipanterior -DefaultGateway $gatewayanterior
            Write-Host 'Se eliminaron los parametros anteriores de la red'
            Write-Output ''
            #Write-Output 'ejemplo de nuevos parametros de red'
            #Write-Output $adaptador' '$Ip' '$Mascara' '$Gateway
            New-NetIPAddress –InterfaceAlias $adaptador –IPAddress $Ip –PrefixLength $Mascara -DefaultGateway $Gateway
            Set-DnsClientServerAddress -InterfaceAlias $adaptador -ServerAddresses ($DNS1, $DNS2)
            Write-Host 'Se agregaron los parametros nuevos de la red'
            Write-Output ''
            #Get-NetIPConfiguration

            Write-Output ''
            Write-Output 'CONFIGURACIONES DE NUEVA RED'
            ipconfig /all
            Write-Output ''
            Write-Output 'Se elimino la carpeta C:\Users\Script'
            rm -Recurse -Force C:\Users\Script
            Write-Output ''
            Write-Output 'Se creo la carpeta C:\Users\Script'
            mkdir -Force C:\Users\Script
            Write-Output ''
            Write-Output 'Se copio el contido de la carpeta C:\Users\Administrador\Documents\SOPORTE\Script\* a la ruta C:\Users\Script\*'
            cp C:\Users\Administrador\Documents\SOPORTE\Script\* -Destination C:\Users\Script\ -Recurse -Force
            
            Write-Output ''
            Write-Output 'Se creo el archivo C:\Users\Script\desinstala.ps1'

            echo '
            Get-AppxPackage *3dbuilder* | Remove-AppxPackage
            Get-AppxPackage *windowsalarms* | Remove-AppxPackage 
            Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
            Get-AppxPackage *windowscamera* | Remove-AppxPackage
            Get-AppxPackage *officehub* | Remove-AppxPackage
            Get-AppxPackage *skypeapp* | Remove-AppxPackage
            Get-AppxPackage *getStarted* | Remove-AppxPackage
            Get-AppxPackage *zunemusic* | Remove-AppxPackage
            Get-AppxPackage *windowsmaps* | Remove-AppxPackage
            Get-AppxPackage *solitairecollection* | Remove-AppxPackage
            Get-AppxPackage *bingfinance* | Remove-AppxPackage
            Get-AppxPackage *zunevideo* | Remove-AppxPackage
            Get-AppxPackage *bingnews* | Remove-AppxPackage
            Get-AppxPackage *OneNote* | Remove-AppxPackage
            Get-AppxPackage *personas* | Remove-AppxPackage
            Get-AppxPackage *WindowsPhone* | Remove-AppxPackage
            Get-AppxPackage *Fotos* | Remove-AppxPackage
            Get-AppxPackage *windowsstore* | Remove-AppxPackage
            Get-AppxPackage *bingsports* | Remove-AppxPackage
            Get-AppxPackage *SoundRecorder* | Remove-AppxPackage
            Get-AppxPackage *bingweather* | Remove-AppxPackage
            Get-AppxPackage *xboxapp* | Remove-AppxPackage
            Get-AppxPackage *Phone* | Remove-AppPackage
            Get-AppxPackage *yourphone* | Remove-AppPackage
            Get-AppxPackage *xboxgaming* | Remove-AppPackage
            Get-AppxPackage *MSPaint* | Remove-AppPackage
            get-appxpackage *Microsoft.People* | Remove-AppPackage
            get-appxpackage *Help* | Remove-AppPackage
            cd *C:\Program Files (x86)\Microsoft\Edge\Application> .\msedge --uninstall --system-level --verbose-logging --force-uninstall*
            Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage 
            Remove-Item "C:\Program Files (x86)\Microsoft\Edge\Application" -Recurse -Force
            Remove-Item "C:\Program Files (x86)\Microsoft\Edge" -Recurse -Force
            Remove-Item "C:\Program Files (x86)\Microsoft\" -Recurse -Force
            Write-Output ""
            Write-Output "SE DESINSTALARON LAS APPS DEL CHECK-LIST"
            ' >> C:\Users\Script\desinstala.ps1

            Write-Output ''
            echo 'start /min powershell -WindowStyle Hidden -Command C:\Users\Script\desinstala.ps1' >> C:\Users\Script\ejecuta.bat
            Write-Output 'Se creo el archivo C:\Users\Script\ejecuta.bat'

            <#
            Write-Output ''
            Write-Output 'SE HABILITO EL USUARIO ADMINISTRADOR'
            Net user Administrador /active:yes
            Write-Output ''
            Write-Host 'Escriba su contraseña de inicio de sesion del ADMINISTRADOR'
            Net user Administrador *

            clear
            Write-Output ''
            Write-Host 'SE DESHABILITO EL USUARIO DE TECNOLOGIA'
            Net user Tecnologia /active:no
            #>


            <# CONFIGURA EXTENSION EN MICROSIP #>
            $oldfile = 'C:\Users\Administrador\Documents\SOPORTE\Script\MicroSIP\microsip.ini'
            $newfile = 'C:\Users\Script\MicroSIP\microsip.ini'

            $almacena = Get-Content -Path $oldfile
            $almacena -replace '7269', $buscaextension | Set-Content -Path $newfile -Force
            Write-Output ''
            Write-Output 'SE REEMPLAZO LA EXTENSION PREDETERMINADA DEL MICROSIP'

            <# REINICIA EL EQUIPO #>
            Write-Output ''
            Write-Output 'SE REINICIARA EL EQUIPO'
            Write-Output ''  

            #Restart-Computer
        }
        2{
            clear
            Write-Output 'OPCIONES DE DOMINIO'
            Write-Output ''
            $opciondominio = Read-Host '1) SUBIR A DOMINIO  2) BAJAR de DOMINIO 3) SALIR'
            Write-Output ''

            switch($opciondominio){
                1{
                    clear
                    Write-Output 'Bienvenid@, estás a punto de subir a dominio el equipo'
                    Write-Output ''
                    Write-Output 'Tu HOSTNAME es' $HostnameActual
                    Write-Output ''
                    Write-Output 'ADVERTENCIA: Recuerda una vez seleccionando la opción 1 se reiniciara el equipo para aplicar los cambios'
                    Write-Output ''
                    Write-Output '¿Deseas cambiar el HOSTNAME?'
                    Write-Output ''
                    $opcionsubirdominio = Read-Host '1) Si  2) No  C) Cancelar'
                    Write-Output ''


                    switch ($opcionsubirdominio){
                        1{
                            clear
                            $HostnameNuevo = Read-Host 'Nombre del equipo'
                            Rename-Computer $HostnameNuevo
                            Add-computer -domainname $Domain -Credential 'soporte' -newname $HostnameNuevo -Restart -Force
                            Restart-Computer
                        }
                        2{
                            Add-computer -domainname $Domain -Credential 'soporte' -Restart -Force

                        }
                        3{
                            Write-Output 'Eres niñita ;) para subir el equipo a DOMINIO'
                        }
                    }
                 }
                2{
                    clear
                    Write-Output 'Bienvenid@, estás a punto de bajar de dominio el equipo'
                    Write-Output ''
                    Write-Output 'NOTA: Recuerda que al seleccionar una opción "1" se reiniciara el equipo'
                    Write-Output ''
                    Write-Output '¿Estás seguro de bajar de dominio el equipo?'
                    Write-Output ''
                    $opcionbajardominio = Read-Host '1) Si  2) No'
                    Write-Output ''

                    switch ($opcionbajardominio){
                        1{
                            Clear
                            $Hostname = (Get-CimInstance -ClassName Win32_ComputerSystem).Name
                            Remove-computer -ComputerName $Hostname -Credential 'itm\soporte' -WorkgroupName 'WORKGROUP' -PassThru -Verbose -Restart -Force
                        }
                        2{
                            Clear
                            Write-Output 'NOS VEMOS PRONTO, NO SE BAJO DE DOMINO EL EQUIPO '
                            Write-Output ''
                        }
                    }
                 }
                3{
                    clear
                    Write-Output 'NOS VEMOS PRONTO, ESTAMOS SALIENDO DE LA OPCION DE DOMINIO'
                    Write-Output ''
                    exit
                 }
            }
        }
        3{
            clear
            Write-Output 'Opciones de RED'
            Write-Output ''
            $opcionred = Read-Host '1) Colocar la IP  2)Modificación completa de red  3) Salir'
            Write-Output ''

            $mascara = '18'
            $gateway = '172.20.0.252'
            $dns1 = '172.20.1.48'
            $dns2 = '172.20.1.77'

            switch ($opcionred){
                1{
                    Clear
                    Write-Output 'Tu IP actual es'
                    Write-Output $ip
                    Write-Output ''
                    Write-Output 'Tu mascara actual es'
                    Write-Output $mascara
                    Write-Output ''
                    Write-Output 'Tu gateway actual es'
                    Write-Output $gateway
                    Write-Output ''
                    Write-Output 'Tus DNS actuales son'
                    Write-Output $dns1
                    Write-Output $dns2
                    Write-Output ''
                    Write-Output '¿Deseas cambiar la ip?'
                    $continuar = Read-Host '1)Si  2) No'
                    Write-Output ''

                    switch($continuar){
                        1{
                            clear
                            Write-Output 'Ingresa una ip'
                            $asignaip = Read-Host 'Ejemplo 172.20.0.254'
                            Write-Output ''
                            $continuar = Read-Host '¿Deseas continuar?  1)Si  2) No'

                            switch($continuar){
                                1{
                                    Remove-NetIPAddress –IPAddress $ip -DefaultGateway $gateway
                                    New-NetIPAddress –InterfaceAlias $adaptador –IPAddress $asignaip –PrefixLength $mascara -DefaultGateway $gateway
                                    Set-DnsClientServerAddress -InterfaceAlias $adaptador -ServerAddresses ($dns1, $dns2)
                                }
                                2{
                                    clear
                                    Write-Output 'Tu ip sigue siendo la misma'
                                    Write-Output $ip
                                    Write-Output ''
                                    Write-Output 'Tu mascara'
                                    Write-Output $mascara
                                    Write-Output ''
                                    Write-Output 'Tu gateway'
                                    Write-Output $gateway
                                    Write-Output ''
                                    Write-Output 'Tus DNS son'
                                    Write-Output $dns1
                                    Write-Output $dns2
                                    Write-Output ''
                                    Write-Output 'No se realizo ningun cambio en la configuracion del adaptador'
                                    
                                    
                                    Remove-NetIPAddress –IPAddress $ip -DefaultGateway $gateway
                                    New-NetIPAddress –InterfaceAlias $adaptador –IPAddress $ip –PrefixLength $mascara -DefaultGateway $gateway
                                    Set-DnsClientServerAddress -InterfaceAlias $adaptador -ServerAddresses ($dns1, $dns2)
                                }
                            }
                        }
                        2{
                            clear
                            Write-Output 'Tu ip sigue siendo la misma'
                            Write-Output $ip
                            Write-Output ''
                            Write-Output 'Tu mascara'
                            Write-Output $mascara
                            Write-Output ''
                            Write-Output 'Tu gateway'
                            Write-Output $gateway
                            Write-Output ''
                            Write-Output 'Tus DNS son'
                            Write-Output $dns1
                            Write-Output $dns2
                            Write-Output ''
                            Write-Output 'No se realizo ningun cambio en la configuracion del adaptador'
                            Write-Output ''
                            Remove-NetIPAddress –IPAddress $ip -DefaultGateway $gateway
                            New-NetIPAddress –InterfaceAlias $adaptador –IPAddress $ip –PrefixLength $mascara -DefaultGateway $gateway
                            Set-DnsClientServerAddress -InterfaceAlias $adaptador -ServerAddresses ($dns1, $dns2)
                        }
                    }
                }
                2{  
                    clear
                    Write-Output 'Se modificara completamente los parametros de la red'
                    Write-Output ''
                    Write-Output 'Ingresa la ip'
                    $asignaip = Read-Host 'Ejemplo 172.20.0.254'
                    Write-Output ''
                    Write-Output 'Ingresa la mascara'
                    $asignamask = Read-Host 'Ejemplo 255.255.192.0'
                    Write-Output ''
                    Write-Output 'Ingresa el gateway'
                    $asignagateway = Read-Host 'Ejemplo 172.20.0.252'
                    Write-Output ''
                    Write-Output 'Ingresa el dns 1'
                    $asignadns1 = Read-Host 'Ejemplo 172.20.1.48'
                    Write-Output ''
                    Write-Output 'Ingresa el dns 2'
                    $asignadns2 = Read-Host 'Ejemplo 172.20.1.77'
                    Write-Output ''
                    $continuar = Read-Host '¿Deseas continuar?  1)Si  2) No'

                    switch($continuar){
                        1{
                            Remove-NetIPAddress –IPAddress $ip -DefaultGateway $gateway
                            New-NetIPAddress –InterfaceAlias $adaptador –IPAddress $asignaip –PrefixLength $asignamask -DefaultGateway $asignagateway
                            Set-DnsClientServerAddress -InterfaceAlias $adaptador -ServerAddresses ($asignadns1, $asignadns2)
                            Write-Output ''


                        }
                        2{
                            clear
                            Write-Output 'Tu ip sigue siendo la misma'
                            Write-Output $ip
                            Write-Output ''
                            Write-Output 'Tu mascara'
                            Write-Output $mascara
                            Write-Output ''
                            Write-Output 'Tu gateway'
                            Write-Output $gateway
                            Write-Output ''
                            Write-Output 'Tus DNS son'
                            Write-Output $dns1
                            Write-Output $dns2
                            Write-Output ''
                            Write-Output 'No se realizo ningun cambio en la configuracion del adaptador'
                        }
                    }
                }
                3{
                    Write-Output 'Salimos de opciones de red'
                }
            }
        }
        4{
            Write-Output ''
            Write-Output 'EMPEZAREMOS A DESINSTALAR LAS APPS DEL CHECK-LIST'
            Write-Output ''
            clear
            $continuar = Read-Host '¿Deseas continuar?  1)Si  2) No'

            switch($continuar){
                1{
                    Get-AppxPackage *3dbuilder* | Remove-AppxPackage
                    Get-AppxPackage *windowsalarms* | Remove-AppxPackage 
                    Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
                    Get-AppxPackage *windowscamera* | Remove-AppxPackage
                    Get-AppxPackage *officehub* | Remove-AppxPackage
                    Get-AppxPackage *skypeapp* | Remove-AppxPackage
                    Get-AppxPackage *getStarted* | Remove-AppxPackage
                    Get-AppxPackage *zunemusic* | Remove-AppxPackage
                    Get-AppxPackage *windowsmaps* | Remove-AppxPackage
                    Get-AppxPackage *solitairecollection* | Remove-AppxPackage
                    Get-AppxPackage *bingfinance* | Remove-AppxPackage
                    Get-AppxPackage *zunevideo* | Remove-AppxPackage
                    Get-AppxPackage *bingnews* | Remove-AppxPackage
                    Get-AppxPackage *OneNote* | Remove-AppxPackage
                    Get-AppxPackage *personas* | Remove-AppxPackage
                    Get-AppxPackage *WindowsPhone* | Remove-AppxPackage
                    Get-AppxPackage *Fotos* | Remove-AppxPackage
                    Get-AppxPackage *windowsstore* | Remove-AppxPackage
                    Get-AppxPackage *bingsports* | Remove-AppxPackage
                    Get-AppxPackage *SoundRecorder* | Remove-AppxPackage
                    Get-AppxPackage *bingweather* | Remove-AppxPackage
                    Get-AppxPackage *xboxapp* | Remove-AppxPackage
                    Get-AppxPackage *Phone* | Remove-AppPackage
                    Get-AppxPackage *yourphone* | Remove-AppPackage
                    Get-AppxPackage *xboxgaming* | Remove-AppPackage
                    Get-AppxPackage *MSPaint* | Remove-AppPackage
                    get-appxpackage *Microsoft.People* | Remove-AppPackage
                    get-appxpackage *Help* | Remove-AppPackage
                    cd *C:\Program Files (x86)\Microsoft\Edge\Application> .\msedge --uninstall --system-level --verbose-logging --force-uninstall*
                    Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage
                    Remove-Item "C:\Program Files (x86)\Microsoft\Edge\Application" -Recurse -Force
                    Remove-Item "C:\Program Files (x86)\Microsoft\Edge" -Recurse -Force
                    Remove-Item "C:\Program Files (x86)\Microsoft\" -Recurse -Force

                    Write-Output ''
                    Write-Output 'SE DESINSTALARON LAS APPS DEL CHECK-LIST'
                }
                2{
                    Write-Output ''
                    Write-Output 'NO SE DESINSTALARON LAS APPS DEL CHECK-LIST'
                }
            }
        }
        5{
            Write-Output ''
            Write-Output 'Salimos de opciones Generales'
        }
    }
