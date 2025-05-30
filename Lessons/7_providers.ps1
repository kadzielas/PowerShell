
     
#providers

#!------------------------------------------------------------!
#!                            Easy                            !
#!------------------------------------------------------------!
#Excercise 7.1

#Description: Display all available providers in PowerShell.

#Get-PSProvider


#!------------------------------------------------------------!
#Excercise 7.2

#Description: Go to alias: and display all aliases that start with the letter g.

#Get-Alias -Name g*
#or
#Get-ChildItem alias:g*


#!------------------------------------------------------------!
#Excercise 7.3

#Description: Go to env: and display the value of the PATH environment variable.

#$env:Path


#!------------------------------------------------------------!
#Excercise 7.4

#Description: Add a new PowerShell variable named mojaZmienna with the value "Testuję providery" and display it.

<#
[string]$mojaZmienna = "Testuje providery"
$mojaZmienna
#>

#!------------------------------------------------------------!
#Excercise 7.5

#Description: Add an alias powitaj that calls Write-Host. Use it to print the text "Działa!".

#Set-Alias -Name powitaj -Value Write-host
#
#powitaj działa!


#!------------------------------------------------------------!
#Excercise 7.6

#Description: Display all environment variables (env:) whose values contain Windows. Use Where-Object.


#Get-ChildItem env: | Where-Object -Property Value -Like *Windows*



#!------------------------------------------------------------!
#Excercise 7.7

#Description: In the C:\Windows directory, find all .log files larger than 100KB. Use access through the FileSystem provider.



#foreach ($file in Get-ChildItem -Path "C:\Windows" -Filter *.log | Where-Object Length -GT 100KB) {
#$file
#}



#!------------------------------------------------------------
#Excercise 7.8

#Description: Add an alias czekaj that executes Start-Sleep -Seconds 5. Run the alias and observe the effect.


#Set-Alias -Name czekaj -Value Start-Sleep
#
#czekaj -Seconds 5


#!------------------------------------------------------------!
#Excercise 7.9

#Description: Create your own function PokażInfo that prints the text: "Dzień dobry z lekcji 7". Then add the alias info for it.


#function PokazInfo {
#    Write-Host Dzień dobry z lekcji 7.
#}
#
#Set-Alias -Name info -Value PokazInfo
#
#info


#!------------------------------------------------------------!
#Excercise 7.10

#Description: List all functions (function:) whose names contain the letter a. Sort them alphabetically.


#ls function:*a* | Sort-Object Name


#!------------------------------------------------------------!


#!------------------------------------------------------------!
#!                           Medium                           !
#!------------------------------------------------------------!

#Excercise 7.1

#Description: Create a function that displays all environment variables containing the string TEMP. The function should return the name and value of each match.

#Get-ChildItem env:*temp* | Select-Object name, value


#!------------------------------------------------------------!
#Excercise 7.2

#Description: Using a loop, go through all aliases (alias:) and print only those whose definitions start with the letter S. Then count how many were found.
    

<#  [string[]]$selectedAliasName =  @()
    [string[]]$selectedAliasDefinition =  @()
    [int]$selectedAliastCount;

Get-ChildItem alias:S* | ForEach-Object{
   
        $selectedAliasName += $_.Name
        $selectedAliasDefinition += $_.Definition
           
    }

    for ($i = 0; $i -lt $selectedAliasName.Length; $i++) {
        $selectedAliasName[$i] + " " + $selectedAliasDefinition[$i]
    }

    $selectedAliastCount = $selectedAliasName.Length;

    Write-Host "Total count: $selectedAliastCount"
    #>



#!------------------------------------------------------------!
#Excercise 7.3

#Description: Create 5 variables using the variable: provider and assign different data types (string, int, bool, array, double). Then display their names and values using a loop.

<#
$allvariables = @{
stringvar = "string"
intvar = 1
boolvar = $true
arrayvar = 1,2,3,4
doublevar = 3.14
}


foreach ($var in $allvariables.Keys) {

$value = $allvariables[$var]
"$var => $($value.GetType().Name)"

}
#>


#!------------------------------------------------------------!
#Excercise 7.4

#Description: In the registry (HKCU:\), list all subkeys under Software whose names are longer than 10 characters. Display their names and lengths.

<#
foreach ($regkeyselected in Get-ChildItem HKCU:\Software -Recurse | 
Where-Object {($_.Name).Length -gt 100}) {
Write-Host @"

Registry key name: $($regkeyselected.Name)
Registry length: $(($regkeyselected.Name).Length)

"@
}
#>

#!------------------------------------------------------------!
#Excercise 7.5

#Description: Create a folder named C:\ProviderReport, and save to a file all alias names that include the letter o (lowercase only). Then display the content of the file.

<#
$aliasO = Get-ChildItem Alias: | Where-Object {$_.Name -cmatch 'o'}

if (-not (Test-Path "C:\ProviderReport")) {
New-Item -ItemType Directory -Path C:\ -Name ProviderReport 
New-Item -ItemType File -Path C:\ProviderReport\ -Name every_alias.txt
} else {
Write-Host "Directory has already exist"
}

if (Test-Path C:\ProviderReport\every_alias.txt) {
Set-Content -Path C:\ProviderReport\every_alias.txt -Value $aliasO
notepad.exe C:\ProviderReport\every_alias.txt
} else {
Write-Host "File doesn't exist"
}
#>

#!------------------------------------------------------------!


#!------------------------------------------------------------!
#!                            Integration                     ! 
#!------------------------------------------------------------!

#Excercise 7.1

#Description: Find all .log files in C:\Windows\Temp that were created in the last 7 days. For each file, display its name, size in KB, and whether the filename contains the word "error".

<#
 Get-ChildItem -Path "C:\Windows\Temp" -Filter *.log | ForEach-Object {
 if ($_.LastWriteTime -gt (Get-Date).AddDays(-7)) {
 [bool]$errorexist = $false;
 if((Get-Content -Path C:\Windows\Temp\$_) -match "error") {
 $errorexist = $true;
 }
 $_ | Select-Object name, @{Name="Size in KB"; Expression={"{0:N2}" -f ($_.Length / 1KB)}}, @{Name="Contain 'error'?"; Expression={$errorexist}}
 
 }
}
#>

#!------------------------------------------------------------!
#Excercise 7.2

#Description: List all PowerShell functions (from function:) whose names contain the letter o, then save these names to a file named functions_report.txt in a new folder called C:\FunctionReports.


<#
New-Item -ItemType Directory -Path "C:\" -Name "FunctionReports"
Get-ChildItem function: | Where-Object {$_.Name -match "o" -and $_.CommandType -match "Function"} |
Set-Content -Path "C:\FunctionReports\functions_report.txt" -Force;
Get-Content -Path "C:\FunctionReports\functions_report.txt";
#>


#!------------------------------------------------------------!
#Excercise 7.3

#Description: Create three custom aliases: one for creating a file, one for opening Notepad, and one for listing running processes. Use them in a script to verify that each alias works correctly.

<#
Set-Alias -Name createFileAlias -Value New-Item
Set-Alias -Name notepadAlias -Value notepad.exe
Set-Alias -Name showProcessesAlias -Value Get-Process

createFileAlias -Path C:\ -Name testfile -ItemType File
notepadAlias
showProcessesAlias
#>


#!------------------------------------------------------------!
#Excercise 7.4

#Description: List all environment variables whose values contain the word "System". Save the output to C:\Logs\env_log.txt, and include a timestamp at the top of the file.

<#
New-Item -ItemType Directory -Path C:\ -Name Logs
Add-Content -Path C:\Logs\env_log.txt -Force -Value (Get-Date)
Get-ChildItem env:*system* | Add-Content -Path C:\Logs\env_log.txt
#>

#!------------------------------------------------------------!
#Excercise 7.5

#Description: Write a function that takes a process name as input. If the process is running, stop it and log a message with a timestamp to C:\ProcessLogs\terminated.txt. If it is not running, log that it was not found, also with a timestamp.

<#
function checkProcess{
[cmdletbinding()]

Param(
[parameter(ValueFromPipeline, Mandatory =$true, HelpMessage = "Provide name of process to check.")]
[ValidateLength(1,15)]
[string]$processName
)
if (-not (Test-Path C:\ProcessLogs\)) {
New-Item -ItemType Directory -Path C:\ -Name ProcessLogs
}

Set-Content -Path C:\ProcessLogs\terminated.txt -Force -Value (Get-Date)

try {
if (Get-Process -Name $processName) {
Stop-Process -Name $processName
Add-Content -Path C:\ProcessLogs\terminated.txt -Value "Process $processName has been stopped"
} else {
Add-Content -Path C:\ProcessLogs\terminated.txt -Value "Process $processName was not found"
}
Get-Content C:\ProcessLogs\terminated.txt
    } catch [Microsoft.PowerShell.Commands.ProcessCommandException] {
    "Process $processName was not found"
    } catch {
    "An error occured"
    }
} 
#>



#!------------------------------------------------------------!


