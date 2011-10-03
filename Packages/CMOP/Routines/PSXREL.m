PSXREL ;BIR/WPB-Manual Barcode Release/Not Dispense ;04/08/97 2:06 PM
 ;;2.0;CMOP;**38**;11 Apr 97
AC ;
 I '$D(^XUSEC("PSXCMOPMGR",DUZ)) W !,"You are not authorized to use this option!" Q
 W !!,"This option will only release/complete Rx's which have labels printed manually." W !!
AC1 ;
 S DIR(0)="S^R:RELEASE;C:NOT DISPENSED",DIR("?",1)="Enter 'R' to release a prescription that has been filled.",DIR("?")="Enter 'C' to mark a prescription as not filled." D ^DIR K DIR S ACT=$G(Y)
 K DIR,DIRUT,DTOUT,DUOUT,DIROUT,Y,X
 G:$G(ACT)="R" RPH
CAN I $G(ACT)="C" W !! S DIR("A")="Enter Cancel Reason",DIR(0)="F^1:40" D ^DIR K DIR S REASON=$G(Y) I $G(REASON)="" G CAN
 G:$G(Y)=""!($D(DIRUT))!($D(DTOUT))!($D(DUOUT))!($D(DIROUT)) EXIT
 K DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y
RPH S DIC("S")="I $D(^XUSEC(""PSXRPH"",+Y))",DIC("A")="Enter PHARMACIST: ",DIC="^VA(200,",DIC(0)="QEAM" D ^DIC K DIC G:"^"[X EXIT G:$D(DTOUT)!($D(DUOUT))!(Y=-1) EXIT S PSRH=+Y K Y,X,DTOUT,DUOUT
BC W !! K DIR,Y,X,RXN S DIR("A")="Enter/Wand PRESCRIPTION number",DIR("?")="^D HELP^PSXREL",DIR(0)="FO",DIR("??")="^D LIST^PSXREL" D ^DIR K DIR S RXN=X
 G:$D(DIRUT) EXIT
 K DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y
 ;I RXN'["-" W !,"INVALID PRESCRIPTION NUMBER" G BC
 I '$D(^PSX(552.3,"AP",RXN)) W !,"INVALID PRESCRIPTION NUMBER" G BC
 S PSX=$O(^PSX(552.3,"AP",RXN,"")) I '$G(PSX) W !,"INVALID PRESCRIPTION NUMBER" K X,PSX,RXN G BC
 I '$D(^PSX(552.3,PSX,0)) W !,"INVALID PRESCRIPTION NUMBER" K X,RXN,PSX G BC
 S PSXN=PSX,PSX=^PSX(552.3,PSX,0),Y=$P(PSX,"|",7) I +$G(Y)>0 W !,"PREVIOUSLY RELEASED ON " X ^DD("DD") W Y K Y,^PSX(552.3,"AP",RXN,PSXN),PSX,PSXN G BC
 D NOW^%DTC S $P(^PSX(552.3,PSXN,0),"|",7)=%_"|"_PSRH_"|"_$G(REASON)
 S ^PSX(552.3,PSXN,1)=2,^PSX(552.3,"AQ",PSXN)="" K ^PSX(552.3,"AP",$G(RXN),PSXN),%
 W !!,"RX# ",$P(PSX,"|",4)_$S($G(ACT)="R":"  released.",$G(ACT)="C":" not dispensed.",1:"") G BC
 Q
EXIT K X,Y,%,PSX,PSXN,DA,DIC,DIRUT,DUOUT,PSRH,DIR,DTOUT,DIROUT,ACT,REASON,RXN
 Q
HELP W !!,"Wand the barcode number of the prescription or manually key in"
 W !,"the number printed below the barcode."
 W !,"The barcode number should be of the format - 'NNN-NNNNNNN'"
 Q
LIST S ZZ="" F  S ZZ=$O(^PSX(552.3,"AP",ZZ)) Q:ZZ=""  W !,?5,$G(ZZ)
 K ZZ
 Q
