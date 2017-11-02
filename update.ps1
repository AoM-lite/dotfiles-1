﻿#Requires -RunAsAdministrator

Set-StrictMode -version Latest

$DotFilesPath = Split-Path $MyInvocation.MyCommand.Path
pushd $DotFilesPath
try {
	# Dotfiles
	git pull --ff-only

	# Chocolatey
	cup all -y

	# Vim Plugins
	gvim -c "PlugUpdate" -c "qa!"

	# Windows Update
	if( Get-Command -Module PSWindowsUpdate ) {
		Get-WUInstall –MicrosoftUpdate –AcceptAll # –AutoReboot
	}
} finally {
	popd
}