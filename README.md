# EvaluateEquations
This codes aim to evaluate a set of equations, each specified on separate line. An equation is defined by:

<LHS> = <RHS>

<LHS> is the left-hand side of the equation and is always a variable name. A variable name can only be composed of letters from the alphabet(e.g. for which Character.isLetterOrDigit(c) == true).

<RHS> is the right hand side of the equation and can be composed of variables, unsigned integers, and the + operator.

Here is one example set of equations:

offset = 4 + destination +1
location = 1 + origin + offset
origin = 3 + 5
destination = 2

The output should sorted by in ascending order by variable name. THe output for the example above would be:

location = 16
offset = 7
origin = 8
destination = 2
