XGKB ;SFISC/VYD - Read with Escape Processing ;10/23/2006
 ;;8.0;KERNEL;**34,244,365**;Jul 10, 1995;Build 5
 ;;Special thanks to MELDRUM.KEVIN@ISC-SLC.VA.GOV
 ;
INIT(XGTRM) ;turn escape processing on and passed terminator string if any
 N %,%OS S %OS=^%ZOSF("OS")
 I %OS["VAX DSM" U $I:(NOLINE:ESCAPE) D:'$D(^XUTL("XGKB")) VAXDSM^XGKB1
 I %OS["MSM" U $I:(0::::64) D:'$D(^XUTL("XGKB")) MSM^XGKB1
 I %OS["DTM" U $I:(VT=1:ESCAPE=1) D:'$D(^XUTL("XGKB")) DTM^XGKB1
 I %OS["OpenM" U $I:(:"CT") D:'$D(^XUTL("XGKB")) DTM^XGKB1 S:$G(XGTRM)="*" XGTRM=""
 I %OS["GT.M" U $I:(ESCAPE) D:'$D(^XUTL("XGKB")) GTM^XGKB1
 I $G(XGTRM)="*" X ^%ZOSF("TRMON") I 1 ;turn all on
 E  I $L($G(XGTRM)) S %=$$SETTRM^%ZOSV(XGTRM) ;turn on passed terminators
 S XGRT=""
 Q
 ;
 ;
EXIT ; Reset device (disable escape processing, turn terminators off)
 N %OS S %OS=^%ZOSF("OS")
 I %OS["VAX DSM" U $I:(LINE:NOESCAPE)
 I %OS["MSM" U $I:(0:::::64)
 I %OS["DTM" U $I:(ESCAPE=0)
 I %OS["GT.M" U $I:(NOESCAPE)
 X ^%ZOSF("TRMOFF")
 K XGRT
 Q
 ;
 ;
ACTION(XGKEY,XGACTION) ;add or remove key-action
 ;XGKEY:key mnemonic ("F10","NEXT",etc.)
 ;XGACTION:M executable string
 ;if action is passed ADD mode is assumed otherwise REMOVE
 I $D(XGACTION) S ^TMP("XGKEY",$J,XGKEY)=XGACTION
 E  K ^TMP("XGKEY",$J,XGKEY)
 Q
 ;
 ;
READ(XGCHARS,XGTO) ; read XGCHARS using escape processing. XGTO timeout (optional).  Result returned.
 ; Char that terminated the read will be in XGRT
 N S,XGW1,XGT1,XGSEQ ;string,window,timer,timer sequence
 K DTOUT
 S XGRT=""
 D:$G(XGTO)=""                 ;set timeout value if one wasn't passed
 . I $D(XGT) D  Q              ;if timers are defined
 . . S XGTO=$O(XGT(0,""))      ;get shortest time left of all timers
 . . S XGW1=$P(XGT(0,XGTO,$O(XGT(0,XGTO,"")),"ID"),U,1) ;get timer's window
 . . S XGT1=$P(XGT(0,XGTO,$O(XGT(0,XGTO,"")),"ID"),U,3) ;get timer's name
 . I $D(XGW) S XGTO=99999999 Q  ;in emulation read forever
 . S XGTO=$G(DTIME,600)
 ;
 I $G(XGCHARS)>0 R S#XGCHARS:XGTO S:'$T DTOUT=1 I 1 ;fixed length read
 E  R S:XGTO S:'$T DTOUT=1 I 1 ;read as many as possible
 S:$G(DTOUT)&('$D(XGT1)) S=U                          ;stuff ^
 ;
 S:$L($ZB) XGRT=$G(^XUTL("XGKB",$ZB))          ;get terminator if any
 I $G(DTOUT),$D(XGT1),$D(^TMP("XGW",$J,XGW1,"T",XGT1,"EVENT","TIMER")) D  I 1 ;if timed out
 . D E^XGEVNT1(XGW1,"T",XGT1,"","TIMER")
 E  I $L(XGRT),$D(^TMP("XGKEY",$J,XGRT)) X ^(XGRT)     ;do some action
 ; this really should be handled by keyboard mapping -- later
 Q S
 ;
 ;
TEST F  S X=$$READ Q:X["^"  W ?20,X,?40,XGRT,?60,$ZB,!
 Q
