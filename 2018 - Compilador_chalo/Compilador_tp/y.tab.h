/* A Bison parser, made by GNU Bison 3.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    COMENTARIO = 259,
    DECVAR = 260,
    ENDDEC = 261,
    ASIG = 262,
    MAYOR = 263,
    MAYOR_IGUAL = 264,
    MENOR = 265,
    MENOR_IGUAL = 266,
    IGUAL = 267,
    DISTINTO = 268,
    SUMA = 269,
    RESTA = 270,
    MULTIPLICACION = 271,
    DIVISION = 272,
    AVG = 273,
    INT = 274,
    FLOAT = 275,
    STRING = 276,
    T_ENTERO = 277,
    T_FLOAT = 278,
    T_STRING = 279,
    IF = 280,
    ELSE = 281,
    WHILE = 282,
    C_ABIERTO = 283,
    C_CERRADO = 284,
    LL_ABIERTA = 285,
    LL_CERRADA = 286,
    P_ABIERTO = 287,
    P_CERRADO = 288,
    DOS_PUNTOS = 289,
    P_COMA = 290,
    COMA = 291,
    AND = 292,
    OR = 293
  };
#endif
/* Tokens.  */
#define ID 258
#define COMENTARIO 259
#define DECVAR 260
#define ENDDEC 261
#define ASIG 262
#define MAYOR 263
#define MAYOR_IGUAL 264
#define MENOR 265
#define MENOR_IGUAL 266
#define IGUAL 267
#define DISTINTO 268
#define SUMA 269
#define RESTA 270
#define MULTIPLICACION 271
#define DIVISION 272
#define AVG 273
#define INT 274
#define FLOAT 275
#define STRING 276
#define T_ENTERO 277
#define T_FLOAT 278
#define T_STRING 279
#define IF 280
#define ELSE 281
#define WHILE 282
#define C_ABIERTO 283
#define C_CERRADO 284
#define LL_ABIERTA 285
#define LL_CERRADA 286
#define P_ABIERTO 287
#define P_CERRADO 288
#define DOS_PUNTOS 289
#define P_COMA 290
#define COMA 291
#define AND 292
#define OR 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 14 "sintactico.y" /* yacc.c:1913  */

	int intValue;
	float floatValue;
	char *stringValue;

#line 136 "y.tab.h" /* yacc.c:1913  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
