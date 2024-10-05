function Install-OpenSSHServer() {
  <#
  .SYNOPSIS
  Install, start, and enable OpenSSH Server on Windows.

  .DESCRIPTION
  This function checks if the OpenSSH server (sshd) service is not installed, installs it, sets its startup type to Automatic, and starts the service if it's running.

  .EXAMPLE
  Install-OpenSSHServer

  .NOTES
  Ensure that the OpenSSH server is NOT installed on your system before running this function.

  #>
  [CmdletBinding(SupportsShouldProcess = $true)]
  param ()
  $openSSHFeature = Get-WindowsCapability -Online | Where-Object { $_.Name -like 'OpenSSH.Server*' }

  if ($openSSHFeature.State -eq 'Installed') {
    throw 'OpenSSH Server already installed...'
  }
  if ($PSCmdlet.ShouldProcess("$openSSHFeature", 'Install it and enable the service to startup automatically')) {
    try {
      Add-WindowsCapability -Online -Name $openSSHFeature.Name
    }
    catch {
      throw 'Unable to install OpenSSH Server'
    }
    Start-OpenSSHServer
    Enable-OpenSSHServer
  }
}

function Start-OpenSSHServer() {
  <#
  .SYNOPSIS
  Starts the OpenSSH Server ('sshd') Service

  .DESCRIPTION
  This function checks if the OpenSSH server (sshd) service is installed and starts the service if it's not running.

  .EXAMPLE
  Start-OpenSSHServer

  .NOTES
  Ensure that the OpenSSH server is installed on your system before running this function.
  #>
  [CmdletBinding(SupportsShouldProcess = $true)]
  param ()
  $serviceName = 'sshd'
  $serviceStatus = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
  if ($PSCmdlet.ShouldProcess("$serviceName", 'Start the service')) {
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
}

function Enable-OpenSSHServer {
  <#
  .SYNOPSIS
  Enables and configures the OpenSSH server service (sshd) to start automatically.

  .DESCRIPTION
  This function checks if the OpenSSH server (sshd) service is installed, sets its startup type to automatic, and starts the service if it's not running.

  .EXAMPLE
  Enable-OpenSSHServer

  .NOTES
  Ensure that the OpenSSH server is installed on your system before running this function.
  #>
  [CmdletBinding(SupportsShouldProcess = $true)]
  param ()

  $serviceName = 'sshd'
  $serviceStatus = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

  if (-not $serviceStatus) {
    throw "$serviceName cannot be found."
  }

  if ($PSCmdlet.ShouldProcess("$serviceName", 'Set service to start automatically and enable OpenSSH server.')) {
    try {
      Set-Service -Name $serviceName -StartupType Automatic
    }
    catch {
      throw "Unable to set $serviceName service to automatic startup"
    }
  }
}

function Stop-OpenSSHServer {
  <#
  .SYNOPSIS
  Stops the OpenSSH Server Service.

  .DESCRIPTION
  This function checks if the OpenSSH server (sshd) service is installed and stops the service if it's running.

  .EXAMPLE
  Stop-OpenSSHServer

  .NOTES
  Ensure that the OpenSSH server is installed on your system before running this function.
  #>
  [CmdletBinding(SupportsShouldProcess = $true)]
  param ()
  $serviceName = 'sshd'
  $serviceStatus = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

  if (-not $serviceStatus) {
    throw "$serviceName cannot be found."
  }

  if ($PSCmdlet.ShouldProcess("$serviceName", 'Stop the service')) {
    try {
      Stop-Service -Name $serviceName -ErrorAction Stop
    }
    catch {
      throw "Unable to stop $serviceName service"
    }
  }
}

function Disable-OpenSSHServer {
  <#
  .SYNOPSIS
  Disables and configures the OpenSSH server service (sshd) to manual startup.

  .DESCRIPTION
  This function checks if the OpenSSH server (sshd) service is installed, sets its startup type to manual, and stops the service if it's running.

  .EXAMPLE
  Disable-OpenSSHServer

  .NOTES
  Ensure that the OpenSSH server is installed on your system before running this function.
  #>
  [CmdletBinding(SupportsShouldProcess = $true)]
  param ()

  $serviceName = 'sshd'
  $serviceStatus = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

  if (-not $serviceStatus) {
    throw "$serviceName cannot be found."
  }

  if ($PSCmdlet.ShouldProcess("$serviceName", 'Set service to manual startup and disable OpenSSH server.')) {
    try {
      Set-Service -Name $serviceName -StartupType Manual
    }
    catch {
      throw "Unable to set $serviceName service to manual startup"
    }
  }
}


function Remove-OpenSSHServer() {
  <#
  .SYNOPSIS
  Removes OpenSSH Server from the Windows System.

  .DESCRIPTION
  This function checks if the OpenSSH server (sshd) service is installed, sets its startup type to manual, and stops the service if it's running. Afterwards, it removes OpenSSH Server from the system.

  .EXAMPLE
  Remove-OpenSSHServer

  .NOTES
  Ensure that the OpenSSH server is installed on your system before running this function.
  #>
  [CmdletBinding(SupportsShouldProcess = $true)]
  param ()

  $openSSHFeature = Get-WindowsCapability -Online | Where-Object { $_.Name -like 'OpenSSH.Server*' }

  if ($openSSHFeature.State -ne 'Installed') {
    throw 'OpenSSH Server not installed...'  
  }

  if ($PSCmdlet.ShouldProcess("$($openSSHFeature.Name)", 'Stop, Disable the service and uninstall')) { 
    try {
      Remove-WindowsCapability -Name $openSSHFeature.Name -Online
    }
    catch {
      throw 'Unable to uninstall OpenSSH Server'
    }
  }
}
