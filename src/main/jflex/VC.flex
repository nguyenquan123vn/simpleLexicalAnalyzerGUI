
import java_cup.runtime.*;

%%

%public
%class Scanner
%implements sym

%unicode

%line
%column

%cup
%cupdebug

%{
  StringBuilder string = new StringBuilder();

      private Symbol symbol(int type) {
        return new VCCSymbol(type, yyline+1, yycolumn+1);
      }

      private Symbol symbol(int type, Object value) {
        return new VCCSymbol(type, yyline+1, yycolumn+1, value);
      }

      /*
       * assumes correct representation of a long value for
       * specified radix in scanner buffer from <code>start</code>
       * to <code>end</code>
       */

%}

/* main character classes */
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

WhiteSpace = {LineTerminator} | [ \t\f]

// comments
Comment = {TraditionalComment} | {EndOfLineComment}

TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?

/* identifiers */
Identifier = [:jletter:][:jletterdigit:]*

// integer literals /
IntegerLiteral = 0 | [1-9][0-9]*

// floating point literals /
FloatLiteral  = ({FLit1}|{FLit2}|{FLit3}) {Exponent}? [fF]
//DoubleLiteral = ({FLit1}|{FLit2}|{FLit3}) {Exponent}?

FLit1    = [0-9]+ \. [0-9]*
FLit2    = \. [0-9]+
FLit3    = [0-9]+
Exponent = [eE] [+-]? [0-9]+

// string and character literals /
StringCharacter = [^\r\n\"\\]
SingleCharacter = [^\r\n\'\\]


%%

<YYINITIAL> {

  // keywords /
  "int"                          {return symbol(INT); }
  "float"                        { return symbol(FLOAT); }
  "void"                         { return symbol(VOID); }
  "boolean"                      { return symbol(BOOLEAN); }

  "if"                           { return symbol(IF); }
  "else"                         { return symbol(ELSE); }
  "for"                          { return symbol(FOR); }
  "while"                        { return symbol(WHILE); }
  "continue"                     { return symbol(CONTINUE); }
  "break"                        { return symbol(BREAK); }
  "return"                       { return symbol(RETURN); }


  // boolean literals /
  "true"                         { return symbol(BOOLEAN_LITERAL, true); }
  "false"                        { return symbol(BOOLEAN_LITERAL, false); }



  // separators /
  "("                            { return symbol(LPAREN); }
  ")"                            { return symbol(RPAREN); }
  "{"                            { return symbol(LBRACE); }
  "}"                            { return symbol(RBRACE); }
  "["                            { return symbol(LBRACKET); }
  "]"                            { return symbol(RBRACKET); }
  ";"                            { return symbol(SEMICOLON); }
  ","                            { return symbol(COMMA); }


  // operators /
  "="                            { return symbol(EQ); }
  ">"                            { return symbol(GT); }
  "<"                            { return symbol(LT); }
  "!"                            { return symbol(NOT); }
  "=="                           { return symbol(EQEQ); }
  "<="                           { return symbol(LTEQ); }
  ">="                           { return symbol(GTEQ); }
  "!="                           { return symbol(NOTEQ); }
  "&&"                           { return symbol(ANDAND); }
  "||"                           { return symbol(OROR); }
  "+"                            { return symbol(PLUS); }
  "-"                            { return symbol(MINUS); }
  "*"                            { return symbol(MULTIPLY); }
  "/"                            { return symbol(DIVIDE); }

  /* This is matched together with the minus, because the number is too big to
     be represented by a positive integer. */
  "-2147483648"                  { return symbol(INTEGER_LITERAL, Integer.valueOf(Integer.MIN_VALUE)); }
  {IntegerLiteral}            { return symbol(INTEGER_LITERAL, Integer.valueOf(yytext())); }

  // comments /
  {Comment}                      { /* ignore */ }

  // whitespace /
  {WhiteSpace}                   { /* ignore */ }

  // identifiers /
  {Identifier}                   { return symbol(ID, yytext()); }
}

// error fallback /
[^]                              { throw new RuntimeException("Illegal character \""+yytext()+
                                                              "\" at line "+yyline+", column "+yycolumn); }
<<EOF>>                          { return symbol(EOF); }