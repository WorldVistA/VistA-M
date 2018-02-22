XVEMKRN ;DJB/KRN**NEW Single Character Read ;2017-08-15  1:00 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; READ+23,GETCHAR+12 Bug fix by Kevin Toppenberg, MD (c) 2017
 ;
READ(PROMPT,LENGTH,NOECHO) ;
 ;PROMPT  Display prompt.
 ;LENGTH  Maximum # of characters user may enter.
 ;NOECHO  1=Do not echo what user types.
 ;
 ;Return: Character(s) user entered
 ;             -or-
 ;        XVV("K") = If user hits a non-printable key, it's returned
 ;                   in this variable enclosed in angle brackets.
 ;                   Example: <BS> or <ESC>
 ;
 NEW CHAR,CHAR1,CHAR2,CLEAR,FLAGQ,I,STRING,TEST,Y
 S FLAGQ=0
 D INIT I FLAGQ Q "<OS>"
 W PROMPT
 X XVV("TRMON")
 X XVV("EOFF")
 ;
 F  D GETCHAR D  Q:($L(STRING)'<LENGTH)!FLAGQ
 . I CHAR?1E S STRING=STRING_CHAR Q
 . ;I ",<BS>,<DEL>,"[(","_CHAR_","),$L(STRING) D  Q  ; TMG/KT Delete vs Backspace
 . I ",<BS>,"[(","_CHAR_","),$L(STRING) D  Q
 .. S STRING=$E(STRING,1,$L(STRING)-1)
 .. W $C(8)," ",$C(8)
 . S FLAGQ=1
 . S:('$L(STRING)) XVV("K")=CHAR
 ;
 X XVV("TRMOFF")
 X XVV("EON")
 Q STRING
 ;
GETCHAR ;Single character READ to get individual characters
 R CHAR#1:XVV("TIME")
 I '$T S CHAR="<TO>" Q
 I $A(CHAR)>31,$A(CHAR)<127 W:$G(NOECHO)'=1 CHAR Q
 X XVV("TRMRD") S CHAR=Y
 D:(CHAR=0) OTHER
 D:(CHAR=27) ESCAPE
 I (CHAR="***") W $C(7) G GETCHAR
 S CHAR=$S(CHAR<0:"TO",CHAR=4:"CTRLD",CHAR=8:"BS",CHAR=9:"TAB",CHAR=13:"RET",CHAR=20:"CTRLT",1:CHAR)
 ;S CHAR=$S(CHAR=21:"F1",CHAR=22:"F2",CHAR=23:"F3",CHAR=24:"F4",CHAR=27:"ESC",CHAR=127:"DEL",1:CHAR) ; TMP/KT Delete vs Backspace
 S CHAR=$S(CHAR=21:"F1",CHAR=22:"F2",CHAR=23:"F3",CHAR=24:"F4",CHAR=27:"ESC",CHAR=127:"BS",1:CHAR)
 S CHAR="<"_CHAR_">"
 Q
 ;====================================================================
ESCAPE ;Process Escape Sequences
 ;<ESCD>,<ESC1>,<ESCAU>, etc.
 S TEST=0
 R *CHAR:50
 I '$T S CHAR=-1 Q
 I CHAR=91 D CURSOR Q
 I CHAR=79 D FKEYS Q
 I CHAR>31,CHAR<97 S CHAR="ESC"_$C(CHAR) Q
 I CHAR>122,CHAR<127 S CHAR="ESC"_$C(CHAR) Q
 ;Convert lower case to uppercase
 I CHAR>96,CHAR<123 S CHAR=CHAR-32,CHAR="ESC"_$C(CHAR) Q
 ;Clean up. See if user hit ESC ESC
 F I=1:1:10 R *CLEAR:0 S:$T TEST=1
 Q:('TEST)&(CHAR=27)  S CHAR="***"
 Q
CURSOR ;Arrow Keys
 ;<AU>,<AD>,<AL>,<AR>
 R *CHAR:50
 S CHAR=$S(CHAR=65:"AU",CHAR=66:"AD",CHAR=67:"AR",CHAR=68:"AL",CHAR=72:"HOME",CHAR=75:"END",1:CHAR)
 I "1,3,4,5,6"[$C(CHAR) D OTHERDTM Q  ;"Other" Keys under DTM
 Q
PFKEYS ;F Keys. Call here when F Keys are to be used alone
 R *CHAR:50
 S CHAR=$S(CHAR=80:"F1",CHAR=81:"F2",CHAR=82:"F3",CHAR=83:"F4",1:CHAR)
 Q
FKEYS ;F Keys. Use F1,F2,F4 with cursor keys, F3 alone.
 R *CHAR:50
 I '$T S CHAR="***" Q
 I CHAR=82 S CHAR="F3" Q
 S CHAR=$S(CHAR=80:"F1",CHAR=81:"F2",CHAR=83:"F4",1:"***")
 Q:(CHAR="***")
FKEYS1 R *CHAR1:50
 I '$T S CHAR="***" Q
 ;
 ;--> <F1-1> thru <F1-9>
 I CHAR1>48,CHAR1<53 D  Q
 . F I=49:1:52 I CHAR1=I S CHAR=CHAR_"-"_(I-48) Q
 ;
 ;--> <F1A>,<F2B>, etc.
 I CHAR1>31,CHAR1<49 S CHAR=CHAR_$C(CHAR1) Q
 I CHAR1>52,CHAR1<97 S CHAR=CHAR_$C(CHAR1) Q
 I CHAR1>122,CHAR1<127 S CHAR=CHAR_$C(CHAR1) Q
 ;Convert lowercase to uppercase
 I CHAR1>96,CHAR<123 S CHAR1=CHAR1-32,CHAR=CHAR_$C(CHAR1) Q
 I CHAR1'=27 R *CHAR:0 S CHAR="***" Q
 ;
 ;--> <F1AU>,<F1AD>,<F1AL>,<F1AR>
 R *CHAR1:50
 ;Look for arrow keys, or F1,2,4 keys struck twice.
 I ('$T)!((CHAR1'=91)&(CHAR1'=79)) R *CHAR2:0 S CHAR="***" Q
 R *CHAR1:50
 I '$T S CHAR="***" Q
 S CHAR=CHAR_$S(CHAR1=65:"AU",CHAR1=66:"AD",CHAR1=67:"AR",CHAR1=68:"AL",CHAR1=80:"F1",CHAR1=81:"F2",CHAR1=83:"F4",1:CHAR1)
 Q
OTHER ;Pageup,Pagedown,Home,End
 R *CHAR:50
 I '$T S CHAR="***" Q
 ;--> <PGUP>,<PGDN>,<HOME>,<END>
 S CHAR=$S(CHAR=73:"PGUP",CHAR=81:"PGDN",CHAR=71:"HOME",CHAR=79:"END",1:CHAR)
 Q
OTHERDTM ;Pageup,Pagedown,Home,End,Delete - DataTree
 R *CHAR1:50
 I '$T!(CHAR1'=126) S CHAR="***" Q
 S CHAR=$S(CHAR=49:"HOME",CHAR=52:"END",CHAR=53:"PGUP",CHAR=54:"PGDN",CHAR=51:"DEL",1:"***")
 Q
INIT ;
 I $G(XVV("OS"))']"" D OS^XVEMKY Q:FLAGQ
 I $G(XVV("TIME"))'>0 D TIME^XVEMKY
 I $G(XVV("EON"))']"" D ECHO^XVEMKY1
 I $G(XVV("EOFF"))']"" D ECHO^XVEMKY1
 I $G(XVV("TRMON"))']"" D TRMREAD^XVEMKY1
 S (STRING,XVV("K"))=""
 S PROMPT=$G(PROMPT),LENGTH=$S($G(LENGTH)>0:LENGTH,1:245)
 Q
