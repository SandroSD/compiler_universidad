
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
     DIV = 266,
     MOD = 267,
     OP_ASIG = 268,
     OP_SUM = 269,
     OP_RES = 270,
     OP_DIV = 271,
     OP_MUL = 272,
     OP_DOSP = 273,
     CAR_COMA = 274,
     CAR_PYC = 275,
     CAR_PA = 276,
     CAR_PC = 277,
     CAR_CA = 278,
     CAR_CC = 279,
     CAR_LA = 280,
     CAR_LC = 281,
     CMP_MAYOR = 282,
     CMP_MENOR = 283,
     CMP_MAYORIGUAL = 284,
     CMP_MENORIGUAL = 285,
     CMP_DISTINTO = 286,
     CMP_IGUAL = 287,
     ID = 288,
     INT = 289,
     FLOAT = 290,
     STRING = 291,
     AND = 292,
     OR = 293,
     READ = 294,
     PRINT = 295,
     OP_MOD = 296,
     OP_IGUAL = 297,
     CONST = 298,
     CONST_INT = 299,
     CONST_REAL = 300,
     CONST_STR = 301
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
#define DIV 266
#define MOD 267
#define OP_ASIG 268
#define OP_SUM 269
#define OP_RES 270
#define OP_DIV 271
#define OP_MUL 272
#define OP_DOSP 273
#define CAR_COMA 274
#define CAR_PYC 275
#define CAR_PA 276
#define CAR_PC 277
#define CAR_CA 278
#define CAR_CC 279
#define CAR_LA 280
#define CAR_LC 281
#define CMP_MAYOR 282
#define CMP_MENOR 283
#define CMP_MAYORIGUAL 284
#define CMP_MENORIGUAL 285
#define CMP_DISTINTO 286
#define CMP_IGUAL 287
#define ID 288
#define INT 289
#define FLOAT 290
#define STRING 291
#define AND 292
#define OR 293
#define READ 294
#define PRINT 295
#define OP_MOD 296
#define OP_IGUAL 297
#define CONST 298
#define CONST_INT 299
#define CONST_REAL 300
#define CONST_STR 301




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 65 "Sintactico.y"

	char * intValue;
	char * floatValue;
	char * stringValue;



/* Line 1676 of yacc.c  */
#line 152 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


