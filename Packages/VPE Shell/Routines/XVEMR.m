XVEMR ;DJB/VRR**SCROLL VRoutine Reader ;2017-08-15  4:20 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Various bug fixes throughout Sam Habiel (c) 2016
 ;
EN ;Entry Point
 I $G(DUZ)'>0 D ID^XVEMKU Q:$G(DUZ)=""
 N $ETRAP,$ES S $ETRAP="D ERROR^XVEMRY,UNWIND^XVEMSY"
START ;
 NEW CD,CDHLD,DX,DY,XCHAR,XCUR,YCUR,YND
 NEW FLAGGLB,FLAGMODE,FLAGQ,I,XVVT,VRRFIND,VRRHIGH,VRRPGM
 I $G(XVVLINE)="" NEW XVVIOST,XVVLINE,XVVLINE1,XVVLINE2,XVVSIZE,XVVX,XVVY
 ;
 ;FLAGVPE="VEDD^VGL^VRR^EDIT"
 I '$D(FLAGVPE) NEW FLAGVPE
 I $G(FLAGVPE)'["VRR" NEW XVVS,VRRS
 I $G(FLAGVPE)'["EDIT",$D(XVV("OS"))#2=0 NEW XVV ;...Mumps system
 ;
 S FLAGQ=0
 D INIT^XVEMRY G:FLAGQ EX
 I $G(FLAGVPE)'["EDIT"!(VRRS>1) NEW FLAGSAVE
 X XVVS("RM0")
 S $P(FLAGVPE,"^",3)="VRR" ;...Marks VRR as running
 S FLAGMODE="" ;...............BLOCK,WEB modes
 D EN^XVEMRS G:FLAGQ EX ;.....Get Program
 D LIBRARY^XVEMRLU(VRRPGM) ;..Is it signed out of Rtn Library?
 ;FLAGGLB: Used to select global from screen
TOP ;
 X XVVS("RM0")
 D IMPORT
 I $D(XVSIMERR) S $EC=",U-SIM-ERROR,"
 D SCROLL^XVEMKT2(1)
 D LIST
 D ENDSCR^XVEMKT2
EX ;
 I $G(FLAGVPE)'["EDIT"!($EC'="") D  Q
 . KILL ^TMP("XVV","VRR",$J,VRRS),^TMP("XVV","IR"_VRRS,$J)
 . S VRRS=VRRS-1 Q:VRRS>1
 . X $G(XVVS("RM80"))
 . W @(XVVS("WRAP"))
 ;Editing
 I VRRS D  ;Unlock rtn if not a duplicate
 . NEW CHK,I,PGM
 . S PGM=$G(^TMP("XVV","VRR",$J,VRRS,"NAME"))
 . S CHK=0
 . F I=1:1 Q:'$D(^TMP("XVV","VRR",$J,I,"NAME"))  D  ;
 .. I I'=VRRS,^("NAME")=PGM S CHK=1
 . I 'CHK,PGM]"" L -VRRLOCK(PGM)
 . ; --> Moved to XVSE
 . ; KILL ^TMP("XVV","VRR",$J,VRRS)
 . ; KILL ^TMP("XVV","IR"_VRRS,$J)
 S VRRS=VRRS-1
 Q:VRRS>0
 W @(XVVS("WRAP"))
 X $G(XVVS("RM80"))
 Q
 ;
GETXVVT ;Set XVVT=Display text
 I $D(^TMP("XVV","IR"_VRRS,$J,XVVT("BOT"))) S XVVT=^(XVVT("BOT")) Q
 S (XVVT,^TMP("XVV","IR"_VRRS,$J,XVVT("BOT")))=" <> <> <>"
 Q
 ;
LIST ;Display text
 D GETXVVT
 W !,$P(XVVT,$C(30),1)
 W $P(XVVT,$C(30),2,99)
 S XVVT("BOT")=XVVT("BOT")+1 ;Bottom line #
 S:XVVT("GAP") XVVT("GAP")=XVVT("GAP")-1 ;Empty lines left on page
 I XVVT=" <> <> <>"!'XVVT("GAP") D READ^XVEMRE Q:FLAGQ
 G LIST
 ;
IMPORT ;Set up for scroller
 NEW LINE,MAR,NAME,SPACE,TMP
 S VRRHIGH=+$G(VRRHIGH)
 S MAR=$G(XVV("IOM")) S:MAR'>0 MAR=80
 S $P(LINE,"=",MAR)=""
 S SPACE="          "
 S NAME=$G(^TMP("XVV","VRR",$J,VRRS,"NAME"))
 S NAME=NAME_$E(SPACE,1,8-$L(NAME))
 S XVVT("HD")=1
 S XVVT("FT")=2
 S XVVT("HD",1)="|=======|"_$E(LINE,1,11)_"[^"_NAME_"]======["_VRRS_" of 1024]===[Lines: "_VRRHIGH_$E("    ",1,3-$L(VRRHIGH))_"]"_$E(LINE,1,MAR-65)_"|"
 S XVVT("FT",1)="|=======|"_$E(LINE,1,MAR-11)_"|"
 S XVVT("FT",2)="<>  <TAB>=MenuBar  <F3>=Block  <RET>=Insert  <ESC>K=Keybrd  <ESC><ESC>=Quit"
 S XVVT("GET")=1
 D INIT^XVEMKT
 D INIT1^XVEMKT
 D INIT2^XVEMKT
 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,1))
 S XCUR=9,(YCUR,YND)=1
 I $G(%2)]"" D MOVETO
 ;--> Adj for $C(30)
 I TMP[$C(30) S XCUR=$F(TMP,$C(30))-2
 Q
 ;
MOVETO ;Adjust YND/YCUR to move to a passed in line tag.
 NEW CHK,CNT,LINE,NUM,TAG
 S (CHK,CNT,NUM)=0
 F  S CNT=$O(^TMP("XVV","IR"_VRRS,$J,CNT)) Q:'CNT!CHK  D  ;
 . S NUM=NUM+1
 . S LINE=^(CNT)
 . Q:(LINE'[$C(30))
 . S TAG=$P(LINE,$C(30),1)
 . Q:$E(TAG)?1N
 . S TAG=$P(TAG,"(",1)
 . ;Strip leading spaces
 . F  Q:$E(TAG)'=" "  S TAG=$E(TAG,2,$L(TAG))
 . ;Strip trailing spaces
 . F  Q:$E(TAG,$L(TAG))'=" "  S TAG=$E(TAG,1,$L(TAG)-1)
 . S:TAG=$G(%2) CHK=1
 I CHK S (XVVT("BOT"),XVVT("TOP"),YND)=NUM
 Q
 ;
PARAM(RTN,TAG) ;Parameter Passing....X=Routine Name
 S RTN=$G(RTN),TAG=$G(TAG)
 G:RTN="" EN
 S ^TMP("XVV",$J)=RTN_"^"_TAG
 I $G(DUZ)'>0 D ID^XVEMKU I $G(DUZ)="" KILL ^TMP("XVV",$J) Q
 ;
 NEW FLAGPRM,%1,%2
 S FLAGPRM=1
 S %1=$P(^TMP("XVV",$J),"^",1) ;Routine
 S %2=$P(^TMP("XVV",$J),"^",2) ;Tag
 KILL ^TMP("XVV",$J)
 G EN
