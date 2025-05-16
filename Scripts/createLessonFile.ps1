[int]$number = $null;
[string]$topic = $null;
[string]$fileName = $null;
[string]$filePath = "C:\Users\Administrator\Desktop\GITHUB_PowerShell\GPT_lessons\"

$number = Read-Host "Provide number of current lesson"
$topic = Read-Host "Provide topic of current lesson"
$fileName = "$number`_$topic.ps1"

$content = @"

     
     #$topic

#!------------------------------------------------------------!
#!                            Easy                            !
#!------------------------------------------------------------!
#Excercise $($number).1

#Description: 




#!------------------------------------------------------------!
#Excercise $number.2

#Description: 




#!------------------------------------------------------------!
#Excercise $number.3

#Description: 




#!------------------------------------------------------------!
#Excercise $number.4

#Description: 



#!------------------------------------------------------------!
#Excercise $number.5

#Description: 



#!------------------------------------------------------------!
#!                            Medium                          !
#!------------------------------------------------------------!
#Excercise $number.1

#Description: 

#!------------------------------------------------------------!
#Excercise $number.2

#Description: 

#!------------------------------------------------------------!
#Excercise $number.3

#Description: 

#!------------------------------------------------------------!
#Excercise $number.4

#Description: 

#!------------------------------------------------------------!
#Excercise $number.5

#Description: 



#!------------------------------------------------------------!
#!                            Mixed                           ! 
#!------------------------------------------------------------!
#Excercise $number.1

#Description: 



#!------------------------------------------------------------!
#Excercise $number.2

#Description: 



#!------------------------------------------------------------!
#Excercise $number.3

#Description: 



#!------------------------------------------------------------!
#Excercise $number.4

#Description: 



#!------------------------------------------------------------!
#Excercise $number.5

#Description: 



#!------------------------------------------------------------!

"@


if ( -not (Test-Path -Path $filePath$fileName)) {
New-Item -ItemType File -Path $filePath -Name "$fileName"
} else {
Write-Host
}

if ([String]::IsNullOrWhiteSpace((Get-Content $filePath$fileName -Raw))) {
Set-Content -Path $filePath$fileName -Value $content | Out-Null;

Write-Host 
"
File name: $fileName
Lesson topic: $topic

Has been created successfully
"
} else {
Write-Host "The file: $fileName, is not empty." 
}

PowerShell_Ise.exe -file $filePath$fileName