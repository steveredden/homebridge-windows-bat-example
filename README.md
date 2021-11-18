# homebridge-windows-bat-example

## Instructions

1. Launch PowerShell
1. Create this directory: `C:\Users\<your user>\.ps`

   ```powershell
   New-Item -ItemType Directory -Path "$env:USERPROFILE\.ps" | Out-Null
   ```

1. Create a credential file, supplying the prompts:
   1. **URL**:  your homebridge url, including http:// or https:// - ex: `https://tanium.local`
   1. **username**:  the user you use to auth to homebridge
   1. **password**:  the password you use to auth to homebridge

    ```powershell
    @{"rootURL"=(Read-Host -Prompt "URL");"password"=(Read-Host -Prompt "Password" -AsSecureString);"username"=(Read-Host -Prompt "Username" -AsSecureString)} | Export-Clixml "$env:USERPROFILE\.ps\homebridge.cred" -Force
    ```

1. Customize .bat files to your heart's desire!  I personally followed [this process](#My_Proof_of_Concept)

## My Proof of Concept

1. Create a script, like [script.ps1](script.ps1)
1. Add a bunch of semi-colons to indicate line-breaks, and replace as many quotes with single-quotes as possible
1. Save this as [script-formatted.ps1](script-formatted.ps1)
1. Start a .bat with the following

   ```bash
   @echo off
   powershell.exe -noprofile -noninteractive -command "& {  }"
   ```

1. Add your [script-formatted.ps1](script-formatted.ps1) contents in between the brackets
1. Quadruple-quote any quotes you have remaining - ex: [disable-pihole.bat](disable-pihole.bat)