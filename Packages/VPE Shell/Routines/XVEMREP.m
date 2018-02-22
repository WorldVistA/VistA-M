XVEMREP ;DJB/VRR**EDIT - Web,Html,Parse Rtn/Global,RETURN ;2017-08-16  12:13 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; ESC-R & ESC-G code refactored by Sam Habiel (c) 2016
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
 S LINE=$G(^TMP("XVV","IR"_VRRS,$J,YND))
 ;
 ;Find TAG^RTN ; NB: (sam): I heavily modified this algorithm
 S (TAG,RTN)=""
 I LINE[$C(30) D  ; (old code assumes 8 chars for TAG^LINE)
 . ;S TAG=$E(LINE,(XCUR-7),(XCUR+1)) ;Go left for TAG (sam): Old
 . ;S RTN=$E(LINE,XCUR+3,XCUR+10) ;..Go right for LINE (sam): Old
 . I $E(LINE,XCUR+2)=U D  ; (sam): New code - for TAG^RTN
 . . N UPOS S UPOS=XCUR+2
 . . F I=1:1 S C=$E(LINE,UPOS-I) Q:C=""  Q:'(C?1AN!(C?1"%"))  S TAG=C_TAG
 . . F I=1:1 S C=$E(LINE,UPOS+I) Q:C=""  Q:'(C?1AN!(C?1"%"))  S RTN=RTN_C
 . ;
 . I $E(LINE,XCUR+2)?1AN D  ; (sam): New code for just tags so you can ESC-R to tags
 . . N UPOS S UPOS=XCUR+2
 . . F I=1:1 S C=$E(LINE,UPOS-I) Q:C=""  Q:'(C?1AN!(C?1"%"))  S TAG=C_TAG
 . . S TAG=TAG_$E(LINE,UPOS)
 . . F I=1:1 S C=$E(LINE,UPOS+I) Q:C=""  Q:'(C?1AN!(C?1"%"))  S TAG=TAG_C
 . . S RTN=^TMP("XVV","VRR",$J,VRRS,"NAME")
 . ;
 . ; Now check that we don't have duds
 . I TAG["%",$E(TAG)'="%" S TAG="" ; % must be first
 . I RTN["%",$E(RTN)'="%" S RTN=""
 . I $E(RTN) S RTN="" ; for a routine, 1st char can't be numeric
 ;
 I $L(RTN)'>7 D  ;
 . S TMP=$G(^TMP("XVV","IR"_VRRS,$J,(YND+1)))
 . Q:TMP[$C(30)  Q:TMP=" <> <> <>"
 . S RTN=RTN_$E(TMP,10,9+8-$L(RTN))
 ;
 ; Check the routine exists
 I $T(@(TAG_"^"_RTN))="" W $C(7) Q
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
 ;(sam): Notes below.
 NEW DIFF,TMP,TMP1,ZX,ZY,ZZ,KEY
 I $G(FLAGGLB)']"" D  S KEY="S"  ; Don't know what KEY="S" means now.
 . S TMP=$G(^TMP("XVV","IR"_VRRS,$J,YND)) ; Get line
 . I TMP[$C(30) S TMP=XCUR+2_"^"_$E(TMP,XCUR+2,XCUR+32) ; Get cursor posotion ^ read 30 chars
 . E  S TMP=XCUR+1_"^"_$E(TMP,XCUR+1,XCUR+31) ; shouldn't run
 . S FLAGGLB=$P(TMP,"^",1)_"^"_YND_"^"_$P(TMP,"^",2,999) ; FLAGGLB = Cursor pos ^ line number ^ global
 . S TMP=$P(FLAGGLB,"^",3,999)  Q:$L(TMP)>29  ; Read the next line for continuation
 . S TMP1=$G(^(YND+1))  Q:TMP1[$C(30)  Q:TMP1=" <> <> <>"
 . S FLAGGLB=FLAGGLB_$E(TMP1,10,10+30-$L(TMP))
 ;
 ; ZX = cur pos, ZY = line number; ZZ global
 S ZX=$P(FLAGGLB,"^",1),ZY=$P(FLAGGLB,"^",2),ZZ=$P(FLAGGLB,"^",3,999)
 ; (sam): Next 5 lines make no sense to me.
 ;S DIFF=$S($G(^TMP("XVV","IR"_VRRS,$J,YND))[$C(30):XCUR+2,1:XCUR+1)
 ;I (YND-ZY)>1 KILL FLAGGLB Q  ;Moved cursor too far
 ;I (ZY>YND) KILL FLAGGLB Q  ;Moved cursor up
 ;I YND>ZY S DIFF=ZX+(XVV("IOM")-ZX)+DIFF-10 I ZX>DIFF KILL FLAGGLB Q
 ;S DIFF=DIFF-ZX+1,FLAGGLB=$E(ZZ,1,DIFF)
 ;S ^TMP("XVV",$J)=FLAGGLB KILL FLAGGLB
 S ZZ=$$PARSEGLB(ZZ)
 I ZZ="" QUIT
 S ^TMP("XVV",$J)=ZZ KILL FLAGGLB
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
 N MODE S MODE="GNAME"
 N I,C
 D
 . I $E(G)'="^" QUIT
 . S GOUT="^"
 . F I=2:1:$L(G) Q:FLAGQ  Q:DONE  S C=$E(G,I) D @MODE
 I MODE="GPQUOTE" S GOUT=$P(GOUT,"""") ; Abnormal termination. Get first part.
 I $E(GOUT,$L(GOUT))="," S $E(GOUT,$L(GOUT))=""
 I $E(GOUT,$L(GOUT)-1,$L(GOUT))=",0" S $E(GOUT,$L(GOUT)-1,$L(GOUT))=""
 Q GOUT
GNAME ; [Internal] Get global name
 I C?.1"%".A S GOUT=GOUT_C QUIT
 I C="(" S GOUT=GOUT_C,MODE="GOPAR" QUIT
 S FLAGQ=1
 QUIT
GOPAR ; [Internal] Open parens
 I C="""" S GOUT=GOUT_C S MODE="GPQUOTE" QUIT
 I C?1N!(C=".") S GOUT=GOUT_C QUIT  ; Numbers are literals
 I C="," S GOUT=GOUT_C QUIT  ; Commas are okay
 I C="$",$E(G,I+1)?1A S GOUT=GOUT_C QUIT  ; ISVs are okay.
 I C?1A,$E(G,I-1)="$" S GOUT=GOUT_C QUIT  ; Ditto
 I C=")" S DONE=1,MODE="GCPAR" QUIT  ; Done; don't append
 S GOUT=GOUT_":,",MODE="GCADV"  ; advance past next comma
 QUIT
GCADV ; [Internal] Advance till next comma
 I C'="," QUIT
 S MODE="GOPAR"
 QUIT
GPQUOTE ; [Internal] Quote inside parens
 I C'="""" S GOUT=GOUT_C QUIT
 S MODE="GOPAR",GOUT=GOUT_C
 QUIT
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
