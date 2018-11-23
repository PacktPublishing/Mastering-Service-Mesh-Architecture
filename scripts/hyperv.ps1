<#
:: Vikram Khatri
::
::
:: Enable / Disbale Hyper-V in Windows using PowerShell for Docker Windows Desktop
:: If VMware is used, Hyper-V virtualization needs to be disabled
:: Docker for Desktop requires Hyper-V
:: Reboot will be required to turn on/off Hyper-V
::
#>
param([string]$hyperv)
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) 
{ 
   Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -hyperv $hyperv" -Verb RunAs
   exit 
}
$curDir = $myinvocation.MyCommand.Definition | split-path -parent
$LOGFILE=$curDir+"\hyperv.log"
function Logger {
    Param(
        $Message,
        $Path = $LOGFILE
    )
    function TS {Get-Date -Format 'MM/dd/yy hh:mm:ss'}
    add-content -Path $LOGFILE -Value "[$(TS)] $Message"
    Write-Host $Message
}
Logger  "Launching PowerShell in an elevated shell with hyperv=$hyperv"

if ($hyperv -eq 'on')
{
  Logger "Enabling Hyper-V"
  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V –All
} else
{
  Logger "Disabling Hyper-V"
  Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V
}
Logger  "Done..."
