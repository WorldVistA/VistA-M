PSDREC2 ;BIR/LTL-CS Receiving (cont'd) ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**30,66**;13 Feb 97;Build 3
 ;Reference to ^DIC(51.5 supported by IA # 1931
 ;Reference to ^PRCS(410 supported by IA #214
 ;Reference to ^PSD(58.8 are covered by DBIA #2711
 ;Reference to ^PSD(58.81 are covered by DBIA #2808
 ;References to ^PSDRUG( are covered by IA #221
CON S DIC="^PRCS(410,",DIC(0)="AEMQZ",DIC("A")="Select Pharmacy Transaction number: ",DIC("B")=$S($D(PSDCON):$P($G(^PRCS(410,+PSDCON,0)),U),1:""),DIC("S")="I $P($G(^(0)),U,2)=""O"",$P($G(^(3)),U,3)[822400"
 D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT)) QUIT S PSDCON=$S(Y>0:+Y,1:"")
 I $G(PSDPO)+$G(PSDCON)<1 W !!,"Sorry, we really can't allow receiving without a P.O. or CP transaction.",!! G QUIT
 I '$O(^PRCS(410,+PSDCON,"IT",1)),'$P($G(^PRCS(410,+PSDCON,"IT",1,0)),U,5) G INV
 G:$D(PSDPO(1))&($O(^PRCS(410,+PSDCON,"IT",0))) ^PSDREC4
INV I $G(PSAPV) S DIR(0)="58.81,71O",DIR("A")="Please enter the Prime Vendor Invoice number" D ^DIR K DIR G:Y'=""&($D(DIRUT)) QUIT S PSAPV=Y
 I $G(PSAPV)=" " S PSAPV=1 W $C(7),!!,"Sorry, the space bar won't work here.",! G INV
 I $G(PSAPV)]"",$O(^PSD(58.81,"PV",Y,"")) S PSD(2)=PSAPV W !!,"Previous receipts have been processed for this invoice.",!! S DIR(0)="Y",DIR("A")="Would you like to review",DIR("B")="Yes" D ^DIR K DIR G:$D(DIRUT) QUIT G:Y=1 DEV^PSDREPV
 N X,X1 D SIG^XUSESIG I X1="" S PSDOUT=1 G QUIT
DRUG F  S DIC="^PSD(58.8,PSDLOC,1,",DIC(0)="AEMQ",DIC("A")="Select "_PSDLOCN_" drug: ",DIC("S")="I $S($P($G(^(0)),U,14):$P($G(^(0)),U,14)>DT,1:1)",DA(1)=PSDLOC D  Q:$G(PSDOUT)
 .W ! D ^DIC I Y<0 S PSDOUT=1 Q
 .K DIC S PSDRUG=+Y,PSDRUGN=$P($G(^PSDRUG(+Y,0)),U),PSDB=$P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,4)
PRIC .W ! S DIE="^PSDRUG(",DA=PSDRUG,DR="15Dispense units per order unit: ;13Price per order unit: " D ^DIE K DIE I $D(Y) S PSDOUT=1 Q
QTY .W ! S DIR(0)="NA^0:999999:0",DIR("A")="Number of "_$P($G(^DIC(51.5,+$P($G(^PSDRUG(+PSDRUG,660)),U,2),0)),U)_"(S) to receive: " D ^DIR K DIR S (PSDREC,PSDREC(1))=Y I $D(DIRUT) S PSDOUT=1 Q
DISP .W ?50,"Converted quantity: ",PSDREC*$P($G(^PSDRUG(+PSDRUG,660)),U,5) S PSDREC=$P($G(^(660)),U,5)*PSDREC
 .;PSD*3*29 (Dave B) Check to see if drug actually stocked
 .I '$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)) W !,"Sorry, but this drug is not stocked in this pharmacy location.",! Q
PQ .S DIR(0)="Y",DIR("A")="OK to post",DIR("B")="Yes",DIR("?")="If yes, the balance will be updated and a transaction stored." D ^DIR K DIR D:Y=1  I $D(DIRUT) S PSDOUT=1 Q
 ..W !!,"There were ",$S($P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,4):$P($G(^(0)),U,4),1:0)," on hand.",?40,"There are now ",$P($G(^(0)),U,4)+PSDREC," on hand.",!
 ..F  L +^PSD(58.8,+PSDLOC,1,+PSDRUG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 ..D NOW^%DTC S PSDAT=+%
 ..S PSDB=$P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,4)
 ..S $P(^PSD(58.8,+PSDLOC,1,+PSDRUG,0),U,4)=PSDREC+PSDB
 ..L -^PSD(58.8,+PSDLOC,1,+PSDRUG,0)
 ..S:'$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,5,0)) ^(0)="^58.801A^^"
 ..I '$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,5,$E(DT,1,5)*100,0)) S DIC="^PSD(58.8,+PSDLOC,1,+PSDRUG,5,",DIC(0)="L",DLAYGO=58.8,X=$E(DT,1,5)*100,DINUM=X,DA(2)=PSDLOC,DA(1)=PSDRUG D ^DIC K DIC,DLAYGO
 ..S DIE="^PSD(58.8,+PSDLOC,1,+PSDRUG,5,",DA(2)=PSDLOC,DA(1)=PSDRUG,DA=$E(DT,1,5)*100,DR="5////^S X=$P($G(^(0)),U,3)+PSDREC" D ^DIE
 ..W !,"Updating monthly receipts and transaction history.",!
TR ..F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND ..S PSDT=$P(^PSD(58.81,0),U,3)+1 I $D(^PSD(58.81,PSDT)) S $P(^PSD(58.81,0),U,3)=$P(^PSD(58.81,0),U,3)+1 G FIND
 ..S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSDT D ^DIC K DIC,DLAYGO L -^PSD(58.81,0)
 ..S DIE="^PSD(58.81,",DA=PSDT,DR="1////1;2////^S X=PSDLOC;3////^S X=PSDAT;4////^S X=PSDRUG;5////^S X=PSDREC;6////^S X=DUZ;7////^S X=PSDCON;8////^S X=PSDPO;9////^S X=PSDB;100////1;71////^S X=$G(PSAPV)" D ^DIE
 ..S:'$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,4,0)) ^(0)="^58.800119PA^^"
 ..S DIC="^PSD(58.8,+PSDLOC,1,+PSDRUG,4,",DIC(0)="L",DLAYGO=58.8
 ..S (X,DINUM)=PSDT
 ..S DA(2)=PSDLOC,DA(1)=PSDRUG D ^DIC K DIC,DA,DLAYGO,PSDRUG
QUIT Q
