
     
#hashtables_advanced

#!------------------------------------------------------------------------------------------------------!
#!                                                Easy                                                  !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!


#Excercise 10.1

#Description: Create a hashtable studentGrades where the key is the student's name and the value is their grade. Calculate and display the average grade.


<# 
[string[]]$script:names = @("rik", "mig", "alex", "ara", "yak", "xax");
[int[]]$grades = @(1, 2, 3, 4, 5, 6);


[hashtable]$studentInfo = @{};

for ($i = 0; $i -lt 10; $i++) {


     $studentInfo["ID_$i"] = [PSCustomObject]@{
          Name   = Get-Random $script:names
          Grades = @(Get-Random -InputObject $grades -Count 3)
     }  
}

$totalGrades = 0;
$totalCount = 0

foreach ($student in $studentInfo.Values) {
     foreach ($grade in $student.Grades) {
          $totalGrades += $grade
          $totalCount++
     }
}

$average = [math]::Round(($totalGrades / $totalCount), 1)
Write-Host "Average grade is: $average"
 #>

 

#!------------------------------------------------------------------------------------------------------!

#Excercise 10.2

#Description: Create a hashtable where the key is the product name and the value is the base price. Add 23% VAT to each product and display the updated prices.

<# 
$names = @("milk", "water", "tea");
$products = [ordered]@{};


for ($i = 0; $i -lt 3; $i++) {
     $products["Product_ID_$i"] = [PSCustomObject]@{
          Name  = $names[$i]
          Price = [System.Math]::Round((Get-Random -Maximum 7 -Minimum 1), 2)
     }
}

Write-Host "Products before VAT update:"
$products
for ($i = 0; $i -lt $products.Count; $i++) {
     $products["Product_ID_$i"].price = $products["Product_ID_$i"].price * 1.23
}
Write-Host "----------------------"
Write-Host "Products before VAT after"
$products
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 10.3

#Description: Create a hashtable fileTypes where keys are file extensions (e.g., .txt, .jpg) and values are file categories (e.g., Text, Image).
#Write a function that takes a filename and returns its type.



<# 
$script:files = @{};

$script:selectedFile = Read-Host "Provide file name"
$script:selectedFileExtension = [System.IO.Path]::GetExtension($script:selectedFile);

switch -regex ($script:selectedFileExtension) {
    ".txt" { $script:files[$script:selectedFileExtension] = "Text file" }
    ".jpg" { $script:files[$script:selectedFileExtension] = "Image file" }
    ".mp4" { $script:files[$script:selectedFileExtension] = "Video file" }
    ".log" { $script:files[$script:selectedFileExtension] = "System file" }
    default { $script:files[$script:selectedFileExtension] = "Out of scope" }
}
Write-Host $script:files
 #>



#!------------------------------------------------------------------------------------------------------!

#Excercise 10.4

#Description: Create a hashtable projectTasks with task names as keys and statuses as values (Pending, In Progress, Done).
#Use switch to count how many tasks are in each category.

<# 
$projectTasks = @{};
$status = @("pending", "in progress", "done");
$tasks = @("create documents", "format documents", "check validation", "updating documents");
$counts = @(0, 0, 0);

Write-Host "--------------------------------------------"


for ($i = 0; $i -lt $tasks.Count; $i++) {
     $projectTasks["ID.$i"] = [PSCustomObject]@{
          Name   = $tasks[$i]
          Status = (Get-Random $status)
     }
}
$projectTasks
for ($i = 0; $i -lt $projectTasks.Keys.Count; $i++) {
     switch ($projectTasks["ID.$i"].status) {
          $status[0] { $counts[0]++ }
          $status[1] { $counts[1]++ }
          $status[2] { $counts[2]++ }
     }
}

Write-Host "--------------------------------------------"
Write-Host "Pending count: $($counts[0])" 
Write-Host "In progress count: $($counts[1])"
Write-Host "Done count: $($counts[2])"
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 10.5

#Description: Create a hashtable employeeShifts with employee names as keys and shift types (Morning, Evening, Night) as values.
#Count how many employees work each shift.


<# 
$employeeShifts = [ordered]@{};
$names = @("adam", "adrian", "bogusz");
$shifts = @{
     Morning = 0
     Evening = 0
     Night   = 0
}
$customViewEmployee = @{};

for ($i = 0; $i -lt $names.Count; $i++) {
     $employeeShifts["ID_employee.$i"] = [PSCustomObject]@{
          Name  = $names[$i]
          Shift = ($shifts.Keys | Get-Random);
          Age   = (Get-Random -Minimum 18 -Maximum 65)
     }
}


for ($i = 0; $i -lt $employeeShifts.Keys.Count; $i++) {
     
     switch ($employeeShifts["ID_employee.$i"].Shift) {
          'Morning' { $shifts.Morning++ }
          'Evening' { $shifts.Evening++ }
          'Night' { $shifts.Night++ }
     }
}

foreach ($employee in $employeeShifts.Keys) {
     $customViewEmployee[$employee] = [PSCustomObject]@{
          Name  = $employeeShifts[$employee].name
          Shift = $employeeShifts[$employee].shift
          Age   = $employeeShifts[$employee].Age
          
     }
}

$customViewEmployee = $customViewEmployee.GetEnumerator() | Format-Table Name, Value -AutoSize | Out-String

Write-Host
"
Employees information:

$customViewEmployee
------------------------
Shifts statistics:
$($shifts | Out-String)
"
 #>


#!------------------------------------------------------------------------------------------------------!



#!------------------------------------------------------------------------------------------------------!
#!                                              Medium                                                  !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!

#Excercise 10.1

#Description: Create a hashtable where the key is a department name and the value is an array of employee names.
#Display all departments and how many employees work in each.


<# 
$script:names = @('adam', 'eric', 'riki', 'bucz', 'meeko', 'dudu');
$script:departments = @('IT', 'HR', 'Logistics', 'Administration', 'Security');
$script:company = @{};
$script:count = 0;

for ($i = 0; $i -lt $script:departments.Length; $i++) {
     
     $script:company[($script:departments[$i])] = @{
          
          employees = Get-Random -InputObject $script:names -Count (Get-Random -Minimum 1 -Maximum 4)
     };

}

foreach ($departament in $script:company.Keys) {

     Write-Host "`nDepartment: $departament"

     foreach ($employee in $script:company[$departament].Values) {
          Write-Host "Staff: $employee"
          
          Write-Host "count: $($script:company[$departament].employees.Count)"
          
     }
}
 #>



#!------------------------------------------------------------------------------------------------------!

#Excercise 10.2

#Description: Create a hashtable warehouseStock with product names as keys and quantity as values.
#Increase stock for any product with quantity below 50 by 10%.



<# 
[hashtable]$script:warehouseStock = @{};
$script:productsNames = @('water', 'milk', 'oil', 'wine', 'cola');

for ($i = 0; $i -lt $script:productsNames.Length; $i++) {
     $script:warehouseStock[$script:productsNames[$i]] = @{
          quantity = Get-Random -Minimum 30 -Maximum 70
     }
     
}

foreach ($product in $script:warehouseStock.Keys) {
     if ($script:warehouseStock[$product].quantity -lt 50) {
          $script:warehouseStock[$product].quantity = [System.Math]::Round($script:warehouseStock[$product].quantity * 1.1, 0)
          
     }
     Write-Host "`nProduct name: $product `n Quantity: $($script:warehouseStock[$product].quantity)"
}
 #>




#!------------------------------------------------------------------------------------------------------!

#Excercise 10.3

#Description: Create a nested hashtable orders where each key is an order ID and each value is another hashtable with customerName, totalAmount, and status.
#Display all orders with Pending status only.


<# 
$private:customerNames = @('Frankie', 'Jimmy', 'Angela', 'Poly', 'Riki');
$private:order = @{};
enum Status {
     InProgress
     Pending
     Finished
}

for ($i = 0; $i -lt $private:customerNames.Count; $i++) {
     $getStatus = [enum]::GetValues([Status])
     $status = Get-Random -InputObject $getStatus
     $amount = Get-Random -Minimum 10 -Maximum 30
     $orderID = Get-Random -Minimum 100 -Maximum 150
     $private:order["$($orderID)_order"] = [PSCustomObject]@{
          customerName = $private:customerNames[$i]
          totalAmount  = $amount
          status       = $status
     }
    
}


foreach ($key in $private:order.Keys) {
     
     switch ($private:order[$key].status) {
          "Pending" {
               Write-Host ("Customer name: $($private:order[$key].customerName)`nAmount: $($private:order[$key].totalAmount)`nStatus: $($private:order[$key].status)`n--------")
          }
     }
}
 #> 

    


#!------------------------------------------------------------------------------------------------------!

#Excercise 10.4

#Description: Read a CSV file with student names and grades. Convert it into a hashtable where each key is a student and the value is an array of their grades.
#Calculate the average for each student.


<# 
$students = @{};
$file = Get-ChildItem -File C:\Users\Administrator\Downloads\students_full_grades.csv
$header = @('firstname', 'lastname', 'grades1', 'grades2', 'grades3', 'grades4')
$csv = Import-Csv $file -Header $header

for ($i = 0; $i -lt $csv.Count; $i++) {
     [int]$ID = Get-Random -Minimum 130 -Maximum 760
     [int[]]$grades = @($csv[$i].grades1, $csv[$i].grades2, $csv[$i].grades3, $csv[$i].grades4)
     $average = ($grades | Measure-Object -Average).Average
    
     $students["$($ID)_$($csv[$i].lastname)"] = @{
          Grades  = $grades
          Average = $average
     }
}


foreach ($object in $students.GetEnumerator()) {
     "$($object.key) avarage grades is $($object.Value.Average)"
}

exit
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 10.5

#Description: In a hashtable machineData, the key is a machine ID and the value is the number of system errors.
#Use a switch to classify machines into OK (0), Warning (1-5), or Critical (6+).


<# 
$machineData = @{};

for ($i = 0; $i -lt 10; $i++) {
     $ID = Get-Random -Minimum 20 -Maximum 99
     $errors = Get-Random -Minimum 0 -Maximum 10

     $machineData[$ID] = @{
          errorsCount = $errors    
     }
}
     
foreach ($machine in $machineData) {
     
     switch ($machine.Values.errorsCount.GetEnumerator()) {
          0 { Write-Host "$($_) - OK" }
          { $_ -ge 1 -and $_ -lt 6 } { Write-Host "$($_)- Warning" }
          { $_ -ge 6 } { Write-Host "$($_) - Critical" }
     }
}

exit
 #>



#!------------------------------------------------------------------------------------------------------!




#!------------------------------------------------------------------------------------------------------!
#!                                          Integration                                                 !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!

#Excercise 10.1

#Description: Use a hashtable to store user logins (username - timestamp).
#Use switch to classify logins as Early (6-9 AM), Regular (9-17), or Late (after 17).



<# 
$logins = @{};

for ($i = 0; $i -lt 10; $i++) {
     $ID = Get-Random -Minimum 10 -Maximum 50
     $username = "user$ID"
     $x = Get-Random -Minimum 1 -Maximum 24

     $logins[$ID] = @{
          username  = $username;
          loginTime = (Get-Date).AddDays(-$x).AddHours( + ($x * 2)).AddMinutes( - ($x * 17)).AddSeconds( + ($x * 3));
     }
}

foreach ($login in $logins) {

     
     switch ($login.Values.loginTime.Hour) {
          { $_ -ge 6 -and $_ -lt 10 } { Write-Host "$_ has classified as Early" }
          { $_ -gt 10 -and $_ -lt 18 } { Write-Host "$_ has classified as Regular" }
          { $_ -gt 18 -and $_ -lt 24 } { Write-Host "$_ has classified as Late" }
          { $_ -gt 00 -and $_ -lt 5 } { Write-Host "$_ has classified as Late" }
          default { }
          
     }
}

exit
 #>



#!------------------------------------------------------------------------------------------------------!

#Excercise 10.2

#Description: Read a .txt file where each line contains a product and quantity (e.g., Milk,4).
#Convert it into a hashtable and calculate the total quantity of all products.

<#      
$lines = Get-Content '.\products.txt'
$products = @{}
foreach ($line in $lines) {
     $name, $qty = $line -split ','
     $name = $name.Trim()
     $qty = [int]$qty
     if ($products.ContainsKey($name)) {
          $products[$name] += $qty
     }
     else {
          $products[$name] = $qty
     }
}
$products.GetEnumerator() | ForEach-Object { "{0,-10} : {1,3}" -f $_.Key, $_.Value }
$total = ($products.Values | Measure-Object -Sum).Sum
Write-Host "`nTotal quantity of all products: $total"
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 10.3

#Description: Generate 10 random IPs. Create a hashtable where the key is the IP and the value is its classification (Private, Public) using switch -regex. 
#Sort and display by classification.

<# 
$ips = 1..10 | ForEach-Object {
     "{0}.{1}.{2}.{3}" -f (Get-Random -Minimum 1 -Maximum 255),
     (Get-Random -Minimum 0 -Maximum 255),
     (Get-Random -Minimum 0 -Maximum 255),
     (Get-Random -Minimum 1 -Maximum 255)
}
$ipTable = @{}
foreach ($ip in $ips) {
     $class = switch -Regex ($ip) {
          '^10\.' { 'Private (10.0.0.0/8)'; break }
          '^192\.168\.' { 'Private (192.168.0.0/16)'; break }
          '^172\.(1[6-9]|2[0-9]|3[0-1])\.' { 'Private (172.16.0.0/12)'; break }
          default { 'Public' }
     }
     $ipTable[$ip] = $class
}
$ipTable.GetEnumerator() |
Sort-Object Value, Key |
Format-Table @{n = 'IP'; e = { $_.Key } }, @{n = 'Classification'; e = { $_.Value } } -AutoSize
 #>

#!------------------------------------------------------------------------------------------------------!

#Excercise 10.4

#Description: Create a hashtable fileStats where the key is a filename and the value is another hashtable containing sizeKB and type.
#Group and display files by type using switch.

<# 
$fileStats = @{}
Get-ChildItem -File | ForEach-Object {
     $ext = $_.Extension.ToLower()
     $type = switch -Wildcard ($ext) {
          '.txt' { 'Text'   ; break }
          '.log' { 'Log'    ; break }
          '.ps1' { 'Script' ; break }
          '.jpg' { 'Image'  ; break }
          default { 'Other' }
     }
     $fileStats[$_.Name] = @{
          sizeKB = [math]::Round($_.Length / 1KB, 2)
          type   = $type
     }
}
$fileStats.GetEnumerator() |
Group-Object { $_.Value.type } |
ForEach-Object {
     Write-Host "`nType: $($_.Name)"
     $_.Group | ForEach-Object { "{0,-20} {1,8} KB" -f $_.Key, $_.Value.sizeKB }
}
 #>

#!------------------------------------------------------------------------------------------------------!

#Excercise 10.5

#Description: Analyze a log file where each line contains [username] [status].
#Build a hashtable where each key is a username and the value is a count of how many error, warning, or ok statuses they had. Summarize the data.

<# 
$lines = Get-Content '.\activity.log'
$userStats = @{}
foreach ($line in $lines) {
     $user, $status = $line -split '\s+', 2
     if (-not $userStats.ContainsKey($user)) {
          $userStats[$user] = @{ Error = 0; Warning = 0; OK = 0 }
     }
     switch ($status.ToLower()) {
          'error' { $userStats[$user].Error++ }
          'warning' { $userStats[$user].Warning++ }
          default { $userStats[$user].OK++ }
     }
}
$userStats.GetEnumerator() | ForEach-Object {
     $u = $_.Key; $c = $_.Value
     "{0,-10} Errors={1,2}   Warnings={2,2}   OK={3,2}" -f $u, $c.Error, $c.Warning, $c.OK
}
 #>

#!------------------------------------------------------------------------------------------------------!