
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     VAR = 258,
     ENDVAR = 259,
     REPEAT = 260,
     UNTIL = 261,
     IF = 262,
     THEN = 263,
     ELSE = 264,
     ENDIF = 265,
     OP_ASIG = 266,
     OP_SUM = 267,
     OP_RES = 268,
     OP_DIV = 269,
     OP_MUL = 270,
     OP_DOSP = 271,
     CAR_COMA = 272,
     CAR_PYC = 273,
     CAR_PA = 274,
     CAR_PC = 275,
     CAR_CA = 276,
     CAR_CC = 277,
     CAR_LA = 278,
     CAR_LC = 279,
     CMP_MAYOR = 280,
     CMP_MENOR = 281,
     CMP_MAYORIGUAL = 282,
     CMP_MENORIGUAL = 283,
     CMP_DISTINTO = 284,
     CMP_IGUAL = 285,
     ID = 286,
     INT = 287,
     FLOAT = 288,
     STRING = 289,
     AND = 290,
     OR = 291,
     READ = 292,
     PRINT = 293,
     OP_MOD = 294,
     OP_IGUAL = 295,
     CONST = 296,
     CONST_INT = 297,
     CONST_REAL = 298,
     CONST_STR = 299
   };
#endif
/* Tokens.  */
#define VAR 258
#define ENDVAR 259
#define REPEAT 260
#define UNTIL 261
#define IF 262
#define THEN 263
#define ELSE 264
#define ENDIF 265
#define OP_ASIG 266
#define OP_SUM 267
#define OP_RES 268
#define OP_DIV 269
#define OP_MUL 270
#define OP_DOSP 271
#define CAR_COMA 272
#define CAR_PYC 273
#define CAR_PA 274
#define CAR_PC 275
#define CAR_CA 276
#define CAR_CC 277
#define CAR_LA 278
#define CAR_LC 279
#define CMP_MAYOR 280
#define CMP_MENOR 281
#define CMP_MAYORIGUAL 282
#define CMP_MENORIGUAL 283
#define CMP_DISTINTO 284
#define CMP_IGUAL 285
#define ID 286
#define INT 287
#define FLOAT 288
#define STRING 289
#define AND 290
#define OR 291
#define READ 292
#define PRINT 293
#define OP_MOD 294
#define OP_IGUAL 295
#define CONST 296
#define CONST_INT 297
#define CONST_REAL 298
#define CONST_STR 299




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 13 "Sintactico.y"

	int intValue;
	float floatValue;
	char *stringValue;



/* Line 1676 of yacc.c  */
#line 148 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


