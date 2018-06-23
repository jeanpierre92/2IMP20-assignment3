module IDE_TC

import Prelude;
import util::IDE;
import util::ValueUI;

import vis::Figure;
import vis::Render;

import Syntax;
import Abstract;
import Typecheck;

//  define the language name and extension

private str NAME = "UMLC";
private str EXT = "umlc";

//  Define the connection with the parser
Tree parser(str x, loc l) {
    return parse(#Program, x, l);
}

//  Define connection with the typechecker
// (includes type checking and uninitialized variables check)

public Program checkPicoProgram(Program x) {
	p = implode(#PROGRAM, x);
	env = checkProgram(p);
	errors = { error(v, l) | <loc l, PicoId v> <- env.errors };
	
	return x[@messages = errors];
    
}


public void register() {
  registerLanguage(NAME, EXT, parser);
  registerAnnotator(NAME, checkPicoProgram);
}