IBCFP ;ALB/ARH - PRINT AUTHORIZED BILLS IN ORDER ;6-DEC-94
 ;;2.0;INTEGRATED BILLING;**41,54,137,155,348**;21-MAR-94;Build 5
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 S IBPAR1=$G(^IBE(350.9,1,1))
 S IBFT=$G(^IBE(353,3,0)) I $P(IBFT,U,2)="" W !!,"Default printer in billing not defined for the "_$P(IBFT,U,1)_", none will print!",!
 I +$P(IBPAR1,U,22) S IBFT=$G(^IBE(353,2,0)) I $P(IBFT,U,2)="" W !!,"Default printer in billing not defined for the "_$P(IBFT,U,1)_", none will print!",!
 I '$D(^DGCR(399,"AST")) W !!,"There are no Authorized but not Printed bills to print!" G END
 ;
 S IBS="",IBZ="Z:ZIP;I:INSURANCE COMPANY NAME;P:PATIENT NAME;"
ORDER S DIR("?")="This option prints all non-transmittable bills with a Status of Authorized in the order requested.  The printed bills may be sorted by: Zip Code, Insurance Company Name, and Patient name."
1 S DIR("A")="First Sort Bills By",DIR(0)="SOB^"_IBZ D ^DIR I $D(DIRUT) G END
 S IBS=IBS_$S(Y="Z":1,Y="I":2,Y="P":3,1:0) S IBX=$P($P(IBZ,Y_":",2),";",1)
 ;
 S DIR("?",1)="Enter the field that the bills should be sorted on within "_IBX_".  Press return if the order already entered is sufficient.",DIR("?",2)=""
2 S DIR("A")="Then Sort Bills By",DIR(0)="SOB^"_IBZ D ^DIR I Y'="",$D(DIRUT) G END
 S IBS=IBS_$S(Y="Z":1,Y="I":2,Y="P":3,1:0) G:Y="" BEG S IBY=$P($P(IBZ,Y_":",2),";",1)
 ;
 S DIR("?",1)="Enter the field that the bills should be sorted on within "_IBX_" and "_IBY_".  Press return if the order already entered is sufficient."
3 S DIR("A")="Then Sort Bills By",DIR(0)="SOB^"_IBZ D ^DIR K DIR I Y'="",$D(DIRUT) G END
 S IBS=IBS_$S(Y="Z":1,Y="I":2,Y="P":3,1:0)
 ;
BEG S DIR("A")="Begin printing bills",DIR("?",1)="  Enter YES to begin printing all authorized non-transmittable bills."
 S DIR("?",2)="  Enter NO to quit this option."
 S DIR("?")="  Enter ?? to list the authorized bills that will be printed."
 W ! S DIR(0)="YBO",DIR("??")="^D DISPX^IBCF" D ^DIR K DIR I 'Y W "... bills not printed!" G END
 ;
 S ZTRTN="QTASK^IBCFP1",ZTDESC="BATCH PRINT AUTHORIZED THIRD PARTY BILLS",ZTIO="",ZTSAVE("IBS")="" D ^%ZTLOAD
 I $D(ZTSK) W !," ... queued"
 ;
END K DIR,IBX,IBY,IBZ,IBS,IBPAR1,IBFT,Y,X,DIRUT ; end of interactive part
 Q
 ;
 ;
DATE(X) Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
