XVEMRP ;DJB/VRR**Block Mode - Highlight Lines ;2017-08-15  4:26 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
UP ;F3 Up-arrow highlight
 Q:$$CHECK()
 I $D(^TMP("XVV","SAVE",$J,YND-1)) D CLEARUP Q
 Q:'$D(^TMP("XVV","IR"_VRRS,$J,YND))
 I ^(YND)=" <> <> <>" D UP^XVEMRE(1) Q
 D CHKBELOW ;See if line below is part of this line
UP1 I YCUR=1,XVVT("TOP")'>1 D  Q
 . I $D(^TMP("XVV","SAVE",$J,YND)) W $C(7) Q
 . S ^TMP("XVV","SAVE",$J,YND)=^TMP("XVV","IR"_VRRS,$J,YND)
 . D MARK(YCUR,YND)
 . S DX=XCUR,DY=YCUR X XVVS("CRSR")
 S ^TMP("XVV","SAVE",$J,YND)=^TMP("XVV","IR"_VRRS,$J,YND)
 D MARK(YCUR,YND)
 D UP^XVEMRE(1)
 Q:^TMP("XVV","IR"_VRRS,$J,YND+1)[$C(30)
 ;Loop back in case line has scrolled
 G UP1
 ;
DOWN ;F3 Down-arrow highlight
 Q:$$CHECK()
 I $D(^TMP("XVV","SAVE",$J,YND)) D CLEARDN1 Q
 I $D(^TMP("XVV","SAVE",$J,YND+1)) D CLEARDN Q
 Q:'$D(^TMP("XVV","IR"_VRRS,$J,YND))
 I ^(YND)=" <> <> <>" W $C(7) Q
 I ^(YND)'[$C(30) D CHKABOVE ;See if line above is part of this line
DOWN1 S ^TMP("XVV","SAVE",$J,YND)=^TMP("XVV","IR"_VRRS,$J,YND)
 D MARK(YCUR,YND)
 D DOWN^XVEMRE(1)
 Q:^TMP("XVV","IR"_VRRS,$J,YND)[$C(30)
 Q:^(YND)=" <> <> <>"
 G DOWN1 ;Do a loop in case line has scrolled
 ;
MARK(YVAL,ND) ;Mark selected lines. YVAL=$Y, ND=Node
 NEW TMP
 S DX=0,DY=YVAL X XVVS("CRSR")
 W @XVVS("BLANK_C_EOL")
 W @XVV("RON")
 X XVVS("CRSR")
 S TMP=$G(^TMP("XVV","SAVE",$J,ND))
 W $P(TMP,$C(30),1)
 W $P(TMP,$C(30),2)
 W ?XVV("IOM")-1
 W @XVV("ROFF")
 Q
 ;
CHKABOVE ;Check if line above is part of this line
 NEW I,YVAL
 S YVAL=YCUR
 F I=YND-1:-1 Q:I<1  D  Q:^TMP("XVV","IR"_VRRS,$J,I)[$C(30)
 . S ^TMP("XVV","SAVE",$J,I)=^TMP("XVV","IR"_VRRS,$J,I)
 . S YVAL=YVAL-1
 . I YVAL>0 D MARK(YVAL,I)
 Q
 ;
CHKBELOW ;Check if line below is part of this line
 NEW I,YVAL
 S YVAL=YCUR
 F I=YND+1:1 Q:'$D(^TMP("XVV","IR"_VRRS,$J,I))  Q:^(I)[$C(30)  Q:^(I)=" <> <> <>"  D  ;
 . S ^TMP("XVV","SAVE",$J,I)=^TMP("XVV","IR"_VRRS,$J,I)
 . S YVAL=YVAL+1
 . I YVAL'>(XVVT("BOT")-XVVT("TOP")) D MARK(YVAL,I)
 Q
 ;
CLEARUP ;Clear one highlighted line - Cursor UP
 ;If line has scrolled clear scrolled portion as well
 NEW FLAGQ,TMP
 S FLAGQ=0
 F  D UP^XVEMRE(1) D  Q:FLAGQ  Q:'$D(^(YND-1))
 . S DX=0,DY=YCUR X XVVS("CRSR")
 . S TMP=$G(^TMP("XVV","SAVE",$J,YND))
 . W $P(TMP,$C(30),1)
 . W $P(TMP,$C(30),2)
 . W ?XVV("IOM")-1
 . S DX=XCUR,DY=YCUR X XVVS("CRSR")
 . S:TMP[$C(30) FLAGQ=1
 . KILL ^TMP("XVV","SAVE",$J,YND)
 Q
 ;
CLEARDN ;Clear one highlighted line - Cursor DOWN
 ;If line has scrolled clear scrolled portion as well
 NEW TMP
 F  D DOWN^XVEMRE(1) D  Q:'$D(^(YND+1))  Q:^(YND+1)[$C(30)
 . S DX=0,DY=YCUR X XVVS("CRSR")
 . S TMP=$G(^TMP("XVV","SAVE",$J,YND))
 . W $P(TMP,$C(30),1)
 . W $P(TMP,$C(30),2)
 . W ?(XVV("IOM")-1)
 . S DX=XCUR,DY=YCUR X XVVS("CRSR")
 . KILL ^TMP("XVV","SAVE",$J,YND)
 Q
 ;
CLEARDN1 ;Clear highlighted top line - Cursor DOWN
 NEW TMP
 F  D  Q:'$D(^(YND+1))  Q:^(YND+1)[$C(30)  D DOWN^XVEMRE(1)
 . S DX=0,DY=YCUR X XVVS("CRSR")
 . S TMP=$G(^TMP("XVV","SAVE",$J,YND))
 . W $P(TMP,$C(30),1)
 . W $P(TMP,$C(30),2)
 . W ?(XVV("IOM")-1)
 . S DX=XCUR,DY=YCUR X XVVS("CRSR")
 . KILL ^TMP("XVV","SAVE",$J,YND)
 Q
 ;
CLEARALL ;Clear all highlighted lines
 NEW CNT,DY,TMP,TMP1
 S CNT=0
 S DY=XVVT("S1")-2
 F I=XVVT("TOP"):1:XVVT("BOT")-1 D  ;
 . S DX=0,DY=DY+1
 . S TMP=$G(^TMP("XVV","SAVE",$J,I))
 . S TMP1=$G(^TMP("XVV","SAVECHAR",$J,I))
 . I TMP']"",TMP1']"" Q
 . X XVVS("CRSR")
 . ;
 . I TMP]"" D  ;
 .. W $P(TMP,$C(30),1)
 .. W $P(TMP,$C(30),2)
 .. W ?(XVV("IOM")-1)
 . E  D  ;
 .. W $P(TMP1,$C(30),1)
 .. W $P(TMP1,$C(30),2)
 .. W ?(XVV("IOM")-1)
 ;
 KILL ^TMP("XVV","SAVE",$J)
 KILL ^TMP("XVV","SAVECHAR",$J)
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 Q
 ;
BULKDN ;Bulk highlight from cursor to bottom of rtn
 Q:$$CHECK()
 I $D(^TMP("XVV","SAVE",$J)) D  Q
 . S FLAGMODE=0
 . D CLEARALL
 . D MODEOFF^XVEMRU("BLOCK")
 I $G(^TMP("XVV","IR"_VRRS,$J,YND))=" <> <> <>" W $C(7) Q
 I ^(YND)'[$C(30) D CHKABOVE ;See if line above is part of this line
 F  D DOWN1 Q:$G(^TMP("XVV","IR"_VRRS,$J,YND))=" <> <> <>"
 Q
 ;
BULKUP ;Bulk highlight from cursor to top of rtn
 Q:$$CHECK
 I $D(^TMP("XVV","SAVE",$J)) D  Q
 . S FLAGMODE=0
 . D CLEARALL
 . D MODEOFF^XVEMRU("BLOCK")
 D CHKBELOW ;See if line below is part of this line
 F  Q:YND=1  D UP
 I YND=1 D  ;
 . S ^TMP("XVV","SAVE",$J,YND)=^TMP("XVV","IR"_VRRS,$J,YND)
 . D MARK(YCUR,YND)
 . S DX=XCUR,DY=YCUR X XVVS("CRSR")
 Q
 ;
CHECK() ;
 I '$D(^TMP("XVV","SAVECHAR",$J))  Q 0
 S FLAGMODE=0
 D CLEARALL^XVEMRP
 D MODEOFF^XVEMRU("BLOCK")
 Q 1
