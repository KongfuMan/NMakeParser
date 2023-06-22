lexer grammar NMakeLexer;

tokens { INDENT, DEDENT, LINE_BREAK }

Identifier: [A-Za-z_][A-Za-z0-9_]*;
WS:                 [ \t\r\n]+ -> channel(HIDDEN);
LINE_COMMENT: '#' ~[\r\n]*  -> channel(HIDDEN);
NEWLINE: ('\r' '\n'? | '\n')+ -> channel(HIDDEN);

COLON : ':';
DOT : '.';

// TOkens
IF : [iI][fF];

//Literals
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

