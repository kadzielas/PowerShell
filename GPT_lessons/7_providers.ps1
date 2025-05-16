
     
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
#!                           Medium                           !
#!------------------------------------------------------------!
#Excercise 7.1

#Description: Display all environment variables (env:) whose values contain Windows. Use Where-Object.

#Get-ChildItem env: | Where-Object -Property Value -Like *Windows*


#!------------------------------------------------------------!
#Excercise 7.2

#Description: In the C:\Windows directory, find all .log files larger than 100KB. Use access through the FileSystem provider.

#foreach ($file in Get-ChildItem -Path "C:\Windows" -Filter *.log | Where-Object Length -GT 100KB) {
#$file
#}

#!------------------------------------------------------------
#Excercise 7.3

#Description: Add an alias czekaj that executes Start-Sleep -Seconds 5. Run the alias and observe the effect.

#Set-Alias -Name czekaj -Value Start-Sleep
#
#czekaj -Seconds 5

#!------------------------------------------------------------!
#Excercise 7.4

#Description: Create your own function PokażInfo that prints the text: "Dzień dobry z lekcji 7". Then add the alias info for it.

#function PokazInfo {
#    Write-Host Dzień dobry z lekcji 7.
#}
#
#Set-Alias -Name info -Value PokazInfo
#
#info

#!------------------------------------------------------------!
#Excercise 7.5

#Description: List all functions (function:) whose names contain the letter a. Sort them alphabetically.

#ls function:*a* | Sort-Object Name

#!------------------------------------------------------------!
#!                            Mixed                           ! 
#!------------------------------------------------------------!
#Excercise 7.1

#Description: Create a function that displays all environment variables containing the string TEMP. The function should return the name and value of each match.



#!------------------------------------------------------------!
#Excercise 7.2

#Description: Using a loop, go through all aliases (alias:) and print only those whose definitions start with the letter S. Then count how many were found.



#!------------------------------------------------------------!
#Excercise 7.3

#Description: Create 5 variables using the variable: provider and assign different data types (string, int, bool, array, double). Then display their names and values using a loop.



#!------------------------------------------------------------!
#Excercise 7.4

#Description: In the registry (HKCU:\), list all subkeys under Software whose names are longer than 10 characters. Display their names and lengths.



#!------------------------------------------------------------!
#Excercise 7.5

#Description: Create a folder named C:\ProviderReport, and save to a file all alias names that include the letter o (lowercase only). Then display the content of the file.



#!------------------------------------------------------------!

