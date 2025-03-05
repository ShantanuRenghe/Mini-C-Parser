# Mini C Compiler

## Overview
This project is a **Mini C Compiler** that performs lexical analysis and parsing for C programs. It checks for syntax errors and provides feedback on the correctness of the input C code. The project is implemented using **Lex (Flex) for lexical analysis** and **Yacc (Bison) for parsing**.

## Features
- **Lexical Analysis**  
  - Tokenizes input C code (keywords, identifiers, operators, numbers, etc.).  
  - Detects invalid tokens and lexical errors.  

- **Parsing**  
  - Implements a grammar for C programs using Yacc (Bison).  
  - Checks for syntax errors and reports them.  

- **Error Handling**  
  - Provides meaningful error messages for incorrect syntax.  
  - Ensures structured error reporting for debugging.  

## Files
- `lexer.l` → Lex file for lexical analysis.  
- `parser.y` → Yacc file for syntax analysis.  
- `main.c` → Main driver program for handling input files and running the parser.  

## How to Compile and Run
### 1. Install Dependencies  
Ensure that `Flex` and `Bison` are installed on your system. If not, install them using:  
```bash
sudo apt install flex bison  # For Linux
```
### 2. Compilation Steps
Run the following commands to compile the Mini C Compiler:

```bash
flex lexer.l          # Generates lex.yy.c
bison -d parser.y     # Generates parser.tab.c and parser.tab.h
gcc -o mini_cc lex.yy.c parser.tab.c main.c -ll -ly  # Compile everything
```
### 3. Running the Compiler
Provide a C source file as input:

```bash
./mini_cc sample.c
```

If the input file has valid syntax, the output will be:

```bash
Successfully parsed!
```
Otherwise, it will print the syntax errors.


#### Notes
- The compiler currently checks for lexical and syntax errors, but semantic analysis and code generation are not yet implemented.
- It supports basic C constructs, but some advanced C features might not be included.
- Error messages can be improved for better debugging support.
#### Future Enhancements
- Add semantic analysis for type checking.
- Implement intermediate code generation.
- Improve error handling and reporting.
