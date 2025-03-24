# PSEasyOpenSSH
A PowerShell module to make it easier to manage OpenSSH Server on a Windows Host.

## Prerequisites
- Operating System:
    - This is designed to work on both Windows Server and Windows Desktop.
- PowerShell:
    - PowerShell 5.1 or later installed on the host.
- Permissions:
    - Administrative privileges on the host in order to control Windows Services.
- Basic Knowledge:
    - Familiarity with PowerShell.

## Installation
There are two ways to install the `PSEasyOpenSSH` module:

1. **Using PowerShell Gallery**
    - Open PowerShell as an administrator and run the following command to install the module from the PowerShell Gallery:
    ```powershell
    Install-Module -Name PSEasyOpenSSH -Scope CurrentUser
    ```
2. **Manual Installation**
    - Clone this repository using Git or download the ZIP file.
    - Extract the contents of the ZIP file to a directory on your computer.
    - Open PowerShell as an administrator and navigate to the directory where you extracted the module files.
    - Run the following command to install the module:

    ```powershell
    Import-Module -Name .\PSEasyOpenSSH.ps1
    ```
    Note that the manual installation method requires you to have Git installed on your computer, as well as the ability to extract ZIP files. If you do not have these tools installed, you can use the PowerShell Gallery method instead.

## Usage

### Examples
```powershell
Install-OpenSSHServer
```
This command installs the OpenSSH Server on Windows, starts it, and sets it to start automatically.

```powershell
Start-OpenSSHServer
```
This command starts the OpenSSH server ('sshd') service if it is not already running.

```powershell
Enable-OpenSSHServer
```
This command enables the OpenSSH server ('sshd') service and sets it to start automatically.

```powershell
Stop-OpenSSHServer
```
This command stops the OpenSSH server ('sshd') service if it is running.

```powershell
Disable-OpenSSHServer
```
This command sets the OpenSSH server ('sshd') service to manual startup and stops it if it's running.

```powershell
Remove-OpenSSHServer
```
This command removes OpenSSH Server if it is installed.

## License

Free Custom License (FCL) v1.0

Copyright 2025, Michael Free. All Rights Reserved.

## Contributions

### Reporting Bugs

If you encounter any issues while using the tool, please report them in the issue tracker on GitHub. Be sure to include the following information in your bug report:

- The steps to reproduce the issue
- The expected behavior
- The actual behavior
- Any error messages or stack traces associated with the issue

### Requesting Features

If you have an idea for a new feature, please let me know by creating an issue in the issue tracker on GitHub. Be sure to explain why this feature would be useful and how it could benefit the project.

### Contributing Code

If you're a developer interested in contributing code to the project, I encourage you to submit a pull request through GitHub. Before submitting your code, please make sure it adheres to my coding standards and passes any automated tests.

### Providing Feedback

Your feedback is valuable to me. If you have any suggestions or ideas for improving the tool, please share them with me through the issue tracker on GitHub or by reaching out to me on Mastodon: https://mastodon.social/@MichaelFree

### Testing and Quality Assurance

I appreciate any help testing the project and reporting issues. If you have experience in testing, please let me know by creating an issue in the issue tracker on GitHub or by contacting me directly.

Thank you for your interest in contributing to my project! Your contributions will help make it even better.
