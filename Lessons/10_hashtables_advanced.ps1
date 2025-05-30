
     
#hashtables_advanced

#!------------------------------------------------------------------------------------------------------!
#!                                                Easy                                                  !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!


#Excercise 10.1

#Description: Create a hashtable studentGrades where the key is the student’s name and the value is their grade. Calculate and display the average grade.

[string[]]$script:names = @("rik", "mig", "alex", "ara", "yak", "xax");
[int[]]$grades = @(1, 2, 3, 4, 5, 6);


[hashtable]$studentInfo = [PSCustomObject]@{};

for ($i = 0; $i -lt 10; $i++) {


     $studentInfo["ID_$i"] = [PSCustomObject]@{
          Name   = Get-Random $script:names
          Grades = Get-Random -InputObject $grades
     }  
}

$studentInfo | ForEach-Object {
     $_.values.Grades
}





#!------------------------------------------------------------------------------------------------------!

#Excercise 10.2

#Description: Create a hashtable where the key is the product name and the value is the base price. Add 23% VAT to each product and display the updated prices.






#!------------------------------------------------------------------------------------------------------!

#Excercise 10.3

#Description: Create a hashtable fileTypes where keys are file extensions (e.g., .txt, .jpg) and values are file categories (e.g., Text, Image).
#Write a function that takes a filename and returns its type.






#!------------------------------------------------------------------------------------------------------!

#Excercise 10.4

#Description: Create a hashtable projectTasks with task names as keys and statuses as values (Pending, In Progress, Done).
#Use switch to count how many tasks are in each category.






#!------------------------------------------------------------------------------------------------------!

#Excercise 10.5

#Description: Create a hashtable employeeShifts with employee names as keys and shift types (Morning, Evening, Night) as values.
#Count how many employees work each shift.






#!------------------------------------------------------------------------------------------------------!



#!------------------------------------------------------------------------------------------------------!
#!                                              Medium                                                  !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!

#Excercise 10.1

#Description: Create a hashtable where the key is a department name and the value is an array of employee names.
#Display all departments and how many employees work in each.






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

