$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsLocation = Get-ToolsLocation
$seleniumDir = "$toolsLocation\selenium"
$driverPath = "$seleniumDir\msedgedriver.exe"

$parameters = Get-PackageParameters

$packageArgs = @{
  packageName   = 'selenium-chromium-edge-driver'
  url           = 'https://msedgedriver.azureedge.net/81.0.363.0/edgedriver_win64.zip'
  checksum      = '2f1850a8bd4492f3a2af648dd8ae8ec6670a76505bfbe850f50ebb16186a32e4785ae5fc4686ebdb0be78fce3aa2f00c1bb6ca7d453a369f1768a8c15b213af3'
  checksumType  = 'sha512'
  unzipLocation = $seleniumDir
}
Install-ChocolateyZipPackage @packageArgs

Uninstall-BinFile -Name 'msedgedriver'
If ($parameters['SkipShim'] -ne 'true') {
  Install-BinFile -Name 'msedgedriver' -Path $driverPath
}

$menuPrograms = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutArgs = @{
  shortcutFilePath = "$menuPrograms\Selenium\Selenium Chromium Edge Driver.lnk"
  targetPath       = $driverPath
  iconLocation     = "$toolsDir\icon.ico"
}
Install-ChocolateyShortcut @shortcutArgs