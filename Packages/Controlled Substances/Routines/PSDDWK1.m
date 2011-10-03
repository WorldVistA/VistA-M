PSDDWK1 ;BIR/JPW-Pharm Dispensing Worksheet (cont'd) ;12/14/99  15:01
 ;;3.0; CONTROLLED SUBSTANCES ;**20**;13 Feb 97
 ;
 ; Reference to XUSEC( supported by DBIA # 10076
 ; Reference to DPT( supported by DBIA # 10035
 ; Reference to PSD(58.8 supported by DBIA # 2711
 ; 
START ;entry point for dispensing options
 S (NEW,PSDNO)=0,NOFLAG=1,ACT="" D DISPLAY Q:(PSDOUT)!(PSDNO)
 S ORDS=$S(NEW:ORDS,1:+PSDS)
CHK ;
 I '$D(^XUSEC("PSJ RPHARM",DUZ)) D TECH Q:PSDOUT  G ACT
 S BAL=+$P(^PSD(58.8,ORDS,1,PSDR,0),"^",4)
 I QTY>BAL W $C(7),!!,"=>  The drug balance is "_BAL_".  You cannot dispense "_QTY_" for this drug.",! G PHARM
 W !!,"Old Balance: ",BAL,?35,"New Balance: ",BAL-QTY,!
PHARM ;by dispensing pharmacist
 W ! K DA,DIR,DTOUT,DUOUT S DIR(0)="SOBA^V:VERIFY;DC:CANCEL;E:EDIT;B:BYPASS;S:SHOW",DIR("?",1)="Enter 'V' to verify or dispense this order, 'DC' to cancel this order,"
 S DIR("?",2)="'E' to edit, 'B' to bypass without verifying,",DIR("?")="'S' to show this order again or '^' to quit.",DIR("A")="ACTION (V DC E B S): "
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S PSDOUT=1 D MSG Q
 S ACT=$S(Y="":"B",1:Y)
ACT ;decides disp action
 I ACT="V" D ^PSDDWK2 Q
 I ACT="P" D ^PSDDWK2 Q
 I ACT="DC" D ^PSDDWK4 Q:STAT=9  Q:PSDOUT  G CHK
 I ACT="E" D EDIT^PSDDWKE Q:(PSDOUT)!(PSDNO)  G CHK
 I ACT="S" D DISPLAY G CHK
 I ACT="B" D MSG
END Q
TECH ;by tech or non-disp pharmacist
 W ! K DA,DIR,DTOUT,DUOUT S DIR("A")="ACTION",DIR(0)="SOBA^P:PROCESS;DC:CANCEL;E:EDIT;B:BYPASS;S:SHOW",DIR("?",1)="Enter 'P' to process this order, 'C' to cancel this order,"
 S DIR("?",2)="'E' to edit, 'B' to bypass without processing,",DIR("?")="'S' to show this order again or '^' to quit.",DIR("A")="ACTION (P DC E B S): "
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S PSDOUT=1 D MSG Q
 S ACT=$S(Y="":"B",1:Y)
 Q
MSG W !!,"Press <RET> to continue" R X:DTIME W !!
 I '$T!(X["^") S PSDOUT=1
 Q
DISPLAY ;displays order request
 Q:PSDOUT  W @IOF,!,?23,"Controlled Substance Order Request"
 I $P($G(^PSD(58.85,PSDN,2)),U,2) W !,?27,"*** PRIORITY" W:$G(PAT) " INFUSION" W " ORDER ***"
 W !! K LN S $P(LN,"-",80)=""
 W "Pharmacy Dispensing #: ",$S(PSDPN:PSDPN,1:""),!,"Requested by",?16,": ",ORDN,?52,"Request Date: ",REQD,!,LN,!
 W !,"Drug",?16,": ",PSDRN,?56,"Quantity: ",?66,QTY
 W:$G(PAT) !,"Patient",?16,": ",$P($G(^DPT(+$G(PAT),0)),U)
 W !,"Dispensed by",?16,": ",$S(PSDBY:PSDBYN,1:""),?50,"Dispensed Date: ",$S(PSDT:PSDDT,1:""),!,"Disp. Location",?16,": ",$S($D(ORDSN):ORDSN,1:"")
 W !,"Manufacturer",?16,": ",MFG,!,"Lot #",?16,": ",LOT,!,"Exp. Date",?16,": ",EXPD
 W !,"Ord. Location",?16,": ",NAOUN,!,"Order Status",?16,": ",$P($G(^PSD(58.82,STAT,0)),"^"),!,"Comments:" S COMM=0
 I $D(^PSD(58.85,PSDN,1,0)) S COMM=1 K ^UTILITY($J,"W") F TEXT=0:0 S TEXT=$O(^PSD(58.85,PSDN,1,TEXT)) Q:'TEXT  S X=$G(^PSD(58.85,PSDN,1,TEXT,0)),DIWL=5,DIWR=75,DIWF="W" D ^DIWP
 I COMM D ^DIWW S COMM=0
 Q
