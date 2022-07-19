function Update-IntuneWin32App {
    <#
    .SYNOPSIS
        Get all or a specific Win32 app by either DisplayName or ID.

    .DESCRIPTION
        Get all or a specific Win32 app by either DisplayName or ID.

    .PARAMETER DisplayName
        Specify the display name for a Win32 application.

    .PARAMETER ID
        Specify the ID for a Win32 application.

    .NOTES
        Author:      Nickolaj Andersen
        Contact:     @NickolajA
        Created:     2020-01-04
        Updated:     2021-08-31

        Version history:
        1.0.0 - (2020-01-04) Function created
        1.0.1 - (2020-01-20) Updated to load all properties for objects return and support multiple objects returned for wildcard search when specifying display name
        1.0.2 - (2021-04-01) Updated token expired message to a warning instead of verbose output
        1.0.3 - (2021-08-31) Updated to use new authentication header
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [parameter(Mandatory = $true,HelpMessage = "Specify the ID for an existing Win32 application.")]
        [ValidateNotNullOrEmpty()]
        [string]$ID ,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New DisplayName for The Win32 application.")]
        [string]$displayName,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New Publisher for The Win32 application.")]
        [string]$publisher,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New isFeatured Flag value for The Win32 application.")]
        [bool]$isFeatured,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New privacyInformationUrl for The Win32 application.")]
        [string]$privacyInformationUrl,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New informationUrl for The Win32 application.")]
        [string]$informationUrl,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New owner for The Win32 application.")]
        [string]$owner,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New developer for The Win32 application.")]
        [string]$developer,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New notes for The Win32 application.")]
        [string]$notes,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New InstallCommandLine for The Win32 application.")]
        [string]$InstallCommandLine,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New uninstallCommandLine for The Win32 application.")]
        [string]$uninstallCommandLine,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New RequirementsRules for The Win32 application.")]
        [hashtable[]]$RequirementRules,
        [parameter(Mandatory = $false,HelpMessage = "Specify the New DetectionRules for The Win32 application.")]
        [hashtable[]]$DetectionRules
    )
    Begin {
        # Ensure required authentication header variable exists
        if ($Global:AuthenticationHeader -eq $null) {
            Write-Warning -Message "Authentication token was not found, use Connect-MSIntuneGraph before using this function"; break
        }
        else {
            $TokenLifeTime = ($Global:AuthenticationHeader.ExpiresOn - (Get-Date).ToUniversalTime()).Minutes
            if ($TokenLifeTime -le 0) {
                Write-Warning -Message "Existing token found but has expired, use Connect-MSIntuneGraph to request a new authentication token"; break
            }
            else {
                Write-Verbose -Message "Current authentication token expires in (minutes): $($TokenLifeTime)"
            }
        }

        # Set script variable for error action preference
        $ErrorActionPreference = "Stop"
    }
    Process { 
        $body = [hashtable]$PSBoundParameters
        $body."@odata.type" = '#microsoft.graph.win32LobApp'

        
        
            Write-Verbose -Message "Updating Applcation: $($ID)"
            $Win32AppResults = Invoke-IntuneGraphRequest -APIVersion "Beta" -Resource "mobileApps/$($ID)" -Method PATCH -Body $(ConvertTo-json $body)
            $Win32App = Invoke-IntuneGraphRequest -APIVersion "Beta" -Resource "mobileApps/$($ID)" -Method "GET"
            return $Win32App
        
    }
}