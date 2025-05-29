#Excercise 6.1
#List all .log files in the C:\Windows\Temp directory that:
#have more than 100 bytes
#have been modified within the last 7 days

<#

foreach ($file in Get-ChildItem -Path "C:\Windows\Temp" |
 Where-Object {
 $_.Length -gt 100 -and $_.LastWriteTime -gt (Get-Date).AddDays(-7)
}
 ) 
    {
 $file
 } 
 #>

#-------------------------------------------------------------------------------------- 

#Excercise 6.2
#Create a folder C:\ReportsLesson6 and save to the file processes.txt a list of 10 processes with the highest RAM consumption.


<#

 $highestCPU = (Get-Process | Sort-Object PM -Descending | Select-Object -First 10);
 New-Item -Path "C:\" -ItemType Directory -Name RaportyLekcja6;
  Set-Content -Path "C:\RaportyLekcja6\procesy.txt" -Force -Value $highestCPU;
  $readFile = Get-Content -Path "C:\RaportyLekcja6\procesy.txt"
  Write-Host "Największe zużycie CPU: $readfile"

  #>

#--------------------------------------------------------------------------------------
#Excercise 6.3
#Check if the explorer.exe process exists. If yes – terminate it using PowerShell. If not – output the message "Process not found."

<#

  $isExplorer = Get-Process -Name "explorer";
  

  if ($isExplorer) {Stop-Process $isExplorer} else {Write-Host "Nie znaleziono procesu"}
  #>

#--------------------------------------------------------------------------------------

#Excercise 6.4
#Create a script that: launches notepad.exe, waits 3 seconds, and then closes the notepad process.
  
<#
  Start-Process notepad.exe
  Write-Host "Czekamy 3 sekundy"
  Start-Sleep -Seconds 3
  Write-Host "Zamykamy notepad"
  Stop-Process -Name notepad
  #>

#--------------------------------------------------------------------------------------
#Excercise 6.5
#For all .txt files in the folder C:\TestLesson6: append the line # Edited by script at the end of each file only if the file contains the word "test" (case insensitive).

<#

  foreach ($file in Get-ChildItem -Path "C:\TestLekcja6" -Filter *.txt) {

  if (
  (Get-Content -Path "C:\TestLekcja6\$file") -like "*test*"
    ) 
  {Add-Content -Value "# Edytowano przez skrypt" -Path "C:\TestLekcja6\$file"; 
  Write-Host "Dodane tekst do $file"; 
  Get-Content -Path "C:\TestLekcja6\$file"
    }
  }
  #>
#--------------------------------------------------------------------------------------

#Excercise 6L.1
#Write a script that searches the C:\Windows\Temp directory and lists all .log files larger than 50 KB and modified within the last 5 days.

<#foreach ($file in Get-ChildItem -Path "C:\Windows\Temp" -Recurse -Filter *.log
    ) {
   $file | Where-Object {$file.Length -gt 20KB -and $file.LastWriteTime -gt (Get-Date).AddDays(-7)} |
   Select-Object name, @{Name="Size in KB"; Expression={"{0:N2}" -f ($file.Length / 1KB)}}, lastwritetime
  }

  #>
#--------------------------------------------------------------------------------------
  
#Excercise 6L.2
#Create a function FindLargeProcesses that:
#Takes no parameters
#Finds the 5 processes with the highest memory usage (PM)
#Saves them to the file C:\Reports\large_processes.txt
#Then outputs the content of this file

<#Function FindLargeProcesses {
  $content = Get-Process | 
  Sort-Object -Descending |
  Select-Object -First 5;
  Set-Content -Path "C:\Raporty\duze_procesy.txt" -Value $content
  Get-Content -Path "C:\Raporty\duze_procesy.txt"
    }

    FindLargeProcesses#>
  
#--------------------------------------------------------------------------------------
  
#Excercise 6L.3
#Create a folder C:\LogTest, add 10 .txt files there. Every second file should contain the phrase "critical error", the others "all OK". 
#Write a script that goes through all files and outputs only those containing "critical error" along with their name and content.



#New-Item -ItemType Directory -Name "LogiTest" -Path "C:\"
#for ($i = 0; $i -lt 10; $i++) {
#New-Item -ItemType File -Path "C:\LogiTest\" -Name "$i-log.txt"
#if ($i % 2 -eq 0) {
#Set-Content -Path "C:\LogiTest\$i-log.txt" -Value "blad krytyczny"
#  } else {
#Set-Content -Path "C:\LogiTest\$i-log.txt" -Value "wszystko OK"
#  }
#}
#foreach ($content in Get-ChildItem -Path "C:\LogiTest\" -ErrorAction SilentlyContinue -Filter *.txt) {
#$filecontent = Get-Content -Path "C:\LogiTest\$content";
#if ($filecontent -like "*blad krytyczny*") {
#Write-Host "
#_________________________________
#| Nazwa pliku: $($content.Name) 
#|--------------------------------
#| Zawartość: $filecontent       
#---------------------------------
#"     
#
#  }
#}


  
#--------------------------------------------------------------------------------------

#Excercise 6L.4
#Write a function KillIfRunning that:
#Accepts one parameter [string] $procName
#Checks if a process with that name is running
#If yes, stops it and outputs a message
#If not, outputs that it was not found

#function KillIfRunning{
#param(
#[string]$procName
#  ) 
#
#$isRunning = Get-Process -Name $procName -ErrorAction SilentlyContinue
#
#if ($isRunning)  {Stop-Process -ProcessName $procName -ErrorAction SilentlyContinue} else {Write-Host "$procName nie został znaleziony"}
#}
#
#KillIfRunning -procName explorer
#KillIfRunning -procName explorerX


#--------------------------------------------------------------------------------------
#Excercise 6L.5
#In the folder C:\TempTasks, create an array of file names (e.g., file1.txt to file5.txt). Write "Task completed" to each file. Then:
#Go through each file
#If it contains "Task", append the line "Confirmed"
#Finally, output the contents of all files

#$filesString = @("test1.txt","test2.txt","test3.txt","test4.txt","test5.txt")
#
#if (Test-Path -Path "C:\TempZadania") {Write-Host "folder istnieje"} else {New-Item -ItemType Directory -Name "TempZadania" -Path "C:\"}
#
#For ($i = 0; $i -lt $filesString.Length; $i++){
#Add-Content -Path C:\TempZadania\$($filesString[$i]) -Value "Zadanie wykonane" -Force
#}
#
#foreach ($file in Get-ChildItem -Path "C:\TempZadania" -Filter *.txt) {
#if ((Get-Content -Path "C:\TempZadania\$file") -join "`n" -like "*Zadanie*") {
#Add-Content -Path C:\TempZadania\$file -Value "Potwierdzono";
#$content = Get-Content -Path "C:\TempZadania\$file" -raw
#Write-Host "Zawartość: $content"
#  }
#}


#--------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------

