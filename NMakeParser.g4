/*
NMake language grammar reference:
https://learn.microsoft.com/en-us/cpp/build/reference/nmake-reference?view=msvc-170
*/

grammar NMakeParser;
//import NMakeLexer;
//options { tokenVocab = NMakeLexer; }

@header {
package syntax;
}

file
    : descriptiopnBlocks EOF
//    | commands
//    | macros
//    | inteferenceRules
//    | dotDirectives
//    | preprocessingDirectives
    ;

descriptiopnBlocks
    : (descriptiopnBlock)* //command*
    ;

descriptiopnBlock
    : dependencyLine
    ;

/*
 A dependency line specifies one or more targets, and zero or more dependents
*/
dependencyLine
    : targets COLON dependents
    ;

targets
    : target+
    ;

dependents
    : (dependent* concat)* dependent* eol
    ;

target
    : fileName
    ;

dependent
    : fileName
    ;

fileName
    : Identifier (DOT Identifier)*
    ;

eol
    : WHITESPACE* EOL
    ;

concat
    : SLASH EOL
    ;

//eol
//    : '\n'
//    ;
//commands
//    :
//    | command (Space command)*
//    ;
//
//command
//    :


/*******************Lexical rules ****************************/
Identifier:         [A-Za-z_][A-Za-z0-9_]*;
Line_comment:       '#' ~[\r\n]* -> channel(HIDDEN);
//NEWLINE:            ('\r'? '\n') -> channel(HIDDEN);

WHITESPACE:         [ \t] -> channel(HIDDEN);
EOL:                [\r\n]+;
SLASH:              '\\';

COLON:              ':';
DOT:                '.';

fragment Digits
    : [0-9] ([0-9_]* [0-9])?
    ;

fragment LetterOrDigit
    : Letter
    | [0-9]
    ;

fragment Letter
    : [a-zA-Z$_] // these are the "java letters" below 0x7F
    | ~[\u0000-\u007F\uD800-\uDBFF] // covers all characters above 0x7F which are not a surrogate
    | [\uD800-\uDBFF] [\uDC00-\uDFFF] // covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
    ;

