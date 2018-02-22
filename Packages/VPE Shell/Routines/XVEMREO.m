XVEMREO ;DJB/VRR**EDIT - Open/Close/Blank/Unblank lines ;2017-08-15  1:43 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
OPEN ;Open a new line.
 S XCUR=0
 I YND<(XVVT("BOT")-1) D  Q
 . S YCUR=YCUR+1,YND=YND+1
 . D INSERT(XCUR,YCUR-1)
 . S DX=XCUR,DY=YCUR X XVVS("CRSR")
 ;Cursor is at bottom of screen
 S YND=YND+1,XVVT("BOT")=XVVT("BOT")+1,XVVT("TOP")=XVVT("TOP")+1
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 W !
 Q
CLOSE ;Close opened line
 NEW GAP,I
 ;Adjust when end of rtn is on screen
 S GAP=XVVT("TOP")+20>$O(^TMP("XVV","IR"_VRRS,$J,""),-1)
 I GAP S XVVT("GAP")=XVVT("GAP")+1,XVVT("BOT")=XVVT("BOT")-1
 S YND=YND-1,YCUR=YCUR-1
 S DX=0,DY=YCUR
 D REDRAW(YND+1,XVVT("BOT"))
 I GAP D ERASEBOT ;Clear lines leftover after " <> <> <>"
 S DX=0,DY=YCUR X XVVS("CRSR")
 Q
 ;=================================================================
INSERT(DX,DY) ;Insert a line. Uses escape sequences not supported by MSM NT.
 S DX=+$G(DX),DY=+$G(DY)
 I $G(^%ZOSF("OS"))["MSM for Windows NT" D ZINSERT(DX,DY) Q
 X XVVS("CRSR")
 W @XVVS("INDEX"),@XVVS("INSRT")
 ;-> Inserting when end-of-file and there's space left on screen.
 I XVVT("GAP") S XVVT("GAP")=XVVT("GAP")-1,XVVT("BOT")=XVVT("BOT")+1
 Q
 ;
ZINSERT(DX,DY) ;Insert a line. Don't use above escape sequences.
 S DX=+$G(DX),DY=+$G(DY)+1 X XVVS("CRSR")
 W @XVVS("BLANK_C_EOL") X XVVS("XY")
 ;-> Inserting when end-of-file and there's space left on screen.
 I XVVT("GAP") S XVVT("GAP")=XVVT("GAP")-1,XVVT("BOT")=XVVT("BOT")+1
 D REDRAW(YND,XVVT("BOT")-1)
 S DX=0,DY=YCUR X XVVS("CRSR")
 Q
 ;=================================================================
ERASEBOT ;Erase lines leftover after "<> <> <>"
 S DX=0,DY=XVVT("BOT")-XVVT("TOP")+1
 Q:DY'<XVVT("S2")
 X XVVS("CRSR")
 W @XVVS("BLANK_C_EOL")
 X XVVS("XY")
 Q
 ;
PUSHDWN ;This would push all lines down when a line was closed, rather than
 ;moving the next line up. I no longer do this.
 NEW TMP
 I YND'<(XVVT("BOT")-1) D  Q
 . S XVVT("TOP")=XVVT("TOP")-1
 . S XVVT("BOT")=XVVT("BOT")-1
 . D INSERT(0,(XVVT("S1")-2))
 . S YND=YND-1
 . S DX=0,DY=(XVVT("S1")-1) X XVVS("CRSR")
 . W @XVVS("BLANK_C_EOL")
 . X XVVS("XY")
 . S TMP=$G(^TMP("XVV","IR"_VRRS,$J,XVVT("TOP")))
 . W $P(TMP,$C(30),1)
 . W $P(TMP,$C(30),2,99)
 . S DX=XCUR,DY=YCUR X XVVS("CRSR")
 Q
 ;====================================================================
BLANK(NUM) ;Blank NUM lines for inserting messages
 NEW I
 S:$G(NUM)'>0 NUM=1
 D @$S(YCUR<(XVVT("BOT")-XVVT("TOP")-NUM):"BLANKB",1:"BLANKA")
 Q
 ;
BLANKA ;Blank lines ABOVE current line
 F I=1:1:NUM D  ;
 . S DX=0,DY=YCUR-I X XVVS("CRSR")
 . W @XVVS("BLANK_C_EOL")
 S DX=0,DY=YCUR-NUM X XVVS("CRSR")
 Q
 ;
BLANKB ;Blank lines BELOW current line
 F I=1:1:NUM D  ;
 . S DX=0,DY=YCUR+I X XVVS("CRSR")
 . W @XVVS("BLANK_C_EOL")
 S DX=0,DY=YCUR+1 X XVVS("CRSR")
 Q
 ;
REDRAW(START,END) ;Redraw rest of screen
 ;START: YND+1        -or-   YND
 ;END..: XVVT("BOT")  -or-   XVVT("BOT")-1
 NEW I,TMP
 F I=START:1 Q:I'<END  D  Q:$G(^(I))=" <> <> <>"
 . S DY=DY+1 X XVVS("CRSR")
 . W @XVVS("BLANK_C_EOL") X XVVS("XY")
 . S TMP=$G(^TMP("XVV","IR"_VRRS,$J,I))
 . W $P(TMP,$C(30),1)
 . W $P(TMP,$C(30),2,99)
 Q
 ;==================================================================
 ;I don't remember why this code is here. Thought I'd keep it anyway.
REDRAWX(NUM) ;
 NEW I,TMP
 D @$S(YCUR<(XVVT("BOT")-XVVT("TOP")-NUM):"REDRAWB",1:"REDRAWA")
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 Q
REDRAWA ;Redraw lines above current line
 F I=1:1:NUM D  ;
 . S DX=0,DY=YCUR-I X XVVS("CRSR") W @XVVS("BLANK_C_EOL") X XVVS("XY")
 . S TMP=$G(^TMP("XVV","IR"_VRRS,$J,YND-I)) Q:TMP']""
 . W $P(TMP,$C(30),1),$P(TMP,$C(30),2,99)
 Q
REDRAWB ;Redraw lines below current line
 F I=1:1:NUM D  ;
 . S DX=0,DY=YCUR+I X XVVS("CRSR") W @XVVS("BLANK_C_EOL") X XVVS("XY")
 . S TMP=$G(^TMP("XVV","IR"_VRRS,$J,YND+I-1)) Q:TMP']""
 . W $P(TMP,$C(30),1),$P(TMP,$C(30),2,99)
 Q
