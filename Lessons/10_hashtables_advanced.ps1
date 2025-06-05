
     
#hashtables_advanced

#!------------------------------------------------------------------------------------------------------!
#!                                                Easy                                                  !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!


#Excercise 10.1

#Description: Create a hashtable studentGrades where the key is the student’s name and the value is their grade. Calculate and display the average grade.


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





#!------------------------------------------------------------------------------------------------------!

#Excercise 10.3

#Description: Create a nested hashtable orders where each key is an order ID and each value is another hashtable with customerName, totalAmount, and status.
#Display all orders with Pending status only.





#!------------------------------------------------------------------------------------------------------!

#Excercise 10.4

#Description: Read a CSV file with student names and grades. Convert it into a hashtable where each key is a student and the value is an array of their grades.
#Calculate the average for each student.





#!------------------------------------------------------------------------------------------------------!

#Excercise 10.5

#Description: In a hashtable machineData, the key is a machine ID and the value is the number of system errors.
#Use a switch to classify machines into OK (0), Warning (1–5), or Critical (6+).





#!------------------------------------------------------------------------------------------------------!




#!------------------------------------------------------------------------------------------------------!
#!                                          Integration                                                 !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!

#Excercise 10.1

#Description: Use a hashtable to store user logins (username → timestamp).
#Use switch to classify logins as Early (6–9 AM), Regular (9–17), or Late (after 17), and show a report like in Lesson 9.






#!------------------------------------------------------------------------------------------------------!

#Excercise 10.2

#Description: Read a .txt file where each line contains a product and quantity (e.g., Milk,4).
#Convert it into a hashtable and calculate the total quantity of all products.






#!------------------------------------------------------------------------------------------------------!

#Excercise 10.3

#Description: Generate 10 random IPs. Create a hashtable where the key is the IP and the value is its classification (Private, Public) using switch -regex. 
#Sort and display by classification.





#!------------------------------------------------------------------------------------------------------!

#Excercise 10.4

#Description: Create a hashtable fileStats where the key is a filename and the value is another hashtable containing sizeKB and type.
#Group and display files by type using switch.





#!------------------------------------------------------------------------------------------------------!

#Excercise 10.5

#Description: Analyze a log file where each line contains [username] [status].
#Build a hashtable where each key is a username and the value is a count of how many error, warning, or ok statuses they had. Summarize the data.





#!------------------------------------------------------------------------------------------------------!

