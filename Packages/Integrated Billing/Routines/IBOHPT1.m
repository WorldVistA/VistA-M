IBOHPT1 ;ALB/EMG -  REPORT OF ON HOLD CHARGES FOR A PATIENT ;JULY 22 1997
 ;;2.0;INTEGRATED BILLING;**70,95,142,199,347**;21-MAR-94;Build 24
 ;
 ;
MAIN ;
 N IBQUIT,IBII,DIRUT,DUOUT,DTOUT,ZTIO,Y S IBQUIT=0
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^DPT(",DIC(0)="AEQMN" D ^DIC K DIC Q:Y<1  S DFN=+Y
 ;
 S DIR(0)="DA^::EX",DIR("A")="Start with DATE: "
 S DIR("?")="Enter the starting date for this report."
 D ^DIR K DIR G:$D(DIRUT) EXIT S IBSDT=+Y
 S DIR(0)="DA^"_+Y_":NOW:EX",DIR("A")="     Go to DATE: "
 S DIR("?")="Enter the ending date for this report."
 D ^DIR K DIR G:$D(DIRUT) EXIT S IBEDT=+Y
 ;
 S DIR(0)="Y",DIR("A")="Include Pharmacy Co-pay charges on this report",DIR("B")="NO"
 S DIR("?",1)="   Enter:  'Y' - to include Pharmacy Co-pay charges on this report"
 S DIR("?",2)="           'N' - to exclude Pharmacy Co-pay charges on this report"
 S DIR("?")="             '^' - to select a new patient"
 D ^DIR K DIR G:$D(DIRUT) EXIT S IBIBRX=Y
 ;
QUEUED ; entry point if queued
 ;***
 K ^TMP($J)
 D:'$G(IBQUIT) DEVICE D:'$G(IBQUIT) CHRGS,REPORT^IBOHPT2
 D EXIT
 ;***
 Q
EXIT ;
 K ^TMP($J)
 K DFN,IBEND,IBSDT,IBEDT,IBIBRX,IBCN,IBDT,IBIFN,X
 K IBRDT,IBRF,IBRX,IBRXN
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
DEVICE ;
 I $D(ZTQUEUED) Q
 W !!,*7,"*** Margin width of this output is 132 ***"
 W !,"*** This output should be queued ***"
 S %ZIS="QM" D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) S ZTRTN="QUEUED^IBOHPT1",ZTIO=ION,ZTDESC="ON HOLD CHARGE INFO/PT",ZTSAVE("IB*")="",ZTSAVE("DFN")="" D ^%ZTLOAD W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED") D HOME^%ZIS K ZTSK S IBQUIT=1 Q
 U IO
 Q
 ; indexes records that should be included in report
 ;
CHRGS ; charges on hold
 N DATE,IBN,IBND,A,B,C,D,E,IBNX
 S IBN=0 F  S IBN=$O(^IB("C",DFN,IBN)) Q:'IBN  S IBND=$G(^IB(IBN,0)) D:IBND
 .I 'IBIBRX,$E($G(^IBE(350.1,+$P(IBND,"^",3),0)),1,3)="PSO" Q
 .Q:$P(IBND,"^",8)["ADMISSION"
 .Q:'$P($G(^IB(IBN,1)),"^",6)
 .Q:'$D(^IB("APDT",IBN))
 .S (C,D)="",C=$O(^IB("APDT",IBN,C)),D=$O(^IB("APDT",IBN,C,D))
 .S E=$P($G(^IB(D,0)),U,3)
 .S A=$P($G(^IBE(350.1,E,0)),U,5)
 .S IBNX=$S(A=2:$P($Q(^IB("APDT",IBN,C,D)),")",1),A=3:$P($Q(^IB("APDT",IBN,C,D)),")",1),1:IBN)
 .I (A=2)!(A=3) D
 ..I IBNX["[""" S IBNX="^"_$P(IBNX,"]",2)
 .I $P(IBNX,",",4)>0 S IBNX=$P(IBNX,",",4)
 .S DATE=$P($G(^IB(+$P(IBND,"^",1),0)),"^",17)
 .S:'DATE DATE=$P($G(^IB(IBNX,1)),"^",5)
 .S:'DATE DATE=$P($G(^IB(IBNX,1)),"^",2)\1
 .I (DATE>(IBSDT-.0001))&(DATE<(IBEDT+.9999)) S ^TMP($J,"IB",-DATE,IBNX)="" D BILLS
 Q
 ;
BILLS ; find bills for charges on hold
 N IBFR,IBT,IBATYPE,IBTO
 S IBATYPE=$S($P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")["OPT":"O",$P($G(^IBE(350.1,+IBND,"^",3,0)),"^")["PSO":"RX",1:"I")
 S IBFR=$P(IBND,"^",14),IBTO=$P(IBND,"^",15)
 I IBATYPE="I" D INP
 I IBATYPE="O" D OPT
 E  D RX
 Q
INP ; inpatient bills
 N IBEV,IBBILL,IBT,X,X1,X2,IBEND,IBOK
 S IBEV=$P(IBND,"^",16) Q:'IBEV  ; parent event
 S IBEV=($P($G(^IB(IBEV,0)),"^",17)\1) Q:'IBEV  ; date of parent event
 S X1=IBEV,X2=1 D C^%DTC S IBEND=X
 S IBT=(IBEV-.0001) F  S IBT=$O(^DGCR(399,"D",IBT)) Q:'IBT!(IBT'<IBEND)  S IBBILL=0 F  S IBBILL=$O(^DGCR(399,"D",IBT,IBBILL)) Q:IBBILL=""  D
 .D INPTCK
 .I IBOK S ^TMP($J,"IB",-DATE,IBNX,IBBILL)=""
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
 ..Q:$D(^TMP($J,"IB",-DATE,IBNX,IBBILL))
 ..S IBBILL0=$G(^DGCR(399,IBBILL,0)) D CK4 Q:'IBOK
 ..S ^TMP($J,"IB",-DATE,IBNX,IBBILL)=""
 Q
RX ; rx refill bills
 Q:'IBIBRX
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
 .S ^TMP($J,"IB",-DATE,IBNX,IBBILL)=""
 Q
