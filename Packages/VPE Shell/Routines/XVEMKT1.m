XVEMKT1 ;DJB/KRN**Txt Scroll-List TEXT ;2017-08-15  1:02 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in LIST+1 (c) 2016 Sam Habiel
 ;
GETXVVT ;Set XVVT=Display text
 I $D(^TMP("XVV","K",$J,XVVT("BOT"))) S XVVT=^(XVVT("BOT")) Q
 Q:$G(XVVT("IMPORT"))="YES"
 X XVVT("GET") S XVVT=$G(^TMP("XVV","K",$J,XVVT("BOT")))
 Q
LIST ;Display text
 I $D(XVSIMERR5) S $EC=",U-SIM-ERROR,"
 D GETXVVT W !,XVVT
 S XVVT("BOT")=XVVT("BOT")+1 ;Bottom line #
 S:XVVT("GAP") XVVT("GAP")=XVVT("GAP")-1 ;Empty lines left on page
 I XVVT=" <> <> <>"!'XVVT("GAP") D READ Q:FLAGQ
 I $G(XVVT("IMPORT"))="YES",'$D(^TMP("XVV","K",$J,XVVT("BOT"))) Q
 G LIST
ENDFILE() ;1=End-of-file  0=Ok
 I XVVT("GAP") W $C(7) Q 1
 I ^TMP("XVV","K",$J,XVVT("BOT")-1)=" <> <> <>" W $C(7) Q 1
 Q 0
READ ;Get input
 I $G(XVVT("FIND"))]"" D FINDCHK Q:$G(XVVT("FIND"))]""  ;Find text
 NEW KEY,VK
READ1 S KEY=$$READ^XVEMKRN("",1,1),KEY=$$ALLCAPS^XVEMKU(KEY),VK=XVV("K")
 I VK="<AU>" W:XVVT("TOP")'>1 $C(7) D:XVVT("TOP")>1 UP("K") G READ1
 I VK="<AD>" G:$$ENDFILE() READ1 D DOWN Q
 I ",<ESC>,<F1E>,<F1Q>,<TO>,"[(","_VK_",") S FLAGQ=1 Q
 I KEY="^" S FLAGQ=1 Q
 I KEY=" " G READ1
 I KEY="?"!(VK="<ESCH>") D  Q
 . D HELP^XVEMKT2,REDRAW^XVEMKT2()
 I KEY="F"!(KEY="L") D FIND(KEY) Q
 I ",<PGUP>,<F4AU>,"[(","_VK_",")!(KEY="U") W:XVVT("TOP")'>1 $C(7) G:XVVT("TOP")'>1 READ1 D LEFT Q
 I ",<PGDN>,<F4AD>,<RET>,"[(","_VK_",")!(KEY="D") G:$$ENDFILE() READ1 D RIGHT Q
 I ",<HOME>,<F4AL>,"[(","_VK_",")!(KEY="T") S XVVT("TOP")=1 D REDRAW^XVEMKT2() Q
 I ",<END>,<F4AR>,"[(","_VK_",")!(KEY="B") D BOTTOM^XVEMKT2() Q
 G READ1
 ;====================================================================
UP(PKG) ;Insert text at top.
 ;PKG=Calling package..."IG"_GLS=VGL,"K"=Generic
 S DX=0,DY=(XVVT("S1")-2) X XVVS("CRSR")
 W @XVVS("INDEX"),@XVVS("INSRT") X XVVS("CRSR")
 I XVVT("GAP") S XVVT("GAP")=XVVT("GAP")-1
 E  S XVVT("BOT")=XVVT("BOT")-1
 S XVVT("TOP")=XVVT("TOP")-1
 Q:^TMP("XVV",PKG,$J,XVVT("TOP"))=" <> <> <>"  W !,^(XVVT("TOP"))
 Q
DOWN ;Insert text at bottom
 S DX=0,DY=(XVVT("S2")-1) X XVVS("CRSR")
 S XVVT("TOP")=XVVT("TOP")+1
 Q
LEFT ;Back up a page
 S (XVVT("BOT"),XVVT("TOP"))=$S(XVVT("TOP")>XVVT("SL"):XVVT("TOP")-XVVT("SL"),1:1)
 S XVVT("GAP")=XVVT("SL") D SCROLL^XVEMKT2()
 Q
RIGHT ;Go forward a page
 S XVVT("TOP")=XVVT("BOT"),XVVT("GAP")=XVVT("SL")
 D SCROLL^XVEMKT2()
 Q
FIND(TYPE) ;
 D ENDSCR^XVEMKT2
 W !!?1,"S C R O L L E R   F I N D   U T I L I T Y"
 W !!?1,"Enter characters that you want the scroller to search for."
 W !?1,"If found, the line containing these characters will appear"
 W !?1,"at the bottom of the screen. If ""<> <> <>"" appears at the"
 W !?1,"bottom of the screen, you've reached the end of the display."
 W !!?1,"Enter CHARACTERS: "
 R XVVT("FIND"):300 I '$T KILL XVVT("FIND")
 D REDRAW^XVEMKT2()
 I $G(XVVT("FIND"))']"" KILL XVVT("FIND") Q
 S XVVT("FIND")=TYPE_"^"_XVVT("FIND")
 Q
FINDCHK ;Find text
 NEW FIND,TXT,TXT1,TYPE
 I XVVT=" <> <> <>" W $C(7) KILL XVVT("FIND") Q
 S TXT=$G(^TMP("XVV","K",$J,XVVT("BOT")-1)) Q:TXT']""
 S TXT1=$S(TXT[$C(9):$P(TXT,$C(9),2,99),1:TXT)
 S TYPE=$P(XVVT("FIND"),"^",1),FIND=$P(XVVT("FIND"),"^",2,99)
 I TYPE="L",TXT[FIND KILL XVVT("FIND") Q
 I TYPE="F" D  I $E(TXT1,1,$L(FIND))=FIND KILL XVVT("FIND") Q
 . ;Remove leading numbers and spaces
 . F  Q:$E(TXT1)?1A!(TXT1']"")  S TXT1=$E(TXT1,2,99)
 S XVVT("TOP")=XVVT("TOP")+1
 Q
LISTSC ;Display text with no pause, for Screen capture
 D GETXVVT Q:XVVT=" <> <> <>"  W !,XVVT
 I $G(XVVPAGE)>0,XVVT("BOT")#XVVPAGE=0 D PAUSE^XVEMKU(2,"Q") Q:FLAGQ  W @XVV("IOF")
 S XVVT("BOT")=XVVT("BOT")+1 ;Bottom line #
 G LISTSC
