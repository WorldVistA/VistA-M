DGPREP4 ;ALB/SCK - Delete/Purge Utilities for Pre-registration ; 1/1/97
 ;;5.3;Registration;**109**;Aug 13, 1993
 Q
 ;
PURGE42 ;  Interactive call for purging call list
 N DGPX
 I '$D(^XUSEC("DGPRE SUPV",DUZ)) D  Q
 . W !!,"You do not have the DGPRE Supervisor key"
 . W !,"Please contact your supervisor."
 W !
 D PRGLST(1,.DGPX)
 W !,DGPX,"  Entries purged from the Pre-Registration Call List."
 Q
 ;
PRGLST(DGPFLG,DGPCNT) ;  Purges all called entries from the PRE-REGISTRATION CALL LIST File, #41.42
 ;
 N DGPN1
 S (DGPN1,DGPCNT)=0
 F  S DGPN1=$O(^DGS(41.42,DGPN1)) Q:DGPN1']""  D
 . I $P($G(^DGS(41.42,DGPN1,0)),U,6)="Y" D
 .. S DIK="^DGS(41.42,",DA=DGPN1
 .. D ^DIK K DIK
 .. S DGPCNT=+$G(DGPCNT)+1
 . W:$G(DGPFLG) "."
 ;
PRGQ Q
 ;
CLEAR42 ;  Interactive call for clearing the call list
 N DGPX
 I '$D(^XUSEC("DGPRE SUPV",DUZ)) D  Q
 . W !!,"You do not have the DGPRE Supervisor key,"
 . W !,"Please contact your supervisor."
 W !
 D CLRLST(1,.DGPX)
 W !!,DGPX,"  Entries deleted from the Pre-Registration Call List."
 Q
 ;
CLRLST(DGPFLG,DGPCNT) ;  Deletes all entries from the PRE-REGISTRATION CALL LIST File, #41.42
 N DGPN1
 S (DGPN1,DGPCNT)=0
 F  S DGPN1=$O(^DGS(41.42,DGPN1)) Q:DGPN1']""  D
 . S DIK="^DGS(41.42,",DA=DGPN1
 . D ^DIK K DIK
 . W:$G(DGPFLG) "."
 . S DGPCNT=$G(DGPCNT)+1
 ;
 Q
 ;
PURGE43 ;  Interactive call to purge the Pre-registration call log file
 ;
 N X1,X2,DGPCNT,DGPDT,DGPN2,XD
 K DIRUT,DUOUT
 ;
 S DGPCNT=0
 I '$D(^XUSEC("DGPRE SUPV",DUZ)) D  Q
 . W !!,"You do not have the DGPRE Supervisor key,"
 . W !,"Please contact your supervisor."
 ;
 S DIR(0)="DA^::EX"
 S XD=+$P($G(^DG(43,1,"DGPRE")),U,4)
 S X1=$P($$NOW^XLFDT,"."),X2=$$FMADD^XLFDT(X1,$S(XD>0:-XD,1:-60))
 S DIR("B")=$$FMTE^XLFDT(X2)
 S DIR("A")="Enter purge date for Call Log : "
 S DIR("?",1)="All log entries prior to this date will be purged."
 S DIR("?")="Enter date in a valid VA Format."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S DGPDT=Y
 S DIR(0)="YA"
 S DIR("A")="Do you really want to purge all entries prior to "_$$FMTE^XLFDT(DGPDT)_"? "
 D ^DIR K DIR
 Q:'Y
 D WAIT^DICD
 S X1=0
 ;
 F  S X1=$O(^DGS(41.43,"B",X1)) Q:X1']""!(X1>DGPDT)  D
 . S DGPN2="" F  S DGPN2=$O(^DGS(41.43,"B",X1,DGPN2)) Q:'DGPN2  D
 .. S DIK="^DGS(41.43,",DA=DGPN2
 .. D ^DIK K DIK,DA
 .. S DGPCNT=+$G(DGPCNT)+1
 ;
 W !!,+$G(DGPCNT)," Entries were purged from the PRE-REGISTRATION CALL LOG File."
 Q
