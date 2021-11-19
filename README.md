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

1. Customize .bat files to your heart's desire!  I personally followed [this process](#my-proof-of-concept)

## My Proof of Concept

1. Create a script, like [script.ps1](script.ps1)
1. In the same directory, create a .bat with the following:

   ```bash
   @echo off
   powershell.exe -noprofile -noninteractive ./script.ps1
   ```

### My Use Case

This uuid links to switch to disable my pi-hole instance for 5 minutes.

https://github.com/arendruni/homebridge-pihole

If I want to click a link that gets blocked, rather than logging into my Homebridge instance, I can use this .bat file.

## Your Inputs

Likely, you can re-use [script.ps1](script.ps1) as a base for any .bat you want.  You *only* need to change your accessory uuid (`line 25`), and the contents of the body (`lines 27:28`) to PUT.

## One-Liner

If you really want to, you can break it down to a single .bat file:

1. Add a bunch of semi-colons to your original [script.ps1](script.ps1) to indicate line-breaks, and replace as many quotes with single-quotes as possible
1. Save this as [script-formatted.ps1](script-formatted.ps1).  Make sure it still works!
1. Create a .bat with the following:

   ```bash
   @echo off
   powershell.exe -noprofile -noninteractive -command "& {  }"
   ```

1. Add the contents of the formatted script between the brackets
1. Quadruple-quote any quotes you have remaining - ex: [disable-pihole.bat](disable-pihole.bat)

## Issues You May Encounter

1. http vs https homebridge / SSL issues
1. no auth at all to web UI
1. finding your `uuid`
1. finding an appropriate `charactersticType` / `value`

[Just explore the swagger documentation!](https://github.com/oznu/homebridge-config-ui-x/wiki/API-Reference) If you're already here, you likely can figure it out :wink:
