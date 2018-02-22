XVEMKTS ;DJB/KRN**Txt Scroll-SELECTOR ;2017-08-15  1:15 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in TOP+1,INIT+3 (c) 2016 Sam Habiel
 ;
TOP ;
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^XVEMKT2,UNWIND^XVEMSY"
 NEW DX,DY,FLAGQ,XVVT NEW:'$D(XVV) XVV NEW:'$D(XVVS) XVVS
 S FLAGQ=0
 KILL ^TMP("XVV","K",$J)
 KILL ^TMP("VPE","SELECT",$J)
 D INIT G:FLAGQ EX
 D TEMPLATE
 D SCROLL^XVEMKT2()
 D LIST
 D ENDSCR^XVEMKT2
EX ;
 KILL ^TMP("XVV","K",$J)
 I $G(DDS) X XVVS("RM0") ;...Called from ScreenMan
 Q
 ;===============================================================
LIST ;Display text
 S XVVT=$G(^TMP("XVV","K",$J,XVVT("BOT")))
 W ! I XVVT=" <> <> <>" W ?3,XVVT
 E  D  ;
 . W:$D(^TMP("VPE","SELECT",$J,XVVT("HLN"))) "=>"
 . W ?3 W:$G(NUMBER) $J(XVVT("HLN"),3)_". "
 . W $S(XVVT[$C(9):$P(XVVT,$C(9),2,999),1:XVVT)
 S XVVT("BOT")=XVVT("BOT")+1
 S:XVVT("GAP") XVVT("GAP")=XVVT("GAP")-1
 S XVVT("HLN")=XVVT("HLN")+1 ;Highlight Line
 S:XVVT("H$Y")<XVVT("S2") XVVT("H$Y")=XVVT("H$Y")+1 ;Highlight $Y
 I XVVT=" <> <> <>"!'XVVT("GAP") D READ^XVEMKTT Q:FLAGQ
 G LIST
 ;====================================================================
TAG ;Tag/Untag a line
 I $D(^TMP("VPE","SELECT",$J,XVVT("HLN")-1)) KILL ^(XVVT("HLN")-1) Q
 D SET(XVVT("HLN")-1)
 Q
ALL ;Tag all lines
 NEW I
 F I=1:1 Q:'$D(^TMP("XVV","K",$J,I))  D SET(I)
 D REDRAW^XVEMKT2()
 Q
CURSORUP ;Tag Cursor-to-Top
 NEW I
 F I=1:1:(XVVT("HLN")-1) Q:'$D(^TMP("XVV","K",$J,I))  D SET(I)
 D REDRAW^XVEMKT2()
 Q
CURSORDN ;Tag Cursor-to-Bottom
 NEW I
 F I=(XVVT("HLN")-1):1 Q:'$D(^TMP("XVV","K",$J,I))  D SET(I)
 D REDRAW^XVEMKT2()
 Q
CLEAR ;Clear all tagged lines
 KILL ^TMP("VPE","SELECT",$J) D REDRAW^XVEMKT2()
 Q
PAGE ;Tag a page
 NEW I
 F I=XVVT("TOP"):1:(XVVT("BOT")-1) D SET(I)
 D REDRAW^XVEMKT2()
 Q
FIND(MODE) ;MODE: +=Find&Tag  -=Find&Clear
 NEW AND,CHAR1,CHAR2,COL1,COL2,DATA,FIND,I
 D ENDSCR^XVEMKT2
 S MODE=$G(MODE)
 S (COL1,COL2,CHAR1,CHAR2,AND)=""
 W !,"F I N D   &   "
 W $S(MODE="+":"T A G",1:"C L E A R")_"   U T I L I T Y"
FIND1 S COL1=$$FINDCOL() I COL1="" D REDRAW^XVEMKT2() Q
FIND2 S CHAR1=$$FINDCHR() I CHAR1="" G FIND1
 W !
 G:$$ASK^XVEMKU("Do you want to include a 2nd criteria",2)'="Y" FIND6
FIND3 W !!,"[A]nd -or- [O]r: "
 R AND:300 S:'$T AND="" I "^"[AND G FIND6
 S AND=$$ALLCAPS^XVEMKU(AND)
 I AND'="A",AND'="O" D  G FIND3
 . W !,"If you want to include a 2nd criteria, then enter A or O."
 . W !,?3,"A = Both criteria must be true"
 . W !,?3,"O = Either criteria must be true"
FIND4 S COL2=$$FINDCOL() I COL2="" G FIND6
FIND5 S CHAR2=$$FINDCHR() I CHAR2="" G FIND4
FIND6 F I=1:1 Q:'$D(^TMP("XVV","K",$J,I))  S DATA=^(I) D  ;
 . I DATA[$C(9) S DATA=$P(DATA,$C(9),2,999)
 . I AND="",$P(DATA,"|",COL1)'[CHAR1 Q
 . I AND="A",$P(DATA,"|",COL1)'[CHAR1!($P(DATA,"|",COL2)'[CHAR2) Q
 . I AND="O",$P(DATA,"|",COL1)'[CHAR1&($P(DATA,"|",COL2)'[CHAR2) Q
 . I MODE="+" D SET(I) Q
 . KILL ^TMP("VPE","SELECT",$J,I) ;Clear tag
 D REDRAW^XVEMKT2()
 Q
 ;
FINDCOL() ;Get column #
 NEW COL
 W !!,"Look in which column?"
FINDCOL1 W !,"Enter COLUMN: "
 R COL:300 S:'$T COL="" I "^"[COL Q ""
 S COL=COL\1
 I COL<1 W "   Enter a valid column number." G FINDCOL1
 Q COL
 ;
FINDCHR() ;Get characters
 NEW CHAR
 W !!,"Look for what characters?"
FINDCHR1 W !,"Enter CHARACTERS: "
 R CHAR:300 S:'$T CHAR="" I "^"[CHAR Q ""
 I CHAR["?" W "   Enter characters to look for." G FINDCHR1
 Q CHAR
 ;
SET(VAL) ;Set "tagged" array. VAL=Line number
 Q:'$D(^TMP("XVV","K",$J,VAL))  Q:^(VAL)=" <> <> <>"
 S ^TMP("VPE","SELECT",$J,VAL)=^TMP("XVV","K",$J,VAL)
 Q
 ;====================================================================
TEMPLATE ;Set pre-selected nodes
 Q:$G(TEMPLATE)']""  Q:'$D(@TEMPLATE)
 NEW SUB
 S SUB=0
 F  S SUB=$O(@TEMPLATE@(SUB)) Q:'SUB  D  ;
 . Q:'$D(^TMP("XVV","K",$J,SUB))
 . S ^TMP("VPE","SELECT",$J,SUB)=^TMP("XVV","K",$J,SUB)
 Q
INIT ;
 NEW HD,TOT
 S FLAGQ=0
 I $D(XVSIMERR4) S $EC=",U-SIM-ERROR,"
 D INIT^XVEMKT Q:FLAGQ
 D INIT1^XVEMKT
 D INIT2^XVEMKT
 S @("HD=$G("_GLBHLD_",""HD""))"),HD=$E(HD,1,XVV("IOM")-10)
 D GETS^XVEMKTG ;...Build array. TOT will equal number of entries.
 S TOT=TOT_$S(TOT>1:" Items",1:" Item")
 S XVVT("HD")=2,XVVT("HD",2)=XVVT("HD",1)
 S XVVT("HD",1)=" Select: "_$S(HD]"":HD,1:"ITEMS")
 S XVVT("FT",1)=$E(XVVT("FT",1),1,XVV("IOM")-$L(TOT)-6)_TOT_$E(XVVT("FT",1),1,5)
 S XVVT("FT",2)="<> <SPACE>=Tag  A=TgAll  C=ClrAll  +=Fnd&Tg  -=Fnd&Clr  ?=Help  M=More"_$S($G(NEW)=1:"  N=New",1:"")
 S XVVT("S1")=3,(XVVT("GAP"),XVVT("SL"))=XVVT("S2")-XVVT("S1")+1
 S XVVT("H$Y")=XVVT("S1")-1 ;...Highlight line $Y
 Q
