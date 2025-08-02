
     
#error_handling

#!------------------------------------------------------------------------------------------------------!
#!                                                Easy                                                  !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!


#Excercise 11.1

#Description: Attempt to read a non-existent file using Get-Content. Catch and print the error message.


<# 
try {
     Get-Content -Path "C:/x/D.txt" -ErrorAction Stop
}
catch {
     Write-Output "Error: $_"
}
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 11.2

#Description: Try dividing a number by zero and catch the exception with a custom message.


<# 
try {
     5 / 0
}
catch [System.Management.Automation.RuntimeException] {
     Write-Output "Error: $_"
}
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 11.3

#Description: Convert "abc" to integer using [int]::Parse(). Catch the error and display "Invalid number".


<# 
try {
     $string = "abc";
     [int]::Parse($string);
}
catch [System.Management.Automation.RuntimeException] {
     Write-Output "Error: $_"
}
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 11.4

#Description: Try accessing C:\Windows\System32\config\SAM. Handle the error and write "Access Denied".


<# 
try {
     Get-Content -Path C:\Windows\System32\config\SAM -ErrorAction Stop 
}
catch [System.IO.IOException] {
     Write-Output "Error: $_"
}
#>


#!------------------------------------------------------------------------------------------------------!

#Excercise 11.5

#Description: Create a script that always prints a message inside the finally block regardless of error.


<# 
try {
     Get-Process | Select-Object -First 10
}
finally {
     Write-Output "Activity complete"
}
 #>


#!------------------------------------------------------------------------------------------------------!



#!------------------------------------------------------------------------------------------------------!
#!                                              Medium                                                  !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!

#Excercise 11.1

#Description: Parse a user input using [int]::Parse() and handle FormatException and general errors differently.


<# 
try {
     $output = Read-Host "Provide text"    
     $intOutput = [int]::Parse($output)
     $intOutput 
}
catch [System.FormatException] {
     Write-Output "Error: $_"
}
 #>

#!------------------------------------------------------------------------------------------------------!

#Excercise 11.2

#Description: Write a function that throws an error if input is negative. Use try/catch to handle it.


<# 
try {
     [int]$output = Read-Host "Provide number above 0"
     if (($output -lt 0)) {
          Write-Error "Provided input is negative: $output" -ErrorAction stop
     }
}
catch {
     Write-Output "Error is negative: $_"
}
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 11.3

#Description: Try reading a missing file, and if it fails, try again after 2 seconds. Max 3 retries.


<# 
$isFile = $false

try {
     
     if (Get-Content "C:/test/file.txt" -ErrorAction SilentlyContinue) {
          Write-Output "Found"
     } 
     else {
          for ($i = 1; $i -le 3; $i++) {
               Start-Sleep -Seconds 2
               Write-Output "$i# - trying to read file"
               Get-Content "C:/test/file.txt" -ErrorAction SilentlyContinue
          }
     }
}
catch {
     Write-Output "Error: $_"
}
 #>



#!------------------------------------------------------------------------------------------------------!

#Excercise 11.4

#Description: Redirect error messages to a log file instead of displaying them on screen.


<# 
$isSuccess

try {
     if (!(Test-Path "C:\Raporty\11_4_logs.txt")) {
          New-Item -ItemType File -Name "11_4_logs.txt" -Path "C:\Raporty\"
     }
     else {
          Write-Output "11_4_logs.txt file has already exist"
     }

     for ($i = 0; $i -lt 5; $i++) {
          if (Get-Content "C:/files/file$i.txt" -ErrorAction stop) {
               $isSuccess = $true
          }
          else {
               $isSuccess = $false
          }
     }
}
catch [System.Management.Automation.ItemNotFoundException] {
     Add-Content -path "C:\Raporty\11_4_logs.txt" -Value "$_"

}
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 11.5

#Description: In the catch block, output the error's Exception.Message, CategoryInfo, and InvocationInfo.


<# 
try {
     Get-Process sadas -ErrorAction stop
}
catch {
     Write-Output "|------------------------"
     Write-Output "|Exception message: $($_.exception)"
     Write-Output "|------------------------"
     Write-Output "|CategoryInfo: $($_.CategoryInfo)"
     Write-Output "|------------------------"
     Write-Output "|InvocationInfo: $($_.InvocationInfo)"
     Write-Output "|------------------------"
}
 #>


#!------------------------------------------------------------------------------------------------------!




#!------------------------------------------------------------------------------------------------------!
#!                                          Integration                                                 !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!

#Excercise 11.1

#Description: Create a hashtable of items with stock counts. Try dividing a number by each count. Use try-catch to avoid divide-by-zero.


<# 
$stock_stats = @{
     Wood  = 12
     Stone = 30
     Water = 0
     Oil   = 3
}

try {
     
     foreach ($object in $stock_stats.Values) {
          100 / [int]$object
          
     } 

}
catch [System.ArithmeticException] {
     Write-Output "Error: $_"
}
 #>



#!------------------------------------------------------------------------------------------------------!

#Excercise 11.2

#Description: Use switch logic to classify numbers. If input is not a number, catch the error and notify the user.

<# 
$input = Read-Host "Provide number"

try {
     switch ([int]$input) {
          { $_ -is [int] } { Write-Output "Number as hell: $_" }
          { $_ -isnot [int] } { Write-Output "$_ is not number!!!" }
     } 
}
catch [System.Management.Automation.MethodInvocationException], [System.Management.Automation.CommandNotFoundException],
[System.Management.Automation.RuntimeException] {
     Write-Output "$_"
}

exit
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 11.3

#Description: Read grades from a CSV. If any grade is not a number, catch the error and log "Invalid data".

<# 
$student = @{}

try {
     $gradesCsv = Import-Csv -Path "C:\Users\Administrator\Downloads\students_full_grades.csv"
     $gradesCsv | ForEach-Object {
          $student["$($_.'First Name')_$($_.'Last Name')"] = [PSCustomObject]@{
               grades = [int]::Parse($_.'Grade 1')
          }
     }
     
     switch ($student.Values.grades) {
          { $_ -isnot [int] } {
               Write-Output "$_ is invalid data"
          }
          Default { Write-Output "$_ is correct data" }
     }
}
catch {
     Write-Output "Error: $_"
}
 #>

#!------------------------------------------------------------------------------------------------------!

#Excercise 11.4

#Description: Read a log file line-by-line. If a line is missing expected parts (e.g., [status]), catch the parsing error.


<# 
try {
     $parseError = New-Object System.Management.Automation.ParseException
     $status = Get-Content -Path "C:\log.txt"
     switch -regex ($status) {
          '^\[status\]\s+(active|inactive)$' { Write-Output "$_ --- sounds good" }
          Default { Write-Error "$_ - $parseError"; continue }
     }
}
catch [System.Web.ParserError] {
     Write-Output "Error: $_"
}

exit
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 11.5

#Description: Build a function that throws if an item is out of stock. Catch the error and append it to an error log file.


$prompt = @(
     "`nProducts offered by market: wood, stone, water, food"
     "`nProvide name of product"
)
$inputUser = Read-Host $prompt
$stocks = @{}

function checkStockAvailability {
     
     param (
          [string]$product
     )
     
     $productsNames = @('wood', 'stone', 'water', 'food');
     


     try {
          for ($i = 0; $i -lt $productsNames.Count; $i++) {

               $stocks[$productsNames[$i]] = @{
                    Count = Get-Random -Minimum 0 -Maximum 10
               }
          }

          switch ($product) {
               { $_ -match $stocks.name } {
                    if ([int]$stocks.Count -ge 1) {
                         Write-Output "$_ count is: $($stocks.$product.count)"
                    }
                    else {
                         Throw "$_ is unavailable, count: $($stocks.$product.count)"
                    }
               }
               Default { Write-Output "We don't offer provided product: $product" }
          }

     }
     catch {
          Write-Output "Error: $_"
     }
}

checkStockAvailability -product $inputUser

exit

#!------------------------------------------------------------------------------------------------------!

