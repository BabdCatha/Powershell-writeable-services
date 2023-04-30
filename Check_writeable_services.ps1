function Get-Writeable-Services {
    $servicios = Get-ItemProperty "registry::HKLM\System\CurrentControlSet\Services\*" | Where-Object {$_.imagepath -notmatch "system" -and $_.imagepath -ne $null } | Select-Object pschildname;
    $result = foreach ($servicio in $servicios) {
    	sc.exe config $servicio.pschildname DisplayName= $servicio.pschildname | Out-Null;
    	if ($? -eq $true) {$writeable = $true} else {$writeable = $false};
    	Get-Service $servicio.PSChildName -ErrorAction SilentlyContinue | Out-Null
    	if ($? -eq $true) {$privs = $true} else {$privs = $false};
    	$Servicios_object = New-Object psobject -Property $([ordered]@{"Writeable" = $writeable ; "Prilileges" = $privs ; "Service" = $servicio.pschildname});
    	$Servicios_object
    }
    $result | Format-Table -AutoSize
}
