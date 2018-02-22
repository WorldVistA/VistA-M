XVEMRER ;DJB/VRR**EDIT - RUN menu choices ;2017-08-16  12:14 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
RUN ;
 KILL DIRHLD ;Tracks cursor for <AU> & <AD>
 I VK="<F1AU>" D SCRNTOP Q  ;Cursor to top of scrn
 I VK="<F2AU>" D UP^XVEMRE(5) Q  ;Cursor up 5 lines
 I $G(^TMP("XVV","IR"_VRRS,$J,YND))=" <> <> <>" W $C(7) Q
 I VK="<F1AL>" D LNBEG^XVEMREM Q  ;Cursor left
 I VK="<F1AR>" D LNEND^XVEMREM Q  ;Cursor right
 I VK="<F1AD>" D SCRNBOT Q  ;Cursor to bottom of scrn
 I VK="<F2AL>" D LNLEFT^XVEMREM Q  ;Cursor left 15
 I VK="<F2AR>" D LNRIGHT^XVEMREM Q  ;Cursor right 15
 I VK="<F2AD>" D DOWN^XVEMRE(5) Q  ;Cursor down 5 lines
 I VK="<F1F1>" D LNLMAR^XVEMREM Q  ;Cursor to left margin
 I VK="<F2F2>" D LNRMAR^XVEMREM Q  ;Cursor to right margin
 I VK="<F1L>" D LNDOWN^XVEMREM Q  ;Cursor down 1 rtn line
 I ",<BS>,<DEL>,"[(","_VK_",") D  D ^XVEMREB Q  ;Delete
 . S:$G(XVV("BS"))="SAME" VK="<BS>" S FLAGSAVE=1
 Q
 ;
RUN2 ;Help Text
 D ENDSCR^XVEMKT2
 I VK="<ESCH>" D HELP^XVEMKT("VRR1") ;Help text
 I VK="<ESCK>" D HELP^XVEMKT("VRR2") ;Keyboard help
 D REDRAW1^XVEMRU
 Q
RUN3 ;Goto Top/Bottom of Rtn
 KILL DIRHLD ;Tracks cursor for <AU> & <AD>
 I ",<F4AR>,<END>,"[(","_VK_",") D  Q  ;Goto bottom of rtn
 . D BOTTOM^XVEMKT2("IR"_VRRS,1)
 . S YND=XVVT("TOP")
 . S YCUR=$O(^TMP("XVV","IR"_VRRS,$J,""),-1)-YND
 . S:YCUR<1 YCUR=1
 I ",<F4AL>,<HOME>,"[(","_VK_",") D  Q  ;Goto top of rtn
 . S (YCUR,YND,XVVT("TOP"))=1 D REDRAW1^XVEMRU
 Q
BLOCK(QUIT) ;Turn off Block mode
 S $P(FLAGMODE,"^",1)="" D MODEOFF^XVEMRU("BLOCK",$G(QUIT))
 Q
WEB ;Turn off Web mode
 S $P(FLAGMODE,"^",2)="" D MODEOFF^XVEMRU("WEB")
 Q
HTML ;Turn off HTML mode
 S $P(FLAGMODE,"^",3)="" D MODEOFF^XVEMRU("HTML")
 Q
BACKUP ;Backup a page
 S (XVVT("BOT"),XVVT("TOP"))=$S(XVVT("TOP")'>XVVT("SL"):1,1:XVVT("TOP")-XVVT("SL"))
 S YND=XVVT("TOP")+YCUR-1,XVVT("GAP")=XVVT("SL")
 D SCROLL^XVEMKT2(1)
 Q
FORWARD ;Go forward a page
 S XVVT("TOP")=XVVT("BOT"),XVVT("GAP")=XVVT("SL")
 S YND=XVVT("TOP")+YCUR-1
 D SCROLL^XVEMKT2(1)
 Q
SCRNTOP ;Go to top of screen
 S YND=XVVT("TOP"),DX=XCUR,(DY,YCUR)=1 X XVVS("CRSR")
 Q
SCRNBOT ;Go to bottom of screen
 S DX=XCUR,(DY,YCUR)=XVVT("BOT")-XVVT("TOP") X XVVS("CRSR")
 S YND=XVVT("BOT")-1
 Q:$G(^TMP("XVV","IR"_VRRS,$J,YND))'=" <> <> <>"
 S YND=YND-1,YCUR=YCUR-1
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 Q
