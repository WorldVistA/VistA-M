PSDEVO1 ;BIR/JPW-Edit/Cancel a Verified Order (cont'd) ; 22 Jun 93
 ;;3.0; CONTROLLED SUBSTANCES ;**66**;13 Feb 97;Build 3
EN ;entry for edit verified order
 W !!,?5,"You may edit quantity, manufacturer, lot # and expiration date.",!,?5,"If you wish to edit drug or NAOU, you must cancel this order",!,?5,"and enter a new order.",!!
 I $D(NQTY) W !!,"This verified order has been previously edited.",!,"You must cancel this order and re-enter a new one.",!! D MSG S PSDOUT=1 Q
 K DA,DIR,DIRUT S DIR(0)="SO^Q:QUANTITY ONLY;M:MFG/LOT#/EXP.DATE ONLY;B:BOTH SETS OF FIELDS"
 S DIR("?",1)="Enter 'Q' to edit quantity only,",DIR("?",2)="Enter 'M' to edit mfg/lot #/exp.date only"
 S DIR("?")="Enter 'B' to edit both sets of fields or '^' to quit.",DIR("A")="Select fields to edit" D ^DIR K DIR I $D(DIRUT) S PSDOUT=1 D MSG Q
 S FIELD=Y
UPDATE ;
 I FIELD="M" D NOW^%DTC S PSDT=+%,NQTY=QTY,AQTY=0,BAL=+$P(^PSD(58.8,+PSDS,1,+PSDR,0),"^",4) G DIE
NQ K DA,DIR,DTOUT,DUOUT S DIR(0)="58.81,50O",DIR("A")="NEW QUANTITY DISPENSED ("_NBKU_"/"_NPKG_")"
 S DIR("?",1)="Enter new quantity being dispensed or",DIR("?")="or '^' to quit" D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S PSDOUT=1 D MSG Q
 S NQTY=+Y I +Y=0 W !!,"Sorry.  You've selected ZERO as the new dispensing balance.",!,"If the new balance is ZERO, please CANCEL this order." S PSDOUT=1 D MSG Q
 W !!,"Old Dispensed Quantity: ",QTY,"     New Dispensed Quantity: ",NQTY,! S AQTY=QTY-NQTY
 I ($P(^PSD(58.8,+PSDS,1,+PSDR,0),"^",4)+AQTY)<0 W !!,"This transaction cannot be processed.",!,"Your vault balance is ",$P(^PSD(58.8,+PSDS,1,+PSDR,0),"^",4),"." D MSG Q
 K DA,DIR,DIRUT S DIR(0)="YOA",DIR("?",1)="Answer 'YES' to edit this order and adjust",DIR("?")="your vault balance, answer 'NO' or '^' to quit."
 S DIR("A")="Are you sure? ",DIR("B")="NO"
 D ^DIR K DIR I 'Y!$D(DIRUT) D MSG Q
 W !!,"Accessing your transaction information..."
 F  L +^PSD(58.8,+PSDS,1,+PSDR,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D NOW^%DTC S PSDT=+%
 S BAL=+$P(^PSD(58.8,+PSDS,1,+PSDR,0),"^",4),$P(^(0),"^",4)=$P(^(0),"^",4)+AQTY
 L -^PSD(58.8,+PSDS,1,+PSDR,0)
 W !!,"Old Balance: ",BAL,?35,"New Balance: ",BAL+AQTY,!!
DIE W !,"Updating transaction history..."
 ;K DA,DIE,DR S DA=+PSDA,DIE=58.81,DR="48////"_PSDT_";49////"_PSDUZ_";50///"_NQTY_";51///"_AQTY_";54///"_BAL_";53;I FIELD=""Q"" S Y=""@1"";52////1;12;13;14;@1"
 K DA,DIE,DR S DA=+PSDA,DIE=58.81,DR="53;I FIELD=""Q"" S Y=48;52////1;12;13;14;48////"_PSDT_";49////"_PSDUZ_";50////"_NQTY_";51////"_AQTY_";54////"_BAL
 D ^DIE K DA,DIE,DR I $D(Y) S PSDOUT=1 D MSG Q
 S MFG=$P($G(^PSD(58.81,PSDA,0)),"^",13),LOT=$P($G(^(0)),"^",14),EXP=$P($G(^(0)),"^",15)
 W !,"Updating Order..."
ORDER K DA,DIE,DR S DA(1)=PSDR,DA(2)=NAOU,DA=ORD,DIE="^PSD(58.8,"_NAOU_",1,"_PSDR_",3,"
 S DR="7///"_MFG_";8///"_LOT_";9///"_EXP_";19////"_NQTY D ^DIE K DA,DIE,DR
 I +$O(^PSD(58.85,"AC",3,NAOU,PSDR,ORD,0)) S WK=+$O(^PSD(58.85,"AC",3,NAOU,PSDR,ORD,0)) I $D(^PSD(58.85,WK,0)) S $P(^(0),"^",17)=NQTY
 W "done."
REPRT ;
 I $D(^PSD(58.81,PSDA,"CS")),+$P(^("CS"),"^",3) W !!,"The VA FORM 10-2321 has been previously printed for this order.",!,"Please use the 'Reprint VA FORM 10-2321' .",!!
 Q
MSG W !!,"** No action taken. **",!!
 Q
