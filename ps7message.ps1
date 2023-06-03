function get-messageInfo {
    param (
        
    )
    begin{
        # Install-Module -Name TMOutput
    }
    process{
        Write-Host " "
        Write-Host "            #################   #################            " -ForegroundColor DarkBlue
        Write-Host "            #################   #################            " -ForegroundColor DarkBlue
        Write-Host "            #################   #################            " -ForegroundColor DarkBlue
        Write-Host "            #################   #################            " -ForegroundColor DarkBlue
        Write-Host "                                                             " -ForegroundColor DarkBlue
        Write-Host "            #################   #################            " -ForegroundColor DarkBlue
        Write-Host "            #################   #################            " -ForegroundColor DarkBlue
        Write-Host "            #################   #################            " -ForegroundColor DarkBlue
        Write-Host "            #################   #################            " -ForegroundColor DarkBlue
        Write-Host " "
        
        #hostname
        Write-host -NoNewline "Hostname: " -ForegroundColor DarkGreen
        Write-Host $env:computername -ForegroundColor DarkBlue

        #Ram info
        $CompObject =  Get-WmiObject -Class WIN32_OperatingSystem
        $RAM = (($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)/1024/1024)
        $ALLRAM = ($CompObject.TotalVisibleMemorySize)/1024/1024
        $RAM = [math]::Round($RAM,2)
        $ALLRAM = [math]::Round($ALLRAM,2)
        Write-host -NoNewline "RAM usage: " -ForegroundColor DarkGreen
        Write-host -NoNewline  $RAM " GB"  -ForegroundColor DarkBlue
        Write-host -NoNewline " from " -ForegroundColor DarkGreen
        Write-Host $ALLRAM  " GB"-ForegroundColor DarkBlue

        #Os info 
       $osver=systeminfo | findstr /B /C:"OS Name" /C:"OS Version" | Out-String
       
        write-host $osver -ForegroundColor DarkCyan

                #Netwok info
        $netAdapterNames = Get-NetAdapter -physical | where status -eq 'up' | select Name
        
         foreach( $nameAapter in $netAdapterNames){
        Get-NetIPAddress -AddressFamily IPV4 | Where InterfaceAlias -eq $nameAapter.Name | Select InterfaceAlias,IPAddress
        
        }

        #Disk info
        $disckinfo = Get-WmiObject -Class win32_logicaldisk | Format-Table DeviceId,VolumeName, @{n="Size";e={[math]::Round($_.Size/1GB,2)}},@{n="FreeSpace";e={[math]::Round($_.FreeSpace/1GB,2)}} 
        $disckinfo 


       
    }
    end{

    }
}
get-messageInfo