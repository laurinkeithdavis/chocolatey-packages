$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsLocation = Get-ToolsLocation
$seleniumDir = "$toolsLocation\selenium"
$driverPath = "$seleniumDir\msedgedriver.exe"

$parameters = Get-PackageParameters

$packageArgs = @{
  packageName   = 'selenium-chromium-edge-driver'
  url           = 'https://msedgedriver.azureedge.net/81.0.416.41/edgedriver_win64.zip'
  checksum      = 'B81499F5FCCA0536C36F34C8C80F6B78EED85B1D5212D41CBB2CB407D4A499218859513E6E4412559D5EC8067A3448B8FBF362DBFBABB71726C2CCB066C97239'
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