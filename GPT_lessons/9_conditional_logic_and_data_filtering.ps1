
     
     #conditional_logic_and_data_filtering

#!------------------------------------------------------------!
#!                            Easy                            !
#!------------------------------------------------------------!

#Excercise 9.1

#Description: Use a switch statement to match a variable $color with possible values: "red", "blue", "green" and display a different message for each.


<#
$input = Read-Host "Provide color"

switch ($input) {
    
    "red" {Write-Host "Selected color: red"}
    "blue" {Write-Host "Selected color: blue"}
    "green" {Write-Host "Selected color: green"}

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

    $script:weekend[0] {Write-Host "$script:input - it's weekend!"}
    $script:weekend[1] {Write-Host "$script:input - it's weekend!"}
    default {Write-Host "$script:input - it's weekday!"}
}
#>


#!------------------------------------------------------------!

#Excercise 9.3

#Description: Use switch to check a number from 1 to 5 and print the number spelled out (e.g. 1 → One, 2 → Two).


<#
[int]$script:input = 0;

$script:input = Read-Host "Provide number"
switch ($script:input) {
    
    1 {Write-Host One}
    2 {Write-Host Two}
    3 {Write-Host Three}
    4 {Write-Host Four}
    5 {Write-Host Five}
    Default {Write-Host "out of scope"}
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
    Write-Host "Invalid input. Please enter one of the following: start, stop"
}

switch ($script:inputValidate) {
    
    start {Write-Host Starting...}
    stop {Write-Host Stopping...}
    
    Default {Write-Host "out of scope"}
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
    { $_ -eq ".txt" } { Write-Host "It's a TXT file extension!" ; break }
    { $_ -eq ".jpg" } { Write-Host "It's a JPG file extension!" ; break }
    { $_ -eq ".exe" } { Write-Host "It's an EXE file extension!" ; break }
    { $_ -eq ".log" } { Write-Host "It's a LOG file extension!" ; break }
    { $_ -eq ".gif" } { Write-Host "It's a GIF file extension!" ; break }
    default { Write-Host "Provided extension is not included in the list." }
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

    "\.(txt|exe|log|zip|bat|ps1)$" {Write-Host "The file extension is $script:selectedFilePath"}
    
    default {Write-Host "Out of scope"}

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
  Write-Host "$($private:runningProcesses[$i]) process is consuming above 100MB of RAM"
  }

}
#>





#!------------------------------------------------------------!

#Excercise 9.3

#Description: Ask the user to input a two-letter country code (e.g., US, PL, DE, JP, FR). 
#Use a switch block to return the country’s full name, official language, and typical time zone. 
#Implement switch -Regex or switch -Wildcard to allow case-insensitive matching.





#!------------------------------------------------------------!

#Excercise 9.4

#Description: Write a function that accepts an array of usernames. Loop through each name, and use switch to check:
#If name contains "admin", mark as "Privileged"
#If name ends in "01", mark as "Temporary account"
#If name contains uppercase letters, mark as "Custom"
#Else, mark as "Standard"
#Return a structured output per user.





#!------------------------------------------------------------!

#Excercise 9.5

#Description: Create a validation script that:
#Asks the user to enter a PowerShell command name.
#Uses switch -Regex to check:
#If it begins with Get- and ends with Item, mark as Filesystem-related
#If it begins with Get- and contains Process or Service, mark as System-related
#If it contains New- or Set-, mark as Configuration command
#Else, show "Unrecognized or advanced command"





#!------------------------------------------------------------!



#!------------------------------------------------------------!
#!                            Integration                     ! 
#!------------------------------------------------------------!

#Excercise 9.1

#Description: 



#!------------------------------------------------------------!
#Excercise 9.2

#Description: 



#!------------------------------------------------------------!
#Excercise 9.3

#Description: 



#!------------------------------------------------------------!
#Excercise 9.4

#Description: 



#!------------------------------------------------------------!
#Excercise 9.5

#Description: 



#!------------------------------------------------------------!

