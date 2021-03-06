/*
Assignment 3 2IMP20.
Authors: Maurits Ambags (0771400), Jeanpierre Balster (0864027).
GLT Group 36.
*/

module Syntax

import Prelude;

lexical Id  = ([a-z][a-zA-Z0-9]* !>> [a-z0-9]) \ Keywords;
lexical Natural = [0-9]+;
lexical String = "\"" ![\"]*  "\"";
lexical Boolean = ("true" | "false");
lexical Scope = ("+" | "-" | "#" | "~");
lexical RelationName = ("association" | "aggregation" | "composition" | "generalization" | "implementation" | "dependency");
lexical ClassType = ("Class" | "Abstract" | "Interface");

keyword Keywords = "beginClasses" | "endClasses" | 
                   "beginRelations" | "endRelations" | 
                   "Class" | "Interface" | 
                   "Attributes" | "Operations" |
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
   = program: "beginClasses" Classes* classes "endClasses" "beginRelations" {Expression ";"}* relations "endRelations" ;

/*
syntax Declarations 
   = "declare" {Declaration ","}* decls ";" ;  
 
syntax Declaration = decl: Id id ":" Type tp;
*/


syntax Classes = ClassType classType Id id "{" "Attributes:" {Attribute ";"}* attributes "Operations:" {Operation ";"}* operations "}";

syntax Attribute = Scope scope Id id ":" Type type;

syntax Operation = Scope scope Id id "("{Parameter ","}* params ")" ":" Type return;

syntax Parameter = Type type Id id;


syntax Relation =  (Assoc | Aggr | Comp | Gene | Impl | Depe);

syntax Assoc = "Association" "(" Id from "," Mult m1 "," Mult m2 "," Id to ")";

syntax Aggr = "Aggregation" "(" Id from "," Mult m "," Id to ")";

syntax Comp = "Composition" "(" Id from "," Mult m "," Id to ")";

syntax Gene = "Generalization" "(" Id from "," Id to ")";

syntax Impl = "Implementation" "(" Id from "," Id to ")";

syntax Depe = "Dependency" "(" Id from "," Id to ")";

syntax Mult = Natural n | (Natural n1 "-" Natural n2) | (Natural n "-*") ;

syntax Type
   = natural:"Natural" 
   | string :"String" 
   | boolean :"Boolean"
   | None : "void"
   ;

syntax Statement = ;
	
syntax Expression = ass:Assoc | agg:Aggr | com:Comp | gen:Gene | imp:Impl | dep:Depe;

public start[Program] program(str s) {
  return parse(#start[Program], s);
}

public start[Program] program(str s, loc l) {
  return parse(#start[Program], s, l);
}
