IBOTR1 ;ALB/CPM - INSURANCE PAYMENT TREND REPORT - USER INTERFACE ; 5-JUN-91
 ;;2.0;INTEGRATED BILLING;**21,42,72,100,118,128**;21-MAR-94
 ;
 ;MAP TO DGCROTR1
 ;
OUTPT W !!,"Select (I)NPATIENT, (O)UTPATIENT, or (B)OTH bill records: BOTH// "
 R X:DTIME G:'$T!(X["^") END S:X="" X="B" S X=$E(X)
 I "BIObio"'[X S IBOFF=1 D HELP^IBOTR11 G OUTPT
 W "  ",$S("Ii"[X:"INPATIENT","Oo"[X:"OUTPATIENT",1:"BOTH")
 S (IBBRT,IBBRTY)=$S("Ii"[X:"I","Oo"[X:"O",1:"A") I "Bb"'[X G ARST
 ;
REPTY W !,"Print (C)OMBINED or (S)EPARATE reports: COMBINED// "
 R X:DTIME G:'$T!(X["^") END S:X="" X="C" S X=$E(X)
 I "CScs"'[X S IBOFF=7 D HELP^IBOTR11 G REPTY
 W "  ",$S("Cc"[X:"COMBINED",1:"SEPARATE")
 S IBBRN=$S("Cc"[X:"C",1:"S")
 ;
ARST W !,"Select (O)PEN, (C)LOSED, or (B)OTH types of bills: BOTH// "
 R X:DTIME G:'$T!(X["^") END S:X="" X="B" S X=$E(X)
 I "BCObco"'[X S IBOFF=14 D HELP^IBOTR11 G ARST
 W "  ",$S("Oo"[X:"OPEN","Cc"[X:"CLOSED",1:"BOTH")
 S IBARST=$S("Oo"[X:"O","Cc"[X:"C",1:"A")
 ;
CANC I $G(IBAF)=16 G QDATE ; Skip if CANCEL BILL? field was selected.
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you want to include cancelled bills"
 S DIR("?")="^S IBOFF=20 D HELP^IBOTR11"
 D ^DIR K DIR S IBCANC=+Y I $D(DIRUT)!$D(DTOUT)!$D(DUOUT) G END
 ;
QDATE S DIR(0)="SA^1:DATE BILL PRINTED;2:TREATMENT DATE"
 S DIR("A")="Print report by 1-DATE BILL PRINTED or 2-TREATMENT DATE: "
 S DIR("B")="1",DIR("T")=20,DIR("?")="^S IBOFF=25 D HELP^IBOTR11"
 W ! D ^DIR K DIR G:Y=""!(X="^") END S IBDF=Y,IBDFN=Y(0)
BEGDT S %DT="AEPX",%DT("A")="   Start with "_IBDFN_": "
 D ^%DT K %DT G:Y<0 END S IBBDT=Y
 S %DT="AEPX",%DT("A")="        Go to "_IBDFN_": "
 D ^%DT K %DT G:Y<0 END S IBEDT=Y
 I Y<IBBDT W *7,!!?3,"The END DATE must follow the BEGIN DATE.",! G BEGDT
 ;
PRINT W !!,"Print (M)AIN REPORT, (S)UMMARY, or (G)RAND TOTALS: M// "
 R X:DTIME G:'$T!(X["^") END S:X="" X="M" S X=$E(X)
 I "GMSgms"'[X S IBOFF=30 D HELP^IBOTR11 G PRINT
 W "  ",$S("Mm"[X:"MAIN REPORT","Ss"[X:"SUMMARY",1:"GRAND TOTALS")
 S IBPRNT=$S("Mm"[X:"M","Ss"[X:"S",1:"G")
 ;
INS W !,"Run ",$S("MS"[IBPRNT:"report",1:"totals")
 W " for (S)PECIFIC insurance companies or a (R)ANGE: RANGE// "
 R X:DTIME G:'$T!(X["^") END S:X="" X="R" S X=$E(X)
 I "RSrs"'[X S IBOFF=38 D HELP^IBOTR11 G INS
 W "  ",$S("Ss"[X:"SPECIFIC",1:"RANGE") G:"Rr"[X INSO1 K IBICPT
INSO S DIC="^DIC(36,",DIC(0)="AEQMZ",DIC("S")="I '$G(^(5))"
 S DIC("A")="   Select "_$S($G(IBICPT):"another ",1:"")_"INSURANCE CO.: "
 D ^DIC K DIC I Y'>0 G END:'$G(IBICPT),INSO3
 I $D(IBICPT(+Y)) D  G INSO
 .W !!?3,"Already selected. Choose another insurance company.",!,*7
 S IBICPT(+Y)="",IBICPT=$G(IBICPT)+1 G INSO
INSO1 W !?3,"Start with INSURANCE COMPANY: FIRST// " R X:DTIME
 G:'$T!(X["^") END I $E(X)="?" S IBOFF=43 D HELP^IBOTR11 G INSO1
 S IBICF=X
INSO2 W !?8,"Go to INSURANCE COMPANY: LAST// " R X:DTIME
 G:'$T!(X["^") END I $E(X)="?" S IBOFF=49 D HELP^IBOTR11 G INSO2
 I X="" S IBICL="zzzzz" S:IBICF="" IBIC="ALL" G INSO3
 I X="@",IBICF="@" S IBICL="@",IBIC="NULL" G INSO3
 I IBICF'="@",IBICF]X D  G INSO2
 .W *7,!!?3,"The LAST value must follow the FIRST.",!
 S IBICL=X
INSO3 I IBPRNT="G" S IBSORT="I" S:$G(IBICPT)!($G(IBIC)'="ALL") IBG=1 G EXRC
 I $G(IBICPT)=1 S IBSORT="I" G EXRC
 W !,"Sort by AMOUNT (O)WED, AMOUNT (P)AID, or (I)NSURANCE CO.: I// "
 R X:DTIME G:'$T!(X["^") END S:X="" X="I" S X=$E(X)
 I "IOPiop"'[X S IBOFF=56 D HELP^IBOTR11 G INSO3
 W "  ",$S("Oo"[X:"AMOUNT OWED","Pp"[X:"AMOUNT PAID",1:"INSURANCE CO.")
 S IBSORT=$S("Oo"[X:"O","Pp"[X:"P",1:"I")
 ;
EXRC S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you want to include receivables referred to Reg. Counsel"
 S DIR("?")="^S IBOFF=66 D HELP^IBOTR11"
 W ! D ^DIR K DIR S IBINRC=+Y I $D(DIRUT)!$D(DTOUT)!$D(DUOUT) G END
 ;
DEV W !!,"You will need a 132 column printer for this report!"
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) D  G END
 .S ZTRTN="^IBOTR2",ZTDESC="INSURANCE PAYMENT TREND REPORT"
 .F X="IB*","VAUTD","VAUTD(" S ZTSAVE(X)=""
 .D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOTR1" D T1^%ZOSV ;stop rt clock
 D ^IBOTR2 ; Compile and print report.
 ;
END K DIRUT,DTOUT,DUOUT,DIROUT
 Q
