IBOHCT ;ALB/EMG - CHECK FOR IB CHARGES ON HOLD ; MAY 2 1997
 ;;2.0; INTEGRATED BILLING ;**70,95,347**; 21-MAR-94;Build 24
 ;
FIND(DFN,IBTRN) ;  find all related IB charges on hold for episodes of care
 ;  for this Claims Tracking entry with Reason Not Billable
 ;  once IB Charge is found, release Charge On Hold to AR
 ;  so patient can be billed.
 ;
 ;  Input:  DFN -- pointer to the patient in file #2
 ;          IBTRN -- ien of Claims Tracking entry
 ;
 I '$G(DFN)!('$G(IBTRN)) G ALLQ
 D HOME^%ZIS
 ;
 N X,Y,Y1,IBA,IBX,IBCTR,IBEDT,IBEND,IBNOS,IBSEQNO,IBDUZ,DP,DL
 ;
 S IBCT=$G(^IBT(356,IBTRN,0)),IBEDT=$P($P(IBCT,"^",6),"."),IBI=0
 I $P(IBCT,"^",18)=4 D RXCHG,REL G ALLQ
 ;
 ;
 ; - find related inpatient/outpatient patient charges on hold
 S (IBNUM,Y)=0 F  S Y=$O(^IB("AFDT",DFN,-IBEDT,Y)) Q:'Y  D
 .S Y1=0 F  S Y1=$O(^IB("AF",Y,Y1)) Q:'Y1  D
 ..Q:'$D(^IB(Y1,0))  S IBX=^(0)
 ..I $P(IBX,"^",5)'=8 Q
 ..S IBNUM=IBNUM+1,IBA(IBNUM)=Y1
 ..Q
 .Q
 ;
REL ; allow user to select IB charges to pass to Accounts Receivable
 ;
 I '$G(IBNUM) G ALLQ
 W !!,"The following IB Action"_$S(IBNUM>2:"s",1:"")_", related to this CT entry, ",$S(IBNUM>2:"are",1:"is")," ON HOLD:" D HDR
 S IBQ=0 F IBNUM=1:1 Q:'$D(IBA(IBNUM))  D:'(IBNUM#15)  Q:IBQ  S IBN=IBA(IBNUM) D LST
 . R !,"Enter RETURN to continue or '^' to stop: ",X:DTIME S:X["^"!('$T) IBQ=1 Q
 ;
 ; prompt user to select IB Actions
 S DIR(0)="LA^1:"_(IBNUM-1)_"^",DIR("A")="Select IB Action"_$E("s",IBNUM>2)_" (REF #) to release to Accounts Receivable (or '^' to exit): ",DIR("?")="^D HELP^IBRREL"
 W ! D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) Q
 ;
 S IBRANGE=Y,IBSEQNO=1,IBDUZ=DUZ
 S DIR(0)="Y",DIR("A")="OK to pass "_$S($P(Y,",",2):"these charges",1:"this charge")_" to Accounts Receivable"
 D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) G ALLQ
 ;
 ; pass charges to Accounts Receivable
 W !!,"Passing charges to Accounts Receivable...",! D HDR
 F IBCTR=1:1 S IBNUM=$P(IBRANGE,",",IBCTR) Q:'IBNUM  I $D(IBA(IBNUM)) S IBNOS=IBA(IBNUM) D ^IBR,ERR:Y<1 I Y>0 S IBN=IBA(IBNUM) D LST
 W !!,"The charge"_$E("s",$P(IBRANGE,",",2)>0)_" listed above "_$S($P(IBRANGE,",",2):"have",1:"has")_" been passed to Accounts Receivable.",!
 ;
 W ! S DIR(0)="E" D ^DIR K DIR G ALLQ
 ;
ALLQ K IBC,IBCRG,IBCT,IBCTR,IBEDT,IBEND,IBI,IBLINE,IBN,IBND
 K IBNOS,IBNUM,IBOHD,IBQ,IBRANGE,IBRXN,IBRXDT,IBRXEND,IBSEQNO
 K DIRUT,DUOUT
 Q
 ;
 ;
HDR ; Display charge header.
 N IBLINE S $P(IBLINE,"=",81)=""
 W !,IBLINE,!," REF   Action ID  Bill Type",?42,"Bill #",?51,"Fr/Fl Dt",?61,"To/Rls Dt",?73,"Charge"
 W !,IBLINE Q
 ;
LST ; Display individual IB Action.
 N IBND,IBND1,IBRXN,IBRX,IBRF,IBRDT,IENS
 S IBND=$G(^IB(IBN,0)),IBND1=$G(^IB(IBN,1)),(IBRXN,IBRX,IBRF,IBRDT)=0
 I $P(IBND,"^",4)["52:" S IBRXN=$P($P(IBND,"^",4),":",2),IBRX=$P($P(IBND,"^",8),"-"),IBRF=$P($P(IBND,"^",4),":",3)
 I $P(IBND,"^",4)["52:"  D
 .I IBRF>0 S IENS=+IBRF,IBRDT=$$SUBFILE^IBRXUTL(+IBRXN,+IENS,52,.01)
 .E  S IENS=+IBRXN,IBRDT=$$FILE^IBRXUTL(+IENS,22)
 W !?1,$J(IBNUM,2),?7,$J(+IBND,9)
 W ?18,$S(IBRXN>0:"Rx #: "_IBRX_$S(IBRF>0:"("_IBRF_")",1:""),1:$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",8))
 W ?42,$P($P(IBND,"^",11),"-",2)
 W ?51,$$DAT1^IBOUTL($S(IBRXN>0:IBRDT,1:$P(IBND,"^",14)))
 W ?61,$$DAT1^IBOUTL($S($P(IBND,"^",15)'="":($P(IBND,"^",15)),1:$P(IBND1,"^",2)))
 W ?70,$J(+$P(IBND,"^",7),9,2)
 Q
 ;
RXCHG ; - find related rx copay's on hold in file 350
 N IBRXN,IBRXBN,IBRXEND,IBRXDT,IBCRG,IBC
 S IBNUM=0
 S IBRXEND=+IBEDT+.999999 F  S IBEDT=$O(^IB("APTDT",DFN,IBEDT)) Q:'IBEDT!(IBEDT>IBRXEND)  S Y1=0 F  S Y1=$O(^IB("APTDT",DFN,IBEDT,Y1)) Q:'Y1  S IBX=^IB(Y1,0),IBOHD=$P($G(^IB(Y1,1)),"^",6) D
 .I $P(IBX,"^",5)'=8 Q
 .S IBNUM=IBNUM+1,IBA(IBNUM)=Y1 Q
 Q
 ;
ERR ; display error message
 W !,?5,"Error encountered - a separate bulletin has been posted"
 Q
