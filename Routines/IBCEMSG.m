IBCEMSG ;ALB/JEH - EDI PURGE STATUS MESSAGES ;10-APR-01
 ;;2.0;INTEGRATED BILLING:**137**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;
 N IBDELDT,IBSEL,IBQUIT,IBPRT,DTOUT,DUOUT,DIRUT,X,Y
 K ^TMP("IBCEMSGA",$J)
 I '$D(^XUSEC("IB SUPERVISOR",DUZ)) W !!,"You do not have the appropriate authority to delete status messages.  See your supervisor for assistance." G MSGQ
 W !,"This option will delete status messages in one of the Final Review statuses",!,"prior to a selected date",!!
 S DIR("A")="DELETE (A)LL OR (S)ELECTED STATUS MESSAGES? ",DIR("B")="SELECTED"
 S DIR(0)="SAXB^A:ALL STATUS MESSAGES;S:SELECTED STATUS MESSAGES"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G MSGQ
 S IBSEL=Y
 ;
 W !
 I IBSEL="A" D  G:IBQUIT MSGQ
 . S IBQUIT=0
 . S DIR("A")="DELETE STATUS MESSAGES REVIEWED PRIOR TO"
 . S DIR(0)="D^:DTP:EX" W ! D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S IBQUIT=1 Q
 . S IBDELDT=Y
 . S DIR("A",1)="This action will delete all status messages with a"
 . S DIR("A",2)="final review action dated before "_$$FMTE^XLFDT(IBDELDT)
 . S DIR("A",3)=""
 . S DIR("A")="ARE YOU SURE THIS IS WHAT YOU WANT TO DO",DIR("B")="YES"
 . S DIR(0)="Y" D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!(+Y=0) S IBQUIT=1 Q
 . S DIR("A")="DO YOU WANT TO PRINT STATUS MESSAGES BEFORE DELETION"
 . S DIR(0)="Y",DIR("B")="YES"
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S IBQUIT=1 Q
 . S IBPRT=Y
 I IBSEL="A" D SET,PRT:IBPRT,DEL
 I IBSEL="S" D EN^IBCEMSG1
MSGQ ;
 Q
SET ;set up tmp global
 N IBDT,IBIEN,IB0,IBNUM,IBSEV,IBFNR,IBFRD,IBQUIT,IBAUTO
 S (IBDT,IBQUIT)=0 F  S IBDT=$O(^IBM(361,"AFR",IBDT)) Q:'IBDT!(IBQUIT)  S IBIEN=0 F  S IBIEN=$O(^IBM(361,"AFR",IBDT,IBIEN)) Q:'IBIEN!(IBQUIT)  D
 . I IBDT>IBDELDT S IBQUIT=1 Q
 . S IB0=$G(^IBM(361,IBIEN,0))
 . S IBNUM=$$BN1^PRCAFN($P($G(IB0),U))
 . S IBSEV=$$EXPAND^IBTRE(361,.03,$P($G(IB0),U,3))
 . S IBFNR=$$EXPAND^IBTRE(361,.1,$P($G(IB0),U,10))
 . S IBFRD=$$DAT1^IBOUTL($P($G(IB0),U,13))
 . S IBAUTO=$$EXPAND^IBTRE(361,.14,$P(IB0,U,5))
 . S ^TMP("IBCEMSGA",$J,IBIEN)=IBNUM_U_IBSEV_U_IBFNR_U_IBFRD
 Q
 ;
PRT ;print status message list
 N IBPG,%ZIS
 S IBPG=0
 S %ZIS="M" D ^%ZIS G:POP MSGQ
 U IO
PRT1 ;
 N IBIEN,IB0 D HDR
 S IBIEN=0 F  S IBIEN=$O(^TMP("IBCEMSGA",$J,IBIEN)) Q:'IBIEN  S IB0=^(IBIEN) D
 .I ($Y+5)>IOSL D  Q:IBQUIT
 .. D ASK Q:IBQUIT  D HDR
 . W !,$P(IB0,U),?13,$P(IB0,U,2),?34,$P(IB0,U,3),?71,$P(IB0,U,4)
 W !
 D ^%ZISC
 Q
ASK ;
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S IBQUIT=1 Q
 Q
 ;
HDR ; - report header
 I $E(IOST,1,2)="C-" W @IOF,*13
 S IBPG=IBPG+1
 W !!,"Status Messages Selected for Deletion",?57,$$FMTE^XLFDT(DT),?71,"Page: ",IBPG,!
 W !,?13,"Message",?34,"Final Review",?67,"Final Review",!,"Bill #",?13,"Severity",?37,"Action",?72,"Date"
 W !,$TR($J("",IOM)," ","=")
 Q
DEL ;Delete status messages in final review status
 N DIK,DA,Y,IBIEN,IBCNT
 W !
 S DIR("A")="ARE YOU SURE YOU WANT TO DELETE STATUS MESSAGES",DIR("B")="YES"
 S DIR(0)="Y" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y=0) G DELQ
 S IBCNT=0,DIK="^IBM(361,"
 S IBIEN=0 F  S IBIEN=$O(^TMP("IBCEMSGA",$J,IBIEN)) Q:'IBIEN  S DA=IBIEN D ^DIK S IBCNT=IBCNT+1
 W !!,IBCNT_$S(IBCNT>1:" Messages",1:" Message")_" deleted"
DELQ Q
 ;
