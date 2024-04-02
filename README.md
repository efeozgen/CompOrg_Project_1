This repository is for solution of 4 differnet problems with algorithms made by using Mips.

Here are the explanations and sample cases of problems:

**Question 1.**

A special sequence of numbers is defined using the following equation,
f(x) = a* f(x-1) + b * f(x-2) – 2, where a and b are coefficients.
As an example, if a = 6, b = 1 and the first two numbers of the sequence are 0 and 1 (x0 = 0, x1 = 1),
then the sequence is “0, 1, 4, 23, 140, 861 …”
Write a MIPS procedure that calculates nth number of this sequence. The program requires five
integers as input: a, b, x0, x1 and n. Then, it calculates the sequence using the given equation until
finds the nth element. Finally, the program prints the result to the screen. Note that n must be
greater than 1; if the value of n is smaller than 1, the program asks the user to enter a number that
is greater than 1.

**Example Run:**

Please enter the coefficients: 2 1

Please enter first two numbers of the sequence: 1 2

Enter the number you want to calculate (it must be greater than 1): 4

**Output:** 4th element of the sequence is 6.

**Question 2:** 

Write a MIPS procedure that switch the elements of an integer array. The procedure takes an integer
array as input, examines if adjacent elements are coprime to each other. Two integers are coprime,
if the only positive integer that is a divisor of both of them is 1. If the adjacent number is coprime,
procedure move to the next pair for examination. Otherwise, the two number is removed from the
array and their least common factor is included to the array. Your MIPS code must print the updated
array.

**Example Run 1:**

**Input:** “6 4 3 2 7 13”

**Output:** “The new array is: 12 7 13”

**Explanation for the example (Note that the following line summarizes the steps of the execution; it
is not the output).**

6 4 3 2 7 13 -> 12 3 2 7 13 -> 12 2 7 13 -> 12 7 13 -> 12 7 13

**Example Run 2:**

**Input:** “25 2 3 9 6 4 5”

**Output:** “The new array is: 25 36 5”

**Explanation for the example:**
25 2 3 9 6 4 5-> 25 2 3 9 6 4 5-> 25 2 3 9 6 4 5-> 25 2 9 6 4 5->25 2 18 4 5->25 18 4 5->25 36 5

**Question 3:**

Write a MIPS procedure that recursively shuffles the given string. The program takes two inputs: a
string array to be shuffled and an integer that represents how many times the shuffle operation is
performed. Initially, the string is divided into two substrings and their positions are swapped. The
division and swapping operation are performed recursively to substrings. The program finished its
execution when it reaches the level n provided by user. Finally, the shuffled string is printed to the
screen. Assume that the number of the characters in the input are power of two; there is no need
to implement additional error checking.

**Example Run:**

**Input:** “Computer”
3

**Output:** “retupmoC”

**Explanation of the example:** Note that the following line summarizes the steps of the execution; it
is not the output.

Computer
uterComp
erutmpCo
retupmoC

**Question 4:**

In a matrix containing only 1s and 0s, the island pattern is defined as a connected set of 1s where
the set of 1s are surrounded by either edge of the matrix or 0s. The cells are considered connected
if they are horizontally or vertically adjacent.Diagonal case is not considered.
Write a MIPS program to determine the largest island of the matrix stored in the memory. In your
program, it will read the memory from the .data segment, where the first two integers represent
the number of rows and columns, respectively. The program prints the matrix stored in the memory
and the number of 1s in the largest island.

**Memory at the beginning of the execution**

.data
matrix: .byte 5, 6, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0,
1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0

**Example Run:**

**Output**
0 0 0 1 1 1
1 1 0 0 1 1
0 1 0 0 1 1
0 0 1 0 1 1
1 0 1 0 1 0

The number of the 1s on the largest island is 10.
