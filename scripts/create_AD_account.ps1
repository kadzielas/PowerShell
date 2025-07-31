#------------------------------------------------------------------------------------------
#Description: Function to automate creation personal accounts.
#------------------------------------------------------------------------------------------

Start-Transcript
$Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
$Length = 12
$GeneratedPassword = -join ((1..$length) | ForEach-Object { $chars[(Get-Random -Minimum 0 -Maximum $chars.Length)] })
$Password = $GeneratedPassword
$GivenName = "name"
$Surname = "surname"
$SupervisorEmail = "SupervisorEmail" 
$Name = "$Surname $GivenName"
$DisplayName = "$Surname $GivenName"
$UserPrincipalName = "email.user"
$SamAccountName = $GivenName+"."+$Surname
$SamAccountName = $SamAccountName.ToLower()
$SamAccountName = if ($SamAccountName.length -gt 20) { $SamAccountName.substring(0, 20) } else { $SamAccountName }
$UserEmail = "email"
$EndDate = ""
$City = "Warsaw"
$Country ="Poland"
$MobilePhone = ""
$credPath = 'C:\password.txt'
$fileCred = Import-Clixml -Path $credPath 
$CountryCode = switch ($Country)
{
    France {"FR"}
    Germany {"DE"}
    Spain {"ES"}
    Poland {"PL"}
    'United Kingdom' {"GB"}
    
}
$c = switch ($Country)
{
    France {"FR"}
    Germany {"DE"}
    Spain {"ES"}
    Poland {"PL"}
    'United Kingdom' {"GB"}
    
}
$co = switch ($Country)
{
    France {"France"}
    Germany {"Germany"}
    Spain {"Spain"}
    Poland {"Poland"}
    'United Kingdom' {"GB"}
    
}
$countrycode = switch ($Country)
{
    France {"250"}
    Germany {"276"}
    Spain {"724"}
    Poland {"616"}
    'United Kingdom' {"826"}
    
}



$Title = "position"
$AccountExpirationDate =if([string]::IsNullOrWhiteSpace($EndDate)){ } else {
Get-Date ""}
$Manager = (Get-ADUser -Filter "UserPrincipalName -eq '$SupervisorEmail'").SamAccountName
$OrganizationalUnit = "OU=Poland,OU=Users,dc=kadzielas,dc=pl"
$password = ConvertTo-SecureString $Password -AsPlainText -Force
New-ADUser  -Name $Name -GivenName $GivenName -Surname $Surname -DisplayName $DisplayName -SamAccountName $SamAccountName -UserEmail $UserEmail -Path $OrganizationalUnit -Title $Title
-Manager $Manager -UserPrincipalName $UserPrincipalName -City $City -Country $CountryCode -AccountExpirationDate $AccountExpirationDate -Enabled $true -MobilePhone $MobilePhone
Unlock-ADAccount -Identity $SamAccountName
Set-ADUser -Identity $SamAccountName -DisplayName $Surname", "$GivenName
Invoke-Command -ComputerName ad -ScriptBlock {Start-ADSyncSyncCycle -PolicyType Delta}
Start-Sleep -s 120



$emailBody = @"
       User $Name has been created.
"@ 
Send-MailMeUKage -To "supervisor.email" -From "sender-email"  -Subject "A new user account has been created."   -SmtpServer 'smtp.office365.com' -Port 587 -UseSsl -Credential $fileCred
