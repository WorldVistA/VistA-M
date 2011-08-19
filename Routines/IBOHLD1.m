IBOHLD1 ;ALB/CJM -  REPORT OF CHARGES ON HOLD W/INS INFO ;MARCH 3 1992
 ;;2.0;INTEGRATED BILLING;**70,95,133,356,347**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; modified HELD CHARGES REPORT - includes INS info
 ;
MAIN ;
 N IBQUIT,IBII,DIRUT,DUOUT,DTOUT,ZTIO,Y S IBQUIT=0
 S DIR(0)="Y",DIR("A")="Include Insurance information on this report",DIR("B")="NO"
 S DIR("?",1)="     Enter:  'Y'  -  to include patient insurance information on this report"
 S DIR("?",2)="             'N'  -  to exclude patient insurance information on this report"
 S DIR("?",3)="             '^'  -  to exit this option"
 D ^DIR K DIR G:$D(DIRUT) EXIT S IBII=+Y
 ;
QUEUED ; entry point if queued
 ;***
 K ^TMP($J)
 D:'$G(IBQUIT) DEVICE D:'$G(IBQUIT) CHRGS,REPORT^IBOHLD2
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
 I $D(IO("Q")) D  Q
 . S ZTRTN="QUEUED^IBOHLD1"
 . S ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL
 . S ZTDESC="HELD CHARGES RPT W/INS"
 . S ZTSAVE("IB*")=""
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS K ZTSK S IBQUIT=1
 U IO
 Q
 ; indexes records that should be included in report
 ;
CHRGS ; charges on hold
 N IBN,DFN,IBNAME,IBND
 S DFN=0 F  S DFN=$O(^IB("AH",DFN)) Q:'DFN  D PAT S IBN=0 F  S IBN=$O(^IB("AH",DFN,IBN)) Q:'IBN  D
 .S IBND=$G(^IB(IBN,0)) Q:'IBND
 .S ^TMP($J,"HOLD",IBNAME,DFN,IBN)=""
 .D BILLS
 Q
PAT ; patient name
 N VAERR,VADM D DEM^VADPT I VAERR K VADM
 S IBNAME=$G(VADM(1)) S:IBNAME="" IBNAME=" "
 Q
BILLS ; find bills for charges on hold
 N IBFR,IBT,IBATYPE,IBTO
 S IBATYPE=$S($P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")["OPT":"O",$P($G(^IBE(350.1,+IBND,"^",3,0)),"^")["PSO":"RX",1:"I")
 S IBFR=$P(IBND,"^",14),IBTO=$P(IBND,"^",15)
 I IBATYPE="I" D INP
 I IBATYPE="O" D OTP
 E  D RX
 Q
INP ; inpatient bills
 N IBEV,IBBILL,IBT,X,X1,X2,IBEND,IBOK
 S IBEV=$P(IBND,"^",16) Q:'IBEV  ; parent event
 S IBEV=($P($G(^IB(IBEV,0)),"^",17)\1) Q:'IBEV  ; date of parent event
 S X1=IBEV,X2=1 D C^%DTC S IBEND=X
 S IBT=(IBEV-.0001) F  S IBT=$O(^DGCR(399,"D",IBT)) Q:'IBT!(IBT'<IBEND)  S IBBILL=0 F  S IBBILL=$O(^DGCR(399,"D",IBT,IBBILL)) Q:IBBILL=""  D
 .D INPTCK
 .I IBOK S ^TMP($J,"HOLD",IBNAME,DFN,IBN,IBBILL)=""
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
OTP ; outpatient bills
 N X,IBV,IBBILL,IBOK,IBBILL0
 S IBV=(IBFR\1)-.0001 F  S IBV=$O(^DGCR(399,"AOPV",DFN,IBV)) Q:'IBV!(IBV>IBTO)  S IBBILL=0 D
 .F  S IBBILL=$O(^DGCR(399,"AOPV",DFN,IBV,IBBILL)) Q:('IBBILL)  D
 ..Q:$D(^TMP($J,"HOLD",IBNAME,DFN,IBN,IBBILL))
 ..S IBBILL0=$G(^DGCR(399,IBBILL,0)) D CK4 Q:'IBOK
 ..S ^TMP($J,"HOLD",IBNAME,DFN,IBN,IBBILL)=""
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
 .S ^TMP($J,"HOLD",IBNAME,DFN,IBN,IBBILL)=""
 Q
