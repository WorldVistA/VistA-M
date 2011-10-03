IBEMTO ;ALB/CPM-BILL MT CHARGES AWAITING NEW COPAY RATE ;02-AUG-93
 ;;2.0;INTEGRATED BILLING;**179,183,202**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Bill MT OPT charges on hold awaiting the new copay rate.
 ;
ENO ; Standalone option entry point
 S IBOPT=1
 ;
ENR ; Enter/edit billing rates entry point
 ;
 ; - quit if job has been fired up from enter/edit rates already
 I $G(IBRUN) G ENQ
 ;
 ; no longer used (at least for now)
 W !!,"This option is no longer available.",! G ENQ
 ;
 ; - quit if there are no charges on hold awaiting the new rate
 I '$D(^IB("AC",20)) W:$G(IBOPT) !!,"There are no charges on hold awaiting the entry of the new copay rate." G ENQ
 ;
 ; - quit if current rate is still too old
 S IBDT=DT,IBX="O" D TYPE^IBAUTL2
 I $$OLDRATE^IBAMTS1(IBRTED,DT) D:$G(IBOPT)  G ENQ
 .W !!,"The current copay rate (effective ",$$DAT1^IBOUTL(IBRTED),") is still too old to use.  Please be"
 .W !,"sure that you have entered the most current rate in your Billing Rates table."
 ;
 ; - if x-ref is locked, the job must be currently running
 L +^IB("AC",20):5 E  D:$G(IBOPT)  G ENQ
 .W !!,"The list of held charges cannot be accessed -- the job to bill these held"
 .W !,"charges may currently be running."
 ;
 ; - queue the job to bill the held charges?
 I '$G(IBOPT) D
 .W !!?28,*7,*7,"***  PLEASE NOTE  ***"
 .W !?8,"The Means Test Outpatient Copayment rate has just been updated,"
 .W !?8,"and there are charges 'on hold' awaiting the entry of this new rate!",!
 ;
 I $G(IBOPT) D
 .S IBN=0 F IBJ=0:1:21 S IBN=$O(^IB("AC",20,IBN)) Q:'IBN
 .W !!,"There ",$S(IBJ=1:"is 1",1:"are "_$S(IBJ>20:"at least ",1:"")_IBJ)," charge",$E("s",IBJ>1)," on hold, awaiting the new copay rate."
 S DIR(0)="Y",DIR("A")="Do you want to queue a job to automatically bill these held charges",DIR("?")="^D HQ^IBEMTO"
 D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) G ENQ
 ;
 ; - queue up job to bill held charges
 S:'$G(IBOPT) ZTDTH=$H
 S ZTRTN="DQ^IBEMTO",ZTIO="",ZTDESC="BILLING OF MT OPT CHARGES AWAITING NEW COPAY RATE"
 S IBRUN=1 D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job!")
 ;
ENQ L -^IB("AC",20)
 K:$G(IBOPT) IBRUN
 K IBN,IBDT,IBATYP,IBDESC,IBJ,IBOPT,IBRTED,IBCHG,IBX,ZTSK
 Q
 ;
HQ ; Help for prompt
 W !!,"If you wish to queue off a job to bill the Means Test Outpatient"
 W !,"copayment charges that are on hold awaiting entry of the updated"
 W !,"billing rate, please enter 'Y' or 'YES'.  The job will be tasked"
 W !,"immediately.  Otherwise, enter 'N' or 'NO' or '^' to quit."
 Q
 ;
 ;
DQ ; Tasked job to bill all charges awaiting the new copay rate.
 S IBJOB=8,IBDUZ=DUZ,IBSEQNO=1,IBCNT=0
 ;
 ; - record start time
 D NOW^%DTC S IBSTART=$$DAT2^IBOUTL(%)
 ;
 ; - if can't lock x-ref, job must currently be running
 L +^IB("AC",20):5
 ;
 ; - loop through all charges awaiting the new rate
 I  S IBREF=0 F  S IBREF=$O(^IB("AC",20,IBREF)) Q:'IBREF  D CHG
 ;
 ; - unlock x-ref, record end time, and post bulletin
 L -^IB("AC",20)
 D NOW^%DTC S IBEND=$$DAT2^IBOUTL(%)
 D BULL^IBEMTO1
 K IBT,IBSTART,IBEND,IBREF,IBND,IBDT,IBX,IBCHG,IBSEQNO,IBNOS,IBCNT,XMTEXT,XMSUB,XMZ,XMY,XMDUZ
 Q
 ;
CHG ; Pass a single charge to Accounts Receivable.
 S IBND=$G(^IB(IBREF,0)) I 'IBND K ^IB("AC",20,IBREF) G CHGQ
 S IBDT=DT,IBX="O" D TYPE^IBAUTL2
 I $$OLDRATE^IBAMTS1(IBRTED,$P(IBND,"^",14)) G CHGQ ; rate still old
 S $P(^IB(IBREF,0),"^",7)=IBCHG,IBSEQNO=1,DFN=+$P(IBND,"^",2)
 S IBNOS=IBREF D ^IBR S:Y>0 IBCNT=IBCNT+1
CHGQ Q
