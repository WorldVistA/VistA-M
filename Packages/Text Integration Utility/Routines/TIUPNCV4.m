TIUPNCV4 ;SLC/DJP ;2/26/98  13:30
 ;;1.0;TEXT INTEGRATION UTILITIES;**9**;Jun 20, 1997
 ;
ENTRY ;Entry point to set-up conversion
 N DIC,TIUQUEUE
 I $G(DUZ)'>0 W !!,"DUZ must be defined as an active user!",! Q
 S TIU("DUZ")=DUZ
 D INTRO^TIUPNCV5 I $G(TIU("QUIT")) K TIU Q
 I $P($G(^TIU(8925.97,1,0)),U,3) W !!,"Conversion has been completed.",! K TIU Q
 W ! S DIR(0)="Y",DIR("A")="Are you sure everything is okay"
 S DIR("B")="NO",DIR("?")="^D HELP1^TIUPNCV4" D ^DIR Q:$D(DIRUT)!(Y=0)
 S TIUQUEUE=$$READ^TIUU("Y","Would you like to QUEUE this Process","NO")
 I +TIUQUEUE D PNDEVICE Q
 W !!?9,$C(7),"Progress Notes Conversion Running in Foreground",!
 D DRIVER^TIUPNCV
 Q
 ;
PNDEVICE ;Permits site to queue conversion
 N %,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTSK,ZTRTN
 S ZTSAVE("TIU*")="",ZTSAVE("GMRP*")=""
 S:'$D(ZTDESC) ZTDESC="TIU PN CONVERSION"
 S ZTRTN="DRIVER^TIUPNCV",ZTIO="" D ^%ZTLOAD
 W !,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled."),!
 D ^%ZISC
 Q
 ;
REPORT ;sends bulletin to initiator of conversion
 I '$D(TIUUSER) S TIUUSER=DUZ
 S XMY(TIUUSER)=""
 S XMB="TIU PRN CONVERSION "_$S(GMRPCTR:"ERRORS",1:"CLEAN")
 S XMDUZ="TIU PROGRESS NOTE CONVERSION"
 S XMB(1)=TIUSTRT,XMB(2)=TIUEND,XMB(3)=TIUCTR
 I ERRCTR S XMB(4)=ERRCTR,XMTEXT="^GMR(121,""ERROR"","
 D ^XMB,KILL^XM K TIUEND,TIUSTRT,ERRCTR
 Q
 ;
RESTART ;Permit restarting of conversion from last successfully processed note.
 W !
 K DIR W @IOF
 W !!?10,"******  RESTART PROGRESS NOTE/TIU CONVERSION  ******",!!
 S GMRPST1=$P($G(^TIU(8925.97,1,0)),U,5)
 I GMRPST1'>0 W !?5,"Conversion has NOT been previously run",!?5,"Please use the CONVERT PROGRESS NOTE option." K GMRPST1 Q
 K DIR S DIR(0)="Y",DIR("A")="Do you wish to restart the conversion"
 S DIR("B")="YES",DIR("?")="^D HELP2^TIUPNCV4" D ^DIR Q:$D(DIRUT)!(Y=0)
 W !!?5,"A mail message documenting discrepancies encountered during "
 W !,?5,"processing will be sent to you.",!
 S TIU("DUZ")=DUZ
 D MAIL^TIUPNCV5
 S GMRPST=(GMRPST1+1)
 W !!,"Restarting Progress Note Conversion at Record #"_GMRPST_"...",!
 S $P(^TIU(8925.97,1,0),U,3)=""
 S GMRPST=(GMRPST-1),RESTARTD=$$NOW^XLFDT
 S ^GMR(121,"RESTART",GMRPST)=RESTARTD ;Records restart date/time
 S ZTDESC="RESTART PN CONVERSION"
 D PNDEVICE
 Q
 ;
INDY ;Converts individual Progress Notes based on IEN in ^GMR(121
 S TIUFPRIV=1
 W @IOF W !!?18,"***** INDIVIDUAL RECORD CONVERSION *****",!
 ;
ENINDY ;Entry of IEN
 K DIR S DIR(0)="NO^1:9999999"
 S DIR("A")="Enter IEN of Note to be converted"
 S DIR("?")="^D HELP4^TIUPNCV4" D ^DIR I $D(DIRUT) K DIR Q
 I '$D(^GMR(121,Y)) W !,"Entry ",Y," not found in file 121",$C(7) G ENINDY
 I +$P($G(^GMR(121,Y,1)),U,3)&($P($G(^GMR(121,Y,5)),U)=1) S TIUECS=$$ASKCOS^TIUPNCVU Q:'TIUECS  ;If signed and uncosigned need to ask for expected cosigner, quit if none entered.
 ;
EMERG ;Emergency entrance - must pass "Y" and "EMER"
 S GMRPIFN=Y,TIU("INDY")=1,GMRPCTR=0,TIUCTR=0
 I $D(^GMR(121,"CNV",GMRPIFN)) W !?5,"Progress Note IEN "_GMRPIFN_" was converted in a prior session.",! K GMRPIFN,TIU("INDY") G ENINDY:'$D(EMER)
 S NEWNODE=1 W:'$D(EMER) !!?5,"Now converting Progress Note "_GMRPIFN_"...",!
 D MAIN^TIUPNCV8
 I '$D(^GMR(121,"CNV",GMRPIFN)),$D(^GMR(121,"ERROR",GMRPIFN)) D  G KILINDY
 . W !!,"*****Progress Note "_GMRPIFN_" NOT converted*****",!
 . W ^GMR(121,"ERROR",GMRPIFN),!
 W:'$D(EMER) !,"Progress Note "_GMRPIFN_" successfully converted",!
 ;
KILINDY ;Cleans up the debris
 K GMRPIFN,TIU("INDY"),DIR,NEWNODE,BADREC,TIUCTR
 I $D(EMER) Q
 G ENINDY
 ;
HELP1 ;Help for are you sure prompt
 W !!,"Enter Yes if you're ready to start the conversion."
 W !,"Press return or enter NO to stop this process."
 Q
HELP2 ;Help for RESTART prompt
 W !!?5,"Enter YES to re-start/re-queue the conversion."
 W !?5,"Press <ret> or enter NO to stop this option."
 Q
 ;
HELP3 ;Help for IEN prompt
 W !!?5,"The default is the next expected Internal File Number (IEN)"
 W " for a note."
 W !?5,"If another starting point is required, enter the IEN for that"
 W " note."
 W !?5,"Enter ""^"" to stop option without processing."
 Q
 ;
HELP4 ;Help for INDY prompt
 W !!?5,"Enter the Internal Entry Number (IEN) of the single Progress"
 W !?5,"you wish to convert to TIU.",!
 Q
 ;
