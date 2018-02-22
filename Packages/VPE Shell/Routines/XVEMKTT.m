XVEMKTT ;DJB/KRN**Txt Scroll-SELECTOR READ ;2017-08-15  1:16 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
READ ;Get input
 ;Move highlight to top line
 I $G(XVVT("FIND-TOP"))]"" D FINDTOP KILL XVVT("FIND-TOP")
 NEW KEY,PKG,VK
 S PKG="K",U="^"
READ1 D HIGHLITE("ON")
 S KEY=$$READ^XVEMKRN("",1,1),KEY=$$ALLCAPS^XVEMKU(KEY),VK=XVV("K")
 I VK="<AU>" D  G READ1
 . I (XVVT("HLN")-1)>XVVT("TOP") D  Q
 . . D HIGHLITE("OFF")
 . . S XVVT("HLN")=XVVT("HLN")-1,XVVT("H$Y")=XVVT("H$Y")-1
 . I XVVT("TOP")>1 D UP Q
 . W $C(7)
 I VK="<AD>",XVVT("HLN")<XVVT("BOT") D  G READ1
 . D HIGHLITE("OFF") S XVVT("HLN")=XVVT("HLN")+1
 . S XVVT("H$Y")=XVVT("H$Y")+1
 I VK="<AD>" G:$$ENDFILE() READ1 D DOWN Q
 I KEY="^" S FLAGQ=1 Q
 I ",<ESC>,<F1E>,<F1Q>,<TO>,"[(","_VK_",") S FLAGQ=1 Q
 I VK="<ESCH>" D HELP^XVEMKT2,REDRAW^XVEMKT2() Q
 I KEY="?" D HELP^XVEMKTU,REDRAW^XVEMKT2() Q
 I KEY=" " D TAG^XVEMKTS G READ1
 I KEY="A" D ALL^XVEMKTS Q
 I KEY="C" D CLEAR^XVEMKTS Q
 ;I KEY="L" D FIND^XVEMKT1(KEY) Q
 I KEY="L" D LOCATE,REDRAW^XVEMKT2() Q
 I KEY="F" D FIND,REDRAW^XVEMKT2() Q
 I KEY="G" D GOTO,REDRAW^XVEMKT2() Q
 I KEY="+" D FIND^XVEMKTS("+") Q
 I KEY="-" D FIND^XVEMKTS("-") Q
 I KEY="M" D MORE^XVEMKTU,REDRAW^XVEMKT2() Q
 I KEY="N",$G(NEW)=1 D  S FLAGQ=1 Q
 . KILL ^TMP("VPE","SELECT",$J)
 . R KEY:1 ;Pause in case user hits N,<RETURN>
 . S ^TMP("VPE","SELECT",$J,"NEW")=""
 I KEY="P" D PAGE^XVEMKTS Q
 I KEY="S" D SHOW^XVEMKTU,REDRAW^XVEMKT2() Q
 I VK="<F4T>" D CURSORUP^XVEMKTS Q  ;Tag cursor to top line
 I VK="<F4B>" D CURSORDN^XVEMKTS Q  ;Tag cursor to bottom line
 I KEY="CT"!(VK="<F1AU>") D  G READ1 ;Cursor to top of page
 . Q:(XVVT("HLN")-1)'>XVVT("TOP")
 . D HIGHLITE("OFF") S XVVT("HLN")=XVVT("TOP")+1
 . S XVVT("H$Y")=XVVT("S1")
 I KEY="CD"!(VK="<F1AD>") D  G READ1 ;Cursor to bottom of page
 . Q:XVVT("HLN")'<XVVT("BOT")
 . D HIGHLITE("OFF") S XVVT("HLN")=XVVT("BOT")
 . S XVVT("H$Y")=$S(XVVT("GAP"):XVVT("S2")-XVVT("GAP"),1:XVVT("S2"))
 I ",<PGUP>,<F4AU>,"[(","_VK_",")!(KEY="U") W:XVVT("TOP")'>1 $C(7) G:XVVT("TOP")'>1 READ1 D LEFT^XVEMKTM Q
 I ",<PGDN>,<F4AD>,<RET>,"[(","_VK_",")!(KEY="D") G:$$ENDFILE() READ1 D RIGHT^XVEMKTM Q
 I ",<HOME>,<F4AL>,"[(","_VK_",")!(KEY="T") S XVVT("TOP")=1 D REDRAW^XVEMKT2() Q
 I ",<END>,<F4AR>,"[(","_VK_",")!(KEY="B") D BOTTOM^XVEMKT2(PKG) Q
 D HIGHLITE("OFF")
 G READ1
 ;====================================================================
ENDFILE() ;1=End-of-file  0=Ok
 I XVVT("GAP") W $C(7) Q 1
 I ^TMP("XVV","K",$J,XVVT("BOT")-1)=" <> <> <>" W $C(7) Q 1
 Q 0
HIGHLITE(MODE) ; MODE="ON"  - Draw highlight
 ;       MODE="OFF" - Redraw with no highlight
 NEW HL I $G(MODE)'="ON" S MODE="OFF"
 S DX=0,DY=XVVT("H$Y")-1 X XVVS("CRSR")
 W:MODE="ON" @XVV("RON")
 W $S($D(^TMP("VPE","SELECT",$J,XVVT("HLN")-1)):"=>",1:"  ")
 W:MODE="ON" @XVV("ROFF")
 Q
 ;====================================================================
UP ;Insert text at top.
 D HIGHLITE("OFF")
 S DX=0,DY=(XVVT("S1")-2) X XVVS("CRSR")
 W @XVVS("INDEX"),@XVVS("INSRT") X XVVS("CRSR")
 I XVVT("GAP") S XVVT("GAP")=XVVT("GAP")-1
 E  S XVVT("BOT")=XVVT("BOT")-1
 S XVVT("TOP")=XVVT("TOP")-1,XVVT("HLN")=XVVT("HLN")-1
 NEW TXT
 S TXT=$G(^TMP("XVV",PKG,$J,XVVT("TOP")))
 Q:TXT=" <> <> <>"
 W !?3 W:$G(NUMBER) $J(XVVT("TOP"),3)_". "
 W $S(TXT[$C(9):$P(TXT,$C(9),2,999),1:TXT)
 Q
DOWN ;Insert text at bottom
 D HIGHLITE("OFF")
 S DX=0,DY=(XVVT("S2")-1) X XVVS("CRSR")
 S XVVT("TOP")=XVVT("TOP")+1
 Q
GOTO ;Goto line number
 NEW NUM
 D ENDSCR^XVEMKT2
GOTO1 W !,"Select LINE NUMBER: "
 R NUM:300 S:'$T NUM="^" I "^"[NUM Q
 I '$D(^TMP("XVV","K",$J,NUM)) W $C(7),"   Invalid" G GOTO1
 S (XVVT("BOT"),XVVT("TOP"))=NUM,XVVT("GAP")=XVVT("SL")
 S XVVT("HLN")=XVVT("TOP")+1,XVVT("H$Y")=XVVT("S1")-1
 Q
FIND ;Find text using "B" xref. Only 1st 10 characters of each line is
 ;stored in "B" xref.
 NEW FIND,FINDHLD,NUM
 D ENDSCR^XVEMKT2
 W !!,"F I N D   U T I L I T Y"
 W !!,"Enter characters you want to search for. If found, the line starting"
 W !,"with these characters will appear at the top of the screen."
 W !!,"Enter CHARACTERS: "
 R FIND:300 S:'$T FIND="" Q:FIND=""
 S FINDHLD=FIND
 S FIND=$O(^TMP("XVV","K",$J,"B",FIND))
 Q:$E(FIND,1,$L(FINDHLD))'=FINDHLD
 S NUM=$O(^TMP("XVV","K",$J,"B",FIND,"")) Q:'NUM
 D SET
 Q
LOCATE ;Locate line that contains text.
 NEW FLAGQ,LOCATE,ND,NUM
 D ENDSCR^XVEMKT2
 W !!,"L O C A T E   U T I L I T Y"
 W !!,"Enter characters you want to search for. If found, the line containing"
 W !,"these characters will appear at the top of the screen."
 W !!,"Enter CHARACTERS: "
 R LOCATE:300 S:'$T LOCATE="" Q:LOCATE=""
 S FLAGQ=0
 S NUM=XVVT("TOP")
 F  S NUM=$O(^TMP("XVV","K",$J,NUM)) Q:'NUM  Q:FLAGQ  S ND=$G(^(NUM)) Q:ND=" <> <> <>"  D  ;
 . Q:ND'[LOCATE
 . D SET
 . S FLAGQ=1
 Q
SET ;Reset variables to correct line
 S (XVVT("BOT"),XVVT("TOP"))=NUM
 S XVVT("GAP")=XVVT("SL")
 S XVVT("HLN")=XVVT("TOP")+1
 S XVVT("H$Y")=XVVT("S1")-1
 S XVVT("FIND-TOP")=1 ;So highlight is moved to top of screen
 Q
FINDTOP ;Move highlight at top of screen
 S XVVT("HLN")=XVVT("TOP")+1,XVVT("H$Y")=XVVT("S1")
 Q
