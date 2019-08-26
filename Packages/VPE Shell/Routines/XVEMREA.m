XVEMREA ;DJB/VRR**EDIT - Add Character ;2019-05-20  6:43 PM
 ;;15.1;VICTORY PROG ENVIRONMENT;;Jun 19, 2019
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Syntax highlighting support by David Wicksell (c) 2019
 ;
TOP ;Add a character to CD string
 NEW CD,FLAGNEW,HLD,HLDX,HLDY1,HLDY2,I,NUM,WHERE,XSAVE,YSAVE,YNDSAVE
 S NUM=YND
 S CD(NUM)=$G(^TMP("XVV","IR"_VRRS,$J,NUM))
 S WHERE=$$CHKADD^XVEMREL() Q:WHERE="Q"
 D SET
 I $L(CD(NUM))<(XVV("IOM")-(CD(NUM)'[$C(30))) D SIMPLE G EX
 S HLDX=XCUR,HLDY1=YCUR ;Save cursor X&Y values. Used by SCROLL.
 D ADJARRAY
 D REDRAW
 D COMPLEX
EX ;Exit
 S XCUR=XSAVE,YCUR=YSAVE,YND=YNDSAVE
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 D ADJOPEN1
 Q
 ;
SET ;Adjust variables
 ;KEY=Character user typed. Set in ^XVEMRE
 S FLAGNEW=0
 S YSAVE=YCUR
 S YNDSAVE=YND
 S (XCUR,XSAVE)=XCUR+1
 S XCHAR=$$XCHARADD^XVEMRU(CD(NUM))
 I XCUR>$L(CD(NUM)) S KEY=$J("",XCUR-$L(CD(NUM))-(CD(NUM)'[$C(30)))_KEY
 S CD(NUM)=$E(CD(NUM),1,XCHAR-2)_KEY_$E(CD(NUM),XCHAR-1,9999)
 Q
 ;
SIMPLE ;Process a line that hasn't reached end yet
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 W @XVVS("BLANK_C_EOL")
 X XVVS("XY")
 I XVV("SYN")="ON" D
 . W $$CONTROL^XVEMSYN("MOV",DY+1) W @XVVS("BLANK_C_EOL")
 . D SYNTAX^XVEMSYN(CD(NUM),NUM)
 E  D
 . W $E(CD(NUM),XCHAR,9999)
 Q
 ;
ADJARRAY ;Adjust CD() array for new character. FLAGNEW=1 Open new line
 NEW FLAGQ S FLAGQ=0
 F I=NUM+1:1 D  Q:FLAGQ  Q:$L(CD(I))<(XVV("IOM")-1)
 . S CD(I)=$G(^TMP("XVV","IR"_VRRS,$J,I))
 . I CD(I)[$C(30)!(CD(I)=" <> <> <>") D  ;Open new line
 . . S CD(I)=$J("",9),FLAGNEW=I,FLAGQ=1
 . S HLD=$E(CD(I-1),$L(CD(I-1))) ;Get last char of previous line
 . S CD(I-1)=$E(CD(I-1),1,$L(CD(I-1))-1) ;Remove it from previous line
 . S CD(I)=$E(CD(I),1,9)_HLD_$E(CD(I),10,9999) ;Add it to current line
 Q
 ;
REDRAW ;Redraw rest of adjusted current line
 I XCUR<(XVV("IOM")-2) D SIMPLE Q
 I XCUR<(XVV("IOM")-1),XVV("SYN")="ON" D SIMPLE
 ;If cursor at line end, move cursor down
 S DX=XVV("IOM")-2,DY=YCUR X XVVS("CRSR")
 W " "
 S (XCUR,XSAVE)=$S(XCUR=(XVV("IOM")-2):9,1:10)
 S YNDSAVE=YND+1
 I YND<(XVVT("BOT")-1) S YSAVE=YCUR+1 Q
 Q:$G(^TMP("XVV","IR"_VRRS,$J,YND+1))[$C(30)
 Q:$G(^(YND+1))=" <> <> <>"
 D DOWN^XVEMRE(1)
 S YCUR=YCUR-1
 Q
 ;
COMPLEX ;Multiple lines and cursor position, need to be adjusted.
 S DY=YCUR
 F I=NUM+1:1 Q:'$D(CD(I))  D  Q:FLAGQ
 . I I=FLAGNEW D OPEN D  Q
 . . I XVV("SYN")="ON" D
 . . . N J,K,DDY,QUIT S QUIT=0,J=I,DDY=DY+1
 . . . F  Q:J=""!(QUIT)  S J=$O(^TMP("XVV","IR"_VRRS,$J,J),-1),DDY=DDY-1 I $D(^(J,"STATE"))=0 S QUIT=1
 . . . F K=J:1:I D
 . . . . W $$CONTROL^XVEMSYN("MOV",DDY) W @XVVS("BLANK_C_EOL")
 . . . . D SYNTAX^XVEMSYN(^TMP("XVV","IR"_VRRS,$J,K),K)
 . . . . S DDY=DDY+1
 . . E  D
 . . . W $P(CD(I),$C(30),1),$P(CD(I),$C(30),2,99)
 . S DX=9,DY=DY+1
 . I DY>(XVVT("BOT")-XVVT("TOP")) S FLAGQ=1 Q  ;Quit at screen bottom
 . X XVVS("CRSR")
 . W @XVVS("BLANK_C_EOL")
 . X XVVS("XY")
 . I XVV("SYN")="ON" D
 . . W $$CONTROL^XVEMSYN("MOV",DY+1) W @XVVS("BLANK_C_EOL")
 . . D SYNTAX^XVEMSYN(CD(I),I)
 . E  D
 . . W $E(CD(I),10,9999)
 Q
 ;
OPEN ;Open new next line.
 NEW BOT
 S BOT=$O(CD(""),-1)-1 I YND<BOT D  ;
 . S YCUR=YCUR+BOT-YND,YND=YND+BOT-YND
 . S DX=XCUR,DY=YCUR X XVVS("CRSR")
 S HLDY2=YCUR ;Save cursor Y value. Used by SCROLL.
 D OPEN^XVEMREO
 D ADJOPEN
SCROLL ;When new line is opened and character is drawn, move cursor back to previous location. Determine if it needs to scroll up 1 line.
 Q:HLDY2<(XVVT("BOT")-XVVT("TOP"))  ;Opened line not at screen bottom.
 I HLDX<(XVV("IOM")-2) S YSAVE=YSAVE-1 Q  ;Cursor not at line end. Always scroll up 1 line.
 Q:HLDY1=(XVVT("BOT")-XVVT("TOP"))  ;Cursor at screen bottom. Don't scroll up 1 line.
 S YSAVE=YSAVE-1 ;Scroll cursor up 1 line.
 Q
 ;
ADJOPEN ;Adjust scroll array - Open a line
 NEW END,I
 S END=$O(^TMP("XVV","IR"_VRRS,$J,""),-1)
 F I=(END+1):-1:YND D  ;
 . S ^TMP("XVV","IR"_VRRS,$J,I)=^TMP("XVV","IR"_VRRS,$J,I-1)
ADJOPEN1 F I=NUM:1 Q:'$D(CD(I))  S ^TMP("XVV","IR"_VRRS,$J,I)=CD(I)
 Q
