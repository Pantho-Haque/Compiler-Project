%{
    #include <stdio.h> 
    #include<math.h>
    #include<stdlib.h>
    #include<string.h>

        extern FILE *yyin;
        extern FILE *yyout; 

	int yylex();
	int yyparse();



    void yyerror(char *s);

    char VAR[10000][10000];
    int VALUE[10000];
    int tot_dec = 0;
    int alreadyDeclared(char *s){
        for(int i=0;i<tot_dec;i++)
        {
                if(strcmp(VAR[i],s) == 0)
                        return 1;
        }return 0;
    }

    int setValue(char *s,int val)
    {   
        int flag =-1;
        for(int i=0;i<tot_dec;i++)
        {
                if(strcmp(VAR[i],s)==0)
                {
                        VALUE[i]=val;
                        flag = 0;
                        break; 
                }

        }
        if(flag==-1){
        strcpy(VAR[tot_dec],s);
        VALUE[tot_dec]=val;
        tot_dec++;}
    }

    int getValue(char *s)
    {
        int pos=-1;
        for(int i=0;i<tot_dec;i++)
        {
                if(strcmp(VAR[i],s)==0)
                {
                        pos = i;
                        break; 
                }

        }
        return pos;
    }
    

        char VARflt[10000][10000];
        float valueflt[10000];
        int tot_flt = 0;

        int alreadyDeclaredflt(char *s) {
        for (int i = 0; i < tot_flt; i++) {
                if (strcmp(VARflt[i], s) == 0)
                return 1;
        }
        return 0;
        }

        int setValueflt(char *s, float val) {
                int flag = -1;
                for (int i = 0; i < tot_flt; i++) {
                        if (strcmp(VARflt[i], s) == 0) {
                                valueflt[i] = val;
                                flag = 0;
                                break;
                        }
                }
                if (flag == -1) {
                        strcpy(VARflt[tot_flt], s);
                        valueflt[tot_flt] = val;
                        tot_flt++;
                }
        }

        int getValueflt(char *s) {
        int pos = -1;
        for (int i = 0; i < tot_flt; i++) {
                if (strcmp(VARflt[i], s) == 0) {
                pos = i;
                break;
                }
        }
        return pos;
        }


    int isprime(int n)
    {
        int i, flag = 0;
        if (n == 0 || n == 1)
                flag = 1;
        for (i = 2; i <= n / 2; ++i) 
        {
                if (n % i == 0) 
                {
                        flag = 1;
                        break;
                }
        }
        if (flag == 0)
        {
                return 1;
        }
        else
        {
                return 0;
        }

    }
%}

%token INTEGER VARIABLE begin end torr int_type plus minus into divi float_type eq char_type string_type inc dec eol power ge le eqeq gt ngt lt nlt neq mod prnt ssqrt prime from to doif or orif stopif ffunc sep FLOAT STRING CHARACTER slcmnt mlcmnt ps sbs sbf headr extension assign invalid valueof matches def

%right power

%left plus minus

%right divi into

%right le

%right ge ngt nlt gt lt neq eqeq eq

%%

program:
        program statement '\n\n'
        | begin program end  
        {
                printf("program Successfully Ended\n");
                printf("total %d variable declared\n",tot_dec);
                
        }
        | /* NULL */
        ;

statement:
        statement eol statement
        | invalid { printf("\ninvalid statement\n\n");}
        | statement statement
        | expression                     
        | int_type syn eol { if($2 == "not"){printf("of INTEGER type\n");}}
        | float_type synFlt eol 
        {
                if ($2 == "not") {
                        printf("of FLOAT type\n");
                }
        }
        | VARIABLE assign expression     
        {  
                if(alreadyDeclared($1)==1){
                        printf("value assigned %d to variable %s\n",$3,$1);
                        setValue($1,$3);
                }else if(alreadyDeclaredflt($1)==1){
                        setValueflt($1,$3);
                        printf("value assigned %f to variable %s\n",valueflt[getValueflt($1)],$1);
                }else{
                        printf("Not Declared\n\n");
                }
        }
        | prnt expression eol              
        {
                if($2 == 111){
                        printf("Displaying a prime number\n");
                }else if($2 == 222){
                        printf("Displaying a non-prime number\n");
                }
                else if($2 != "not"){
                        printf("Displaying the value %d\n", $2);
                }
        }
        | prnt STRING eol                  
        {
                printf("Displaying the text %s\n\n", $2);
        }
        | doif ps expression ps sbs statement sbf        
        {
                if($3){
                        printf("If condition true\n\n");
                
                }else{
                        printf("If condition false\n\n");
                }
        } 
        | doif ps expression ps sbs statement sbf elfb or sbs statement sbf       
        {
                if($3){
                        printf("If condition true\n\n");
                
                }else{
                        printf("If condition false\n\n");
                }
        } 
        | from  fstatement to  INTEGER sbs statement sbf          
        {       
                if($2 != "not"){
                        for(int a =$2;a<=$4; a= a+1 ){ 
                                printf("from to Looping %d\n",a);
                        }
                }
                printf("From to loop finished\n\n");
        } 
        | stopif ps VARIABLE ge INTEGER ps sbs VARIABLE dec INTEGER eol statement sbf          
        {
                int a = VALUE[getValue($3)];
                for(int i=a;i>=$5;i=i-$12){
                        printf("Stop-if loop current value %d\n",i);
                }        
                printf("Stop-if loop finished\n\n");}
        | stopif ps VARIABLE le INTEGER ps sbs VARIABLE inc INTEGER eol statement sbf          
        {
                int a = VALUE[getValue($3)];
                for(int i=a;i<=$5;i=i+$12){
                        printf("Stop-if loop current value %d\n",i);
                }
                printf("Stop-if loop finished\n\n");
        }
        | begin statement end                    
        {
                printf("program started");
        }
        | ffunc VARIABLE ps param ps sbs statement sbf int_type    
        {
                printf("%s Function Declared\n",$2);
        }
        | headr ps VARIABLE wxt ps                                  
        {
                printf("Header File Detected\n");
        }
        |
        ;

wxt: extension |

param:
        param int_type VARIABLE               
        { 
                if(alreadyDeclared($2)!=1){}
                else{
                        printf("%s already Declared\n\n",$2);
                        $$ = "not";
                } 
        }
        |int_type VARIABLE sep 
        {
                if(alreadyDeclared($2)!=1){}
                else{
                        printf("%s already Declared\n\n",$2);
                        $$ = "not";
                }
        }
        |
        ;
elfb:
        elfb orif ps expression ps sbs statement sbf 
        | orif ps expression ps sbs statement sbf 
        |        
        ;

fstatement:
         int_type VARIABLE assign expression              
         {
                if(alreadyDeclared($2)!=1){setValue($2,$4);$$=$4;}
                else{
                        printf("%s already Declared\n\n",$2);
                        $$ = "not";
                } 
        }
        | VARIABLE assign expression       
        {  
                if(alreadyDeclared($1)==1){
                        setValue($1,$3);
                        $$=$3;
                }else{
                        printf("Not Declared\n\n");
                        $$ = "not";
                }
        }
        ;
syn:
        syn sep VARIABLE                     
        {
                if(alreadyDeclared($3)==1){
                        printf("Variable %s Declared Before\n\n",$3);
                }else{
                        setValue($3,0);
                        printf("variable %s is declared\n",$3);
                        $$ = "not";
                }
        }
        | VARIABLE                           
        {
                if(alreadyDeclared($1)==1){
                        printf("%s Declared Before\n\n",$1);
                }else{
                        setValue($1,0);
                        printf("variable %s is declared\n",$1);
                        $$ = "not";
                }
        }
        ;

synFlt:
        synFlt sep VARIABLE                     
        {
                if(alreadyDeclaredflt($3)==1){
                        printf("Variable %s Declared Before\n\n",$3);
                }else{
                        setValueflt($3,0);
                        printf("variable %s is declared\n",$3);
                        $$ = "not";
                }
        }
        | VARIABLE                           
        {
                if(alreadyDeclaredflt($1)==1){
                        printf("%s Declared Before\n\n",$1);
                }else{
                        setValueflt($1,0);
                        printf("variable %s is declared\n",$1);
                        $$ = "not";
                }
        }
        ;

expression:
        INTEGER   
        | FLOAT     
        | STRING                
        | VARIABLE                      
        {                      
                if(alreadyDeclared($1)==0)
                {
                        printf("Not Declared\n\n");
                        $$="not";
                }else{
                        $$ = VALUE[getValue($1)];
                }
        }
        | expression plus expression     { $$ = $1 + $3; }
        | expression minus expression     { $$ = $1 - $3; }
        | expression into expression     { $$ = $1 * $3; }
        | minus expression               { $$ = -$2;}
        | expression power expression    { $$ = pow($1,$3);}
        | ssqrt expression              { $$ = sqrt($2);}
        | expression mod expression      { $$ = $1% $3;}
        | expression gt expression       { $$ = $1 > $3;}
        | expression lt expression       { $$ = $1 < $3;}
        | expression eqeq expression     { $$ = $1 == $3;}
        | expression neq expression      { $$ = $1 != $3;}
        | expression ge expression      { $$ = $1 >= $3;}
        | expression le expression      { $$ = $1 <= $3;}
        | expression ngt expression      { $$ = $1 < $3;}
        | expression nlt expression      { $$ = $1 > $3;}
        | expression divi expression     { $$ = $1 / $3; }
        | prime expression               { $$ = isprime($2) ? 111 : 222 ; }


        | VARIABLE inc                
        { 
                if(alreadyDeclared($1)==1){
                        setValue($1,VALUE[getValue($1)]+1);
                        $$ = "not";
                }else{
                        printf("Not Declared\n\n");
                        $$ = "not";
                }
        }
        | VARIABLE dec                
        { 
                if(alreadyDeclared($1)==1){
                        setValue($1,VALUE[getValue($1)]-1);
                        $$ = "not";
                }else{
                        printf("Not Declared\n\n");
                        $$ = "not";
                }
        }
        | INTEGER inc   {$$ = $1 + 1;}
        | INTEGER dec   {$$ = $1 - 1;}
        | slcmnt        {printf("Single line comment : %s\n\n",$1);}
        | mlcmnt         {printf("Multiple line Comment Starts : %s :Multiple line Comment Ends\n\n",$1);}
        ;


%%



void yyerror(char *s) {
    fprintf(stderr, "%s\n\n", s);
}


int main(void) {

yyin=freopen("input.txt","r",stdin);

yyout = freopen("output.txt","w",stdout);

yyparse();

return 0;
}
