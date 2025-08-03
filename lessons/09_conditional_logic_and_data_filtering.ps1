
     
#conditional_logic_and_data_filtering

#!------------------------------------------------------------!
#!                            Easy                            !
#!------------------------------------------------------------!

#Excercise 9.1

#Description: Use a switch statement to match a variable $color with possible values: "red", "blue", "green" and display a different message for each.


<#
$input = Read-Host "Provide color"

switch ($input) {
    
    "red" {Write-Output "Selected color: red"}
    "blue" {Write-Output "Selected color: blue"}
    "green" {Write-Output "Selected color: green"}

}
#>


#!------------------------------------------------------------!

#Excercise 9.2

#Description: Ask the user to input a day of the week and use switch to print whether it’s a weekday or weekend.


<#
[string[]]$script:weekend = @("sunday", "staruday");
[string]$script:input = "";

$script:input = Read-Host "Provide name of day";

switch ($script:input) {

    $script:weekend[0] {Write-Output "$script:input - it's weekend!"}
    $script:weekend[1] {Write-Output "$script:input - it's weekend!"}
    default {Write-Output "$script:input - it's weekday!"}
}
#>


#!------------------------------------------------------------!

#Excercise 9.3

#Description: Use switch to check a number from 1 to 5 and print the number spelled out (e.g. 1 → One, 2 → Two).


<#
[int]$script:input = 0;

$script:input = Read-Host "Provide number"
switch ($script:input) {
    
    1 {Write-Output One}
    2 {Write-Output Two}
    3 {Write-Output Three}
    4 {Write-Output Four}
    5 {Write-Output Five}
    Default {Write-Output "out of scope"}
}
#>


#!------------------------------------------------------------!

#Excercise 9.4

#Description: Create a switch block that handles both "start" and "stop" commands. For "start" show “Starting...”, for "stop" show “Stopping...”.


<#
enum status {
start
stop
empty
}

[string]$script:input;
[status]$script:inputValidate = [status]::empty;

$script:input = Read-Host "Provide status"

try {
    $script:inputValidate = [status]::Parse([status], $script:input, $true)  
}
catch {
    Write-Output "Invalid input. Please enter one of the following: start, stop"
}

switch ($script:inputValidate) {
    
    start {Write-Output Starting...}
    stop {Write-Output Stopping...}
    
    Default {Write-Output "out of scope"}
}
#>


#!------------------------------------------------------------!

#Excercise 9.5

#Description: Create an array of 5 file extensions (e.g., .txt, .jpg, .exe) and use switch to display a message depending on the file type.

<#
$script:arrayOfFilesExtensions = @(".txt", ".jpg", ".exe", ".log", ".gif")
[string]$script:input = Read-Host "Provide extension"

if (-not $script:input.StartsWith(".")) {
    $script:input = "." + $script:input
}

switch ($script:input) {
    { $_ -eq ".txt" } { Write-Output "It's a TXT file extension!" ; break }
    { $_ -eq ".jpg" } { Write-Output "It's a JPG file extension!" ; break }
    { $_ -eq ".exe" } { Write-Output "It's an EXE file extension!" ; break }
    { $_ -eq ".log" } { Write-Output "It's a LOG file extension!" ; break }
    { $_ -eq ".gif" } { Write-Output "It's a GIF file extension!" ; break }
    default { Write-Output "Provided extension is not included in the list." }
}
#>


#!------------------------------------------------------------!



#!------------------------------------------------------------!
#!                            Medium                          !
#!------------------------------------------------------------!

#Excercise 9.1

#Description: Prompt the user for a file path. Extract the file extension using Split-Path or Get-Item, 
#then use switch to classify the file as document, image, code, audio, or other. Support at least 10 file types.



<#
try {

[string]$script:selectedFilePath = Read-Host "Provide path to file"

$script:selectedFilePath = Split-Path -Path $script:selectedFilePath -Leaf

$script:selectedFilePath = [System.IO.Path]::GetExtension($script:selectedFilePath)

switch -Regex ($script:selectedFilePath) {

    "\.(txt|exe|log|zip|bat|ps1)$" {Write-Output "The file extension is $script:selectedFilePath"}
    
    default {Write-Output "Out of scope"}

}

    } catch {

Write-Error "Something went wrong"

    }

#>



#!------------------------------------------------------------!

#Excercise 9.2

#Description: Create a script that reads all currently running processes. Based on the process name, use switch to:
#Display a warning for high-memory services (e.g., chrome, sqlservr, teams)
#Show info for regular system processes (e.g., explorer, winlogon)
#Mark others as "safe background task"
#Filter and print only those with more than 100MB of memory usage.



<#
$private:runningProcesses = @(Get-Process |  Select-Object ProcessName)

$private:runningProcesses = $private:runningProcesses -replace  '^@{ProcessName=', '' -replace '}$', '' | Select-Object -Unique


for ($i = 0; $i -lt $private:runningProcesses.Length; $i++){

switch -Regex ($private:runningProcesses[$i]) {

    "(chrome|sqlservr|teams)" {Write-Warning "The process - $($private:runningProcesses[$i]) - is marked as high RAM amount needed process"}
    "(explorer|winlogon)" {Write-Warning "The process - $($private:runningProcesses[$i]) - is marked as medium RAM amount needed process"}
    default {}
    }
    
  if (Get-Process | Where-Object {$_.Name -match $private:runningProcesses[$i] -and $_.PM -gt 100MB}) {
  Write-Output "$($private:runningProcesses[$i]) process is consuming above 100MB of RAM"
  }

}
#>





#!------------------------------------------------------------!

#Excercise 9.3

#Description: Ask the user to input a two-letter country code (e.g., US, PL, DE, JP, FR). 
#Use a switch block to return the country’s full name, official language, and typical time zone. 
#Implement switch -Regex or switch -Wildcard to allow case-insensitive matching.



<#
$script:output = Read-Host "Provide two-letter country code"

switch -Wildcard ($script:output) {

    "PL" {Write-Output "Poland, polish, CET+1"}
    default {Write-Output "Provided country code is not included."}

}
#>



#!------------------------------------------------------------!

#Excercise 9.4

#Description: Write a function that accepts an array of usernames. Loop through each name, and use switch to check:
#If name contains "admin", mark as "Privileged"
#If name ends in "01", mark as "Temporary account"
#If name contains uppercase letters, mark as "Custom"
#Else, mark as "Standard"
#Return a structured output per user.


<#
[string[]]$users = @('olx', 'ra01at', 'rata12adminha', 'WUWUX', 'mord01ko');

function checkName {
    param (
        [string[]]$usernames
    )
    
    foreach ($check in $usernames) {
        
        switch -Regex ($check) {
            'admin' { Write-Output "$check Privileged" }
            '01' { Write-Output "$check Temporary account" }
            "^[A-Z]+$" { Write-Output "$check Custom" }
            Default { Write-Output "$check Standard" }
        }
    }
}

checkName -usernames $users
#>


#!------------------------------------------------------------!

#Excercise 9.5

#Description: Create a validation script that:
#Asks the user to enter a PowerShell command name.
#Uses switch -Regex to check:
#If it begins with Get- and ends with Item, mark as Filesystem-related
#If it begins with Get- and contains Process or Service, mark as System-related
#If it contains New- or Set-, mark as Configuration command
#Else, show "Unrecognized or advanced command"


<#
$script:output = Read-Host "Provide PS command"

function checkCommand {
    [CmdletBinding()]
    param (
        [string]$providedCommand
    )

    switch -Regex ($providedCommand) {
        '^Get-Item' { Write-Output "$providedCommand is Filesystem-related command" }
        '^Get-(service|process)' { Write-Output "$providedCommand is System-related command" }
        '(new-|set-)' { Write-Output "$providedCommand is Configuration command" }
        Default { Write-Output "Unrecognized or advanced command" }
    }
    
}

checkCommand -providedCommand $script:output
#>


#!------------------------------------------------------------!



#!------------------------------------------------------------!
#!                            Integration                     ! 
#!------------------------------------------------------------!

#Excercise 9.1

#Description: Create a script that analyzes a list of installed software from the registry and classifies each based on its name. 
#Use switch -regex to categorize software as a browser, security tool, system tool, or miscellaneous. Display a structured report for each group.


<# 
$apps = [System.Collections.ArrayList]::new();

$apps = Get-AppPackage | Select-Object name

foreach ($check in $apps) {

    switch -regex ($check) {
        "(security|windows)" { Write-Output "$check is recognized as security tool" }
        "system" { Write-Output "$check is recognized as system tool" }
        "browser" { Write-Output "$check is recognized as browser" }
        Default { Write-Output "$check is recognized as miscellaneous" }
    }

}
 #>


#!------------------------------------------------------------!
#Excercise 9.2

#Description: Write a function that takes a hashtable with usernames and login timestamps. Use switch to classify activity:
#If login time is between 6–9 AM, mark as "Early login"
#9 – 17 as "Regular login"
#After 17 as "After-hours login"
#Return a report with username, login time, and login type.



<# 
$private:names = [System.Collections.ArrayList]@("seba", "ola", "magda", "adam", "riki");

[hashtable]$userInfo = [ordered]@{}

for ($i = 0; $i -lt 5; $i++) {
    $userInfo["user_$i"] = [PSCustomObject]@{
        Name      = $private:names[$i];
        LoginTime = (Get-Date).AddMinutes(- $i * 17).AddHours(- $i * 3).AddSeconds(- $i * 4)
    }
}

$userInfo

foreach ($selected in $userInfo.Values) {
    $hour = [int]$selected.LoginTime.toString("HH");
    switch ($hour) {
        { $_ -GE 6 -and $_ -LT 9 } { Write-Output "$($selected.Name):Early login" }
        { $_ -GE 9 -and $_ -LT 17 } { Write-Output "$($selected.Name):Regular login" }
        { $_ -GE 17 -and $_ -LT 23 } { Write-Output "$($selected.Name):After-hours login" }
        { $_ -GE 0 -and $_ -LT 6 } { Write-Output "$($selected.Name):After-hours login" }
    }

}
 #>




#!------------------------------------------------------------!
#Excercise 9.3

#Description: Create a script that lists all files in a given directory (ask user for path), groups them by extension using switch, and displays:
#File name
#Type (Text, Image, Archive, Executable, Other)
#Size in KB



<# 
$Private:selectedPath = Read-Host "provide path to directory"

if (Test-Path $Private:selectedPath) {
    $private:files = Get-ChildItem -Path $Private:selectedPath -File
    
    $private:extensions = @($private:files | Select-Object Extension -Unique | -replace "^@{Extension=" '' -replace "}$" '')

    for ($i = 0; $i -lt $private:files.Length; $i++) {

        switch -regex ($private:files[$i]) {

            "$($private:extensions[0])$" { Write-Output "Name: $(Split-Path $private:files[$i].Directory) `n Type: Other `n Size: $([System.Math]::Round(($private:files[$i].Length / 1KB), 2)) KB" }
            "$($private:extensions[1])$" { Write-Output "Name: $(Split-Path $private:files[$i].Directory) `n Type: Executable `n Size: $([System.Math]::Round(($private:files[$i].Length / 1KB), 2)) KB `n -------------" }
            
        
        }
    }
    
}
 #>



#!------------------------------------------------------------!
#Excercise 9.4

#Description: Write a script that analyzes a log file line by line. Use switch -regex to count how many lines:
#Contain the word error
#Contain the word warning
#Are empty
#Display the final count and percentage breakdown.



<# 
$filepath = Read-Host "Provide path to file"
$content = Get-Content -Path $filepath
$errorCount = 0
$warningCount = 0
$emptyCount = 0

foreach ($line in $content) {
    switch -Regex ($line) {
        '^\s*$' { $emptyCount++ ; break }
        'error' { $errorCount++ ; break }
        'warning' { $warningCount++ ; break }
        default { }  
    }
}

$total = $content.Count

Write-Output ""
Write-Output "Final line count:"
Write-Output "Error: $errorCount"
Write-Output "Warning: $warningCount"
Write-Output "Empty: $emptyCount"
Write-Output ""
Write-Output "Total % of errors: $([math]::Round(($errorCount / $total) * 100))%"
 #>
 


#!------------------------------------------------------------!
#Excercise 9.5

#Description: Create a function that receives a list of IP addresses and classifies them using switch:
#Starts with 192. → "Private"
#Starts with 10. → "Private"
#Starts with 172.16–172.31 → "Private"
#Any other → "Public"
#Return a grouped output with IP and classification.



<# 
[string[]]$ips = @("192.168.20.1", "10.32.12.1", "155.111.232.1", "172.16.23.23", "172.14.1.1", "172.31.23.23")
[hashtable]$sorted = @{};

function sortIPs {
    [CmdletBinding()]
    param (
        [string[]]$ipsToSort
    )
    
    begin {
        Write-Verbose "starting.."
    }
    
    process {
        
        for ($i = 0; $i -lt $ipsToSort.Length; $i++) {
            switch -regex ($ipsToSort[$i]) {

                "^192." {
                    $sorted["IP_ID_$i"] = [PSCustomObject]@{
                        addressIP      = $ipsToSort[$i];
                        classification = "private";
                    }
                }
                "^10." {
                    $sorted["IP_ID_$i"] = [PSCustomObject]@{
                        addressIP      = $ipsToSort[$i];
                        classification = "private";
                    }
                }
                "(^172.16|^172.31)" {
                    $sorted["IP_ID_$i"] = [PSCustomObject]@{
                        addressIP      = $ipsToSort[$i];
                        classification = "private";
                    }
                }
                Default {
                    $sorted["IP_ID_$i"] = [PSCustomObject]@{
                        addressIP      = $ipsToSort[$i];
                        classification = "public";
                    }
                }
            }
        }

    }
    
    end {
        Write-Verbose "finishing..."
        $sorted.Values | Sort-Object classification
    }
}

sortIPs -ipsToSort $ips -Verbose
 #>



#!------------------------------------------------------------!

