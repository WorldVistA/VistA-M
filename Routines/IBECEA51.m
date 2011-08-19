IBECEA51 ;ALB/CPM - Cancel/Edit/Add... Update Event Actions ; 05-MAY-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**57**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CS ; 'Change Status' Entry Action
 N DIE,DA,DR,IBCOMMIT,IBLINE,IBNDX,IBSTAT,IBDEST,IBNBR,IBN
 S IBCOMMIT=0 D EN^VALM2($G(XQORNOD(0))) I '$O(VALMY(0)) G CSQ
 S IBNBR="" F  S IBNBR=$O(VALMY(IBNBR)) Q:'IBNBR  D
 .S IBLINE=^TMP("IBACME",$J,IBNBR,0),IBNDX=^TMP("IBACMEI",$J,IBNBR)
 .S IBSTAT=$P(IBNDX,"^"),IBN=$P(IBNDX,"^",3)
 .S IBDEST=$S(IBSTAT="OPEN":"CLOSED",1:"OPEN")
 .W !!,"Processing Event #",IBNBR,":"
 .Q:$$FEE(IBN)
 .S DIR(0)="Y",DIR("A")="Change the status of this event from "_IBSTAT_" to "_IBDEST,DIR("?")="^D HCS^IBECEA51"
 .D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) W !,"This event will remain "_IBSTAT_"." Q
 .S DIE="^IB(",DA=IBN,DR=".05////"_$S(IBDEST="OPEN":1,1:2)
 .D ^DIE I $D(Y) W !,"An error occured while changing the status - event is still ",IBSTAT,"." Q
 .S IBCOMMIT=1 W !,"The status has been changed to ",IBDEST,"."
 .S IBLINE=$$SETSTR^VALM1(IBDEST,IBLINE,+$P(VALMDDF("STATUS"),"^",2),+$P(VALMDDF("STATUS"),"^",3))
 .S ^TMP("IBACME",$J,IBNBR,0)=IBLINE,$P(^TMP("IBACMEI",$J,IBNBR),"^",1)=IBDEST
 D PAUSE^VALM1
CSQ S VALMBCK=$S(IBCOMMIT:"R",1:"")
 Q
 ;
HCS ; Help for 'Change Status'
 W !!,"Please enter 'Y' or 'YES' to change the status of this event from ",IBSTAT
 W !,"to ",IBDEST,", or 'N', 'NO', or '^' to quit."
 W !!,"If the status of this event is changed to open, and the patient is still an"
 W !,"inpatient in this ward (on the specified admission date), charges will be"
 W !,"billed starting the day after the Date Last Calculated.  If the status is"
 W !,"changed to closed, no further charges will be associated with this event."
 Q
 ;
LC ; 'Last Date Calc' Entry Action
 N IBCOMMIT,IBNBR
 S IBCOMMIT=0 D EN^VALM2($G(XQORNOD(0))) I '$O(VALMY(0)) G LCQ
 S IBNBR="" F  S IBNBR=$O(VALMY(IBNBR)) Q:'IBNBR  D LCO
 D PAUSE^VALM1
LCQ S VALMBCK=$S(IBCOMMIT:"R",1:"")
 Q
 ;
LCO ; Update Last Calc Date for a Single Event.
 N DIE,DR,DA,IBLINE,IBNDX,IBLCAL,IBN,IBEVDT,IBNEWV,%DT
 S IBLINE=^TMP("IBACME",$J,IBNBR,0),IBNDX=^TMP("IBACMEI",$J,IBNBR)
 S IBLCAL=$P(IBNDX,"^",2),IBN=$P(IBNDX,"^",3),IBEVDT=$P(IBNDX,"^",4)
 W !!,"Processing Event #",IBNBR,":"
 I $$FEE(IBN) G LCOQ
LCP W !,"Date Last Calculated: " W:IBLCAL $$DAT2^IBOUTL(IBLCAL),"// "
 R X:DTIME S:'IBLCAL&(X="") X="^" S:'$T X="^" I $E(X)="^" G LCOQ
 I X="" W "  (",$$DAT2^IBOUTL(IBLCAL),")",!,"No change!" G LCOQ
 I $E(X)="?"!($E(X)="@") D HLC G LCP
 S %DT="EPX" D ^%DT I Y<0 D HELP^%DTC G LCP
 I Y<IBEVDT!(Y>$$FMADD^XLFDT(DT,-1)) D HLC G LCP
 S IBNEWV=Y,DIE="^IB(",DA=IBN,DR=".18////"_Y
 D ^DIE I $D(Y) W !,"An error occured while changing the Last Calc Date - no change made!" G LCOQ
 S IBCOMMIT=1 W !,"The Date Last Calculated has been changed to ",$$DAT1^IBOUTL(IBNEWV),"."
 S IBLINE=$$SETSTR^VALM1($$DAT1^IBOUTL(IBNEWV),IBLINE,+$P(VALMDDF("LCALC"),"^",2),+$P(VALMDDF("LCALC"),"^",3))
 S ^TMP("IBACME",$J,IBNBR,0)=IBLINE,$P(^TMP("IBACMEI",$J,IBNBR),"^",2)=IBNEWV
LCOQ Q
 ;
HLC ; Help for 'Last Calc Date'
 W !!,"The Date Last Calculated is used to record the last date for which Means Test"
 W !,"charges were billed for an admission."
 W !!,"This date cannot be deleted.  Please enter a date not less than the Event"
 W !,"Date (",$$DAT1^IBOUTL(IBEVDT),") and not greater than yesterday (",$$DAT1^IBOUTL($$FMADD^XLFDT(DT,-1)),").",!
 Q
 ;
 ;
FEE(IBN) ; If the Event Record is for Fee, it is uneditable.
 ;  Input:    IBN  --  Pointer to an event record in file #350
 ; Output:  IBFEE  --  1 = record is uneditable
 ;                     0 = record is editable
 N IBFEE S IBFEE=0
 I $P($G(^IB(+$G(IBN),0)),"^",8)["FEE" S IBFEE=1 W !,*7,"Fee Admissions cannot be edited!"
FEEQ Q IBFEE
