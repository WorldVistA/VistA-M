XVEMREP ;DJB/VRR**EDIT - Web,Html,Parse Rtn/Global,RETURN ;Aug 27, 2019@10:23
 ;;15.2;VICTORY PROG ENVIRONMENT;;Aug 27, 2019
 ; Original Code authored by David J. Bolduc 1985-2005
 ; ESC-R & ESC-G code refactored by Sam Habiel (c) 2016,2019
 ;
WEB ;Web Mode
 I FLAGMODE["WEB" D WEB^XVEMRER Q
 S $P(FLAGMODE,"^",2)="WEB" D MODEON^XVEMRU("WEB")
 Q
 ;
HTML ;HTML Code insertion
 I FLAGMODE["HTML" D HTML^XVEMRER Q
 S $P(FLAGMODE,"^",3)="HTML" D MODEON^XVEMRU("HTML")
 Q
 ;===================================================================
PARSE ;Run rtn name from code at cursor position
 NEW FLAG,I,LINE,RTN,TAG,TMP,C
 ;
 N ELINE   S ELINE=$G(^TMP("XVV","IR"_VRRS,$J,YND))   ; Editor line
 N NELINE S NELINE=$G(^TMP("XVV","IR"_VRRS,$J,YND+1)) ; Next Line
 N PVLINE S PVLINE=$G(^TMP("XVV","IR"_VRRS,$J,YND-1)) ; Prev Line
 I NELINE'="",NELINE'[$C(30),NELINE'=" <> <> <>" S ELINE=ELINE_$E(NELINE,10,999) ; Concatentate
 S LINE=ELINE
 ;
 ;Find TAG^RTN
 S (TAG,RTN)=""
 N UPOS
 I LINE[$C(30) S UPOS=XCUR+2
 E             S UPOS=XCUR+1
 N LINEBOUN S LINEBOUN=0 ; Line Boundary
 I $E(LINE,UPOS)=U D  ; (sam): New code - for TAG^RTN
 . F I=1:1 S C=$E(LINE,UPOS-I) Q:C=""  Q:'(C?1AN!(C?1"%"))  S TAG=C_TAG
 . I LINE'[$C(30),UPOS-I<10 S LINEBOUN=1
 . F I=1:1 S C=$E(LINE,UPOS+I) Q:C=""  Q:'(C?1AN!(C?1"%"))  S RTN=RTN_C
 . I LINEBOUN D
 .. F I=$L(PVLINE):-1 S C=$E(PVLINE,I) Q:C=""  Q:'(C?1AN!(C?1"%"))  S TAG=C_TAG
 ;
 I $E(LINE,UPOS)?1(1"%",1AN) D  ; (sam): New code for just tags so you can ESC-R to tags
 . F I=1:1 S C=$E(LINE,UPOS-I) Q:C=""  Q:'(C?1AN!(C?1"%"))  S TAG=C_TAG
 . I LINE'[$C(30),UPOS-I<10 S LINEBOUN=1
 . S TAG=TAG_$E(LINE,UPOS)
 . F I=1:1 S C=$E(LINE,UPOS+I) Q:C=""  Q:'(C?1AN!(C?1"%"))  S TAG=TAG_C
 . I LINEBOUN D
 .. F I=$L(PVLINE):-1 S C=$E(PVLINE,I) Q:C=""  Q:'(C?1AN!(C?1"%"))  S TAG=C_TAG
 . S RTN=^TMP("XVV","VRR",$J,VRRS,"NAME")
 ;
 ; Now check that we don't have duds
 I TAG["%",$E(TAG)'="%" S TAG="" ; % must be first
 I RTN["%",$E(RTN)'="%" S RTN=""
 I $E(RTN) S RTN="" ; for a routine, 1st char can't be numeric
 ;
 ; No Routine?
 I RTN="" W $C(7) Q
 ;
 ; Check the routine exists
 I RTN'="",$T(@(TAG_"^"_RTN))="" W $C(7) Q
 ;
 ;Save RTN & TAG before clearing symbol table.
 S ^TMP("XVV",$J)=RTN_"^"_TAG
 D SYMTAB^XVEMKST("C","VRR",VRRS) ;Save symbol table
 ;
 ;FLAG("<ESC>R")=If user hits <ESC>R to branch to rtn, and the rtn is
 ;               locked, clear screen before displaying msg.
 S FLAG("<ESC>R")=1
 ;
 S RTN=$$GETRTN()
 S TAG=$P(^TMP("XVV",$J),"^",2)
 I RTN'=0 D PARAM^XVEMR(RTN,TAG)
 D SYMTAB^XVEMKST("R","VRR",VRRS) ;Restore symbol table
 KILL ^TMP("XVV",$J)
 Q
 ;
GETRTN() ;Parse routine name
 NEW CODE,I,RTN
 I VRRS>1023 W $C(7) Q 0
 S CODE=$P(^TMP("XVV",$J),"^",1)
 S RTN=$E(CODE,1)
 I RTN'="%",RTN'?1A W $C(7) Q 0
 F I=2:1 Q:$E(CODE,I)'?1AN  S RTN=RTN_$E(CODE,I)
 I '$$EXIST^XVEMKU(RTN) W $C(7) Q 0
 Q RTN
 ;===================================================================
GLB ;Select global for viewing by hitting <ESCG>
 ; ZEXCEPT: KEY. See below for note.
 ;(sam): Notes below.
 NEW GLB S GLB="" ; Global Name
 NEW RCUR SET RCUR=XCUR-8 ; Real Cursor
 NEW CARET S CARET=0 ; Look for ^
 ;
 N ELINE   S ELINE=$G(^TMP("XVV","IR"_VRRS,$J,YND))   ; Editor line
 N NELINE S NELINE=$G(^TMP("XVV","IR"_VRRS,$J,YND+1)) ; Next Line
 I NELINE'="",NELINE'[$C(30),NELINE'=" <> <> <>" S ELINE=ELINE_$E(NELINE,10,999) ; Concatentate
 N LLINE
 I ELINE[$C(30) S LLINE=$P(ELINE,$C(30),2,99)            ; Level Line
 E              S LLINE=$E(ELINE,10,999)                 ; Continuation line
 N CHAR S CHAR=$E(LLINE,RCUR)          ; Char at Cursor
 I CHAR="^" S GLB=$E(LLINE,RCUR,999) ; Get Global
 I CHAR="("!(CHAR=")")!(CHAR=",") N DONE S DONE=0 FOR  DO  Q:CARET  Q:DONE  ; If ESC-G over ( or , construct global to Caret
 . N I F I=RCUR:-1:0 S CHAR=$E(LLINE,I) I CHAR="^" S CARET=I QUIT  ; Find Caret
 . I CARET QUIT
 . N PLINE S PLINE=$G(^TMP("XVV","IR"_VRRS,$J,YND-1)) ; prev line
 . I PLINE="" S DONE=1 QUIT                           ; no prev line to be found
 . I PLINE[$C(30) S PLINE=$P(PLINE,$C(30),2,99)  ; Full line
 . E              S PLINE=$E(PLINE,10,999)       ; Actually a continuation itself
 . S LLINE=PLINE_LLINE,RCUR=RCUR+$L(PLINE)       ; Construction full line for another search
 I CARET S GLB=$E(LLINE,CARET,RCUR) ; Get Global
 ;
 I GLB="" S KEY="S" W $C(7) QUIT  ; KEY="S" will keep us in the reader
 S GLB=$$PARSEGLB(GLB) ; Parse global, replacing variables with :
 I GLB="" S KEY="S" W $C(7) QUIT  ; KEY="S" will keep us in the reader
 S ^TMP("XVV",$J)=GLB
 D ENDSCR^XVEMKT2
 D SYMTAB^XVEMKST("C","VRR",VRRS) ;Save symbol table
 D PARAM^XVEMG(^TMP("XVV",$J))
 KILL ^TMP("XVV",$J)
 D SYMTAB^XVEMKST("R","VRR",VRRS) ;Restore symbol table
 D REDRAW1^XVEMRU
 Q
PARSEGLB(G) ; [Internal] Parse the global into a format XVEMG recognizes
 N FLAGQ S FLAGQ=0
 N DONE S DONE=0
 N GOUT S GOUT=""
 N GOPAR S GOPAR=0 ; Paren count
 N MODE S MODE="GNAME"
 N I,C
 D
 . I $E(G)'="^" QUIT
 . S GOUT="^"
 . F I=2:1:$L(G) Q:FLAGQ  Q:DONE  S C=$E(G,I) D @MODE
 I MODE="GPQUOTE" S GOUT=$P(GOUT,"""") ; Abnormal termination. Get first part.
 I $E(GOUT,$L(GOUT))="," S $E(GOUT,$L(GOUT))=""
 Q GOUT
GNAME ; [Internal] Get global name
 I C?1"%",$E(GOUT,2)=""        S GOUT=GOUT_C QUIT
 I C?1AN                       S GOUT=GOUT_C QUIT
 I C="(" S GOUT=GOUT_C,GOPAR=GOPAR+1,MODE="GOPAR" QUIT
 S FLAGQ=1
 QUIT
GOPAR ; [Internal] Open parens
 I C="""" S GOUT=GOUT_C S MODE="GPQUOTE" QUIT
 I C?1N!(C=".") S GOUT=GOUT_C QUIT        ; Numbers are literals
 I C="," S GOUT=GOUT_C QUIT               ; Commas are okay
 I C="$" S MODE="GISVFUNC" QUIT           ; ISVs or Functions (int/ext)
 I C?1A,$E(G,I-1)="$" S GOUT=GOUT_C QUIT  ; Ditto
 I C=")" S GOPAR=GOPAR-1,GOUT=GOUT_C,DONE=1 QUIT      ; Done
 S GOUT=GOUT_":,",MODE="GCADV"            ; advance past next comma
 QUIT
GCADV ; [Internal] Advance till next comma
 I C="(" S GOPAR=GOPAR+1 QUIT  ; Increment paren count
 I C=")" S GOPAR=GOPAR-1       ; decrement ditto
 I GOPAR>1 QUIT                ; if inside parens (e.g. function) keep going. Ignore comma.
 I GOPAR<1 S $E(GOUT,$L(GOUT))=")",DONE=1 QUIT       ; Terminal Paren. We are done. Replace ":," with ":)"
 I C'="," QUIT                 ; terminate at comma only if at bottom parens
 S MODE="GOPAR"
 QUIT
GISVFUNC ; [Internal] Handle $ - ISV/Functions inside globals
 ; By the time we are here, the dollar was traversed and discarded
 ; Only allowable ISV is $J otherwise discard
 I $E(G,I)="J",'($E(G,I+1)="(") S GOUT=GOUT_"$J",MODE="GOPAR" QUIT  ; $JOB not $JUSTIFY
 I $E(G,I,I+2)="JOB"            S GOUT=GOUT_"$J",MODE="GOPAR" QUIT  ; $JOB for sure
 S GOUT=GOUT_":,"
 S MODE="GCADV"
 QUIT
GPQUOTE ; [Internal] Quote inside parens
 I C'="""" S GOUT=GOUT_C QUIT
 S MODE="GOPAR",GOUT=GOUT_C
 QUIT
TEST ; [Public] Tests Global parser
 i $t(+0^%ut)="" quit
 do en^%ut($t(+0),1)
 quit
T1 ; @TEST Test Global parser with $J
 do eq^%ut($$PARSEGLB^XVEMREP("^UTILITY($J,""BOO"",99,""FOO"")"),"^UTILITY($J,""BOO"",99,""FOO"")")
 quit
T2 ; @TEST Test Global parser with embedded functions and parens
 do eq^%ut($$PARSEGLB^XVEMREP("^PSRX(RX,1,$P($G(RXFL(RX)),""^""),0)) K RXY,RXP,REPRINT Q"),"^PSRX(:,1,:,0)")
 quit
 ;
T3 ; @TEST Parse Global with a number in the name
 do eq^%ut($$PARSEGLB^XVEMREP("^VX523A($J,RXN,1)"),"^VX523A($J,:,1)")
 quit
T4 ; @TEST Parse TMP global with unusual output
 do eq^%ut($$PARSEGLB^XVEMREP("^TMP($J,""PSOCP"",DFN)"),"^TMP($J,""PSOCP"",:)")
 quit
 ;
 ;===================================================================
RETURN ;Process <RET> key
 ;If new rtn, open new line regardless of parameter setting.
 I $G(^TMP("XVV","IR"_VRRS,$J,1))=" <> <> <>" D INSERT^XVEMRI(2) Q
 NEW MD,X,Y
 S MD="",FLAGSAVE=1
 S:$G(XVV("ID"))>0 MD=$G(^XVEMS("E","PARAM",XVV("ID"),"RETURN"))
 I MD'=2 D INSERT^XVEMRI(2) Q  ;Open line below
 S X=$G(^TMP("XVV","IR"_VRRS,$J,YND))
 I X=" <> <> <>"!(X']"") W $C(7) Q
 ;--> If cursor is at beginning of line, open line above
 I X[$C(30),XCUR'>($F(X,$C(30))-2) D INSERT^XVEMRI(1) Q
 ;--> If cursor is at end of line, open line below
 S Y=$G(^TMP("XVV","IR"_VRRS,$J,YND+1))
 I Y[$C(30)!(Y=" <> <> <>"),XCUR>($L(X)-$S(X[$C(30):2,1:1)) D INSERT^XVEMRI(2) Q
 ;--> Break line
 D BREAK^XVEMREJ
 D REDRAW^XVEMRU(YND)
 Q
