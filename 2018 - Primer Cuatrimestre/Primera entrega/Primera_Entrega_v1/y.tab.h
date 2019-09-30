
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
     PROGRAM = 258,
     VAR = 259,
     ENDVAR = 260,
     BEGINP = 261,
     ENDP = 262,
     REAL = 263,
     INTEGER = 264,
     STRING = 265,
     FLOAT = 266,
     DO = 267,
     WHILE = 268,
     IN = 269,
     ENDWHILE = 270,
     IF = 271,
     THEN = 272,
     ELSE = 273,
     ENDIF = 274,
     FIB = 275,
     CTE_STR = 276,
     DOS_PUNTOS = 277,
     PUNTO = 278,
     COMA = 279,
     IGUAL = 280,
     OP_COMP_IGUAL = 281,
     OP_COMP_DIST = 282,
     OP_COMP_MEN = 283,
     OP_COMP_MAY = 284,
     OP_COMP_MENIG = 285,
     OP_COMP_MAYIG = 286,
     OP_ASIG = 287,
     CONCATENAR_STR = 288,
     SIGNO_MAS = 289,
     SIGNO_MENOS = 290,
     SIGNO_POR = 291,
     SIGNO_DIV = 292,
     WRITE = 293,
     READ = 294,
     P_A = 295,
     P_C = 296,
     C_A = 297,
     C_C = 298,
     AND = 299,
     OR = 300,
     NOT = 301,
     ID = 302,
     CTE_INT = 303,
     CTE_REAL = 304
   };
#endif
/* Tokens.  */
#define PROGRAM 258
#define VAR 259
#define ENDVAR 260
#define BEGINP 261
#define ENDP 262
#define REAL 263
#define INTEGER 264
#define STRING 265
#define FLOAT 266
#define DO 267
#define WHILE 268
#define IN 269
#define ENDWHILE 270
#define IF 271
#define THEN 272
#define ELSE 273
#define ENDIF 274
#define FIB 275
#define CTE_STR 276
#define DOS_PUNTOS 277
#define PUNTO 278
#define COMA 279
#define IGUAL 280
#define OP_COMP_IGUAL 281
#define OP_COMP_DIST 282
#define OP_COMP_MEN 283
#define OP_COMP_MAY 284
#define OP_COMP_MENIG 285
#define OP_COMP_MAYIG 286
#define OP_ASIG 287
#define CONCATENAR_STR 288
#define SIGNO_MAS 289
#define SIGNO_MENOS 290
#define SIGNO_POR 291
#define SIGNO_DIV 292
#define WRITE 293
#define READ 294
#define P_A 295
#define P_C 296
#define C_A 297
#define C_C 298
#define AND 299
#define OR 300
#define NOT 301
#define ID 302
#define CTE_INT 303
#define CTE_REAL 304




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


