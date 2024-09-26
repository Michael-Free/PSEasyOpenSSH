function Install-OpenSSHServer() {
  <#
  .SYNOPSIS
  Short description

  .DESCRIPTION
  Long description

  .EXAMPLE
  An example

  .NOTES
  General notes
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
  Short description

  .DESCRIPTION
  Long description

  .EXAMPLE
  An example

  .NOTES
  General notes
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
  [CmdletBinding(SupportsShouldProcess = $true)]
  param ()
  <#
  .SYNOPSIS
  Short description

  .DESCRIPTION
  Long description

  .EXAMPLE
  An example

  .NOTES
  General notes
  #>
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

  if ($PSCmdlet.ShouldProcess("$serviceName", "Set service to manual startup and disable OpenSSH server.")) {
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
  Short description

  .DESCRIPTION
  Long description

  .EXAMPLE
  An example

  .NOTES
  General notes
  #>
  [CmdletBinding(SupportsShouldProcess = $true)]
  param ()

  $openSSHFeature = Get-WindowsCapability -Online | Where-Object { $_.Name -like 'OpenSSH.Server*' }

  if (-not $openSSHFeature.State -eq 'Installed') {
    throw 'OpenSSH Server not installed...'
  }

  if ($PSCmdlet.ShouldProcess("$serviceName", 'Stop, Disable the service and uninstall')) {
    Stop-OpenSSHServer

    Disable-OpenSSHServer
  
    try {
      Remove-WindowsCapability -Name $openSSHFeature.Name
    }
    catch {
      throw 'Unable to uninstall OpenSSH Server'
    }
  }
}

#PSUseShouldProcessForStateChangingF Warning      PSEasyOpen 81    Function 'Remove-OpenSSHServer' has
#unctions                                         SSH.psm1         verb that could change system state.
#                                                                  Therefore, the function has to
#                                                                  support 'ShouldProcess'.
