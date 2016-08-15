#include <stdio.h>
#include "y.tab.h"
extern char* yytext;
int main() {
  int token;
  while (token = yylex()) {
    switch (token) {
      // Identifier
      case IDENTIFIER: printf("<IDENTIFIER, %d, %s>\n",
        token, yytext); break;
      // Constant
      case INTCONST: printf("<INT_CONSTANT, %d, %s>\n",
        token, yytext); break;
      case FLOATCONSTANT: printf("<FLOAT_CONSTANT, %d, %s>\n",
        token, yytext); break;
      case ENUMERATIONCONSTANT: printf("<ENU_CONSTANT, %d, %s>\n",
        token, yytext); break;
      case CHARACTERCONST: printf("<CHAR_CONSTANT, %d, %s>\n",
        token, yytext); break;
      // String Literals
      case STRINGLIT: printf("<STRING LITERAL, %d, %s>\n",
        token, yytext); break;
     /* case PUNCTUATORS: printf("<PUNCTUATORS, %d, %s>\n",
        token, yytext); break;*/
      // Comments // Multi line comments are ignored
      case COMMENT: 
        printf("<COMMENT, %d>\n",token); break;
      // Keyword
      case BREAK:
      case AUTO:
      case CASE:
      case CHAR:
      case CONST:
      case CONTINUE:
      case DEFAULT:
      case DO:
      case DOUBLE:
      case ELSE:
      case ENUM:
      case EXTERN:
      case FLOAT:
      case FOR:
      case GOTO:
      case IF:
      case INLINE:
      case INT:
      case LONG:
      case REGISTER:
      case RESTRICT:
      case RETURN:
      case SHORT:
      case SIGNED:
      case SIZEOF:
      case STATIC:
      case STRUCT:
      case SWITCH:
      case TYPEDEF:
      case UNION:
      case UNSIGNED:
      case VOID:
      case VOLATILE:
      case WHILE:
      case BOOL:
      case COMPLEX:
      case IMAGINARY:
      printf("<KEYWORD, %d, %s>\n",token, yytext); break;
    // Punctuators
      default: printf("<PUNCTUATOR, %d, %s>\n",
        token, yytext); break;
    }
  }
}