XVEMKTM ;DJB/KRN**Txt Scroll-Highlight Menu [3/6/96 6:23pm];2017-08-15  1:14 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
ENDFILE() ;1=End-of-file  0=Ok
 I XVVT("GAP") W $C(7) Q 1
 I $G(^TMP("XVV",PKG,$J,XVVT("BOT")-1))=" <> <> <>"  W $C(7) Q 1
 Q 0
READ(PKG) ;PKG=Calling package's subscript ("IG"_GLS=VGL,"ID"_VEDDS=VEDD,etc)
 NEW HL,KEY,VK
READ1 I $G(TABHLD)]"" D  KILL TABHLD ;Keeps highlight at same node
 . S XVVT("HLN")=$P(TABHLD,"^",1),XVVT("H$Y")=$P(TABHLD,"^",2)
 D HIGHLITE("ON"),CURSOR^XVEMKU1(9,XVVT("S2")+XVVT("FT")-1,1)
 S KEY=$$READ^XVEMKRN(),KEY=$$ALLCAPS^XVEMKU(KEY),VK=XVV("K")
 I VK="<AU>" D  G READ1
 . I (XVVT("HLN")-1)>XVVT("TOP") D  Q
 . . D HIGHLITE("OFF") S XVVT("HLN")=XVVT("HLN")-1
 . . S XVVT("H$Y")=XVVT("H$Y")-1
 . I XVVT("TOP")>1 D UP Q
 . W $C(7)
 I VK="<AD>",XVVT("HLN")<XVVT("BOT") D  G READ1
 . D HIGHLITE("OFF") S XVVT("HLN")=XVVT("HLN")+1
 . S XVVT("H$Y")=XVVT("H$Y")+1
 I VK="<AD>" G:$$ENDFILE() READ1 D DOWN Q "QUIT"
 I KEY=" " G READ1
 I KEY="^" S FLAGQ=1 Q "QUIT"
 I ",<ESC>,<F1E>,<F1Q>,<TO>,"[(","_VK_",") S FLAGQ=1 Q "QUIT"
 I KEY="?" Q KEY
 I VK="<ESCH>" Q VK
 I ",<HOME>,<F4AL>,"[(","_VK_",")!(KEY="T") S XVVT("TOP")=1 D REDRAW^XVEMKT2() Q "QUIT"
 I ",<END>,<F4AR>,"[(","_VK_",")!(KEY="B") D BOTTOM^XVEMKT2(PKG) Q "QUIT"
 I VK="<F1AU>" D  G READ1
 . Q:(XVVT("HLN")-1)'>XVVT("TOP")
 . D HIGHLITE("OFF") S XVVT("HLN")=XVVT("TOP")+1
 . S XVVT("H$Y")=XVVT("S1")
 I VK="<F1AD>" D  G READ1
 . Q:XVVT("HLN")'<XVVT("BOT")
 . D HIGHLITE("OFF") S XVVT("HLN")=XVVT("BOT")
 . S XVVT("H$Y")=$S(XVVT("GAP"):XVVT("S2")-XVVT("GAP"),1:XVVT("S2"))
 I ",<PGUP>,<F4AU>,"[(","_VK_",")!(KEY="U") W:XVVT("TOP")'>1 $C(7) G:XVVT("TOP")'>1 READ1 D LEFT Q "QUIT"
 I ",<PGDN>,<F4AD>,<RET>,"[(","_VK_",")!(KEY="D") G:$$ENDFILE() READ1 D RIGHT Q "QUIT"
 S:KEY']"" KEY=VK
 Q KEY
 ;===================================================================
UP ;Insert text at top.
 D HIGHLITE("OFF")
 S DX=0,DY=(XVVT("S1")-2) X XVVS("CRSR")
 W @XVVS("INDEX"),@XVVS("INSRT") X XVVS("CRSR")
 I XVVT("GAP") S XVVT("GAP")=XVVT("GAP")-1
 E  S XVVT("BOT")=XVVT("BOT")-1
 S XVVT("TOP")=XVVT("TOP")-1,XVVT("HLN")=XVVT("HLN")-1
 NEW TXT
 S TXT=$G(^TMP("XVV",PKG,$J,XVVT("TOP")))
 Q:TXT=" <> <> <>"  I $G(VGLREV) D REVERSE^XVEMGI1(TXT) Q
 W !,TXT
 Q
DOWN ;Insert text at bottom
 D HIGHLITE("OFF")
 S DX=0,DY=(XVVT("S2")-1) X XVVS("CRSR")
 S XVVT("TOP")=XVVT("TOP")+1
 Q
LEFT ;Go back a page
 S XVVT("TOP")=$S(XVVT("TOP")>XVVT("SL"):XVVT("TOP")-XVVT("SL"),1:1)
 S XVVT("BOT")=XVVT("TOP"),XVVT("GAP")=XVVT("SL")
 S XVVT("HLN")=XVVT("TOP"),XVVT("H$Y")=XVVT("S1")
 D SCROLL^XVEMKT2()
 Q
RIGHT ;Go forward a page
 S XVVT("TOP")=XVVT("BOT"),XVVT("GAP")=XVVT("SL")
 S XVVT("HLN")=XVVT("TOP"),XVVT("H$Y")=XVVT("S1")-1
 D SCROLL^XVEMKT2()
 Q
HIGHLITE(MODE) ; MODE="ON"  - Draw highlight
 ;      MODE="OFF" - Redraw with no highlight
 NEW HL I $G(MODE)'="ON" S MODE="OFF"
 S DX=0,DY=XVVT("H$Y")-1 X XVVS("CRSR")
 W:MODE="ON" @XVV("RON")
 S HL=$E($G(^TMP("XVV",PKG,$J,XVVT("HLN")-1))) W $S(HL]"":HL,1:" ")
 W:MODE="ON" @XVV("ROFF")
 Q
