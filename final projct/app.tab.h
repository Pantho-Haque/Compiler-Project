
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
     INTEGER = 258,
     VARIABLE = 259,
     begin = 260,
     end = 261,
     torr = 262,
     int_type = 263,
     plus = 264,
     minus = 265,
     into = 266,
     divi = 267,
     float_type = 268,
     eq = 269,
     char_type = 270,
     string_type = 271,
     inc = 272,
     dec = 273,
     eol = 274,
     power = 275,
     ge = 276,
     le = 277,
     eqeq = 278,
     gt = 279,
     ngt = 280,
     lt = 281,
     nlt = 282,
     neq = 283,
     mod = 284,
     prnt = 285,
     ssqrt = 286,
     prime = 287,
     from = 288,
     to = 289,
     doif = 290,
     or = 291,
     orif = 292,
     stopif = 293,
     ffunc = 294,
     sep = 295,
     FLOAT = 296,
     STRING = 297,
     CHARACTER = 298,
     slcmnt = 299,
     mlcmnt = 300,
     ps = 301,
     sbs = 302,
     sbf = 303,
     headr = 304,
     extension = 305,
     assign = 306,
     invalid = 307,
     valueof = 308,
     matches = 309,
     def = 310
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


