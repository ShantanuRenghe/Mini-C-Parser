#include <stdio.h>

extern int yyparse();
extern FILE *yyin;

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error opening file");
            return 1;
        }
    }

    if (!yyparse())
        printf("Successfully parsed!\n");

    if (argc > 1) fclose(yyin);

    return 0;
}
