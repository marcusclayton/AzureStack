#https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-connect-azure-stack
cd .\AzureStack\
invoke-webrequest https://github.com/Azure/AzureStack-Tools/archive/master.zip -OutFile master.zip
expand-archive master.zip -DestinationPath . -Force
cd .\AzureStack-Tools-master\
cd .\Connect\
ipmo .\AzureStack.Connect.psm1
$hostIP = "<hostIP>"
$password = ConvertTo-SecureString "passwd_here" -AsPlainText -Force -Verbose
Set-Item wsman:\localhost\Client\TrustedHosts -Value $hostIP -Concatenate
Set-Item wsman:\localhost\Client\TrustedHosts -Value mas-ca01.azurestack.local -Concatenate  
$natIp = Get-AzureStackNatServerAddress -HostComputer $hostIP -Password $Password -Verbose
Add-AzureStackVpnConnection -ServerAddress $natIp -Password $Password -Verbose
Connect-AzureStackVpn -Password $Password