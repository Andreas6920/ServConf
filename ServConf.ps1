# Prepare
    $path_install = "C:\Program Files\WindowsPowerShell\Modules\ServConf"
        New-Item -ItemType Directory $path_install -ErrorAction SilentlyContinue | Out-Null
    
    $modules = "ServConf_HostConfigurator","ServConf_RoleConfigurator","ServConf_ADConfigurator","ServConf_ShareConfigurator"
        $modules | % {iwr -useb "https://raw.githubusercontent.com/Andreas6920/ServConf/main/res/modules/$_.psm1" -OutFile $path_install\$_.psm1}

    $reg_install = "HKLM:\Software\ServConf"
        If (!(Test-Path $reg_install)) {New-Item -Path $reg_install -Force | Out-Null; $modules | % {Set-ItemProperty -Path $reg_install -Name $_ -Type DWord -Value 0 | Out-Null}}


# Menu

    $logo = 
"

███████╗███████╗██████╗ ██╗   ██╗ ██████╗ ██████╗ ███╗   ██╗███████╗
██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔═══██╗████╗  ██║██╔════╝
███████╗█████╗  ██████╔╝██║   ██║██║     ██║   ██║██╔██╗ ██║█████╗  
╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║     ██║   ██║██║╚██╗██║██╔══╝  
███████║███████╗██║  ██║ ╚████╔╝ ╚██████╗╚██████╔╝██║ ╚████║██║     
╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     

Version 0.1
Creator: Andreas6920 | https://github.com/Andreas6920/
"                                                                   

        # Change color if module already executed
        if ((Get-ItemProperty -Path "HKLM:\Software\ServConf" -Name "ServConf_HostConfigurator").ServConf_HostConfigurator -eq 0){$menu1 = "Green"} else {$menu1 = "DarkGray"}
        if ((Get-ItemProperty -Path "HKLM:\Software\ServConf" -Name "ServConf_RoleConfigurator").ServConf_RoleConfigurator -eq 0){$menu2 = "Green"} else {$menu2 = "DarkGray"}
        if ((Get-ItemProperty -Path "HKLM:\Software\ServConf" -Name "ServConf_ADConfigurator").ServConf_ADConfigurator -eq 0){$menu3 = "Green"} else {$menu3 = "DarkGray"}
        if ((Get-ItemProperty -Path "HKLM:\Software\ServConf" -Name "ServConf_ShareConfigurator").ServConf_ShareConfigurator -eq 0){$menu4 = "Green"} else {$menu4 = "DarkGray"}
 
        # Option list
        Clear-Host
        "";
        Write-host $logo -f Green
        "";
        Write-host "`t`t1) Host Configurator`t`t( Hostname / IP )" -f $menu1
        Write-host "`t`t2) Baserole Configurator`t( Server Role / Domain Name )" -f $menu2
        Write-host "`t`t3) AD Configurator`t`t`t( OU creation / User Creation / CSV import )" -f $menu3
        Write-host "`t`t4) Share Configurator`t`t( Security Group Creator / NTFS / SMB )" -f $menu4
        Write-host "`t`t0) Exit" -f Green
        "";"";

        # User input
        do {
            Write-Host "Choose your option:`t" -f Green -nonewline; ; ;
            $selection = Read-Host
            Switch ($selection) {

                1 {    Import-Module "C:\Program Files\WindowsPowerShell\Modules\ServConf\ServConf_HostConfigurator"    }
                2 {    Import-Module "C:\Program Files\WindowsPowerShell\Modules\ServConf\ServConf_RoleConfigurator"    }
                3 {    Import-Module "C:\Program Files\WindowsPowerShell\Modules\ServConf\ServConf_ADConfigurator"      }
                4 {    Import-Module "C:\Program Files\WindowsPowerShell\Modules\ServConf\ServConf_ShareConfigurator"   }
                0 {                                         EXIT                                                        }
           
            }}
        while ($selection -ne 0 )