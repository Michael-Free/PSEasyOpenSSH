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

function Remove-OpenSSHServer() {
}

function Disable-OpenSSHServer() {
}

function Stop-OpenSSHServer() {
}
