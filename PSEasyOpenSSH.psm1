function Install-OpenSSHServer() {
  $openSSHFeature = Get-WindowsCapability -Online | Where-Object { $_.Name -like 'OpenSSH.Server*' }

  if ($openSSHFeature.State -eq 'Installed') {
    throw 'OpenSSH Server already installed...'
  }
        
  try {
    Add-WindowsCapability -Online -Name $openSSHFeature.Name
  }
  catch {
    throw 'Unable to install OpenSSH Server'
  }

  Start-OpenSSHServer
  Enable-OpenSSHServer
}

function Start-OpenSSHServer() {
  $serviceName = 'sshd'
  $serviceStatus = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

  if (-not $serviceStatus) {
    throw "$serviceName cannot be found."
  }
  elseif ($serviceStatus.Status -ne 'Running') {
    try {
      Start-Service -Name $serviceName
    }
    catch {
      throw "Unable to start $serviceName service"
    }
  }
}

function Enable-OpenSSHServer() {
  $serviceName = 'sshd'
  $serviceStatus = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

  if (-not $serviceStatus) {
    throw "$serviceName cannot be found."
  }
  try {
    Set-Service -Name $serviceName -StartupType Automatic
  }
  catch {
    throw "Unable to set $serviceName service to automatic startup"
  }
}

function Stop-OpenSSHServer() {
  $serviceName = 'sshd'
  $serviceStatus = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

  if (-not $serviceStatus) {
    throw "$serviceName cannot be found."
  }
  try {
    Stop-Service -Name $serviceName
  }
  catch {
    throw "Unable to stop $serviceName service"
  }
}

function Disable-OpenSSHServer() {
  $serviceName = 'sshd'
  $serviceStatus = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

  if (-not $serviceStatus) {
    throw "$serviceName cannot be found."
  }
  try {
    Set-Service -Name $serviceName -StartupType Manual
  }
  catch {
    throw "Unable to set $serviceName service to manual startup"
  }
}

function Remove-OpenSSHServer() {
  $openSSHFeature = Get-WindowsCapability -Online | Where-Object { $_.Name -like 'OpenSSH.Server*' }

  if (-not $openSSHFeature.State -eq 'Installed') {
    throw 'OpenSSH Server not installed...'
  }

  Stop-OpenSSHServer

  Disable-OpenSSHServer

  try {
    Remove-WindowsCapability -Name $openSSHFeature.Name
  }
  catch {
    throw 'Unable to uninstall OpenSSH Server'
  }
}
#
#PSUseShouldProcessForStateChangingF Warning      PSEasyOpen 19    Function 'Start-OpenSSHServer' has
#unctions                                         SSH.psm1         verb that could change system state.
#                                                                  Therefore, the function has to
#                                                                  support 'ShouldProcess'.
#PSUseShouldProcessForStateChangingF Warning      PSEasyOpen 51    Function 'Stop-OpenSSHServer' has
#unctions                                         SSH.psm1         verb that could change system state.
#                                                                  Therefore, the function has to
#                                                                  support 'ShouldProcess'.
#PSUseShouldProcessForStateChangingF Warning      PSEasyOpen 81    Function 'Remove-OpenSSHServer' has
#unctions                                         SSH.psm1         verb that could change system state.
#                                                                  Therefore, the function has to
#                                                                  support 'ShouldProcess'.