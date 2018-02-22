XVEMREB ;DJB/VRR**EDIT - Remove Character ;2017-08-15  1:41 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
TOP ;
 NEW CD,HLD,I,NUM,WHERE,XSAVE,YSAVE,YNDSAVE
 S NUM=YND
 S CD(NUM)=$G(^TMP("XVV","IR"_VRRS,$J,NUM))
 S WHERE=$$CHKDEL^XVEMREL() Q:WHERE="Q"
 D SET,ADJARRAY
 I CD(NUM)[$C(30),'$D(CD(NUM+1)) D SIMPLE G EX
 D REDRAW
 D COMPLEX
EX ;Exit
 ;Strip ending spaces
 I $E(CD(NUM),$L(CD(NUM)))=" ",'$D(CD(NUM+1)) D SPACES
 S XCUR=XSAVE
 S YCUR=YSAVE
 S YND=YNDSAVE
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 D ADJCLOS1 ;Adjust scroll array
 Q
 ;
SET ;Adjust variables
 S YSAVE=YCUR
 S YNDSAVE=YND
 S XCUR=$S($G(VK)="<DEL>":XCUR,1:XCUR-1)
 S XSAVE=XCUR
 S XCHAR=$$XCHARDEL^XVEMRU(CD(NUM))
 Q
 ;
SPACES ;Strip ending spaces from line
 F  Q:$E(CD(NUM),$L(CD(NUM)))'=" "  D  ;
 . S CD(NUM)=$E(CD(NUM),1,$L(CD(NUM))-1)
 Q
 ;
SIMPLE ;Process a line that hasn't reached end yet
 S CD(NUM)=$E(CD(NUM),1,XCHAR-1)_$E(CD(NUM),XCHAR+1,9999)
SIMPLE1 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 W @XVVS("BLANK_C_EOL")
 W $E(CD(NUM),XCHAR,9999)
 Q
 ;
COMPLEX ;Multiple lines and cursor position need to be adjusted.
 F I=NUM+1:1 Q:'$D(CD(I))  D  ;
 . I CD(I)?1." " KILL CD(I) D CLOSE Q
 . Q:NUM'<(XVVT("BOT")-1)  ;.........Ignore lines below screen bottom
 . S DX=9,DY=DY+1 X XVVS("CRSR")
 . W @XVVS("BLANK_C_EOL")
 . X XVVS("XY")
 . W $E(CD(I),10,9999)
 Q
 ;
REDRAW ;Redraw rest of adjusted line
 I CD(NUM)'[$C(30),XCUR<9 D  Q  ;If cursor at line begin, move it up
 . S HLD=$E(CD(NUM),10)
 . S CD(NUM)=$E(CD(NUM),1,9)_$E(CD(NUM),11,9999)
 . D REDRAW1(77)
 . S CD(NUM)=$E(CD(NUM),1,$L(CD(NUM))-1)_HLD
 . S ^TMP("XVV","IR"_VRRS,$J,NUM)=CD(NUM)
 . D SIMPLE1
 D SIMPLE
 D:CD(NUM)?1." " REDRAW1(XVV("IOM")-2)
 Q
 ;
REDRAW1(XPOS) ;When cursor is on bottom line and it deletes last char, close
 ;line and move cursor up.
 S NUM=NUM-1
 S CD(NUM)=$G(^TMP("XVV","IR"_VRRS,$J,NUM))
 S (XCUR,XSAVE)=XPOS
 S (YCUR,YSAVE)=YCUR-1
 S (YND,YNDSAVE)=YND-1
 S XCHAR=$$XCHARDEL^XVEMRU(CD(NUM))
 Q
 ;
ADJARRAY ;Adjust CD() array to remove a character.
 NEW I,FLAGQ S FLAGQ=0
 F I=NUM+1:1 D  Q:FLAGQ
 . S CD(I)=$G(^TMP("XVV","IR"_VRRS,$J,I))
 . I CD(I)[$C(30)!(CD(I)=" <> <> <>") KILL CD(I) S FLAGQ=1 Q
 . S HLD=$E(CD(I),10) ;.....................Get 1st char of next line
 . S CD(I-1)=CD(I-1)_HLD ;..................Add it to current line
 . S CD(I)=$E(CD(I),1,9)_$E(CD(I),11,9999) ;Remove it from line
 Q
 ;
ADJCLOS ;Adjust scroll array - Close a line
 NEW END,I
 S END=$O(^TMP("XVV","IR"_VRRS,$J,""),-1)
 F I=YND+1:1:END-1 D  ;
 . S ^TMP("XVV","IR"_VRRS,$J,I)=^TMP("XVV","IR"_VRRS,$J,I+1)
 KILL ^TMP("XVV","IR"_VRRS,$J,END)
ADJCLOS1 F I=NUM:1 Q:'$D(CD(I))  S ^TMP("XVV","IR"_VRRS,$J,I)=CD(I)
 Q
 ;
CLOSE ;Close a line that's been deleted
 NEW BOT
 S BOT=$O(CD(""),-1)
 I YND<BOT D  ;Move to bottom of line
 . S YCUR=YCUR+BOT-YND
 . S YND=YND+BOT-YND
 . S DX=XCUR,DY=YCUR X XVVS("CRSR")
 ;--> Quit if line to be closed is below scrn bottom
 D ADJCLOS
 Q:YND'<(XVVT("BOT")-1)
 D CLOSE^XVEMREO
 Q
