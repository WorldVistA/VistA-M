XVEMREM ;DJB/VRR**EDIT - Move to different parts of a line ;2017-08-15  1:43 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
LNBEG ;Go to beginning of line
 NEW TMP
 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,YND)) Q:TMP=" <> <> <>"!(TMP']"")
 I TMP'[$C(30) S TMP=YND D  ;
 . F  S TMP=$O(^TMP("XVV","IR"_VRRS,$J,TMP),-1) D  Q:$G(^(TMP))[$C(30)!(YND=1)
 . . I YND=XVVT("TOP") D UP^XVEMRE(1) Q
 . . S:YCUR>1 YCUR=YCUR-1 S:YND>1 YND=YND-1
 S (DX,XCUR)=$$LNBEG1() X XVVS("CRSR")
 Q
LNBEG1() ;Return beginning of line.
 NEW I,START,TMP,TMP1
 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,YND)) I TMP']"" Q 0
 S DY=YCUR,START=0
 F I=1:1 S TMP1=$E(TMP,I) Q:TMP1?1ACP&(TMP1'=" ")  S START=START+1
 Q START
LNEND ;Go to end of line
 Q:$G(^TMP("XVV","IR"_VRRS,$J,YND))=" <> <> <>"
 NEW TMP,X S X=YND
 F  S X=$O(^TMP("XVV","IR"_VRRS,$J,X)) Q:^(X)[$C(30)!(^(X)=" <> <> <>")  D  ;
 . I YND=(XVVT("BOT")-1) D DOWN^XVEMRE(1) Q
 . S YCUR=YCUR+1,YND=YND+1
 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,YND))
 S DY=YCUR,(DX,XCUR)=$L(TMP)-(TMP[$C(30)) X XVVS("CRSR")
 Q
LNLEFT ;Go left 15 spaces
 NEW START
 S START=$$LNBEG1(),DY=YCUR
 I XCUR-15>START S (DX,XCUR)=XCUR-15 X XVVS("CRSR") Q
 S (DX,XCUR)=XCUR-(XCUR-START) X XVVS("CRSR")
 Q
LNRIGHT ;Go right 15 spaces
 NEW L,TMP
 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,YND)) Q:TMP']""  Q:TMP=" <> <> <>"
 S L=$L(TMP)-(TMP[$C(30)) Q:XCUR=L  S DY=YCUR
 I XCUR+15'>L S (DX,XCUR)=XCUR+15 X XVVS("CRSR") Q
 S (DX,XCUR)=XCUR+(L-XCUR) X XVVS("CRSR")
 Q
LNLMAR ;Left margin of current line
 NEW L,TMP
 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,YND)) Q:TMP']""  Q:TMP=" <> <> <>"
 I TMP'[$C(30) S L=9
 E  S L=$L($P(TMP,$C(30),1))
 S DY=YCUR,(DX,XCUR)=L X XVVS("CRSR")
 Q
LNRMAR ;Right margin of current line
 NEW L,TMP
 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,YND)) Q:TMP']""  Q:TMP=" <> <> <>"
 S L=$L(TMP)-(TMP[$C(30)) Q:XCUR=L
 S DY=YCUR,(DX,XCUR)=L X XVVS("CRSR")
 Q
LNDOWN ;Scroll down 1 routine line (<ESC>L).
 KILL DIRHLD ;Tracks cursor for <AU> & <AD>
 NEW ND
 Q:$G(^TMP("XVV","IR"_VRRS,$J,YND))=" <> <> <>"
 D HIGHOFF^XVEMRE
 F  D  Q:ND=" <> <> <>"!(ND[$C(30))
 . S YND=YND+1,ND=$G(^TMP("XVV","IR"_VRRS,$J,YND))
 . I YCUR'<(XVVT("BOT")-XVVT("TOP")) D  Q
 . . S XVVT("BOT")=XVVT("BOT")+1,XVVT("TOP")=XVVT("TOP")+1
 . . W !,$P(ND,$C(30),1),$P(ND,$C(30),2,99)
 . S YCUR=YCUR+1
 D HIGHON^XVEMRE
 Q
