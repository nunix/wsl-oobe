#Requires -RunAsAdministrator

[cmdletbinding(PositionalBinding = $false)]
param (
    [Parameter(Mandatory = $true)][string]$TarFile,
    [string]$Flavor = "corsairnix",
    [string]$Version = "corsairnix-v0.1",
    [string]$FriendlyName = "Corsairnix version 0.1 based on AzureLinux")

Set-StrictMode -Version latest

# $TarPath = Resolve-Path $TarPath
# $hash = (Get-Filehash $TarPath -Algorithm SHA256).Hash
$wc = [System.Net.WebClient]::new()
$hash = (Get-FileHash -InputStream ($wc.OpenRead($TarFile)) -Algorithm SHA256).Hash

$manifest= @{
    ModernDistributions=@{
        "$Flavor" = @(
            @{
                "Name" = "$Version"
                Default = $true
                FriendlyName = "$FriendlyName"
                Amd64Url = @{
                    Url = "$TarFile"
                    Sha256 = "0x$($hash)"
                }
            })
        }
    }

$manifestFile = "$PSScriptRoot/manifest.json"
$manifest | ConvertTo-Json -Depth 5 | Out-File -encoding ascii $manifestFile

Set-ItemProperty -Path "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss" -Name DistributionListUrlAppend -Value "file://$manifestFile" -Type String -Force