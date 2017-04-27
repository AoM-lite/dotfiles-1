﻿function prompt {
	$realLASTEXITCODE = $LASTEXITCODE
	$host.UI.RawUI.WindowTitle = Microsoft.PowerShell.Management\Split-Path $pwd.ProviderPath -Leaf
	Microsoft.PowerShell.Utility\Write-Host
	Microsoft.PowerShell.Utility\Write-Host $env:COMPUTERNAME -NoNewLine -ForegroundColor "White"
	Microsoft.PowerShell.Utility\Write-Host ":" -NoNewLine -ForegroundColor "DarkGray"
	Microsoft.PowerShell.Utility\Write-Host $pwd.ProviderPath -NoNewLine -ForegroundColor "Green"
	Write-VcsStatus -ErrorAction SilentlyContinue
	Microsoft.PowerShell.Utility\Write-Host "`nλ " -NoNewLine -ForegroundColor "DarkGray"
	$Host.UI.RawUI.ForegroundColor = "White"
	$global:LASTEXITCODE = $realLASTEXITCODE
	return " "
}
