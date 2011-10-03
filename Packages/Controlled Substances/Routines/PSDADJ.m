PSDADJ ;BIR/LTL-Adjustments ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**16,66**;13 Feb 97;Build 3
 ;
 ;References to ^PSD(58.8, supported by DBIA2711
 ;References to ^PSD(58.81 are supported by DBIA2808
 ;References to ^PSDRUG( supported by DBIA #221
 ;
 I '$D(PSDSITE) D ^PSDSET G:'$D(PSDSITE) QUIT
 I '$D(^XUSEC("PSDMGR",DUZ)) W !!,"Sorry, you need the PSDMGR Security key to do adjustments.",!! G QUIT
 I $P($G(^VA(200,DUZ,20)),U,4)']"" N XQH S XQH="PSD ESIG" D EN^XQH G QUIT
 N DIC,DIE,DINUM,D0,D1,DLAYGO,DR,DIR,DIRUT,DTOUT,DUOUT,PSDAT,PSDB,PSDEX,PSDLOC,PSDLOCN,DA,PSDRUG,PSDRUGN,PSDOK,PSDS,PSAQ,PSDR,PSDREC,PSDT,X,Y,%,%H,%I
 S DIR(0)="Y",DIR("A")="Review",DIR("B")="No",DIR("?")="If you answer yes, you will be shown all adjustments performed within               a selected time range." D ^DIR K DIR G:$D(DIRUT) QUIT G:Y=1 ^PSDADJR
 S PSDLOC=$P(PSDSITE,U,3),PSDLOCN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
LOOK S DIC="^PSD(58.8,",DIC(0)="AEQ",DIC("A")="Select Dispensing Site: "
 S DIC("S")="I $P($G(^(0)),U,3)=+PSDSITE,$S($P($G(^(0)),U,2)[""M"":1,$P($G(^(0)),U,2)[""S"":1,1:0),$S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0)"
 S DIC("B")=$P(PSDSITE,U,4)
 D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<1) QUIT
 S PSDLOC=+Y,PSDLOCN=$P(Y,U,2)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=$P(Y,U,2)
CHKD I '$O(^PSD(58.8,PSDLOC,1,0)) W !!,"There are no drugs in ",PSDLOCN G QUIT
 N X,X1 D SIG^XUSESIG I X1="" G QUIT
 F  S DIC="^PSD(58.8,PSDLOC,1,",DIC(0)="AEMQZ",DIC("A")="Select "_PSDLOCN_" drug: ",DIC("S")="I $S($P($G(^(0)),U,14):$P($G(^(0)),U,14)>DT,1:1)",DA(1)=PSDLOC W ! D ^DIC K DIC G:Y<1 QUIT D  G:$D(DIRUT) QUIT D:$D(PSDEX) DEST^PSDGSRV1 K PSDEX
 .S PSDRUG=+Y,PSDRUGN=$P($G(^PSDRUG(+Y,0)),U)
 .;DAVE B (28APR99) Moving lock of PSD(58.8,LOC,1,DRUG) up.
 .F  L +^PSD(58.8,+PSDLOC,1,+PSDRUG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .S PSAQ=$P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,4)
 .W !!,"Current Balance: ",PSAQ,?40
 .W "Breakdown Unit: ",$P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,8),!
 .S DIR(0)="N^"_-PSAQ_":999999:2" S DIR("A")="Enter adjustment quantity (with '-' if negative)" D ^DIR K DIR Q:$D(DIRUT)
 .S PSDREC=Y
 .S DIR(0)="F^1:45",DIR("A")="Please enter reason for adjustment" W ! D ^DIR K DIR Q:$D(DIRUT)  S PSDR=Y
POST .S DIR(0)="Y",DIR("A")="OK to post",DIR("B")="Yes",DIR("?")="Answer 'YES' to adjust your inventory balance, 'NO' or '^' to quit." W ! D ^DIR K DIR D:Y=1  L -^PSD(58.8,+PSDLOC,1,+PSDRUG,0) K PSDRUG Q
 ..W !!,"There were ",$S($P($G(^PSD(58.8,+PSDLOC,1,+PSDRUG,0)),U,4):$P($G(^(0)),U,4),1:0)," on hand.",?40,"There are now ",$P($G(^(0)),U,4)+PSDREC," on hand.",!
 ..;F  L +^PSD(58.8,+PSDLOC,1,+PSDRUG,0):0 I  Q
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
 ..S DIE="^PSD(58.81,",DA=PSDT,DR="1////9;2////^S X=PSDLOC;3////^S X=PSDAT;4////^S X=PSDRUG;5////^S X=PSDREC;6////^S X=DUZ;9////^S X=PSAQ;15////^S X=PSDR;100////1" D ^DIE K DIE
 ..S:'$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,4,0)) ^(0)="^58.800119PA^^"
 ..S DIC="^PSD(58.8,+PSDLOC,1,+PSDRUG,4,",DIC(0)="L",DLAYGO=58.8
 ..S (X,DINUM)=PSDT
 ..S DA(2)=PSDLOC,DA(1)=PSDRUG D ^DIC K DIC,DA,DLAYGO S Y=1
 ..I PSDREC<0 S DIR(0)="Y",DIR("A")="To be destroyed",DIR("B")="No" D ^DIR K DIR I Y=1 S PSDEX=1,PSDA=PSDT,PSDOK=1
QUIT Q
