%{
#include <bits/stdc++.h>
#include"app.tab.h"

using namespace std;

extern FILE *yyin;
extern FILE *yyout;

int stmtCount = 0;
map<string, pair<string, string>> variableTable; 

%}

var [A-Za-z][A-Za-z0-9]*
arr {var}(\[\])?
ws [ \n\t]*
dataT (ch)|(st)|(in)|(floating)|(dfloat)
relop (gt)|(lt)|(ge)|(le)|(ne)|(eq)

%%

==.*== { cout << "Single line comment " << endl; }
\/=[^=]*=\/ { cout << "Multiline comment" << endl; }

##<.+> { cout << "Header file insertion" << endl; stmtCount++; }
begining { cout << "Beginning of the code " << endl; stmtCount++; }

{dataT}([ ]+{arr}([ ]*,[ ]*{arr})*)+;; {
    string dataType = yytext;
    size_t spacePos = dataType.find(' ');
    dataType = dataType.substr(0, spacePos);
    string defaultValue="null";

    string variables = yytext;
    size_t dataTypeEnd = variables.find(' ');
    variables = variables.substr(dataTypeEnd + 1,variables.length()-dataTypeEnd-3);
    vector<string> varList;
    stringstream ss(variables);
    string varName;
    
    bool isArray=false;

    while (getline(ss, varName, ',')) {

        varName = varName.substr(0);
        int l=varName.length();

        if(varName[l-1]==']' && varName[l-2]=='['){
            isArray=true;
            varName = varName.substr(0,l-2);
        }
        varList.push_back(varName);
    }

    for (const string& varName : varList) {
        if (variableTable.find(varName) == variableTable.end()) {
            int l=varName.length();
            variableTable[varName] = make_pair(dataType, defaultValue);
            cout << (isArray?"An Array ":"Variable ") << varName << " is created" << endl;
            // cout << dataType << " " << varName << " created" <<  << endl;
            
        } else {
            cout << "Variable '" << varName << "' already declared as type " << variableTable[varName].first << " with value of "<< variableTable[varName].second  << endl;
        }
    }
    stmtCount++;
}


display\([^)]*\);;  {

    string varName=yytext;
    size_t stringStarts = varName.find('(');
    varName = varName.substr(stringStarts + 1,varName.length()-stringStarts-4);

    if (variableTable.find(varName) == variableTable.end()) {
        cout << "Displaying the Text '" << varName << "'" <<endl;
    } else {
        cout << "Displaying the value of variable '" << varName << "' is "<< variableTable[varName].second  <<endl;
    }
    
}

"add" { return add; }
"sub" { return sub; }
"mul" { return mul; }
"div" { return div; }
"gt"  { return gt; }
"lt"  { return lt; }
"ge"  { return ge; }
"le"  { return le; }
"ne"  { return ne; }
"eq"  { return eq; }
{var} { yylval.str = strdup(yytext); return VARIABLE_NAME; }
\"[^\"]*\" { yylval.str = strdup(yytext); return STRING_VALUE; }
[0-9]+ { yylval.str = strdup(yytext); return INTEGER_VALUE; }
";;" { return ';;'; }
"<-" { return '<-'; }


[A-Za-z]+<-[^;]+;; {
    
    string stmt=yytext;
    size_t stringStarts = stmt.find('<');
    string varName = stmt.substr(0,stringStarts);
    string value = stmt.substr(stringStarts+2,stmt.length());

    cout << varName << endl;
    cout << value << endl;
    cout << "Assignment Operation" << endl;stmtCount++; }

{var}[ ]add[ ]{var} { cout << "Addition Operation" << endl; }
{var}[ ]sub[ ]{var} { cout << "Subtraction Operation" << endl; }
{var}[ ]mul[ ]{var} { cout << "Multiplication Operation" << endl; }
{var}[ ]div[ ]{var} { cout << "Division Operation" << endl; }

{var}[ ]gt[ ]{var} { cout << "Greater Than Comparison" << endl; }
{var}[ ]lt[ ]{var} { cout << "Less Than Comparison" << endl; }
{var}[ ]ge[ ]{var} { cout << "Greater equal Comparison" << endl; }
{var}[ ]le[ ]{var} { cout << "Less equal Comparison" << endl; }
{var}[ ]ne[ ]{var} { cout << "Not Equal Comparison" << endl;; }
{var}[ ]eq[ ]{var} { cout << "Equal to Comparison" << endl; }

do-if\|{var}[ ]{relop}[ ]{var}(\|\{)[^\}]*\}(or-if\|{var}[ ]{relop}[ ]{var}\|\{[^\}]*\})?(or\{[^\}]*\})? {
    cout << "Or-If Conditional Statement " << endl;
    
}

valueof\|{var}\|\{{ws}(matches[ ][0-9]+\{[^}]*\}{ws})+def\{[^}]*\}{ws}\} {
    cout << "Value-of Conditional Statement " << endl;
}

from[ ]{var}[ ]*<-[0-9]+[ ]+to[ ]+[0-9]+\{[^}]*\} { cout << "from to Loop occured" << endl; }

stopif\|{var}[ ]{relop}[ ]{var}\|\{[^\}]*\} {cout << "Stop if Loop Occured" << endl;}

func[ ]+{var}[ ]*\|({dataT}[ ]+{var})(,{dataT}[ ]+{var})*\|\{[^\}]*\}  { cout << "Function Declared" << endl;  }



ending {
    cout << "End of the code " << endl;
    stmtCount++;
    cout << endl << endl;
    cout << "---> Total " << stmtCount << " statements created " << endl;
    cout << "---> Total " << variableTable.size() << " unique variables created " << endl;
}

;; {stmtCount++;}

\n {}

([^ \n\t]+) {cout << "unknown statment !!! " << endl;}

%%

int yywrap() { return 1; }