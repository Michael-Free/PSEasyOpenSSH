---
external help file: PSEasyOpenSSH-help.xml
Module Name: PSEasyOpenSSH
online version: https://github.com/Michael-Free/PSEasyOpenSSH/
schema: 2.0.0
---

# Stop-OpenSSHServer

## SYNOPSIS
Stops the OpenSSH server ('sshd') service.

## SYNTAX

```
Stop-OpenSSHServer [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function checks if the OpenSSH server ('sshd') service is installed.
If it exists 
and is currently running, the function stops the service.

## EXAMPLES

### EXAMPLE 1
```
Stop-OpenSSHServer
```

This command stops the OpenSSH server ('sshd') service if it is running.

## PARAMETERS

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. This function does not accept pipeline input.
## OUTPUTS

### None. This function does not return any output.
## NOTES
Author      : Michael Free
Date        : 2025-03-22
License     : Free Custom License (FCL) v1.0
Copyright   : 2025, Michael Free.
All Rights Reserved.

## RELATED LINKS

[https://github.com/Michael-Free/PSEasyOpenSSH/](https://github.com/Michael-Free/PSEasyOpenSSH/)

