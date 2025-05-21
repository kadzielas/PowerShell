
     
     #arrays_and_variables

#!------------------------------------------------------------!
#!                            Easy                            !
#!------------------------------------------------------------!

#Excercise 8.1

#Description: Create an array of 5 integers and print each one using a loop.

<#
$intarray = @(1,2,3,4,5)

foreach ($x in $intarray){
$x
}
#>

#!------------------------------------------------------------!
#Excercise 8.2

#Description: Create a string array containing three names. Display the second name.

<#
$stringarray = $('one', 'two', 'three')

$stringarray[1]
#>

#!------------------------------------------------------------!
#Excercise 8.3

#Description: Create a variable $age with value 25. Increase it by 5 and print the result.

<#
$age = 25;

for ($i = $age; $i -lt 40; $i += 5) {
$i
}
#>


#!------------------------------------------------------------!
#Excercise 8.4

#Description: Create an array of mixed data types: a string, an integer, and a boolean. Print the data type of each item.

<#
$mixedarray = @('text', 2, $true) 

$mixedarray | ForEach-Object {
$_.GetType()
}
#>

#!------------------------------------------------------------!
#Excercise 8.5

#Description: Create an empty array and add the numbers 10, 20, and 30 using +=.

<#
$emptyarray = @()
$ints = @(10,20,30)

$ints | ForEach-Object {
$emptyarray += $_
}
$emptyarray
#>


#!------------------------------------------------------------!



#!------------------------------------------------------------!
#!                            Medium                          !
#!------------------------------------------------------------!

#Excercise 8.1

#Description: Create a function that accepts an array of numbers as input and returns a new array containing only even numbers.



<#
function evenNumbersCheck {
[CmdletBinding()]
param(
[Param(Man)]
[ValidateRange(1,100)]
[int[]]$numbers
)
$numbers | ForEach-Object {

if ($_ % 2 -eq 0) {
    return $_
    }
}

}

$testnumbers = @(1,3,6,7,10,55)

evenNumbersCheck $testnumbers
#>



#!------------------------------------------------------------!
#Excercise 8.2

#Description: Create a script that: Prompts the user for 5 words. Adds them to a string array. Displays the array sorted alphabetically.



<#
[string[]]$stringarray;

function sortStringArray {
[CmdletBinding()]
param (
[Parameter(ValueFromPipeline)]
[ValidateLength(1,20)]
[string[]]$stringToArray
)

for ($i = 0; $i -lt 5; $i++){
$userOutput = Read-Host "Provide $($i+1)`st word"
$stringToArray += $userOutput
}


$stringToArray | Sort-Object
}

sortStringArray

#>



#!------------------------------------------------------------!
#Excercise 8.3

#Description: Create a mixed array (integers, strings, and booleans) and: Loop through it. Count how many items are of type [int].


<#
$mixedarray = @("string", 32, $true, 65, 12);
[int]$countofINTS = 0;


for ($i = 0; $i -lt $mixedarray.Length; $i++){
    if ($mixedarray[$i].GetType() -like "*int*"){
    $countofINTS++;
    } 
}

Write-Host "INT count: $countofINTS"
#>



#!------------------------------------------------------------!
#Excercise 8.4

#Description: Create an array of numbers and calculate the sum of its elements using a foreach loop (without Measure-Object).


<#
$arrayNumbers = @(12,43,65,21,2)
[int]$totalx = 0;
foreach ($x in $arrayNumbers) {
Write-Host "$totalx before"
$totalx += $x;
}

$totalx
#>


#!------------------------------------------------------------!
#Excercise 8.5

#Description: Create two arrays of equal length with numbers. Write a loop that multiplies elements with the same index. Store the results in a third array. Print the final array.


<#
$arrayOne = @(1,6,12,54);
$arrayTwo = @(4,6,15,87);
$arrayThree = @();

for ($i = 0; $i -lt $arrayOne.Length; $i++){
    $total = $arrayOne[$i] * $arrayTwo[$i]
    $i
    $arrayThree += $total;
}

$arrayThree
#>


#!------------------------------------------------------------!



#!------------------------------------------------------------!
#!                            Integration                     ! 
#!------------------------------------------------------------!

#Excercise 8.1

#Description: Create a function that takes a string array of file names and creates empty .txt files with those names in C:\GeneratedFiles. After creation, return how many files were created.



#!------------------------------------------------------------!
#Excercise 8.2

#Description: Generate an array of all services whose names contain the word "Windows". Store their names in a string array, then use a loop to write each name to a file called windows_services.txt in C:\Logs.



#!------------------------------------------------------------!
#Excercise 8.3

#Description: Create two integer arrays of equal length. Write a script that multiplies elements at the same index and logs only the results greater than 100 to C:\Results\high_products.txt, including the index.



#!------------------------------------------------------------!
#Excercise 8.4

#Description: Create a function that takes an array of process names. For each name, check if the process is running. If it is, stop the process and store its name in an array. Finally, display the array of successfully stopped processes.



#!------------------------------------------------------------!
#Excercise 8.5

#Description: Write a script that takes all environment variables whose names start with the letter P, stores them in an array of custom objects with fields: VariableName, ValueLength, and IsPathRelated (true if the name contains "path"). Output the array sorted by ValueLength descending.



#!------------------------------------------------------------!

