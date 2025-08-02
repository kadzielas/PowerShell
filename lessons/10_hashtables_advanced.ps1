
     
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
Write-Output "Average grade is: $average"
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

Write-Output "Products before VAT update:"
$products
for ($i = 0; $i -lt $products.Count; $i++) {
     $products["Product_ID_$i"].price = $products["Product_ID_$i"].price * 1.23
}
Write-Output "----------------------"
Write-Output "Products before VAT after"
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
Write-Output $script:files
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

Write-Output "--------------------------------------------"


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

Write-Output "--------------------------------------------"
Wri
