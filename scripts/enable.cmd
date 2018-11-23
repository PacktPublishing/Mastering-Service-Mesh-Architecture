:: Vikram Khatri
::
:: Double Click the script from Windows Explorer to Turn off Hyper-V
::
START /WAIT CMD /C powershell -executionPolicy Bypass -file .\hyperv.ps1 -hyperv "off"
