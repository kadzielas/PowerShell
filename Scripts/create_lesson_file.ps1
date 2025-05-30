﻿#------------------------------------------------------------------------------------------
#Description: Function to automate creation lesson file.
#------------------------------------------------------------------------------------------


[int]$script:number = 0;
[string]$script:topic = "";
[string]$script:fileName = "";
[string]$script:filePath = "C:\Users\Administrator\Desktop\GITHUB_PowerShell\Lessons\"

$script:number = Read-Host "Provide number of current lesson"
$script:topic = Read-Host "Provide topic of current lesson"
$script:fileName = "$number`_$topic.ps1"

$script:content = @"

     
     #$script:topic

#!------------------------------------------------------------------------------------------------------!
#!                                                Easy                                                  !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!


#Excercise $script:number.1

#Description: 






#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.2

#Description: 






#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.3

#Description: 






#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.4

#Description: 






#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.5

#Description: 






#!------------------------------------------------------------------------------------------------------!



#!------------------------------------------------------------------------------------------------------!
#!                                              Medium                                                  !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.1

#Description: 






#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.2

#Description: 





#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.3

#Description: 





#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.4

#Description: 





#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.5

#Description: 





#!------------------------------------------------------------------------------------------------------!




#!------------------------------------------------------------------------------------------------------!
#!                                          Integration                                                 !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.1

#Description: 






#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.2

#Description: 






#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.3

#Description: 





#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.4

#Description: 





#!------------------------------------------------------------------------------------------------------!

#Excercise $script:number.5

#Description: 





#!------------------------------------------------------------------------------------------------------!

"@


if ( -not (Test-Path -Path $script:filePath$fileName)) {
     New-Item -ItemType File -Path $script:filePath -Name "$fileName"
}
else {
     Write-Host
}

if ([String]::IsNullOrWhiteSpace((Get-Content $script:filePath$fileName -Raw))) {
     Set-Content -Path $script:filePath$fileName -Value $script:content | Out-Null;

     Write-Host 
     "
File name: $script:fileName
Lesson topic: $script:topic

Has been created successfully
"
}
else {
     Write-Host "The file: $script:fileName, is not empty." 
}

PowerShell_Ise.exe -file $script:filePath$fileName