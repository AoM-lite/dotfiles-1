﻿#Requires -RunAsAdministrator
[CmdletBinding()]
Param(
    [Parameter()]
    [ValidateSet("Minimal","Basic","Full")]
    $Profile
)

Set-StrictMode -version Latest

# Functions

function StowFile([String]$link, [String]$target) {
	$file = Get-Item $link -ErrorAction SilentlyContinue

	if($file) {
		if ($file.LinkType -ne "SymbolicLink") {
			Write-Error "$($file.FullName) already exists and is not a symbolic link"
		}
		if ($file.Target -ne $target) {
			Write-Error "$($file.FullName) already exists and points to '$($file.Target)', it should point to '$target'"
		} else {
			Write-Verbose "$($file.FullName) already linked"
			return
		}
	}

	Write-Verbose "Creating link $($link)"
	(New-Item -Path $link -ItemType SymbolicLink -Value $target -ErrorAction Continue).Target
}

function Stow([String]$package, [String]$target) {
	if(-not $target) {
		Write-Error "Could not define the target link folder of $package"
	}

	ls $DotFilesPath\$package | % {
		if(-not $_.PSIsContainer) {
			StowFile (Join-Path -Path $target -ChildPath $_.Name) $_.FullName
		}
	}
}

function Install([String]$package) {
	if(-not ((choco list $package --exact --local-only --limitoutput) -like "$package*")) {
		Write-Verbose "Installing package $package"
		choco install $package
	} else {
		Write-Verbose "Package $package already installed"
	}
}

# Arguments

$LevelMinimal = 1
$LevelBasic = 10
$LevelFull = 100
$Level = 0

switch($Profile) {
	"Minimal" { $Level = $LevelMinimal }
	"Basic" { $Level = $LevelBasic }
	"Full" { $Level = $LevelFull }
}

Write-Verbose "Profile: $Profile ($Level)"

# Prepare

# TODO:
# * Chocolatey
# * Setup environment variables

# Bootstrap

$DotFilesPath = Split-Path $MyInvocation.MyCommand.Path
pushd $DotFilesPath
try {

	# PowerShell
	if($Level -ge $LevelMinimal) {
		Stow powershell (Split-Path -Path $global:PROFILE)
	}

	# ConEmu
	if($Level -ge $LevelBasic) {
		Stow conemu $env:APPDATA
		Install conemu
	}

	# Git
	if($Level -ge $LevelMinimal) {
		Stow git $env:HOME
		Install git
	}

	# Vim
	if($Level -ge $LevelMinimal) {
		if(-not [Environment]::GetEnvironmentVariable("VIM","User")) {
			[Environment]::SetEnvironmentVariable("VIM", (Get-Item"$env:HOME\.vim").FullName, "User")
		}

		StowFile "$env:HOME\.vim" (Get-Item "vim\.vim").FullName
		StowFile "$env:HOME\_vimrc" (Get-Item "vim\.vimrc").FullName
		StowFile "$env:HOME\_vsvimrc" (Get-Item "vim\.vsvimrc").FullName
		Install vim
	}

	if($Level -ge $LevelBasic) {
		$vimprocdll ="$env:HOME\.vim\vimfiles\autoload\vimproc_win64.dll"
		if(-not Test-Path $vimprocdll) {
			$vimprocurl = "https://github.com/Shougo/vimproc.vim/releases/download/ver.9.2/vimproc_win64.dll"
			Invoke-WebRequest -Uri $vimprocurl -OutFile $output
		}

		if(-not Test-Path "$env:HOME\.vim\bundle\vimproc.vim") {
			vim -c "PlugInstall vimproc.vim" -c "qa!"
			vim -c "silent VimProcInstall" -c "qa!"
			vim -c "PlugInstall" -c "qa!"
		}
	}
} finally {
	popd
}

# choco install ag hackfont vim poshgit clink far conemu everything curl 7zip fiddler4 git gitextensions GoogleChrome greenshot launchy paint.net putty sharpkeys -y

# TODO:
# * Download vimproc, fullscreen
# * Install sharpkeys CapsLock
# * Setup putty at startup
# * configure launchy with chocolatey
# * configure conemu ConEmu.xml to APPDATA one
# * Configure python for Vim (can we use python 3 now?)
# * Add other software, like Skype
