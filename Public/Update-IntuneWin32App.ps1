function update-IntuneWin32App {
    <#
    .SYNOPSIS
        Update a Win32 application in Microsoft Intune.

    .DESCRIPTION
        Update a Win32 application in Microsoft Intune.

    .PARAMETER DisplayName
        Specify a display name for the Win32 application.
    
    .PARAMETER Description
        Specify a description for the Win32 application.
    
    .PARAMETER Publisher
        Specify a publisher name for the Win32 application.

    .PARAMETER AppVersion
        Specify the app version for the Win32 application.
    
    .PARAMETER Developer
        Specify the developer name for the Win32 application.

    .PARAMETER Owner
        Specify the owner property for the Win32 application.

    .PARAMETER Notes
        Specify the notes property for the Win32 application.

    .PARAMETER InformationURL
        Specify the information URL for the Win32 application.
    
    .PARAMETER PrivacyURL
        Specify the privacy URL for the Win32 application.
    
    .PARAMETER CompanyPortalFeaturedApp
        Specify whether to have the Win32 application featured in Company Portal or not.

    .PARAMETER InstallCommandLine
        Specify the install command line for the Win32 application.
    
    .PARAMETER UninstallCommandLine
        Specify the uninstall command line for the Win32 application.

    .PARAMETER InstallExperience
        Specify the install experience for the Win32 application. Supported values are: system or user.
    
    .PARAMETER RestartBehavior
        Specify the restart behavior for the Win32 application. Supported values are: allow, basedOnReturnCode, suppress or force.
    
    .PARAMETER DetectionRule
        Provide an array of a single or multiple OrderedDictionary objects as detection rules that will be used for the Win32 application.

    .PARAMETER RequirementRule
        Provide an OrderedDictionary object as requirement rule that will be used for the Win32 application.

    .PARAMETER AdditionalRequirementRule
        Provide an array of OrderedDictionary objects as additional requirement rule, e.g. for file, registry or script rules, that will be used for the Win32 application.

    .PARAMETER ReturnCode
        Provide an array of a single or multiple hash-tables for the Win32 application with return code information.

    .PARAMETER Icon
        Provide a Base64 encoded string of the PNG/JPG/JPEG file.

    .NOTES
        Author:      Nickolaj Andersen
        Contact:     @NickolajA
        Created:     2020-01-04
        Updated:     2022-10-02

        Version history:
        1.0.0 - (2020-10-07) Function created
    #>
    [CmdletBinding(SupportsShouldProcess = $true,DefaultParameterSetName = 'Default')] 
    param(
        [parameter(Mandatory = $true, ParameterSetName="Default", HelpMessage = "Please specific ID of application to update")]
        [parameter(Mandatory = $true, ParameterSetName="AdditionalRequirementRules", HelpMessage = "Please specific ID of application to update")]
        [parameter(Mandatory = $true, ParameterSetName="RestartBehavior", HelpMessage = "Please specific ID of application to update")]
        [parameter(Mandatory = $true, ParameterSetName="ALL", HelpMessage = "Please specific ID of application to update")]
        [ValidateNotNullOrEmpty()]
        [string]$Id,
        [parameter(Mandatory = $false,ParameterSetName="Default", HelpMessage = "Specify a display name for the Win32 application.")]
        [parameter(Mandatory = $false,ParameterSetName="AdditionalRequirementRules", HelpMessage = "Specify a display name for the Win32 application.")]
        [parameter(Mandatory = $false,ParameterSetName="RestartBehavior", HelpMessage = "Specify a display name for the Win32 application.")]
        [parameter(Mandatory = $false,ParameterSetName="ALL", HelpMessage = "Specify a display name for the Win32 application.")]
        [ValidateNotNullOrEmpty()]
        [string]$DisplayName,

        [parameter(Mandatory = $false, ParameterSetName="Default", HelpMessage = "Specify a description for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName="AdditionalRequirementRules", HelpMessage = "Specify a description for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName="RestartBehavior", HelpMessage = "Specify a description for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName="ALL", HelpMessage = "Specify a description for the Win32 application.")]
        [ValidateNotNullOrEmpty()]
        [string]$Description,

        [parameter(Mandatory = $false, ParameterSetName="Default", HelpMessage = "Specify a publisher name for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName="AdditionalRequirementRules", HelpMessage = "Specify a publisher name for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName="RestartBehavior", HelpMessage = "Specify a publisher name for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName="ALL", HelpMessage = "Specify a publisher name for the Win32 application.")]
        [ValidateNotNullOrEmpty()]
        [string]$Publisher,

        [parameter(Mandatory = $false, ParameterSetName="Default", HelpMessage = "Specify the app version for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName="AdditionalRequirementRules", HelpMessage = "Specify the app version for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName="RestartBehavior", HelpMessage = "Specify the app version for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName="ALL", HelpMessage = "Specify the app version for the Win32 application.")]
        
        [string]$AppVersion = [string]::Empty,

        
        [parameter(Mandatory = $false, ParameterSetName = "Default", HelpMessage = "Specify the developer name for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Specify the developer name for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "RestartBehavior", HelpMessage = "Specify the developer name for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "ALL", HelpMessage = "Specify the developer name for the Win32 application.")]
        [string]$Developer = [string]::Empty,

        [parameter(Mandatory = $false, ParameterSetName = "Default", HelpMessage = "Specify the owner property for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Specify the owner property for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "RestartBehavior", HelpMessage = "Specify the owner property for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "ALL", HelpMessage = "Specify the owner property for the Win32 application.")]
        [string]$Owner = [string]::Empty,

        [parameter(Mandatory = $false, ParameterSetName = "Default", HelpMessage = "Specify the notes property for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Specify the notes property for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "RestartBehavior", HelpMessage = "Specify the notes property for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "ALL", HelpMessage = "Specify the notes property for the Win32 application.")]
        
        [string]$Notes = [string]::Empty,

        
        [parameter(Mandatory = $false,  ParameterSetName = "Default", HelpMessage = "Specify the information URL for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Specify the information URL for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "RestartBehavior", HelpMessage = "Specify the information URL for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "ALL", HelpMessage = "Specify the information URL for the Win32 application.")]
        [ValidatePattern("(http[s]?|[s]?ftp[s]?)(:\/\/)([^\s,]+)|^$")]
        [string]$InformationURL = [string]::Empty,

        
        [parameter(Mandatory = $false,  ParameterSetName = "Default", HelpMessage = "Specify the privacy URL for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Specify the privacy URL for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "RestartBehavior", HelpMessage = "Specify the privacy URL for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "ALL", HelpMessage = "Specify the privacy URL for the Win32 application.")]
        [ValidatePattern("(http[s]?|[s]?ftp[s]?)(:\/\/)([^\s,]+)|^$")]
        [string]$PrivacyURL = [string]::Empty,

        
        [parameter(Mandatory = $false,  ParameterSetName = "Default", HelpMessage = "Specify whether to have the Win32 application featured in Company Portal or not.")]
        [parameter(Mandatory = $false,  ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Specify whether to have the Win32 application featured in Company Portal or not.")]
        [parameter(Mandatory = $false,  ParameterSetName = "RestartBehavior", HelpMessage = "Specify whether to have the Win32 application featured in Company Portal or not.")]
        [parameter(Mandatory = $false,  ParameterSetName = "ALL", HelpMessage = "Specify whether to have the Win32 application featured in Company Portal or not.")]
        [bool]$CompanyPortalFeaturedApp = $false,

        [parameter(Mandatory = $false, ParameterSetName = "Default", HelpMessage = "Specify the install command line for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Specify the install command line for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "RestartBehavior", HelpMessage = "Specify the install command line for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "ALL", HelpMessage = "Specify the install command line for the Win32 application.")]
        [ValidateNotNullOrEmpty()]
        [string]$InstallCommandLine,

        [parameter(Mandatory = $false, ParameterSetName = "Default", HelpMessage = "Specify the uninstall command line for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Specify the uninstall command line for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "RestartBehavior", HelpMessage = "Specify the uninstall command line for the Win32 application.")]
        [parameter(Mandatory = $false, ParameterSetName = "ALL", HelpMessage = "Specify the uninstall command line for the Win32 application.")]
        [ValidateNotNullOrEmpty()]
        [string]$UninstallCommandLine,

        [parameter(Mandatory = $true,  ParameterSetName = "RestartBehavior", HelpMessage = "Specify the install experience for the Win32 application. Supported values are: system or user.")]
        [parameter(Mandatory = $true,  ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Specify the install experience for the Win32 application. Supported values are: system or user.")]
        [parameter(Mandatory = $true,  ParameterSetName = "ALL", HelpMessage = "Specify the install experience for the Win32 application. Supported values are: system or user.")]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("system", "user")]
        [string]$InstallExperience,

        [parameter(Mandatory = $true,  ParameterSetName = "RestartBehavior", HelpMessage = "Specify the restart behavior for the Win32 application. Supported values are: allow, basedOnReturnCode, suppress or force.")]
        [parameter(Mandatory = $true,  ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Specify the restart behavior for the Win32 application. Supported values are: allow, basedOnReturnCode, suppress or force.")]
        [parameter(Mandatory = $true,  ParameterSetName = "ALL", HelpMessage = "Specify the restart behavior for the Win32 application. Supported values are: allow, basedOnReturnCode, suppress or force.")]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("allow", "basedOnReturnCode", "suppress", "force")]
        [string]$RestartBehavior,

        [parameter(Mandatory = $false,  ParameterSetName = "Default", HelpMessage = "Provide an array of a single or multiple OrderedDictionary objects as detection rules that will be used for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Provide an array of a single or multiple OrderedDictionary objects as detection rules that will be used for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "RestartBehavior", HelpMessage = "Provide an array of a single or multiple OrderedDictionary objects as detection rules that will be used for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "ALL", HelpMessage = "Provide an array of a single or multiple OrderedDictionary objects as detection rules that will be used for the Win32 application.")]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Specialized.OrderedDictionary[]]$DetectionRules,

        [parameter(Mandatory = $false,  ParameterSetName = "Default", HelpMessage = "Provide an OrderedDictionary object as requirement rule that will be used for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Provide an OrderedDictionary object as requirement rule that will be used for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "RestartBehavior", HelpMessage = "Provide an OrderedDictionary object as requirement rule that will be used for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "ALL", HelpMessage = "Provide an OrderedDictionary object as requirement rule that will be used for the Win32 application.")]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Specialized.OrderedDictionary[]]$RequirementRules,

        [parameter(Mandatory = $false,  ParameterSetName = "Default", HelpMessage = "Provide an array of OrderedDictionary objects as additional requirement rule, e.g. for file, registry or script rules, that will be used for the Win32 application.")]
        [parameter(Mandatory = $true,  ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Provide an array of OrderedDictionary objects as additional requirement rule, e.g. for file, registry or script rules, that will be used for the Win32 application.")]
        [parameter(Mandatory = $false,  ParameterSetName = "RestartBehavior", HelpMessage = "Provide an array of OrderedDictionary objects as additional requirement rule, e.g. for file, registry or script rules, that will be used for the Win32 application.")]
        [parameter(Mandatory = $true,  ParameterSetName = "ALL", HelpMessage = "Provide an array of OrderedDictionary objects as additional requirement rule, e.g. for file, registry or script rules, that will be used for the Win32 application.")]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Specialized.OrderedDictionary[]]$AdditionalRequirementRule,

        [parameter(Mandatory = $false,  ParameterSetName = "Default", HelpMessage = "Provide an array of a single or multiple hash-tables for the Win32 application with return code information.")]
        [parameter(Mandatory = $true,  ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Provide an array of a single or multiple hash-tables for the Win32 application with return code information.")]
        [parameter(Mandatory = $false,  ParameterSetName = "RestartBehavior", HelpMessage = "Provide an array of a single or multiple hash-tables for the Win32 application with return code information.")]
        [parameter(Mandatory = $true,  ParameterSetName = "ALL", HelpMessage = "Provide an array of a single or multiple hash-tables for the Win32 application with return code information.")]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]$ReturnCode,

        [parameter(Mandatory = $false,  ParameterSetName = "Default", HelpMessage = "Provide an array of a single or multiple hash-tables for the Win32 application with return code information.")]
        [parameter(Mandatory = $false,  ParameterSetName = "AdditionalRequirementRules", HelpMessage = "Provide an array of a single or multiple hash-tables for the Win32 application with return code information.")]
        [parameter(Mandatory = $false,  ParameterSetName = "RestartBehavior", HelpMessage = "Provide an array of a single or multiple hash-tables for the Win32 application with return code information.")]
        [parameter(Mandatory = $false,  ParameterSetName = "ALL", HelpMessage = "Provide an array of a single or multiple hash-tables for the Win32 application with return code information.")]
        [ValidateNotNullOrEmpty()]
        [string]$Icon

    )
    Begin {
        Write-Warning "This Function is currently experimental"
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
        try {

            if ($PSBoundParameters.Count -le 1)  {
                Throw "No Properties to update"
            }
                $Win32AppBody = [ordered] @{
                }

                if ($PSBoundParameters["DisplayName"]) {
                    $Win32AppBody['displayName'] = $DisplayName
                }

                if ($PSBoundParameters["Description"]) {
                    $Win32AppBody['description'] = $Description
                }

                if ($PSBoundParameters["Publisher"]) {
                    $Win32AppBody['publisher'] = $Publisher
                }

                if ($PSBoundParameters["AppVersion"]) {
                    $Win32AppBody['appVersion'] = $APPVersion
                }
                if ($PSBoundParameters["AppVersion"]) {
                    $Win32AppBody['appVersion'] = $APPVersion
                }

                if ($PSBoundParameters["Developer"]) {
                    $Win32AppBody['developer'] = $Developer
                }

                if ($PSBoundParameters["Owner"]) {
                    $Win32AppBody['owner'] = $Owner
                }

                if ($PSBoundParameters["Notes"]) {
                    $Win32AppBody['Notes'] = $Notes
                }

                if ($PSBoundParameters["InformationUrl"]) {
                    $Win32AppBody['informationUrls'] = $InformationUrls
                }

                if ($PSBoundParameters["PrivacyUrl"]) {
                    $Win32AppBody['privacyUrl'] = $PrivacyUrl
                }

                if ($PSBoundParameters["CompanyPortalFeaturedApp"]) {
                    $Win32AppBody['isFeatured'] = $CompanyPortalFeaturedApp
                }

                if ($PSBoundParameters["InstallCommandLine"]) {
                    $Win32AppBody['installCommandLine'] = $InstallCommandLine
                }

                if ($PSBoundParameters["UninstallCommandLine"]) {
                    $Win32AppBody['uninstallCommandLine'] = $UninstallCommandLine
                }

                if ($PSBoundParameters["InstallExperience"]){
                    $Win32AppBody['installExperience'] = @{
                        'runAsAccount' = $InstallExperience
                        'deviceRestartBehavior' = $RestartBehavior
                    }
                }

                if ($PSBoundParameters["DetectionRules"]) {
                    $Win32AppBody['detectionRules'] = $DetectionRules
                }


                if ($PSBoundParameters["RequirementRules"]) {
                    $Win32AppBody['requirementRules'] = $RequirementRules
                }
                if ($PSBoundParameters["AdditonalRequirementRules"]) {
                    $Win32AppBody['requirementRules'] = $Win32AppBody['requirementRules'] + $Win32AppBody['AdditonalRequirementRules']
                }
                

                $Win32AppBody."@odata.type" = '#microsoft.graph.win32LobApp'



            # Validate that correct detection rules have been passed on command line, only 1 PowerShell script based detection rule is allowed
            if (($DetectionRule.'@odata.type' -contains "#microsoft.graph.win32LobAppPowerShellScriptDetection") -and (@($DetectionRules).'@odata.type'.Count -gt 1)) {
                Write-Warning -Message "Multiple PowerShell Script detection rules were detected, this is not a supported configuration"; break
            }

            # Create the Win32 app
            Write-Verbose -Message "Attempting to create Win32 app using constructed body converted to JSON content"
            $Win32MobileAppRequest = Invoke-IntuneGraphRequest -APIVersion "Beta" -Resource "mobileApps/$Id" -Method "Patch" -Body ($Win32AppBody | ConvertTo-Json)
            Write-Verbose -Message "Successfully Updated Win32 app with ID: $($Win32MobileAppRequest.id)"
        }
    catch [System.Exception] {
        Write-Warning -Message "An error occurred while patching the Win32 application. Error message: $($_.Exception.Message)"
        exit 1
    }
}}