function Invoke_command{

<#
.SYNOPSIS

Lux(Hai vaknin)
*The Invoke-Command cmdlet runs commands on a local or remote computer and returns all output from the commands, including errors. Using a single Invoke-Command command, you can run commands on multiple computers.
*Resolving Host_Name by ips

.PARAMETER File_location
TXT File contain IP-Address seperated by new line.

.PARAMETER Single_ip
invoke with single ip.

.EXAMPLE
PS > Invoke_command -mycommand "powershell calc.exe" -File_location MyFile.txt


.EXAMPLE
PS > Invoke_command -mycommand "powershell calc.exe" Single_ip xx.xx.xx.xx

#>
Param(
    [Parameter(Mandatory)][string]$mycommand,
    [Parameter(ParameterSetName="File_location")][String]$File_location,
    [Parameter(ParameterSetName="Single_ip")][String]$Single_ip)


switch ($PsCmdlet.ParameterSetName){
    "File_location" {
     Get-Content $File_location | ForEach-Object {
     $temp_host=[system.net.dns]::GetHostByAddress($_).HostName
     write-host -ForegroundColor Red this is the host: $temp_host
     $scriptBlock = [Scriptblock]::Create($mycommand)
     write-host -ForegroundColor Red this is the command in scriptblock: $scriptBlock
     Invoke-Command -ComputerName $temp_host -ScriptBlock $scriptBlock
     }

    
    
    
     }

    "Single_ip"{
     $host_name=[System.Net.Dns]::GetHostByAddress($Single_ip).HostName
     write-host -ForegroundColor Red this is the host: $host_name
     $scriptBlock = [Scriptblock]::Create($mycommand)
     write-host -ForegroundColor Red this is the command in scriptblock: $scriptBlock
     Invoke-Command -ComputerName $host_name -ScriptBlock $scriptBlock
    }
    
}
         
}