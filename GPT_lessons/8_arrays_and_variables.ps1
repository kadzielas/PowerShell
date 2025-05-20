
     
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

#!------------------------------------------------------------!
#Excercise 8.2

#Description: Create a script that: Prompts the user for 5 words. Adds them to a string array. Displays the array sorted alphabetically.

#!------------------------------------------------------------!
#Excercise 8.3

#Description: Create a mixed array (integers, strings, and booleans) and: Loop through it. Count how many items are of type [int].

#!------------------------------------------------------------!
#Excercise 8.4

#Description: Create an array of numbers and calculate the sum of its elements using a foreach loop (without Measure-Object).

#!------------------------------------------------------------!
#Excercise 8.5

#Description: Create two arrays of equal length with numbers. Write a loop that multiplies elements with the same index. Store the results in a third array. Print the final array.



#!------------------------------------------------------------!



#!------------------------------------------------------------!
#!                            Integration                     ! 
#!------------------------------------------------------------!

#Excercise 8.1

#Description: 



#!------------------------------------------------------------!
#Excercise 8.2

#Description: 



#!------------------------------------------------------------!
#Excercise 8.3

#Description: 



#!------------------------------------------------------------!
#Excercise 8.4

#Description: 



#!------------------------------------------------------------!
#Excercise 8.5

#Description: 



#!------------------------------------------------------------!

