XVEMRMS ;DJB/VRR**Save Changes ;2017-08-15  4:24 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in SAVE (c) 2016 Sam Habiel
 ;
SAVE ;Save changes on-the-fly.
 N $ESTACK,$ETRAP S $ETRAP="D ERROR,UNWIND^XVEMSY"
 D SAVE1
 QUIT
 ;
SAVE1 ; [Internal] Extra level so unwind will pop appropriatly
 ;Rtns calling here should have FLAGQ=1. FLAGQ is set to 0 if user
 ;is not to be exited but returned to current rtn to continue editing.
 ;
 Q:$$ASK^XVEMKU(" Do you wish to save your changes",1)'="Y"
 ;
 NEW XVVS,VRRPGM,VRRUPDAT,X
 ;
 KILL ^UTILITY($J)
 ;
 D BUILD G:$G(VRRPGM)']"" EX
 G:$$DUP() EX
 D VERIFY^XVEMRV(VRRS) G:'FLAGQ EX
 X "S X=VRRPGM X XVVS(""ZS"")"
 I VRRS>1 L -VRRLOCK(VRRPGM)
 W !!,"Changes saved to disk..."
 ;
 D ADD^XVEMRLU(VRRPGM) ;Routine Library
 D ADD^XVEMRLV(VRRPGM) ;Routine Versioning
 ;
 S FLAGSAVE=0
 D PAUSE^XVEMKC(2)
 ;
EX ;Exit
 KILL ^UTILITY($J)
 Q
 ;
BUILD ;Build ^UTILITY array
 NEW FLAGQ,LN,TG
 S FLAGQ=0
 D INIT^XVEMRC
 I FLAGQ S VRRPGM="" Q
 S VRRPGM=$G(^TMP("XVV","VRR",$J,VRRS,"NAME"))
 Q:VRRPGM']""
 I $G(XVSIMERR1) S $EC=",U-SIM-ERROR,"
 D CONVERT^XVEMRV(VRRS)
 S TMP=$G(^UTILITY($J,0,1))
 I TMP']""!(TMP=" <> <> <>") S VRRPGM="" Q
 S TG=$P(TMP," ",1),LN=$P(TMP," ",2,99)
 D DATE^XVEMRC
 Q
 ;
DUP() ;Can't save changes to rtn you are editing in another session
 ;0=Ok  1=Quit
 ;
 I VRRS'>1 Q 0
 ;
 NEW CHK,I
 S CHK=0
 F I=1:1 Q:$G(^TMP("XVV","VRR",$J,I,"NAME"))']""  I I'=VRRS,$G(^("NAME"))=VRRPGM S CHK=1 D  Q
 . W $C(7),!!,"You are currently editing this program in another session."
 I CHK D PAUSE^XVEMKU(2) Q 1
 Q 0
 ;
ERROR ;Error trap
 KILL ^UTILITY($J) D ERRMSG^XVEMKU1("VRR"),PAUSE^XVEMKU(2)
 Q
 ;
TAG ;Option 'T' on menu bar. Select a line tag to move to.
 NEW FLAGQ,TAG
 S FLAGQ=0
 D ENDSCR^XVEMKT2
 D TAGLIST Q:FLAGQ
 D TAGASK Q:FLAGQ
 D REDRAW^XVEMRM
 Q
 ;
TAGLIST ;List line tags
 NEW CNT,I,TG,TMP
 S CNT=1
 F I=2:1 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,I)) Q:TMP']""  Q:TMP=" <> <> <>"  D  ;
 . Q:TMP'[$C(30)
 . D GETTAG^XVEMRM1
 . Q:TG']""
 . I CNT=1 W !,"Move to a line tag."
 . W !,"  " I $L(CNT)=1 W " "
 . W CNT,". ",TG
 . S TAG(CNT)=I
 . S CNT=CNT+1
 . I $Y>(XVV("IOSL")-4) D PAUSE^XVEMKU(2,"P") W @XVV("IOF")
 ;
 I CNT=1 D  Q
 . S FLAGQ=1
 . W !,"There are no line tags in this routine."
 . D PAUSE^XVEMKC(2)
 Q
 ;
TAGASK ;Select a tag
 W !
TAGASK1 W !,"Select NUMBER: "
 R TAG:100 S:'$T TAG="^" I "^"[TAG S FLAGQ=1 Q
 I '$D(TAG(TAG)) D  G TAGASK1
 . W "   Enter a number from the left hand column."
 ;
 ;Move to selected tag.
 ;Note: FLAGMENU=YND^XVVT("TOP")^YCUR^XCUR
 S FLAGMENU=TAG(TAG)_"^"_TAG(TAG)_"^"_1
 Q
