PSDADJN ;B'ham ISC/LTL,JPW - Adjustments for NAOU ; 16 Feb 94
 ;;3.0; CONTROLLED SUBSTANCES ;**66**;13 Feb 97;Build 3
 I '$D(PSDSITE) D ^PSDSET G:'$D(PSDSITE) QUIT
 ;I '$D(^XUSEC("PSD ERROR",DUZ)) W !!,"Sorry, you need the PSD ERROR Security key to do adjustments.",!! G QUIT
 N DIC,DIE,DINUM,D0,D1,DLAYGO,DR,DIR,DIRUT,DTOUT,DUOUT,PSDAT,PSDB,PSDEX,PSDLOC,PSDLOCN,DA,PSDOUT,PSDRUG,PSDRUGN,PSDS,PSAQ,PSDR,PSDREC,PSDT,X,Y,%,%H,%I
 G LOOK
REV S DIR(0)="Y",DIR("A")="Review",DIR("B")="No",DIR("?")="If you answer yes, I'll show you all adjustments performed within               a selected time range." D ^DIR K DIR G:$D(DIRUT) QUIT G:Y=1 ^PSDADJN1
 Q
LOOK S DIC="^PSD(58.8,",DIC(0)="AEMQ",DIC("A")="Select NAOU: ",DIC("S")="I $P($G(^(0)),U,3)=+PSDSITE,$P($G(^(0)),U,2)[""N"",'$P(^(0),""^"",7),$S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0)"
 D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<1) QUIT S PSDLOC=+Y,PSDLOCN=$P(Y,U,2)
 I '+$P($G(^PSD(58.8,PSDLOC,2)),"^",5) W !!,"This NAOU does not maintain a perpetual inventory balance to be adjusted.",!! K PSDLOC,PSDLOCN G LOOK
CHKD I '$O(^PSD(58.8,PSDLOC,1,0)) W !!,"There are no drugs in ",PSDLOCN G QUIT
 S PSDOUT=0
 F  S DIC="^PSD(58.8,PSDLOC,1,",DIC(0)="AEMQZ",DIC("A")="Select "_PSDLOCN_" drug: ",DA(1)=PSDLOC D  G:$D(DTOUT)!($D(DUOUT))!(PSDOUT) QUIT
 .W ! D ^DIC K DIC I $D(DTOUT)!($D(DUOUT))!(Y<1) S PSDOUT=1 Q
 .S PSDRUG=+Y,PSDRUGN=$P($G(^PSDRUG(+Y,0)),U)
 .S PSAQ=$P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,4)
 .W !!,"Current Balance: ",PSAQ,?40
 .W "Breakdown Unit: ",$P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,8),!
 .S DIR(0)="NOA^"_-PSAQ_":999999:2" S DIR("A")="Enter adjustment quantity (with '-' if negative):" D ^DIR K DIR
 .I $D(DTOUT)!($D(DUOUT)) S PSDOUT=1 Q
 .Q:$D(DIRUT)
 .S PSDREC=Y
 .S DIR(0)="F^1:45",DIR("A")="Please enter reason for adjustment" W ! D ^DIR K DIR Q:$D(DIRUT)  S PSDR=Y
POST .S DIR(0)="Y",DIR("A")="OK to post",DIR("B")="Yes" W ! D ^DIR K DIR D:Y=1  K PSDRUG Q
 ..W !!,"There were ",$S($P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,4):$P($G(^(0)),U,4),1:0)," on hand.",?40,"There are now ",$P($G(^(0)),U,4)+PSDREC," on hand.",!
 ..F  L +^PSD(58.8,+PSDLOC,1,+PSDRUG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 ..D NOW^%DTC S PSDAT=+%
 ..S PSAQ=$P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,4)
 ..S $P(^PSD(58.8,+PSDLOC,1,+PSDRUG,0),U,4)=PSDREC+PSAQ
 ..L -^PSD(58.8,+PSDLOC,1,+PSDRUG,0)
MON ..S:'$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,5,0)) ^(0)="^58.801A^^"
 ..I '$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,5,$E(DT,1,5)*100,0)) S DIC="^PSD(58.8,+PSDLOC,1,+PSDRUG,5,",DIC(0)="LM",DLAYGO=58.8,(X,DINUM)=$E(DT,1,5)*100,DA(2)=PSDLOC,DA(1)=PSDRUG D ^DIC K DIC,DLAYGO
 ..S DIE="^PSD(58.8,+PSDLOC,1,+PSDRUG,5,",DA(2)=PSDLOC,DA(1)=PSDRUG,DA=$E(DT,1,5)*100,DR="7////^S X=$P($G(^(0)),U,5)+PSDREC" D ^DIE
 ..W !,"Updating monthly adjustments and transaction history.",!
TR ..F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND ..S PSDT=$P(^PSD(58.81,0),U,3)+1 I $D(^PSD(58.81,PSDT)) S $P(^PSD(58.81,0),U,3)=$P(^PSD(58.81,0),U,3)+1 G FIND
 ..S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSDT D ^DIC K DIC,DLAYGO L -^PSD(58.81,0)
 ..S DIE="^PSD(58.81,",DA=PSDT,DR="1////9;2////^S X=PSDLOC;3////^S X=PSDAT;4////^S X=PSDRUG;5////^S X=PSDREC;6////^S X=DUZ;9////^S X=PSAQ;15////^S X=PSDR;17////^S X=PSDLOC;100////1" D ^DIE K DIE
 ..S:'$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,4,0)) ^(0)="^58.800119PA^^"
 ..S DIC="^PSD(58.8,+PSDLOC,1,+PSDRUG,4,",DIC(0)="L",DLAYGO=58.8
 ..S (X,DINUM)=PSDT
 ..S DA(2)=PSDLOC,DA(1)=PSDRUG D ^DIC K DIC,DA,DLAYGO,PSDRUG S Y=1
QUIT D:'$G(PSDOUT)!('$D(DIRUT)) REV Q
