XVEMRU ;DJB/VRR**Utilities ;2019-08-16  11:28 AM
 ;;15.2;VICTORY PROG ENVIRONMENT;;Aug 27, 2019
 ; Original Code authored by David J. Bolduc 1985-2005
 ; LINECNT bug fix for routines > 8 c long (c) 2016 Sam Habiel
 ; Syntax highlighting support by David Wicksell (c) 2019
 ; LINECNT display bug fix for routines > 999 lines by David Wicksell (c) 2019
 ; Dynamic linelabel+offset display support by David Wicksell (c) 2019
 ;
LNSTART(CD) ;Find start of line for EDIT mode.
 ;"2^11" - TAG starts at 2, LINE starts at 11
 I CD[$C(30) Q $$TAGSTART(CD)
 Q "10^10"
 ;
TAGSTART(CD) ;Find start of tag
 NEW L,START,TAG
 S TAG=$P(CD,$C(30),1),L=$L(TAG)
 I TAG?1.N1." "!(TAG?1." ") Q "11^11"
 F START=1:1 Q:$E(TAG)'=" "  S TAG=$E(TAG,2,999)
 Q START_"^"_(L+2)
 ;
LNSTART1(CD) ;Find start of line for INSERT mode
 NEW START,TAG
 S START=9,TAG=$P(CD,$C(30),1)
 I CD'[$C(30) Q START
 I +TAG>0 Q START
 I $L(TAG)'>9 Q START
 Q START+($L(TAG)-9)
 ;
XCHARADD(CD) ;Adjust XCHAR for $C(30) - When adding code
 ;XCUR=$L(CD)-1 because $X starts with zero.
 ;--> If XCUR is left of $C(30) XCHAR=XCUR+1. Else XCHAR=XCUR+2.
 I CD'[$C(30) Q (XCUR+1)
 ;--> Cursor is in space between tag and line
 I XCUR+2=$F(CD,$C(30)) Q (XCUR+1)
 I XCUR+1'<$F(CD,$C(30)) Q (XCUR+2)
 Q (XCUR+1)
 ;
XCHARDEL(CD) ;Adjust XCHAR for $C(30) - When deleting code
 I CD'[$C(30) Q (XCUR+1)
 ;--> Cursor is in space between tag and line
 I XCUR+2'<$F(CD,$C(30)) Q (XCUR+2)
 Q (XCUR+1)
 ;
LINENUM(ND) ;Get line number for new code. ND=Scroll array node
 I $G(ND)'>0 Q 1
 NEW NUM,X S NUM=1,X=0
 F  S X=$O(^TMP("XVV","IR"_VRRS,$J,X)) D  Q:X=ND
 . I ^(X)[$C(30) S NUM=NUM+1
 Q NUM
 ;
GETNODE(LN) ;Convert a line number to an array node. LN=Line #
 NEW ND,NM,X
 S (ND,NM,X)=0
 F  S X=$O(^TMP("XVV","IR"_VRRS,$J,X)) Q:^(X)=" <> <> <>"  D  Q:NM=LN
 . S ND=ND+1
 . I ^(X)[$C(30) S NM=NM+1
 I X']"" Q 0
 I ^(X)=" <> <> <>" Q 0
 Q ND
 ;==================================================================
INSERT(DX,DY) ;Insert a line. Uses escape sequences not supported by MSM NT.
 S DX=+$G(DX),DY=+$G(DY)
 I $G(^%ZOSF("OS"))["MSM for Windows NT" D ZINSERT(DX,DY) Q
 X XVVS("CRSR") W @XVVS("INDEX"),@XVVS("INSRT")
 I XVVT("GAP") D  Q
 . S XVVT("GAP")=XVVT("GAP")-1
 S XVVT("BOT")=XVVT("BOT")-1
 Q
 ;
ZINSERT(DX,DY) ;Insert a line. Don't use above escape sequences.
 S DX=+$G(DX),DY=+$G(DY)+1 X XVVS("CRSR")
 W @XVVS("BLANK_C_EOL") X XVVS("XY")
 I XVVT("GAP") S XVVT("GAP")=XVVT("GAP")-1
 E  S XVVT("BOT")=XVVT("BOT")-1
 D REDRAW^XVEMREO(YND+1,XVVT("BOT"))
 S DX=0,DY=YCUR X XVVS("CRSR")
 Q
 ;==================================================================
REDRAW(YVAL) ;Adjust line count and redraw from YVAL to bottom of screen
 Q:$G(YVAL)'>0
 NEW I,FLAGQ,TMP
 S FLAGQ=0
 F I=YVAL:1 D  Q:FLAGQ
 . S TMP=$G(^TMP("XVV","IR"_VRRS,$J,I))
 . I I'<XVVT("BOT") D  Q:FLAGQ
 . . I 'XVVT("GAP") S FLAGQ=1 Q
 . . S XVVT("BOT")=XVVT("BOT")+1,XVVT("GAP")=XVVT("GAP")-1
 . S DX=0,DY=I-XVVT("TOP")+1
 . X XVVS("CRSR") W @XVVS("BLANK_C_EOL") X XVVS("XY")
 . I XVV("SYN")="ON" D
 . . D SYNTAX^XVEMSYN(TMP,I)
 . E  D
 . . W $P(TMP,$C(30),1),$P(TMP,$C(30),2)
 . I TMP=" <> <> <>" S FLAGQ=1 Q
 D LINECNT
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 Q
 ;
REDRAW1 ;Adjust line count and then redraw top & bottom of screen
 D LINECNT,LINELBL,REDRAW^XVEMKT2(1)
 Q
 ;
REDRAW2 ;Redraw screen with no adjustments
 D REDRAW^XVEMKT2(1),REDRAW(XVVT("TOP"))
 Q
 ;
REDRAW3 ;Adjust line count and then redraw screen
 D LINECNT,REDRAW^XVEMKT2(1),REDRAW(XVVT("TOP"))
 Q
 ;
LINECNT ;Adjust line count at top of screen
 NEW NEWHIGH,END
 S NEWHIGH=$E("   ",1,3-$L(VRRHIGH))_VRRHIGH
 N TOPUT S TOPUT=$F(XVVT("HD",1),"Lines:") ; (sam): Where should we put this?
 S $P(END,"=",XVV("IOM")-TOPUT-$L(NEWHIGH)-2)="",END=END_"|"
 S XVVT("HD",1)=$E(XVVT("HD",1),1,TOPUT)_NEWHIGH_"]"_END
 S DX=TOPUT,DY=0 X XVVS("CRSR") W NEWHIGH_"]"_END
 Q
 ;
LINELBL(RSETCRSR) ;Adjust line label plus offset at top of screen
 N I,NUM,QFLAG,NAME,TOPUT,TAG,FIND,MAR,LINE,DIV
 S NAME="^"_^TMP("XVV","VRR",$J,VRRS,"NAME")
 S NUM=YND+1,(I,QFLAG)=0,TAG=""
 I $G(^TMP("XVV","IR"_VRRS,$J,YND))'=" <> <> <>" D
 . F  S NUM=$O(^TMP("XVV","IR"_VRRS,$J,NUM),-1) Q:NUM=""  D  Q:QFLAG
 . . S FIND=^(NUM)
 . . I FIND'[$C(30) Q
 . . S FIND=$P(FIND,$C(30))
 . . I FIND="" S QFLAG=1 Q
 . . I FIND'?1.N2." " S TAG=$TR($P(FIND,"(")," ","") I TAG'[":" S TAG=TAG_$S(I>0:"+"_I,1:""),QFLAG=1 Q
 . . S I=I+1
 I NUM="" S NAME=$S(I>0:"+"_I,1:"")_"^"_$P(NAME,"^",2)
 E  S NAME=TAG_"^"_$P(NAME,"^",2)
 S MAR=$G(XVV("IOM")) S:MAR'>0 MAR=80
 S $P(LINE,"=",MAR)=""
 S NUM=MAR-($L(NAME)+$L(VRRS)+$L(VRRHIGH)+44)
 I NUM<0 D
 . I $G(^TMP("XVV","IR"_VRRS,$J,YND))'=" <> <> <>" D
 . . N TAG,OFFSET,ROUTINE
 . . S TAG=$P(NAME,"^"),TAG=$P(TAG,"+"),OFFSET=$S(I>0:"+"_I,1:""),ROUTINE="^"_$P(NAME,"^",2)
 . . S NUM=MAR-($L(TAG)+$L(OFFSET)+$L(VRRS)+$L(VRRHIGH)+44)
 . . I NUM<0 S NAME=$E(TAG,1,$L(TAG)+NUM-2)_".."_OFFSET
 . . E  I NUM<4 S NAME=$E(TAG,1,$L(TAG)+NUM)_OFFSET
 . . E  S NAME=TAG_OFFSET_$E(ROUTINE,1,NUM-2)_"..",NUM=0
 . E  S NAME=$E(NAME,1,$L(NAME)+NUM-2)_".."
 S DIV=$E(LINE,1,NUM)
 S XVVT("HD",1)="|=======|===["_NAME_"]==="_DIV_"["_VRRS_" of 1024]===[Lines: "_VRRHIGH_"]===|"
 S TOPUT=$F(XVVT("HD",1),"[")
 S DX=TOPUT-1,DY=0 X XVVS("CRSR") W $E(XVVT("HD",1),$F(XVVT("HD",1),"["),$L(XVVT("HD",1)))
 I $G(RSETCRSR,0) S DX=XCUR,DY=YCUR X XVVS("CRSR")
 Q
 ;
MODEON(MODE,QUIT) ;MODE display in upper right of screen.
 ;MODE=BLOCK or WEB
 ;QUIT=1 Quit before repositioning the cursor
 S DX=$S($G(MODE)="WEB":3,1:2)
 S DY=(XVVT("S1")-2) X XVVS("CRSR")
 W @XVV("RON") X XVVS("XY") W MODE,@XVV("ROFF")
 Q:$G(QUIT)
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 Q
 ;
MODEOFF(MODE,QUIT) ;Turn off MODE notice
 ;MODE=BLOCK or WEB
 S DX=$S($G(MODE)="WEB":3,1:2)
 S DY=(XVVT("S1")-2) X XVVS("CRSR") W "======"
 Q:$G(QUIT)
 S DX=XCUR,DY=YCUR X XVVS("CRSR")
 Q
