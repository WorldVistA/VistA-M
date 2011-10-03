PSDDWK2 ;BIR/JPW-Pharm Dispensing Worksheet (cont'd) ; 21 Jun 93
 ;;3.0; CONTROLLED SUBSTANCES ;**66**;13 Feb 97;Build 3
PROC ;ver/proc req ord
 D CHK Q:PSDLES
 S TECH=$S($P($G(^PSD(58.85,PSDN,0)),"^",16):$P(^(0),"^",16),ACT="P":DUZ,1:"") I PSDT="" D NOW^%DTC S PSDT=+%
DISPN ;assign dsp #s
 G:$P($G(^PSD(58.85,PSDN,0)),"^",15) EDIT S FLAG=0,ORDS=$S(NEW:ORDS,1:PSDS),PSDAGN=$S(NEW:PSDAGN,1:PSDAG)
 I PSDAGN W !!,"Assigning Pharmacy Dispensing #...",! D AUTO Q:PSDOUT  G EDIT
ASKN K DIR,DIRUT S DIR(0)="N^1:999999999:0",DIR("A")="PHARMACY DISPENSING #",DIR("?")="Enter your narcotic control number for this order." D ^DIR K DIR
 I $D(DIRUT) W !!,"This order cannot be processed without a dispensing number.",!!,"Press <RET> to continue" R X:DTIME Q
 I +$O(^PSD(58.81,"D",Y,0)) W !!,"The number "_Y_" has previously been used as a dispensing number.",!,"Please select another number.",!! G ASKN
 S PSDPN=Y
EDIT ;edit/add ord
 S BAL=0 W !!,"PHARMACY DISPENSING # ",PSDPN,!
 K PSDREC I +$P($G(^PSD(58.85,PSDN,0)),"^",8) S PSDREC=$P(^(0),"^",8)
 W !!,"Accessing the order...",! D:'$D(PSDREC) ADD D:ACT="V" SUB
 W !,"Updating the transaction..."
 D UPDATE^PSDDWK3,MSG1
 Q
ADD ;find entry number
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSDREC=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSDREC)) S $P(^PSD(58.81,0),"^",3)=PSDREC G FIND
 K DIC,DLAYGO S DIC(0)="L",(DIC,DLAYGO)=58.81,(X,DINUM)=PSDREC D ^DIC K DIC,DINUM,DLAYGO
 L -^PSD(58.81,0)
 Q
AUTO ;select next available disp #
 K MSG I '$P($G(^PSD(58.8,+ORDS,2)),"^",4) S MSG=1 D MSG Q
 I $P($G(^PSD(58.8,+ORDS,2)),"^",3)'>$P($G(^PSD(58.8,+ORDS,2)),"^",4) S MSG=0 D MSG Q
 F  L +^PSD(58.8,+ORDS,2):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
ADDN S PSDPN=$P($G(^PSD(58.8,+ORDS,2)),"^",4)
 I +$O(^PSD(58.81,"D",PSDPN,0)) S $P(^PSD(58.8,+ORDS,2),"^",4)=PSDPN+1 G ADDN
 S $P(^PSD(58.8,+ORDS,2),"^",4)=PSDPN+1
 L -^PSD(58.8,+ORDS,2)
 Q
MSG ;prints message
 W $C(7),!!,"  Contact your Pharmacy Co-ordinator.",!,"  Your ""Dispensing #'s"" range has "_$S(MSG:"not been defined.",1:"been exceeded.") S PSDOUT=1
MSG1 W !!,"Press <RET> to continue" R X:DTIME
 I '$T!(X["^") S PSDOUT=1
 Q
SUB ;sub qty from dsp site
 F  L +^PSD(58.8,ORDS,1,PSDR,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D NOW^%DTC S PSDT=+%
 S BAL=$P(^PSD(58.8,ORDS,1,PSDR,0),"^",4),$P(^(0),"^",4)=$P(^(0),"^",4)-QTY
 L -^PSD(58.8,ORDS,1,PSDR,0)
 W !!,"Old Balance : ",BAL,?35,"New Balance :",BAL-QTY,!!
 Q
CHK ;check for valid bal
 S PSDLES=0 D:QTY>$P(^PSD(58.8,ORDS,1,PSDR,0),"^",4)  Q:PSDLES
 .W $C(7),!!,"=>   The drug balance is "_+$P(^PSD(58.8,ORDS,1,PSDR,0),"^",4)_".  You cannot dispense "_QTY_" for this drug.",!,?5,"This order remains "_$P($G(^PSD(58.82,STAT,0)),"^")_".",! S PSDLES=1
 .D MSG1
