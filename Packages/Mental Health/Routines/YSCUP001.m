YSCUP001 ;DALISC/LJA - Pt Move Utils: UPDATE Logic ;8/31/94 11:45
 ;;5.01;MENTAL HEALTH;**2,11,20,29**;Dec 30, 1994
 ;
UPDATE(MHNO,MOVNO) ;  Using MH Inpt from ^TMP("YSPM",$J, AND YSMH data...
 ;  !!!!!!!!!!!!!!!!!! Programmer!!!  No QUITting !!!!!!!!!!!!!!!!!!!
 N MHIEN,MOVE,TIEN,WIEN,YSMH0,YSMH7
 ;
 ;  Set "main" variables...
 S YSACTS=1
 S MHIEN=+$G(^TMP("YSMH",$J,+MHNO,0))
 I MHIEN'>0 D   QUIT  ;->
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W !,"Missing MH array entry..."
 S YSMH0=$P($G(^TMP("YSMH",$J,+MHNO,0)),"~",2,99)
 S YSMH7=$G(^TMP("YSMH",$J,+MHNO,7))
 S MOVE=$G(^TMP("YSPM",$J,+MOVNO))
 I YSMH0']""!(YSMH7']"")!(MOVE']"") D  QUIT  ;->
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W !,"Missing required update variables..."
 ;
 ;  ************************** Update XTMP ***************************
 S X=$G(^XTMP($G(YSXTMP),"PRE0-UPD",+MHIEN)) S:X']"" ^XTMP(YSXTMP,"PRE0-UPD",+MHIEN)=$G(^YSG("INP",+MHIEN,0))
 S X=$G(^XTMP($G(YSXTMP),"PRE7-UPD",+MHIEN)) S:X']"" ^XTMP(YSXTMP,"PRE7-UPD",+MHIEN)=$G(^YSG("INP",+MHIEN,7))
 ;
 ;  ************************* AIN AOUT AWC CP ************************
 ;  Kill AOUT, AWC, and CP xrefs... 
 ;  They will be rebuilt later, if appropriate.
 K ^YSG("INP","AIN",9999999-$P(YSMH0,U,3),+MHIEN)
 K ^YSG("INP","AOUT",9999999-$P(YSMH7,U,2),+MHIEN)
 K ^YSG("INP","AWC",+$P(YSMH7,U),+$P(YSMH7,U,4),+MHIEN)
 K ^YSG("INP","CP",+YSDFN)
 ;
 ;  NEVER TRANSFERRED & this is NOT a DISCHARGE, Clear p(2)
 I $G(YSLTRSF)']"",$P(MOVE,U,4)'=3 D
 .  S $P(YSMH7,U,2)=""
 .  S X=+$P(YSMH7,U,3) S:X>0 $P(YSMH7,U,3)=+X_"~"
 ;
 ;  If First to MH movement's Date is valid, reset UNIT ENTRY DATE
 I +$P(YSFMTMH,U,6)?7N.E S $P(YSMH0,U,3)=+$P(YSFMTMH,U,6)
 ;
 ;  If First to MH movement's IEN is valid, reset ADMISSION POINTER p(1)
 I +$P(YSFMTMH,U,5)>0 D
 .  S X=$P(YSMH7,U,3),$P(X,"~")=+$P(YSFMTMH,U,5),$P(YSMH7,U,3)=X
 ;
 ;  If Last Movement out of MH ward Date is valid, reset DC/Trsf Date
 I +$P(YSLMOMH,U,6)?7N.E S $P(YSMH7,U,2)=+$P(YSMH7,U,2)
 ;
 ;  If Last Movement out of MH ward IEN is valid, reset ADMISSION POINTER p(2)
 I +$P(YSLMOMH,U,5)>0 D
 .  S X=$P(YSMH7,U,3),$P(X,"~",2)=+$P(YSLMOMH,U,5),$P(YSMH7,U,3)=X
 ;
 ;  ***** Patient is on MH ward, and is being DISCHARGED...
 I +MOVE>0,$P(MOVE,U,4)=3 D
 .  S $P(YSMH7,U,2)=$P(MOVE,U,6) ;Discharge Date
 .  S $P(YSMH7,U,4)="" ;Remove team
 .  S X=$P(YSMH7,U,3),$P(YSMH7,U,3)=+X_"~"_$P(MOVE,U,5) ;Admit/DC Pointer
 ;
 ;  ***** Patient is on MH ward, is is NOT being DISCHARGED *****
 I +MOVE>0,$P(MOVE,U,4)'=3 D
 .
 .  ;  Update Ward and Team on ^(7)
 .  S X=+$P(MOVE,U,2),$P(YSMH7,U)=$S(X>0:+X,1:"")
 .  S X=+$P(MOVE,U,3),$P(YSMH7,U,4)=$S(X>0:+X,1:"")
 .  S X=+$P(MOVE,U,3),$P(YSMH0,U,4)=$S(X>0:+X,1:"")
 .  D TEAMHX
 .
 .  ;  Admit~DC/Transfer p(3)
 .  ;  If pt is on a MH ward, p(3)'s 2nd piece should ALWAYS be null...
 .  ;  (Strip off dc/Tfr movement.)
 .  S X=$P(YSMH7,U,3) S $P(YSMH7,U,3)=$S(+X>0:+X_"~",1:"~")
 .
 .  ;  If pt is on a MH ward, p(2) should never be filled in...
 .  S $P(YSMH7,U,2)=""
 ;
 ;  ************ Patient is NOT on a MH ward ************
 I +MOVE'>0,$P(MOVE,U,4)>0 D
 .  S $P(YSMH7,U,4)=""
 .
 .  ;  ==> No DC/Trf Date p(2)...
 .  ;         Movement is a DC/Transfer, & 
 .  ;             DC/Trf Date available, so ... <==
 .  I $P(YSMH7,U,2)']"",23[$P(MOVE,U,4),$P(MOVE,U,6)?7N.E S $P(YSMH7,U,2)=$P(MOVE,U,6)
 .
 .  ;  Check whether Movement Off MH ward Date/Time has been edited.
 .  ;  If so, reset Date/Time...
 .  D
 .  .  QUIT:$P(YSMH7,U,2)']""  ;-> Not transfer out or DC recorded yet...
 .  .  QUIT:$L(YSLMOMH,"~")'=2  ;-> No Last Move off MH Ward recorded...
 .  .  QUIT:$P(YSMH7,U,2)=$P(YSLMOMH,U,6)  ;-> No change of DC/Trsf Date...
 .  .  S $P(YSMH7,U,2)=$P(YSLMOMH,U,6)
 .
 .  ; Admit/DC-Tfr IENs
 .  S YSX=+$P(YSMH7,U,3) ;          Strip DC/Transfer movement
 .  S YSY=+$P($P(YSMH7,U,3),"~",2) ;DC/Transfer Movement...
 .  S YSY=+$S(+$P(YSLMOMH,U,5)<1:+$P(MOVE,U,5),$P(YSLMOMH,U,5)'=$P(MOVE,U,5):+$P(YSLMOMH,U,5),1:+$P(MOVE,U,5))
 .  S $P(YSMH7,U,3)=+YSX_"~"_YSY
 ;
 ;  First move to MH ward Date/Time edited?
 S YSMHDT=+$P($G(YSFMTMH),U,6) ;Date/Time of 1st to MH move...
 I YSMHDT?7N.E&(+YSMH0'=+YSMHDT) S $P(YSMH0,U,3)=+YSMHDT
 ;
 ;  0 node sets...
 S ^YSG("INP",+MHIEN,0)=YSMH0
 ;
 ;  ^XTMP sets...
 S ^XTMP(YSXTMP,"POST0-UPD",+MHIEN)=YSMH0
 S ^XTMP(YSXTMP,"POST7-UPD",+MHIEN)=YSMH7
 ;
 ;  7 node sets...
 S ^YSG("INP",+MHIEN,7)=YSMH7
 ;
 ;  Xref SETS...
 ;
 ;  Active Inpatient?
 I $P(YSMH7,U)>0&($P(YSMH7,U,4)>0) D
 .  S ^YSG("INP","CP",+YSDFN,+MHIEN)=""
 .  S ^YSG("INP","AWC",+$P(YSMH7,U),+$P(YSMH7,U,4),+MHIEN)=""
 ;
 ;  Discharged or Transferred?
 I $P(YSMH7,U,2)]"" D
 .  S ^YSG("INP","AOUT",9999999-$P(YSMH7,U,2),+MHIEN)=""
 ;
 ;  Into MH ward AIN xref...
 S X=+$P(YSMH0,U,3) I X?7N.E D
 .  S ^YSG("INP","AIN",9999999-X,+MHIEN)=""
 ;  !!!!!!!!!!!!!!!!! Programmer!!!  You can QUIT now !!!!!!!!!!!!!!!!!
 ;
 QUIT
 ;
TEAMHX ; Update the multiple field PAST TEAMS
 ;
 S:'$D(^YSG("INP",+MHIEN,6,0)) ^YSG("INP",+MHIEN,6,0)="^618.419P^0^0"
 L +^YSG("INP",+MHIEN,6):999999 Q:$T
 S YSN=$P(^YSG("INP",+MHIEN,6,0),U,3)+1
 I (YSN>1),$D(^YSG("INP",+MHIEN,6,YSN-1)),(X=+^YSG("INP",+MHIEN,6,YSN-1,0)) S X2=^YSG("INP",+MHIEN,6,YSN-1,0),W1=+^YSG("INP",+MHIEN,7),^YSG("INP","AST",9999999-$P(X2,U,2),W1,X,+MHIEN)="" L -^YSG("INP",+MHIEN,6,0) Q
 S ^YSG("INP",+MHIEN,6,0)=$P(^YSG("INP",+MHIEN,6,0),U,1,2)_U_YSN_U_($P(^YSG("INP",+MHIEN,6,0),U,4)+1) L -^YSG("INP",+MHIEN,6)
 S W1=+^YSG("INP",+MHIEN,7),YSU=X,X="NOW",%DT="T" D ^%DT S X=YSU,YSNOW=9999999-Y,^YSG("INP","AST",YSNOW,W1,X,+MHIEN)="" K YSU,YSNOW
 S ^YSG("INP",+MHIEN,6,YSN,0)=X_U_Y_U_DUZ,^YSG("INP",+MHIEN,6,"B",X,YSN)=""
 Q:'$D(^YSG("SUB",X,1))
 Q:'$P(^YSG("SUB",X,1),U,4)  S YSTM8="" F ZZ=1:1 Q:'$D(^YSG("CEN",W1,"ROT"))  S YSTM7=$P(^YSG("CEN",W1,"ROT"),U,ZZ) Q:YSTM7'?1N.N  S:YSTM7'=X YSTM8=YSTM8_YSTM7_U
 S ^YSG("CEN",W1,"ROT")=YSTM8_X
 ;
 QUIT
 ;
EOR ;YSCUP001 - Pt Move Utils: UPDATE Logic ;8/31/94 11:45
