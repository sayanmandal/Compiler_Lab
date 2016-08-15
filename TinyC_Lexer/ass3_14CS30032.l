%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "y.tab.h"
#include <time.h>
extern void yyerror(const char *); /* prints error message */
%}


exp 		[eE]
letter		[a-zA-Z]
digit		[0-9]
sign 		[+-]

MULTICOMMENT	\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/
SINGLECOMMENT	\/\/(.)*

IDENTIFIER		[_A-Za-z][_A-Za-z0-9]*
INTEGERCONSTANT 	[1-9]+[0-9]*

FRACTIONALCONSTANT	{digit}*\.{digit}+|{digit}+\.
EXPONENTPART		{exp}{sign}?{digit}+	

FLOATINGCONSTANT	{FRACTIONALCONSTANT}{EXPONENTPART}?|{digit}+{EXPONENTPART}
ENUMERATIONCONSTANT		{IDENTIFIER}

ESCAPESEQUENCE		\\['"?\\abfnrtv]
CCHARACTER		[^'\\\n]|{ESCAPESEQUENCE}

CHARACTERCONSTANT	\'{CCHARACTER}+\'
SCHARACTER		[^"\\\n]|{ESCAPESEQUENCE}

STRINGLITERAL	\"{SCHARACTER}*\"
ws 				[ \t\v\n\f]


%%

{MULTICOMMENT}	{return COMMENT;}
{SINGLECOMMENT}	{return COMMENT;}


"auto"			{ return AUTO; }
"break"         { return BREAK; }
"case"          { return CASE; }
"char"          { return CHAR; }
"const"         { return CONST; }
"continue"      { return CONTINUE; }
"default"       { return DEFAULT; }
"do"            { return DO; }
"double"        { return DOUBLE; }
"else"          { return ELSE; }
"enum"          { return ENUM; }
"extern"        { return EXTERN; }
"float"         { return FLOAT; }
"for"           { return FOR; }
"goto"          { return GOTO; }
"if"            { return IF; }
"inline"        { return INLINE; }
"int"           { return INT; }
"long"          { return LONG; }
"register"      { return REGISTER; }
"restrict"      { return RESTRICT; }
"return"        { return RETURN; }
"short"         { return SHORT; }
"signed"        { return SIGNED; }
"sizeof"        { return SIZEOF; }
"static"        { return STATIC; }
"struct"        { return STRUCT; }
"switch"        { return SWITCH; }
"typedef"       { return TYPEDEF; }
"union"         { return UNION; }
"unsigned"      { return UNSIGNED; }
"void"          { return VOID; }
"volatile"      { return VOLATILE; }
"while"         { return WHILE; }
"_Bool"         { return BOOL; }
"_Complex"      { return COMPLEX; }
"_Imaginary"    { return IMAGINARY; }




{CHARACTERCONSTANT}	{
			yylval.charactervalue = (char*)malloc(strlen(yytext)*sizeof(char));
			yylval.charactervalue = strdup(yytext);
			return CHARACTERCONST;
			}

{STRINGLITERAL}	{
			yylval.charactervalue = (char*)malloc(strlen(yytext)*sizeof(char));
			yylval.charactervalue = strdup(yytext);
			return STRINGLIT;
			}


{INTEGERCONSTANT}	{
				yylval.integervalue = atoi(yytext);
				return INTCONST;
				}	


{FLOATINGCONSTANT}	{
				yylval.floatvalue = atof(yytext);	
				return FLOATCONSTANT;
				}


{IDENTIFIER}	{
				yylval.charactervalue = (char*)malloc(strlen(yytext)*sizeof(char));
				yylval.charactervalue = strdup(yytext);
				return IDENTIFIER;
				}

{ENUMERATIONCONSTANT}	{
						yylval.charactervalue = (char*)malloc(strlen(yytext)*sizeof(char));
						yylval.charactervalue = strdup(yytext);
						return ENUMERATIONCONSTANT;
						}

"["			{return '[';}
"]"			{return ']';}
"("			{return '(';}
")"			{return ')';}
"{"			{return '{';}
"}"			{return '}';}
"." 		{return '.';}

"->"		{return ARROW;}
"++"		{return ADDUNARY;}
"--" 		{return SUBTRACTUNARY;}


"&"			{return '&';}
"*"			{return '*';}
"+"			{return '+';}
"-"			{return '-';}
"~"			{return '~';}
"!"			{return '!';}
"/"			{return '/';}

"%"			{return '%';}

"<<"		{return LEFTSHIFT;}
">>"		{return RIGHTSHIFT;}

"<"			{return LESS;}
">"			{return GREATER;}
"<="		{return LE;}
">="		{return GE;}


"==" 		{return COMPARISONEQUAL;}
"!="		{return NE;}
"^"			{return BITWISEXOR;}
"|"			{return BITWISEOR;}
"&&"		{return BITWISEAND;}
"||"		{return OR;}
"?"			{return QUESTIONMARK;}
":"			{return COLON;}
";"			{return ';';}


"..."		{return TRIPLEDOT;}
"="			{return '=';}
"*="		{return MULTIPLYEQUAL;}
"/="		{return DIVIDEEQUAL;}
"%="		{return PERCENTILEEQUAL;}
"+="		{return PLUSEQUAL;}
"-="		{return MINUSEQUAL;}
"<<="		{return LEFTSHIFTEQUAL;}
">>="		{return RIGHTSHIFTEQUAL;}
"&="		{return BITWISEANDEQUAL;}
"^="		{return BITWISEXOREQUAL;}
"|="		{return BITWISEOREQUAL;}

","			{return ',';}
"#"			{return '#';}


{ws}		{ /* whitespace separates tokens */ }
.		

%%