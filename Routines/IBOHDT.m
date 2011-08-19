IBOHDT ;ALB/EMG -  REPORT OF CHARGES ON HOLD > 60 DAYS ;FEB 14 1997
 ;;2.0;INTEGRATED BILLING;**70,95,142,347**;21-MAR-94;Build 24
 ;
 ; 
MAIN ;
 N DIRUT,DTOUT,DUOUT,IBNUM,IBQUIT,POP,VA,ZTIO,Y S (IBQUIT,IBNUM)=0
 W !!
 S DIR(0)="NO",DIR("B")=60,DIR("A")="Enter number of days",DIR("A",1)="This report is used to follow-up on charges that have been on hold for an"
 S DIR("A",2)="extended period of time.  Press return to print a list of charges on hold",DIR("A",3)="for longer than 60 days.  You may limit your search to older charges"
 S DIR("A",4)="by typing a higher number.  (For example, type 80 to see charges on hold",DIR("A",5)="for longer than 80 days.)",DIR("A",6)=""
 D ^DIR K DIR S IBNUM=+Y Q:$D(DIRUT)
QUEUED ; entry point if queued
 ;***
 K ^TMP($J)
 D:'$G(IBQUIT) DEVICE D:'$G(IBQUIT) CHRGS,REPORT^IBOHDT1
 D EXIT
 ;***
 Q
EXIT ;
 K ^TMP($J)
 K IBRDT,IBRF,IBRX,IBRXN
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
DEVICE ;
 I $D(ZTQUEUED) Q
 W !!,*7,"*** Margin width of this output is 132 ***"
 W !,"*** This output should be queued ***"
 S %ZIS="QM" D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) S ZTRTN="QUEUED^IBOHDT",ZTIO=ION,ZTDESC="HELD CHARGES REPORT",ZTSAVE("IB*")="" D ^%ZTLOAD W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED") D HOME^%ZIS K ZTSK S IBQUIT=1 Q
 U IO
 Q
 ; indexes records that should be included in report
 ;
CHRGS ; charges on hold
 N DFN,IBDT,IBN,IBNAME,IBND,IBTYPE,X1,X2
 S X1=DT,X2=(-IBNUM) D C^%DTC S IBTO=X
 S DFN=0 F  S DFN=$O(^IB("AHDT",DFN)) Q:'DFN  S IBDT=0 F  S IBDT=$O(^IB("AHDT",DFN,8,IBDT)) Q:'IBDT!(IBDT>IBTO)  S IBN=0 F  S IBN=$O(^IB("AHDT",DFN,8,IBDT,IBN)) Q:IBN=""  D
 .S IBND=$G(^IB(IBN,0)) Q:'IBND
 .S DFN=$P(IBND,"^",2) D  ;fetch patient name
 ..N VAERR,VADM D DEM^VADPT I VAERR K VADM
 ..S IBNAME=$G(VADM(1))
 ..Q
 .S IBTYPE=$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^"),IBATYPE=$S(IBTYPE["OPT":"O",IBTYPE["PSO":"RX",1:"I")
 .S ^TMP($J,"HOLD",IBNAME,DFN,IBATYPE,IBN)=""
 .D BILLS
 Q
PAT ; patient name
 N VAERR,VADM D DEM^VADPT I VAERR K VADM
 S IBNAME=$G(VADM(1)) S:IBNAME="" IBNAME=" "
 Q
BILLS ; find bills for charges on hold
 N IBFR,IBT,IBATYPE,IBTO
 S IBATYPE=$S($P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")["OPT":"O",$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")["PSO":"RX",1:"I")
 S IBFR=$P(IBND,"^",14),IBTO=$P(IBND,"^",15)
 I IBATYPE="I" D INP
 I IBATYPE="O" D OPT
 E  D RX,OPT
 Q
INP ; inpatient bills
 N IBEV,IBBILL,IBT,X,IBEND,IBOK
 S IBEV=$P(IBND,"^",16) Q:'IBEV  ; parent event
 S IBEV=($P($G(^IB(IBEV,0)),"^",17)\1) Q:'IBEV  ; date of parent event
 S X1=IBEV,X2=1 D C^%DTC S IBEND=X
 S IBT=(IBEV-.0001) F  S IBT=$O(^DGCR(399,"D",IBT)) Q:'IBT!(IBT'<IBEND)  S IBBILL=0 F  S IBBILL=$O(^DGCR(399,"D",IBT,IBBILL)) Q:IBBILL=""  D
 .D INPTCK
 .I IBOK S ^TMP($J,"HOLD",IBNAME,DFN,IBATYPE,IBN,IBBILL)=""
 Q
 ;
INPTCK ; does bill belong to charge? returns IBOK=0 if no
 N IBBILL0,IBBILLU
 S IBBILL0=$G(^DGCR(399,IBBILL,0)),IBBILLU=$G(^("U"))
 S IBOK=1
CK1 ; for same patient?
 I DFN=$P(IBBILL0,"^",2)
 S IBOK=$T
 Q:'IBOK
CK2 ; same type- inp or opt?
 N B S B=$S(+$P(IBBILL0,"^",5)<3:"I",1:"O")
 I B=IBATYPE
 S IBOK=$T
 Q:'IBOK
CK3 ; overlap in date range?
 N F,T
 S F=+IBBILLU,T=$P(IBBILLU,"^",2)
 I (IBTO<F)!(IBFR>T)
 S IBOK='$T
 Q:'IBOK
CK4 ; insurance bill?
 I $P(IBBILL0,"^",11)="i"
 S IBOK=$T
 Q
OPT ; outpatient bills
 N X,IBV,IBBILL,IBOK,IBBILL0
 S IBV=(IBFR\1)-.0001 F  S IBV=$O(^DGCR(399,"AOPV",DFN,IBV)) Q:'IBV!(IBV>IBTO)  S IBBILL=0 D
 .F  S IBBILL=$O(^DGCR(399,"AOPV",DFN,IBV,IBBILL)) Q:('IBBILL)  D
 ..Q:$D(^TMP($J,"HOLD",IBNAME,DFN,IBATYPE,IBN,IBBILL))
 ..S IBBILL0=$G(^DGCR(399,IBBILL,0)) D CK4 Q:'IBOK
 ..S ^TMP($J,"HOLD",IBNAME,DFN,IBATYPE,IBN,IBBILL)=""
 Q
RX ; rx refill bills
 S (IBRX,IBRXN,IBRF,IBRDT)=0 N IENS
 I $P(IBND,"^",4)'["52:" Q
 ;
 S IBRXN=$P($P(IBND,"^",4),":",2),IBRX=$P($P(IBND,"^",8),"-"),IBRF=$P($P(IBND,"^",4),":",3)
 ;
 I +IBRF>0 S IBRDT=$$SUBFILE^IBRXUTL(+IBRXN,IBRF,52,.01)
 I +IBRF=0 S IBRDT=$$FILE^IBRXUTL(+IBRXN,22)
 ;
 Q:(IBRX="")!('IBRDT)
 N X,IBBILL,IBBILL0,IBFILL,IBFILL0,IBOK S IBBILL=0
 S IBFILL=0 F  S IBFILL=$O(^IBA(362.4,"B",IBRX,IBFILL)) Q:IBFILL=""  D
 .S IBFILL0=$G(^IBA(362.4,IBFILL,0)) I $P(IBFILL0,"^",3)'=IBRDT Q
 .S IBBILL=+$P(IBFILL0,"^",2) I 'IBBILL Q
 .S IBBILL0=$G(^DGCR(399,IBBILL,0)) D CK4 I 'IBOK Q
 .S ^TMP($J,"HOLD",IBNAME,DFN,IBATYPE,IBN,IBBILL)=""
 Q
