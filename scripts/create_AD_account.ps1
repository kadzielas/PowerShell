#------------------------------------------------------------------------------------------
#Description: Function to automate creation personal accounts.
#------------------------------------------------------------------------------------------
function New-User-Account {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [string]$DeviceName
    )
    try {
        Start-Transcript
        $Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
        $Length = 12
        $GeneratedPassword = -join ((1..$length) | ForEach-Object { $chars[(Get-Random -Minimum 0 -Maximum $chars.Length)] })
        $GivenName = "name"
        $Surname = "surname"
        $SupervisorEmail = "SupervisorEmail" 
        $Name = "$Surname $GivenName"
        $DisplayName = "$Surname $GivenName"
        $UserPrincipalName = "email.user"
        $SamAccountName = $GivenName + "." + $Surname
        $SamAccountName = $SamAccountName.ToLower()
        $SamAccountName = if ($SamAccountName.length -gt 20) { $SamAccountName.substring(0, 20) } else { $SamAccountName }
        $UserEmail = "email"
        $Title = "position"
        $EndDate = ""
        $City = "Warsaw"
        $Country = "Poland"
        $MobilePhone = ""
        $CountryCode = switch ($Country) {
            France { "FR" }
            Germany { "DE" }
            Spain { "ES" }
            Poland { "PL" }
            'United Kingdom' { "GB" }
    
        }
        $countrycode = switch ($Country) {
            France { "250" }
            Germany { "276" }
            Spain { "724" }
            Poland { "616" }
            'United Kingdom' { "826" }
    
        }



        $AccountExpirationDate = if ([string]::IsNullOrWhiteSpace($EndDate)) { } else {
            Get-Date ""
        }
        $Manager = (Get-ADUser -Filter "UserPrincipalName -eq '$SupervisorEmail'" -ErrorAction Stop).SamAccountName
        $OrganizationalUnit = "OU=Poland,OU=Users,dc=kadzielas,dc=pl"

        New-ADUser  -Name $Name -GivenName $GivenName -Surname $Surname -DisplayName $DisplayName
        -SamAccountName $SamAccountName -UserEmail $UserEmail -Path $OrganizationalUnit -Title $Title
        -Manager $Manager -UserPrincipalName $UserPrincipalName -City $City -Country $CountryCode
        -AccountExpirationDate $AccountExpirationDate -Enabled $false -MobilePhone $MobilePhone -ErrorAction Stop
        Unlock-ADAccount -Identity $SamAccountName -ErrorAction Stop
        Set-ADUser -Identity $SamAccountName -DisplayName $Surname", "$GivenName -ErrorAction Stop
        Set-ADccountPassword -Identity $SamAccountName -NewPassword $GeneratedPassword -ErrorAction Stop
        Invoke-Command -ComputerName $DeviceName -ScriptBlock { Start-ADSyncSyncCycle -PolicyType Delta } -ErrorAction Stop
        Start-Sleep -s 120
    }
    catch {
        Write-Error "Error occured during creating new user account: $_"
    }
}