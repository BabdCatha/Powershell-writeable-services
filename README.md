# Powershell-writeable-services
This is a small script to detect modifiable Services on a Windows machine. Based on code from https://github.com/Hackplayers/evil-winrm

# How does it works ?
Basically, It uses a PowerShell command from the Evil-WinRM project to list the services on the machine. Then, for each service, it tries to overwrite its DisplayName to the value it currently has.
This means that, if we are successful, the service has not changed, and we have the permissions to modify the service. If we don't have the rights to modify the service, the command will return an error.
By logging which service returns an error and which service accept the modification, we can know which services we can modify on the machine.
