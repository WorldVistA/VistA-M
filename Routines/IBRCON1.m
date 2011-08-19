IBRCON1 ;ALB/RJS - PASS CONVERTED INPATIENT CHARGES ; 28-APR-92
 ;;2.0;INTEGRATED BILLING;**153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Selection is by patient name
 ;
EN ; Entry point for stand-alone 'pass' option
 I '$D(^IB("AI")) W !!,"There are no patients with converted charges at this time.",! Q
 ;
 D HOME^%ZIS
 W !!,"This option is used to pass Means Test charges which have been"
 W !,"converted. Please enter a patient with converted charges and these"
 W !,"charges will be displayed and may be selected to be released to Accounts",!,"Receivable.",!
 ;
ASK S IBRHOLD=0
 R !!,"Select PATIENT NAME: ",X:DTIME G END:"^"[X
 I $E(X,1,2)="??" D HLP1 G ASK
 I $E(X)="?" D HLP G ASK
 S DIC("S")="I $D(^IB(""AI"",+Y))"
 S DIC="^DPT(",DIC(0)="MQE" D ^DIC K DIC G ASK:Y<1 S DFN=+Y
 ;
 K IBA
 S IBRRJS=0 F IBNUM=1:1 S IBRRJS=$O(^IB("AI",DFN,IBRRJS)) Q:'IBRRJS  S IBA(IBNUM)=IBRRJS
 I '$D(IBA) W !!,"This patient does not have any converted charges",! G ASK
 ;
 D DEM^VADPT W @IOF,VADM(1),"      Pt ID: ",VA("PID"),! F I=1:1:79 W "-"
 ;
 ; - display header and list charges
RESUME W !!,"The following IB Actions for this patient, are CONVERTED CHARGES:" D HDR1
 S IBQ=0 F IBNUM=1:1 Q:'$D(IBA(IBNUM))  D:'(IBNUM#15)  Q:IBQ  S IBN=IBA(IBNUM) D LST1
 . R !,"Enter RETURN to continue or '^' to stop: ",X:DTIME S:X["^"!('$T) IBQ=1 Q
 ;
 ; - prompt user to select IB Actions
 S DIR(0)="LAO^1:"_(IBNUM-1)_"^K:X[""."" X",DIR("A")="Select IB Action"_$E("s",IBNUM>2)_" (REF #) to pass (or '^' to exit): ",DIR("?")="^D HELP^IBRCON1"
 W ! D ^DIR K DIR I $D(DUOUT) G END
 I $D(DIRUT) G LOOP
 ;
 S IBRANGE=Y,IBSEQNO=1,IBDUZ=DUZ
 ;
 S DIR("B")="YES"
 S DIR(0)="YOA",DIR("A")="OK to pass "_$S($P(Y,",",2):"these charges",1:"this charge")_" to Accounts Receivable: "
 D ^DIR K DIR I $D(DUOUT) G END
 I 'Y!($D(DIRUT)) G LOOP
 ;
 ; - pass charges to Accounts Receivable
 W !!,"Passing charges to Accounts Receivable...",! D HDR2
 F IBRRJS=1:1 S IBNUM=$P(IBRANGE,",",IBRRJS) Q:'IBNUM  S IBNOS=IBA(IBNUM) D ^IBR,ERR:Y<1 I Y>0 S IBN=IBA(IBNUM) D LST2
 W !!,"The charge"_$E("s",$P(IBRANGE,",",2)>0)_" listed above "_$S($P(IBRANGE,",",2):"have",1:"has")_" been passed to Accounts Receivable",!
 W:IBRHOLD=1 !,"* Please note that charges placed 'On Hold' are still",!,"  pending release from Integrated Billing."
 ;
LOOP ;
 G ASK
 ;
END K DIRUT,DUOUT,DTOUT,IBA,IBAFY,IBARTYP,IBATYP,IBN,IBDA,IBDUZ,IBFAC,IBRRJSL,IBRANGE,IBNOS,IBNUM,IBQ,IBSEQNO,IBSERV,IBSITE,IBTOTL,IBTRAN,IBWHER,VA,VADM,VAERR
 K DFN,DIC,DIR,I,IBA,IBLINE,IBND,IBRRJS,VA,VADM,X,Y,IBRHOLD
 Q
 ;
 ;
HDR1 ; Display charge header.
 N IBLINE S $P(IBLINE,"=",81)=""
 W !,IBLINE,!," REF   Action ID  Bill Type",?44,"From",?54,"To",?64,"Charge"
 W !,IBLINE Q
 ;
HDR2 ; Display charge header.
 N IBLINE S $P(IBLINE,"=",81)=""
 W !,IBLINE,!,?42,"Bill # or"
 W !," REF   Action ID  Bill Type",?42,"On Hold",?53,"From",?64,"To",?73,"Charge"
 W !,IBLINE Q
 ;
LST1 ; Display individual IB Action.
 N IBND S IBND=$G(^IB(IBN,0))
 W !?1,$J(IBNUM,2),?7,$J(+IBND,9),?18,$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",8)
 W ?42,$$DAT1^IBOUTL($P(IBND,"^",14)),?52,$$DAT1^IBOUTL($P(IBND,"^",15))
 W ?61,$J(+$P(IBND,"^",7),9,2)
 Q
 ;
LST2 ; Display individual IB Action.
 N IBND S IBND=$G(^IB(IBN,0))
 W !?1,$J(IBNUM,2),?7,$J(+IBND,9),?18,$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^",8)
 I $P(IBND,U,5)=8 W ?42,"On Hold" S IBRHOLD=1
 E  W ?42,$P($P(IBND,"^",11),"-",2)
 W ?51,$$DAT1^IBOUTL($P(IBND,"^",14)),?61,$$DAT1^IBOUTL($P(IBND,"^",15))
 W ?70,$J(+$P(IBND,"^",7),9,2)
 Q
 ;
ERR ; Display error message.
 W !?1,$J(IBNUM,2),?7,"Error encountered - a separate bulletin has been posted"
 Q
 ;
HLP ; Display basic help message.
 W !!,"Enter:    the name of a patient with converted charges or"
 W !?10,"'??' --  to see all patients with converted charges or"
 W !?10,"'^'  --  to quit this option.",!
 Q
 ;
HLP1 ; Display all patients with converted charges
 N DFN,I,IBQ,VA,VAERR
 W !!,"The following patients have converted charges"
 S (DFN,IBQ)=0 F I=1:1 S DFN=$O(^IB("AI",DFN)) Q:'DFN  D:'(I#15)  Q:IBQ  D PID^VADPT6 W !?3,$P($G(^DPT(DFN,0)),"^"),$J("",10),VA("PID")
 . R !,"Enter RETURN to continue or '^' to stop: ",X:DTIME S:X["^"!('$T) IBQ=1 Q
 W ! Q
 ;
HELP ; Help for the 'Select' prompt.
 W !!?4,"Please enter a list or range of IB Actions (i.e. 1,3,5 or 2-4,8), none"
 W !?4,"greater than ",IBNUM-1,", to be passed to Accounts Receivable, or '^' to quit."
 Q
