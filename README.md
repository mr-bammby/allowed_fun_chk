# Allowed function checker

Shell script checking if compailed project includes any forbbiden function.

## INPUT

Argument 1: Program name(including path if not in the same file)

Standard input with list of allowed functions in format

fun1
fun2
...

## OUTPUT

On standard output in format:

ALLOWED FUNCTIONS:
fun1
fun2
...

FOUND FUNCTIONS:
fun2
fun3
...

FORBBIDEN FUNCTIONS:
fun3
...

## USECASE

>cat < input.txt
malloc
free
>shell allowd_fun_chk.sh tested_program.out < input.txt
ALLOWED FUNCTIONS:
malloc
free

FOUND FUNCTIONS:
malloc
strlen

FORBBIDEN FUNCTIONS:
srelen
