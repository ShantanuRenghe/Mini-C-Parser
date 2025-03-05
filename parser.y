%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yylex();
    void yyerror(const char* s);
%}

%token HASH INCLUDE DEFINE DOT HEADER_TYPE STRING
%token INT VOID IF ELSE MAIN RETURN
%token PLUS MINUS MULTIPLY DIVIDE MODULO ASSIGN
%token EQUAL GTEQ GT LTEQ LT
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON COMMA
%token IDENTIFIER NUMBER

%left MINUS PLUS
%left MULTIPLY DIVIDE MODULO

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%start program

%%

program : pp_directives units main_function units
        | 
        ;

pp_directives : pp_directives pp_include
              | pp_directives pp_define
              |
              ;

pp_include : HASH INCLUDE LT header GT
           | HASH INCLUDE STRING
           ;

header : IDENTIFIER DOT HEADER_TYPE
       ;

pp_define : HASH DEFINE IDENTIFIER NUMBER
          ;

units : units unit
      |
      ;

unit : function
     ;
     
main_function : ret_type MAIN LPAREN RPAREN LBRACE statements RBRACE
              ;

function : ret_type IDENTIFIER LPAREN args RPAREN function_body
         ;

function_body : LBRACE statements RBRACE
              ;

ret_type : INT
         | VOID
         ;

statements : statements statement
           |
           ;

statement : assgn_st
          | decl_st
          | func_call
          | ret_st
          | if_else_st
          ;

args : arg_list
     |
     ;

arg_list : arg_list COMMA arg
         | arg
         ;

arg : INT IDENTIFIER
    ;

decl_st : INT var_list SEMICOLON
        ;

var_list : IDENTIFIER
         | IDENTIFIER ASSIGN expr
         | var_list COMMA IDENTIFIER
         | var_list COMMA IDENTIFIER ASSIGN expr
         ;

assgn_st : IDENTIFIER ASSIGN expr SEMICOLON
         ;

ret_st : RETURN expr SEMICOLON
       | RETURN SEMICOLON
       ;

func_call : IDENTIFIER LPAREN id_list RPAREN SEMICOLON
          | IDENTIFIER LPAREN RPAREN SEMICOLON;
          ;

id_list : id_list COMMA IDENTIFIER
        | id_list COMMA NUMBER
        | IDENTIFIER
        | NUMBER
        ;
    
if_else_st : IF LPAREN comp_expr RPAREN LBRACE statements RBRACE %prec LOWER_THAN_ELSE
           | IF LPAREN comp_expr RPAREN statement %prec LOWER_THAN_ELSE
           | IF LPAREN comp_expr RPAREN LBRACE statements RBRACE ELSE LBRACE statements RBRACE
           | IF LPAREN comp_expr RPAREN statement ELSE 
           | IF LPAREN comp_expr RPAREN LBRACE statements RBRACE ELSE statement
           | IF LPAREN comp_expr RPAREN statement ELSE LBRACE statements RBRACE
           ;

expr : expr PLUS term
     | expr MINUS term
     | term
     ;

term : term MULTIPLY factor
     | term DIVIDE factor
     | term MODULO factor
     | factor
     ;

factor : LPAREN expr RPAREN
       | IDENTIFIER
       | NUMBER
       ;

comp_expr : expr comp_op expr
          | expr
          ;

comp_op : EQUAL
        | LT
        | GT
        | GTEQ
        | LTEQ
        ;

%%

void yyerror(const char* msg) {
    extern char *yytext;
    fprintf(stderr, "SyntaxError: %s\n", msg);

    if (strcmp(yytext, ";") == 0) {
        fprintf(stderr, "Unexpected token '%s' encountered. A semicolon may be misplaced or unexpected here.\n", yytext);
    } else if (strcmp(yytext, "{") == 0) {
        fprintf(stderr, "Unmatched '{' encountered. A corresponding '}' is required to properly close the block.\n");
    } else if (strcmp(yytext, "(") == 0) {
        fprintf(stderr, "Unmatched '(' encountered. A corresponding ')' is required to complete the expression.\n");
    } else if (strcmp(yytext, "}") == 0) {
        fprintf(stderr, "Unexpected '}' encountered. No matching '{' exists for this token.\n");
    } else if (strcmp(yytext, ")") == 0) {
        fprintf(stderr, "Unexpected ')' encountered. No matching '(' exists for this token.\n");
    } else if (strcmp(yytext, "#") == 0) {
        fprintf(stderr, "Invalid preprocessor directive syntax. Verify the format for directives such as #include or #define.\n");
    } else {
        fprintf(stderr, "Unexpected token '%s' encountered. Review the surrounding syntax for potential errors.\n", yytext);
    }
}