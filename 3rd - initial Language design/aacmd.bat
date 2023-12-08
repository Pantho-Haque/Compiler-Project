bison -d app.y && flex app.l && g++ lex.yy.c app.tab.c -o app && app.exe

@REM @echo off
@REM :: Set directories
@REM set ENGINE_DIR=Engine
@REM set IO_DIR=I/O

@REM :: Create directories if they don't exist
@REM if not exist "%ENGINE_DIR%" mkdir "%ENGINE_DIR%"
@REM if not exist "%IO_DIR%" mkdir "%IO_DIR%"

@REM :: Remove old files
@REM del "%ENGINE_DIR%\app.exe"
@REM del "%ENGINE_DIR%\lex.yy.c"
@REM del "%ENGINE_DIR%\app.tab.c"
@REM del "%ENGINE_DIR%\app.tab.h"
@REM del "%IO_DIR%\output.txt"

@REM :: Run Bison and Flex


@REM :: Move generated files to Engine directory
@REM move lex.yy.c "%ENGINE_DIR%"
@REM move app.tab.c "%ENGINE_DIR%"
@REM move app.tab.h "%ENGINE_DIR%"

@REM :: Compile the generated C files from the Engine directory
@REM g++ -w -o "%ENGINE_DIR%\app.exe" "%ENGINE_DIR%\app.tab.c" "%ENGINE_DIR%\lex.yy.c"

@REM :: Run the parser with input from b.n in the I/O directory and output to output.txt in the same directory
@REM type "%IO_DIR%\input.txt" | "%ENGINE_DIR%\app.exe" > "%IO_DIR%\output.txt"