PSDREC3 ;BIR/LTL-CS Receiving (cont'd) ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**30,66**;13 Feb 97;Build 3
 ;Reference to ^PRC(441 supported by IA #682
 ;Reference to ^PRC(442 supported by IA #682
 ;References to $$UNITCODE^PRCPUX1 are covered by IA #259
 ;Reference to ^PSD(58.8 are covered by DBIA #2711
 ;Reference to ^PSD(58.81 are covered by DBIA #2808
 ;References to ^PSDRUG( are covered by IA #221
 N X,X1 D SIG^XUSESIG Q:X1=""
SEL F  S D0=+PSDPO,DIC="^PRC(442,"_+D0_",2,",DIC(0)="AEMQZ",DIC("A")="Select Line Item Number: ",D="B",DZ="??" D DQ^DICQ W ! D ^DIC K DIC Q:$D(DTOUT)!($D(DUOUT))!(Y<1)  S PSDI=+Y,PSDIT=Y(0) D  Q:$D(DTOUT)!($D(DUOUT))!(Y>1)
 .S PSDPI=$O(^PRC(442,+PSDPO,2,+PSDIT,3,0)) D:$O(^PRC(442,+PSDPO,2,+PSDIT,3,PSDPI))  Q:Y<1
PART ..S DIC="^PRC(442,+PSDPO,2,+PSDIT,3,",DIC(0)="AEMQZ",DIC("A")="Select Warehouse Receipt date: ",DA(2)=PSDPO,DA(1)=PSDIT,D="B",DZ="??" D DQ^DICQ W ! D ^DIC K DIC S PSDPI=+Y
 .W !!,$P(PSDIT,U)
 .S PSDW=0 F  S PSDW=$O(^PRC(442,+PSDPO,2,+PSDI,1,PSDW)) Q:'PSDW  W ?5,$E($P($G(^PRC(442,+PSDPO,2,+PSDI,1,PSDW,0)),U),1,75),!
 .W !,"Packaging: ",$S($P(PSDIT,U,12):$P(PSDIT,U,12)_"/",1:"")
 .;PSD*3*29 changed direct 420.5 lookup to supported IA #259
 .W $$UNITCODE^PRCPUX1(+$P(PSDIT,U,3))
 .W ?20,"Price :$",$P(PSDIT,U,9)
 .W ?35,"Item #: ",$P(PSDIT,U,5),?50,"Vendor Stock #: ",$P(PSDIT,U,6),!
NON .I '$P(PSDIT,U,5)!('$O(^PSDRUG("AB",+$P(PSDIT,U,5),"")))!('$G(^PSD(58.8,+PSDLOC,1,+$O(^PSDRUG("AB",+$P(PSDIT,U,5),"")),0))) D  Q:$D(DTOUT)!($D(DUOUT))!(Y<1)
 ..S DIC="^PSD(58.8,PSDLOC,1,",DIC(0)="AEMQZ",DIC("A")="Select "_PSDLOCN_" drug: ",DIC("S")="I $S($P($G(^(0)),U,14):$P($G(^(0)),U,14)>DT,1:1)",DA(1)=PSDLOC D ^DIC K DIC Q:$D(DTOUT)!($D(DUOUT))!(Y<1)
 ..S PSDRUG=+Y,PSDRUGN=$P($G(^PSDRUG(+Y,0)),U),PSDB=$P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,4)
 ..I $P(PSDIT,U,5),$E($G(^PRC(441,+$P(PSDIT,U,5),3)),1)'=1,'$O(^PSDRUG("AB",+$P(PSDIT,U,5),"")) D
 ...S DIR(0)="Y",DIR("A",1)="Are you sure that you want to link ITEM MASTER file entry,"
 ...S DIR("A",2)="",DIR("A",3)=$P($G(^PRC(441,+$P(PSDIT,U,5),0)),U,2)_" to DRUG file entry,"
 ...S DIR("A",4)="",DIR("A",5)=PSDRUGN,DIR("A")="Y/N",DIR("B")="Yes"
 ...S DIR("?")="Once linked, future receipts for this item will be posted to this drug.",DIR("A",6)=""
 ...W ! D ^DIR K DIR Q:Y<1
 ...S DIE=50,DA=PSDRUG,DR="441///^S X=$P(PSDIT,U,5)" D ^DIE K DIE W:'$D(Y) !!,"Now, ",PSDRUGN," is linked to Item # ",$P(PSDIT,U,5),"." S Y=1
IT .S:'$D(PSDRUG) PSDRUG=$O(^PSDRUG("AB",+$P(PSDIT,U,5),"")),PSDRUGN=$P($G(^PSDRUG(+PSDRUG,0)),U)
 .W !!,PSDRUGN,!!
 .S DIE="^PSDRUG(",DA=PSDRUG,DR="15Dispense units per order unit;13Price per order unit" D ^DIE K DIE I $D(Y) K PSDRUG Q
DISP .W !!,"Quantity rec'd: ",$P($G(^PRC(442,+PSDPO,2,+PSDI,3,+PSDPI,0)),U,2) S PSDREC=$P($G(^(0)),U,2)
 .W ?40,"Converted quantity: ",PSDREC*$P($G(^PSDRUG(+PSDRUG,660)),U,5),! S PSDREC=$P($G(^(660)),U,5)*PSDREC
 .;PSD*3*29 (Dave B) Check to see if drug actually stocked
 .I '$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)) W !,"Sorry, but this drug is not stocked in this pharmacy location.",! Q
POST .S DIR(0)="Y",DIR("A")="OK to post",DIR("B")="Yes",DIR("?")="If yes, the balance will be updated and a transaction stored." D ^DIR K DIR D:Y=1  K PSDRUG Q
 ..W !!,"There were ",$S($P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,4):$P($G(^(0)),U,4),1:0)," on hand.",?40,"There are now ",$P($G(^(0)),U,4)+PSDREC," on hand.",!
 ..F  L +^PSD(58.8,+PSDLOC,1,+PSDRUG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 ..D NOW^%DTC S PSDAT=+%
 ..S PSDB=$P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,4)
 ..S $P(^PSD(58.8,+PSDLOC,1,+PSDRUG,0),U,4)=PSDREC+PSDB
 ..L -^PSD(58.8,+PSDLOC,1,+PSDRUG,0)
MON ..S:'$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,5,0)) ^(0)="^58.801A^^"
 ..I '$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,5,$E(DT,1,5)*100,0)) S DIC="^PSD(58.8,+PSDLOC,1,+PSDRUG,5,",DIC(0)="",X=$E(DT,1,5)*100,DA(2)=PSDLOC,DA(1)=PSDRUG D ^DIC K DIC
 ..S DIE="^PSD(58.8,+PSDLOC,1,+PSDRUG,5,",DA(2)=PSDLOC,DA(1)=PSDRUG,DA=$E(DT,1,5)*100,DR="5////^S X=$P($G(^(0)),U,3)+PSDREC" D ^DIE
 ..W !,"Updating monthly receipts and transaction history.",!
TR ..F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND ..S PSDT=$P(^PSD(58.81,0),U,3)+1 I $D(^PSD(58.81,PSDT)) S $P(^PSD(58.81,0),U,3)=$P(^PSD(58.81,0),U,3)+1 G FIND
 ..S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSDT D ^DIC K DIC,DLAYGO L -^PSD(58.81,0)
 ..S DIE="^PSD(58.81,",DA=PSDT,DR="1////1;2////^S X=PSDLOC;3////^S X=PSDAT;4////^S X=PSDRUG;5////^S X=PSDREC;6////^S X=DUZ;7////^S X=PSDCON;8////^S X=PSDPO;9////^S X=PSDB;100////1" D ^DIE K DIE
 ..S:'$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,4,0)) ^(0)="^58.800119PA^^"
 ..S DIC="^PSD(58.8,+PSDLOC,1,+PSDRUG,4,",DIC(0)="L",DLAYGO=58.8
 ..S (X,DINUM)=PSDT
 ..S DA(2)=PSDLOC,DA(1)=PSDRUG D ^DIC K DIC,DA,DLAYGO,PSDRUG
QUIT Q
