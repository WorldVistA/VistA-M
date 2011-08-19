PSDESTO ;BIR/BJW-Add CS Non-Inv Drug to Holding file ; 28 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8,32,66,69**;13 Feb 97;Build 13
 ;**Y2K compliance**;display 4 digit year on va forms
 ;References to ^PSD(58.86, supported by DBIA4472
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ)),'$D(^XUSEC("PSD TECH ADV",DUZ)) W !!,"Please contact your Pharmacy Coordinator for access to",!,"destroy Controlled Substances.",!!,"PSJ RPHARM or PSD TECH ADV security key required.",! G END
 S PSDUZ=DUZ D NOW^%DTC S PSDT=+$E(%,1,12)
 W !!,?5,"NOTE: This Holding for Destruction transaction WILL NOT update your",!,?5,"Controlled Substances inventory balance.",!!
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4) G:$P(PSDSITE,U,5) DRUG
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
DRUG ;ask non-inv CS drug
 W !!,"You may select a Controlled Substances drug to place on hold for destruction.",!,"Your Dispensing Site inventory balance WILL NOT be updated.",!!
 K DA,DIC S DIC("A")="Select DRUG: ",DIC=50,DIC(0)="QEAM",DIC("S")="I $S('$D(^(""I"")):1,+^(""I"")>DT:1,1:0),$P($G(^(2)),""^"",3)[""N""" D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT)) END I Y<0 G RPTCPY
 S PSDR=+Y,PSDRN=$P(Y,"^",2)
DEST ;set up file 58.86
 S PSDOUT=0,PSDCT=1
 S (MFG,LOT,EXP)=""
 ;7/27/95 Field 18 added, to prompt for patient name returning drugs.
DIR2 K DA,DIR,DIRUT,DTOUT,DUOUT,PSD,PSDANS F PSDANS=2,4,11,12,18 S DIR(0)="58.86,"_PSDANS D ^DIR K DA,DIR D  I PSDOUT D MSG G END
 .I $D(DTOUT)!($D(DUOUT)) S PSDOUT=1 Q
 .I PSDANS'=4,PSDANS'=18,Y']"" S PSDOUT=1 Q
 .S PSD(PSDANS)=Y
 .K DIRUT,DTOUT,DUOUT
 ;DIR was added for E3R# 3771
DIR ;enter free-text information 
 W !!,"You may enter free-text info regarding drug placed on hold for destruction."
COM K DA,DIR,DIRUT S DIR(0)="58.86,14" D ^DIR K DA,DIR
 I $D(DTOUT)!($D(DUOUT)) D MSG G END
 S PSDCOMS=Y
 I PSDCOMS[";" W !,"A semicolon is not allowed in the COMMENTS field. Please edit your entry.",! G COM
ASKY ;ask ok to continue
 W !!,PSDRN," has been selected.",!
 K DA,DIR,DIRUT S DIR(0)="YA",DIR("B")="NO",DIR("A")="Is this OK to create Holding for Destructions number? "
 S DIR("?",1)="Answer 'YES' to create a Holding for Destruction number for this drug,",DIR("?")="answer 'NO' to select a different CS drug or '^' to quit."
 D ^DIR K DIR I $D(DIRUT) D MSG G END
 I 'Y W !!,"Select a new CS drug to place on hold for destruction",!! G DRUG
 W !!,"Creating an entry in the Destructions file..."
 F  L +^PSD(58.86,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 ;Field 14 added for E3R# 3771,Fld 18 added 7/27/95
FIND S PSDHLD=$P(^PSD(58.86,0),"^",3)+1 I $D(^PSD(58.86,PSDHLD)) S $P(^PSD(58.86,0),"^",3)=PSDHLD G FIND
 K DA,DIC,DLAYGO S (DIC,DLAYGO)=58.86,DIC(0)="L",(X,DINUM)=PSDHLD D ^DIC K DIC,DLAYGO
 L -^PSD(58.86,0)
 W !!,"Your Destructions Holding number is ",PSDHLD
 K DA,DIE,DR S DIE=58.86,DA=PSDHLD,DR="1////"_PSDR_";2////"_PSD(2)_";3////"_PSDUZ_";5////"_PSDT_";6////"_PSDS_";4////"_$S(+PSD(4):+PSD(4),1:"")_";11////"_+PSD(11)_";12////"_PSD(12)_";14////"_PSDCOMS_";18////"_+PSD(18)
 D ^DIE K DIE,DA,DR
 S RQTY=+$P($G(^PSD(58.86,PSDHLD,0)),"^",3)
 S PSDOK=1
TEMPX ;build temp file added june 96
 S Y=PSDT X ^DD("DD") S PSDYR=$P(Y,",",2),PSDYR=$E(PSDYR,1,4)
 S PG=0,RECDT=$E(PSDT,4,5)_"/"_$E(PSDT,6,7)_"/"_PSDYR I EXP S (EXP1,EXPD)=$$FMTE^XLFDT(EXP,"5D") S:'$P(EXP1,"/",2) EXPD=$P(EXP1,"/")_"/"_$P(EXP1,"/",3)
 S ^TMP("PSDESTO",$J,PSDHLD)=PSDHLD_"^"_RECDT_"^"_PSDRN_"^"_RQTY_"^"_PSDCOMS G DRUG
RPTCPY ;ask # of report copies
 I '$G(PSDHLD) G END
 W !!,"Number of copies of VA FORM 10-2321? " R NUM:DTIME I '$T!(NUM="^")!(NUM="") W !!,"No copies printed!!",!! G END
 I $G(NUM) D ^PSDGSRV2 G END
 I NUM'?1N!(NUM=0)  W !!,"Enter a whole number between 1 and 9",! G RPTCPY
END ;kill variables
 K %,%DT,%H,%I,ALL,CNT,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT,EXP,EXP1,EXPD,LN,LOT,MFG,NUM
 K PG,PSD,PSDANS,PSDCOMS,PSDCT,PSDHLD,PSDOK,PSDOUT,PSDR,PSDRN,PSDS,PSDSN,PSDT,PSDUZ,PSDYR,RECDT,RPDT,RQTY,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDESTO",$J)
 Q
MSG W $C(7),!!,"WARNING: Holding for Destructions entry HAS NOT been created.",!!
 Q
