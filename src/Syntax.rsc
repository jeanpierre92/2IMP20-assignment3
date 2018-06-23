/*
Assignment 3 2IMP20.
Authors: Maurits Ambags (0771400), Jeanpierre Balster ().
GLT Group 36.
*/

module Syntax

import Prelude;

lexical Id  = ([a-z][a-zA-Z0-9]* !>> [a-z0-9]) \ Keywords;
lexical Natural = [0-9]+;
lexical String = "\"" ![\"]*  "\"";
lexical Boolean = ("true" | "false");
lexical Scope = ("+" | "-" | "#" | "~");
lexical Multiplicity = Natural | (Natural"-"Natural) | (Natural"-*") ;
lexical RelationName = ("association" | "aggregation" | "composition" | "generalization");

keyword Keywords = "beginClasses" | "endClasses" | 
                   "beginRelations" | "endRelations" | 
                   "Class" | "Attributes" | "Operations" | 
                   "Attributes" | "Operations"
                   "natural" | "string" | "boolean" |
                   "Relation"
                   ;

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r%];

lexical WhitespaceAndComment 
   = [\ \t\n\r]
   | @category="Comment" "%" ![%]+ "%"
   | @category="Comment" "%%" ![\n]* $
   ;

start syntax Program 
   = program: "beginClasses" Class* classes "endClasses" "beginRelations" {Relation ";"}* relations "endRelations" ;

/*
syntax Declarations 
   = "declare" {Declaration ","}* decls ";" ;  
 
syntax Declaration = decl: Id id ":" Type tp;
*/


syntax Class = "Class" Id id "{" "Attributes:" {Attribute ";"}* attributes "Operations:" {Operation ";"}* "}";

syntax Attribute = Scope scope Id id ":" Type type;

syntax Parameter = Type type Id id;

syntax Operation = Scope scope Id id "("{Parameter ","}* params "):" Type return;

syntax Relation = "Relation(" Id id "," Multiplicity mult "," RelationName relation "," Multiplicity mult "," Id id ")";

syntax Type
   = natural:"Natural" 
   | string :"String" 
   | boolean :"Boolean"
   | None : "void"
   ;

/* Misschien later nog als we manipulations van UML diagrams willen doen (bijv "add method m1 to all children of class c1").

syntax Statement 
   = asgStat: Id var ":="  Expression val 
   | ifElseStat: "if" Expression cond "then" {Statement ";"}*  thenPart "else" {Statement ";"}* elsePart "fi"
   | whileStat: "while" Expression cond "do" {Statement ";"}* body "od"
   | forStat: "for" "(" {Statement ";"}* init ";" Expression guard ";" {Statement ";"}* maint ")" 
   	 "do" {Statement ";"}* body "od"
  ;  

syntax Expression 
   = id: Id name
   | strCon: String string
   | natCon: Natural natcon
   | boolCon: Boolean bool
   | bracket "(" Expression e ")"
   > left b_not: "not" Expression e
   > left b_and: Expression lhs "and" Expression rhs
   > left b_or: Expression lhs "or" Expression rhs
   > left conc: Expression lhs "||" Expression rhs
   > left ( add: Expression lhs "+" Expression rhs
          | sub: Expression lhs "-" Expression rhs
          )
   > left 	( neq: Expression lhs "!=" Expression rhs
   			| eq: Expression lhs "==" Expression rhs
   			)
  ;*/

public start[Program] program(str s) {
  return parse(#start[Program], s);
}

public start[Program] program(str s, loc l) {
  return parse(#start[Program], s, l);
}
