# homebridge-windows-bat-example

A very rough Proof of Concept based on a question from Reddit: [Controlling HomeKit from Windows](https://www.reddit.com/r/homebridge/comments/quv3fy/controlling_homekit_from_windows/hkt8ooh/?context=3)

Safely stores credentials and homebridge URL using [Import-Clixml/Export-Clixml](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-clixml?view=powershell-7.2#example-3--encrypt-an-exported-credential-object-on-windows), for easy re-use.

No immediate intent to 'prettify' the content, just leaving it here for your future reference :smile:

## Cached Credential Setup

1. Launch PowerShell
1. Create this directory: `C:\Users\<your user>\.ps`

   ```powershell
   if ( -Not (Test-Path "$env:USERPROFILE\.ps" ) { New-Item -ItemType Directory -Path "$env:USERPROFILE\.ps" }
   ```

1. Create a credential file, supplying the prompts:
   1. **URL**:  your homebridge url, including http:// or https:// - ex: `https://homebridge.local`
   1. **username**:  the user you use to auth to homebridge
   1. **password**:  the password you use to auth to homebridge

    ```powershell
    @{"rootURL"=(Read-Host -Prompt "URL");"password"=(Read-Host -Prompt "Password" -AsSecureString);"username"=(Read-Host -Prompt "Username" -AsSecureString)} | Export-Clixml "$env:USERPROFILE\.ps\homebridge.cred" -Force
    ```

## My Proof of Concept / Instructions

1. Create a script that changes the state of your homebridge accessory, like [script.ps1](script.ps1)
1. In the same directory, create a .bat with the following - ex: [disable-pihole.bat](disable-pihole.bat)

   ```bash
   @echo off
   powershell.exe -noprofile -noninteractive ./script.ps1
   ```

1. Double-click your .bat to watch your accessories change!

### My Use Case

The uuid in [script.ps1](script.ps1) links to a switch to disable my pi-hole instance for 5 minutes.

FYI: [Pi-Hole Plugin](https://github.com/arendruni/homebridge-pihole)

If, in my day-to-day, I click a link that gets blocked by pi-hole, and I *really* want to get to that link, rather than logging into my Homebridge instance I *could* use this .bat file.  Will I? :man_shrugging:

## Your Inputs

Likely, you can re-use [script.ps1](script.ps1) as a base for any .bat you want.  You *only* need to change your accessory uuid (`line 25`), and the contents of the body (`lines 27:28`).

## One-Liner-Style

If you really want to, you can break it down to a single .bat file:

1. Add a bunch of semi-colons to your original [script.ps1](script.ps1) to indicate line-breaks, and replace as many quotes with single-quotes as possible
1. Save this as something named like [script-formatted.ps1](script-formatted.ps1).  Make sure it still works!
1. Create a .bat with the following:

   ```bash
   @echo off
   powershell.exe -noprofile -noninteractive -command "& {  }"
   ```

1. Add the contents of the formatted script between the brackets
1. Quadruple-quote any quotes you have remaining - ex: [disable-pihole-oneliner.bat](disable-pihole-oneliner.bat)

## Other Issues You May Encounter

1. http vs https homebridge / SSL issues
1. no auth at all to web UI
1. finding your `uuid`
1. finding an appropriate `charactersticType` / `value`

[Just explore the swagger documentation!](https://github.com/oznu/homebridge-config-ui-x/wiki/API-Reference) If you're already here, you likely can figure it out :wink:

## :clap: Credits :clap:

[oznu](https://github.com/oznu/homebridge-config-ui-x) \
[arendruni](https://github.com/arendruni/homebridge-pihole) \
[107+ contributors](https://github.com/homebridge/homebridge/graphs/contributors) \
etc
