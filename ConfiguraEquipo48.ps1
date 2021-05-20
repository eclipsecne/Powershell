# Habilita la opcion de ejecutar scripts
Set-ExecutionPolicy RemoteSigned -Force

clear
Write-Output 'Bienvenid@, Empezaremos a configurar el equipo'
Write-Output ''
Write-Output 'NOTA: '
Write-Output ''

    $Domain = 'itm.qro.mx'
    $HostnameActual = $env:COMPUTERNAME

    clear
    Write-Output 'OPCIONES GENERALES'
    Write-Output ''
    $opcion = Read-Host '1) INSTALA TODO  2)DOMINIO  3) RED  4)DESINTALA CHECK-LIST 5)USB 6)CORTANA 0) SALIR'
    Write-Output ''

    switch($opcion){
        1{
            clear
            Write-Output 'Bienvenid@, estás a punto de configurar el equipo'
            Write-Output ''                      
            Write-Output $HostnameActual' <- Tu nuevo hostname debe ser diferente a este'
            Write-Output ''                      
            $HostnameNuevo = Read-Host 'Nombre del equipo'
            Rename-Computer $HostnameNuevo
            Write-Host ''
            Write-Host 'Se renombro el nombre del equipo'
            Write-Host ''
            Add-computer -domainname $Domain -Credential 'soporte' -newname $HostnameNuevo -Restart -Force
            Write-Host ''
            Write-Host 'Se subio a dominio el equipo'            
            Write-Output ''                      
            Write-Output 'Se modificara completamente los parametros de la red'
            Write-Output ''
            Write-Output 'Ingresa la ip'
            $asignaip = Read-Host 'Ejemplo 172.20.20.1'
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

            clear
            Write-Host ''
            Remove-NetIPAddress –IPAddress $ip -DefaultGateway $gateway
            Write-Host 'Se eliminaron los parametros anteriores de la red'
            New-NetIPAddress –InterfaceAlias $adaptador –IPAddress $asignaip –PrefixLength $asignamask -DefaultGateway $asignagateway
            Set-DnsClientServerAddress -InterfaceAlias $adaptador -ServerAddresses ($asignadns1, $asignadns2)
            Write-Output ''
            Write-Host 'Se agregaron los parametros nuevos de la red'
            Write-Host ''
            Get-NetIPConfiguration

            mkdir C:\Users\Script
            
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

            echo 'start /min powershell -WindowStyle Hidden -Command C:\Users\Script\desinstala.ps1' >> C:\Users\Script\ejecuta.bat

            Write-Host ''
            Write-Host 'SE HABILITO EL USUARIO ADMINISTRADOR'
            Net user Administrador /active:yes
            Write-Host ''
            Write-Host 'Escriba su contraseña de inicio de sesion del ADMINISTRADOR'
            Net user Administrador *

            clear
            Write-Host ''
            Write-Host 'SE DESHABILITO EL USUARIO DE TECNOLOGIA'
            Net user Tecnologia /active:no

            clear
            Write-Host ''
            Write-Host 'SE REINICIARA EL EQUIPO'
            Write-Host ''
            Write-Host ''
            Write-Host ''
            Restart-Computer
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

            $ip = (Get-NetIPAddress -PrefixOrigin Manual).IPAddress
            $adaptador = (Get-NetAdapter).Name
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
            Clear
            Write-Output 'OPCION DE PUERTOS USB A CONFIGURAR'
            Write-Output ''
            $continuar = Read-Host '1)Bloquear puertos USB  2)No bloquear puertos USB'

            
            switch($continuar){
                1{
                    reg add HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR /v START /t REG_DWORD /f /d 4
                    Write-Output 'Están bloqueados las USB en el equipo'
                    gpupdate /force
                    gpupdate /force
                    gpupdate /force
                }
                2{
                    reg add HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR /v START /t REG_DWORD /f /d 3
                    Write-Output 'Están permitidas las USB en el equipo'
                    gpupdate /force
                    gpupdate /force
                    gpupdate /force
                }
            }
        }
        6{
            Clear
            Write-Output 'OPCION DE CORTANA A CONFIGURAR'
            Write-Output ''
            $continuar = Read-Host '1)Bloquear CORTANA 2)No bloquear CORTANA'

            
            switch($continuar){
                1{
                    reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v ALLOWCORTANA /t REG_DWORD /f /d 1
                    Write-Output 'Está bloqueado cortana en el equipo'
                    gpupdate /force
                    gpupdate /force
                    gpupdate /force
                }
                2{
                    reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v ALLOWCORTANA /t REG_DWORD /f /d 0
                    Write-Output 'Está permitido cortana en el equipo'
                    gpupdate /force
                    gpupdate /force
                    gpupdate /force
                }
            }
        }
        0{
            Write-Output ''
            Write-Output 'Salimos de opciones Generales'
        }
    }
