function Install-OpenSSHServer() {
  <#
  .SYNOPSIS
    Installs, starts, and enables the OpenSSH Server on Windows.

  .DESCRIPTION
    This function checks if the OpenSSH Server (sshd) service is installed. If it is not installed, the function
    installs the OpenSSH Server, sets its startup type to Automatic, and starts the service.

  .PARAMETER None
    This function does not take any parameters.

  .INPUTS
    None. This function does not accept pipeline input.

  .OUTPUTS
    None. This function does not return any output.

  .EXAMPLE
    Install-OpenSSHServer

    This command installs the OpenSSH Server on Windows, starts it, and sets it to start automatically.

  .EXAMPLE
    Install-OpenSSHServer -WhatIf

    This command simulates the installation of OpenSSH Server and shows what would happen without making changes.

  .EXAMPLE
    Install-OpenSSHServer -Confirm:$false

    This command installs OpenSSH Server without prompting for confirmation.

  .NOTES
    Author      : Michael Free
    Date        : 2025-03-22
    License     : Free Custom License (FCL) v1.0
    Copyright   : 2025, Michael Free. All Rights Reserved.

  .LINK
    https://github.com/Michael-Free/PSEasyOpenSSH/
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
    Starts the OpenSSH Server ('sshd') service.

  .DESCRIPTION
    This function checks if the OpenSSH server ('sshd') service is installed. If the service exists but is not running, 
    the function starts it.

  .PARAMETER None
    This function does not take any parameters.

  .INPUTS
    None. This function does not accept pipeline input.

  .OUTPUTS
    None. This function does not return any output.

  .EXAMPLE
    Start-OpenSSHServer

    This command starts the OpenSSH server ('sshd') service if it is not already running.

  .EXAMPLE
    Start-OpenSSHServer -WhatIf

    This command simulates the action and shows what would happen without making changes.

  .EXAMPLE
    Start-OpenSSHServer -Confirm:$false

    This command starts the OpenSSH server without prompting for confirmation.

  .NOTES
    Author      : Michael Free
    Date        : 2025-03-22
    License     : Free Custom License (FCL) v1.0
    Copyright   : 2025, Michael Free. All Rights Reserved.

  .LINK
    https://github.com/Michael-Free/PSEasyOpenSSH/
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
    This function checks if the OpenSSH server ('sshd') service is installed. If it exists, 
    the function sets its startup type to 'Automatic' to ensure it starts on boot.

  .PARAMETER None
    This function does not take any parameters.

  .INPUTS
    None. This function does not accept pipeline input.

  .OUTPUTS
    None. This function does not return any output.

  .EXAMPLE
    Enable-OpenSSHServer

    This command enables the OpenSSH server ('sshd') service and sets it to start automatically.

  .EXAMPLE
    Enable-OpenSSHServer -WhatIf

    This command simulates the action and shows what would happen without making changes.

  .EXAMPLE
    Enable-OpenSSHServer -Confirm:$false

    This command enables the OpenSSH server without prompting for confirmation.

  .NOTES
    Author      : Michael Free
    Date        : 2025-03-22
    License     : Free Custom License (FCL) v1.0
    Copyright   : 2025, Michael Free. All Rights Reserved.

  .LINK
    https://github.com/Michael-Free/PSEasyOpenSSH/
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
    Stops the OpenSSH server ('sshd') service.

  .DESCRIPTION
    This function checks if the OpenSSH server ('sshd') service is installed. If it exists 
    and is currently running, the function stops the service.

  .PARAMETER None
    This function does not accept any parameters.

  .INPUTS
    None. This function does not accept pipeline input.

  .OUTPUTS
    None. This function does not return any output.

  .EXAMPLE
    Stop-OpenSSHServer

    This command stops the OpenSSH server ('sshd') service if it is running.

  .EXAMPLE
    Stop-OpenSSHServer -WhatIf

    This command simulates stopping the OpenSSH service without actually performing the action.

  .EXAMPLE
    Stop-OpenSSHServer -Confirm:$false

    This command stops the OpenSSH service without prompting for confirmation.

  .NOTES
    Author      : Michael Free
    Date        : 2025-03-22
    License     : Free Custom License (FCL) v1.0
    Copyright   : 2025, Michael Free. All Rights Reserved.

  .LINK
    https://github.com/Michael-Free/PSEasyOpenSSH/
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
    Disables and configures the OpenSSH server ('sshd') service to manual startup.

  .DESCRIPTION
    This function checks if the OpenSSH server ('sshd') service is installed. If the service exists, 
    it sets the startup type to 'Manual' and stops the service if it is currently running.

  .PARAMETER None
    This function does not accept any parameters.

  .INPUTS
    None. This function does not accept pipeline input.

  .OUTPUTS
    None. This function does not return any output.

  .EXAMPLE
    Disable-OpenSSHServer

    This command sets the OpenSSH server ('sshd') service to manual startup and stops it if it's running.

  .EXAMPLE
    Disable-OpenSSHServer -WhatIf

    This command simulates disabling the OpenSSH server service without making any changes.

  .EXAMPLE
    Disable-OpenSSHServer -Confirm:$false

    This command disables the OpenSSH server service without prompting for confirmation.

  .NOTES
    Author      : Michael Free
    Date        : 2025-03-22
    License     : Free Custom License (FCL) v1.0
    Copyright   : 2025, Michael Free. All Rights Reserved.

  .LINK
    https://github.com/Michael-Free/PSEasyOpenSSH/
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
    Removes OpenSSH Server from the Windows system.

  .DESCRIPTION
    This function checks if the OpenSSH Server feature is installed. If it is, it removes OpenSSH Server from the system.

  .EXAMPLE
    Remove-OpenSSHServer

    This command removes OpenSSH Server if it is installed.

  .EXAMPLE
    Remove-OpenSSHServer -WhatIf

    This command simulates the removal process without actually uninstalling OpenSSH Server.

  .EXAMPLE
    Remove-OpenSSHServer -Confirm:$false

    This command removes OpenSSH Server without prompting for confirmation.

  .NOTES
    Author      : Michael Free
    Date        : 2025-03-22
    License     : Free Custom License (FCL) v1.0
    Copyright   : 2025, Michael Free. All Rights Reserved.

  .LINK
    https://github.com/Michael-Free/PSEasyOpenSSH/
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
