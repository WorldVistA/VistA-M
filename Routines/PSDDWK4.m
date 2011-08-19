PSDDWK4 ;BIR/JPW-Pharm Dispensing Worksheet (cont'd) ; 24 Aug 93
 ;;3.0; CONTROLLED SUBSTANCES ;**66**;13 Feb 97;Build 3
CANC ;canc req ord
 I STAT>2 W !!,"This order is ",$P($G(^PSD(58.82,+STAT,0)),"^"),!,"and should be cancelled using the 'Edit Verified Order' option.",!!
 W ! S PSDOUT=0 K DIR,DIRUT,DUOUT S DIR(0)="YO",DIR("A")="Do you want to cancel this request order",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to cancel this request order,",DIR("?")="answer 'NO' to leave this request active or '^' to quit." D ^DIR K DIR I $D(DUOUT) S PSDOUT=1 Q
 Q:PSDOUT  I 'Y W $C(7),!!,"No action taken.  This request order remains active.",!!,"Press <RET> to continue.",! R X:DTIME Q
 W !!,"Accessing your order information..."
 F  L +^PSD(58.8,+PSDS,1,PSDR,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D NOW^%DTC S PSDT=+%
 S BAL=$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",4)
 L -^PSD(58.8,+PSDS,1,PSDR,0)
 K DA,DIE,DR S DIE=58.85,DA=PSDN,DR="6////9" D ^DIE K DA,DIE,DR
 K DA,DIE,DR S DA=+$P($G(^PSD(58.85,PSDN,0)),"^",5),DA(1)=+$P($G(^(0)),"^",4),DA(2)=+$P($G(^(0)),"^",3),DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,",DR="10////9;19////@" D ^DIE K DA,DIE,DR
 I +$P($G(^PSD(58.85,PSDN,0)),"^",8) K DA,DIE,DR S DA=$P(^(0),"^",8),DIE=58.81,DR="1////7;3////"_PSDT_";10////9;9////"_BAL D ^DIE K DA,DIE,DR W !!,?10,"Balance: ",BAL,!!
 S STAT=9 W !!,?10,"CANCELLED...",! I ANS="W" W !!,"Press <RET> to continue" R X:DTIME I '$T!(X["^") S PSDOUT=1
 Q
