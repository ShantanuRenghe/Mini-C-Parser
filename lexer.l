%{
    #include "parser.tab.h"    
%}

LETTER [a-zA-Z]
DIGIT [0-9]
UNDERSCORE [_]

%%

"#"         { return HASH; }
"include"  { return INCLUDE; }
"define"   { return DEFINE; }
"."         { return DOT; }
"h"         { return HEADER_TYPE; }

"int"       { return INT; }
"void"      { return VOID; }
"if"        { return IF; }
"else"      { return ELSE; }
"main"      { return MAIN; }
"return"    { return RETURN; }

"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MULTIPLY; }
"/"         { return DIVIDE; }
"%"         { return MODULO; }
"="         { return ASSIGN; }
"=="        { return EQUAL; }
">="        { return GTEQ; }
">"         { return GT; }
"<="        { return LTEQ; }
"<"         { return LT; }

"("         { return LPAREN; }
")"         { return RPAREN; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }
","         { return COMMA; }
";"         { return SEMICOLON; }

{DIGIT}+    { return NUMBER; }
({LETTER}|{UNDERSCORE})({LETTER}|{UNDERSCORE}|{DIGIT})* { return IDENTIFIER; }
\"([^\"\\]|\\.)*\"  { return STRING;}

"//".*      { }
"/*"(.|\n)*?"*/" { }
[ \n\t]+      { }
.           { return yytext[0]; }

%%

int yywrap() {
    return 1;
}