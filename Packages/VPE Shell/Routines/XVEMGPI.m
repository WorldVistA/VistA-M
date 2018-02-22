XVEMGPI ;DJB/VGL**PIECES - Scroller Import [5/5/97 5:40pm];2017-08-15  12:43 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
IMPORT ;Import text to the scroller
 D SETARRAY,LIST
 Q
GETXVVT ;Set XVVT=Display text
 S XVVT=$G(^TMP("XVV","IGP",$J,XVVT("BOT")))
 Q
LIST ;Display text
 D GETXVVT W !,XVVT
 S XVVT("BOT")=XVVT("BOT")+1
 S:XVVT("GAP") XVVT("GAP")=XVVT("GAP")-1
 I XVVT=" <> <> <>"!'XVVT("GAP") D READ
 Q:FLAGTYPE["SWITCH"!FLAGQ!FLAGE
 Q:'$D(^TMP("XVV","IGP",$J,XVVT("BOT")))
 G LIST
SETARRAY ;Set scroll array
 I $G(XVVT)']""!($G(XVVT)=" <> <> <>") D  Q
 . S ^TMP("XVV","IGP",$J,XVVT("BOT"))=" <> <> <>"
 S ^TMP("XVV","IGP",$J,XVVT("BOT"))=XVVT
 Q
ENDFILE() ;1=End-of-file  0=Ok
 I XVVT("GAP") W $C(7) Q 1
 I ^TMP("XVV","IGP",$J,XVVT("BOT")-1)=" <> <> <>"  W $C(7) Q 1
 Q 0
READ ;Get input
 W @XVVS("CON") ;Turn cursor back on
 D CURSOR^XVEMKU1(9,XVVT("S2")+XVVT("FT")-1,1)
 S KEY=$$READ^XVEMKRN()
 I ",^, ,"[(","_KEY_",") S FLAGQ=1 Q
 I ",<ESC>,<F1E>,<F1Q>,<TAB>,<TO>,"[(","_XVV("K")_",") S FLAGQ=1 Q
 I ",<HOME>,<F4AL>,"[(","_XVV("K")_",") S XVVT("TOP")=1 D REDRAW^XVEMKT2() Q
 I ",<END>,<F4AR>,"[(","_XVV("K")_",") D BOTTOM^XVEMKT2("IGP") Q
 I XVV("K")="<AU>" D  G READ
 . I XVVT("TOP")'>1 W $C(7) Q
 . D UP^XVEMKT1("IGP")
 I XVV("K")="<AD>" G:$$ENDFILE() READ D DOWN^XVEMKT1 Q
 I ",<PGUP>,<F4AU>,"[(","_XVV("K")_","),XVVT("TOP")'>1 W $C(7) G READ
 I ",<PGUP>,<F4AU>,"[(","_XVV("K")_",") D LEFT^XVEMKT1 Q
 I ",<PGDN>,<F4AD>,<RET>,"[(","_XVV("K")_",") G:$$ENDFILE() READ D RIGHT^XVEMKT1 Q
 S KEY=$$ALLCAPS^XVEMKU(KEY)
 I XVV("K")'="<ESCH>",",?,I,M,X,"'[(","_KEY_","),KEY'?1.N W $C(7) G READ
 I KEY="I" S FLAGTYPE="I^SWITCH" Q
 I KEY="X" S FLAGTYPE="X^SWITCH" Q
 D ENDSCR^XVEMKT2
 I KEY["?" D HELP
 I XVV("K")="<ESCH>" D HELP^XVEMKT2
 I KEY?1.N D INDIV^XVEMGP(KEY) Q:FLAGQ!FLAGE
 D REDRAW^XVEMKT2()
 Q
HELP ;
 W !?1,"'n'.........: Enter number from center column to view data dictionary"
 W !?2,"I .........: Display internal values on right side of screen"
 W !?2,"X .........: Display external values on right side of screen"
 D PAUSE^XVEMKC(2)
 Q
START ;Use Scroller
 NEW HD,LINE,MAR,TMP
 S MAR=$G(XVV("IOM")) S:MAR'>0 MAR=80
 S $P(LINE,"=",MAR)=""
 S TMP=GLNAM I TMP["""" S TMP=$$QUOTES2^XVEMKU(TMP)
 S HD=" "_Z1_") "_TMP,HD=HD_$J("",(MAR-17-$L(HD)))
 S HD=HD_$S(TYPE="X":"[EXTERNAL VALUE]",1:"[INTERNAL VALUE]")
 S XVVT("HD")=2,XVVT("FT")=3
 S XVVT("HD",1)=HD
 S XVVT("HD",2)=LINE
 S XVVT("FT",1)=LINE
 S XVVT("FT",2)="<>  'n'=FldDD  I=IntVal  X=ExtVal  ?=Help  <ESCH>=ScrollHelp"
 S XVVT("FT",3)=" Select: "
 S XVVT("S1")=3,XVVT("S2")=(XVV("IOSL")-3)
 S XVVT("GET")="D SETARRAY^XVEMGY"
 D IMPORTS^XVEMKT("IGP")
 Q
FINISH ;Call here AFTER calling IMPORT
 I 'FLAGQ,'FLAGE S XVVT=" <> <> <>" D IMPORT
 KILL ^TMP("XVV","IGP",$J)
 D ENDSCR^XVEMKT2 ;Reset to full screen
 Q
