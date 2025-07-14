
     
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
     Write-Host "Error: $_"
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
     Write-Host "Error: $_"
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
     Write-Host "Error: $_"
}
 #>


#!------------------------------------------------------------------------------------------------------!

#Excercise 11.4

#Description: Try accessing C:\Windows\System32\config\SAM. Handle the error and write "Access Denied".






#!------------------------------------------------------------------------------------------------------!

#Excercise 11.5

#Description: Create a script that always prints a message inside the finally block regardless of error.






#!------------------------------------------------------------------------------------------------------!



#!------------------------------------------------------------------------------------------------------!
#!                                              Medium                                                  !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!

#Excercise 11.1

#Description: Parse a user input using [int]::Parse() and handle FormatException and general errors differently.






#!------------------------------------------------------------------------------------------------------!

#Excercise 11.2

#Description: Write a function that throws an error if input is negative. Use try/catch to handle it.





#!------------------------------------------------------------------------------------------------------!

#Excercise 11.3

#Description: Try reading a missing file, and if it fails, try again after 2 seconds. Max 3 retries.





#!------------------------------------------------------------------------------------------------------!

#Excercise 11.4

#Description: Redirect error messages to a log file instead of displaying them on screen.





#!------------------------------------------------------------------------------------------------------!

#Excercise 11.5

#Description: In the catch block, output the error's Exception.Message, CategoryInfo, and InvocationInfo.





#!------------------------------------------------------------------------------------------------------!




#!------------------------------------------------------------------------------------------------------!
#!                                          Integration                                                 !
#!------------------------------------------------------------------------------------------------------!

#!------------------------------------------------------------------------------------------------------!

#Excercise 11.1

#Description: Create a hashtable of items with stock counts. Try dividing a number by each count. Use try-catch to avoid divide-by-zero.






#!------------------------------------------------------------------------------------------------------!

#Excercise 11.2

#Description: Use switch logic to classify numbers. If input is not a number, catch the error and notify the user.






#!------------------------------------------------------------------------------------------------------!

#Excercise 11.3

#Description: Read grades from a CSV. If any grade is not a number, catch the error and log "Invalid data".





#!------------------------------------------------------------------------------------------------------!

#Excercise 11.4

#Description: Read a log file line-by-line. If a line is missing expected parts (e.g., [status]), catch the parsing error.





#!------------------------------------------------------------------------------------------------------!

#Excercise 11.5

#Description: Build a function that throws if an item is out of stock. Catch the error and append it to an error log file.





#!------------------------------------------------------------------------------------------------------!

