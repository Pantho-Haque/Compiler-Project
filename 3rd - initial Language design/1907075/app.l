%{
#include <bits/stdc++.h>
using namespace std;

extern FILE *yyin;
extern FILE *yyout;

int stmtCount = 0;
map<string, string> variableTable;

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
            variableTable[varName] = dataType;
            cout << dataType << " " << varName << " created" << (isArray?" an Array":"") << endl;
            
        } else {
            cout << "Variable '" << varName << "' already declared as type " << variableTable[varName] << endl;
        }
    }
    stmtCount++;
}


display\([^)]*\);;  {

    string varName=yytext;
    size_t stringStarts = varName.find('(');
    varName = varName.substr(stringStarts + 1,varName.length()-stringStarts-4);
    cout << varName <<endl;
}

[A-Za-z]+<-[^;]+;; { cout << "Assignment Operation" << endl;stmtCount++; }

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

[^ \n\t]* {cout << "unknown statment !!! " << endl;}

%%

int yywrap() { return 1; }

int main() {
    yyin = freopen("input.txt", "r", stdin);
    yyout = freopen("output.txt", "w", stdout);
    yylex();
    return 0;
}
