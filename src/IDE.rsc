module IDE

import Prelude;
import util::IDE;
import util::ValueUI;

import vis::Figure;
import vis::Render;

import Syntax;

//  define the language name and extension

private str NAME = "UMLC";
private str EXT = "umlc";

//  Define the connection with the Pico parser
Tree parser(str x, loc l) {
    return parse(#Program, x, l);
}

public void register() {
  registerLanguage(NAME, EXT, parser);
}