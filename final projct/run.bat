bison -d app.y
flex app.l
gcc -w lex.yy.c app.tab.c -o app
app