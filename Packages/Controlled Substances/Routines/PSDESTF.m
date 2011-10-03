PSDESTF ;BIR/BJW-Add Non-CS Drug to Holding file ; 26 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8,66,69**;13 Feb 97;Build 13
 ;**Y2K compliance**;display 4 digit year on va forms
 ;References to ^PSD(58.86, supported by DBIA4472
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ)),'$D(^XUSEC("PSD TECH ADV",DUZ)) W !!,"Please contact your Pharmacy Coordinator for access to",!,"destroy Controlled Substances.",!!,"PSJ RPHARM or PSD TECH ADV security key required.",! G END
 S PSDUZ=DUZ,PSDOUT=0 D NOW^%DTC S PSDT=+$E(%,1,12)
 W !!,?5,"NOTE: This Holding for Destruction transaction WILL NOT update your",!,?5,"Controlled Substances inventory balance.",!!
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4) G:$P(PSDSITE,U,5) DEST
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
DEST ;set up file 58.86
 S PSDOUT=0,PSDCT=1
 S (MFG,LOT,EXP)=""
DIR ;ask free-text drug name
 W !!,"You may create a free-text CS drug to place on hold for destruction.",!,"Your Dispensing Site inventory balance WILL NOT be updated.",!!
 K DA,DIR,DIRUT S DIR(0)="58.86,13" D ^DIR K DA,DIR
 I $D(DIRUT) D MSG G END
 I Y']"" D MSG G END
 S PSDRN=Y
DIR2 K DA,DIR,DIRUT,DTOUT,DUOUT F PSDANS=2,4,11,12,18 S DIR(0)="58.86,"_PSDANS D ^DIR K DA,DIR D  I PSDOUT D MSG G END
 .I $D(DTOUT)!($D(DUOUT)) S PSDOUT=1 Q
 .I PSDANS'=4,PSDANS'=18,Y']"" S PSDOUT=1 Q
 .S PSD(PSDANS)=Y
 .K DIRUT,DTOUT,DUOUT
 ;DIR3 added 5/7/95 to add comments field
DIR3 ;enter free-text information(comments)
 W !!,"You may enter free-text info regarding drug placed on hold for destruction."
 K DA,DIR,DIRUT S DIR(0)="58.86,14" D ^DIR K DA,DIR
 I $D(DTOUT)!($D(DUOUT)) D MSG G END
 S PSDCOMS=Y
ASKY ;ask ok to continue
 W !!,PSDRN," has been selected.",!
 K DA,DIR,DIRUT S DIR(0)="YA",DIR("B")="NO",DIR("A")="Is this OK to create Holding for Destructions number? "
 S DIR("?",1)="Answer 'YES' to create a Holding for Destruction number for this drug,",DIR("?")="answer 'NO' to create a different free-text CS drug, or '^' to quit."
 D ^DIR K DIR I $D(DIRUT) D MSG G END
 I 'Y G DIR
 W !!,"Creating an entry in the Destructions file..."
 F  L +^PSD(58.86,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 ;5/7/95 Fld 14 added, 7/28/95 Fld 18 added
FIND S PSDHLD=$P(^PSD(58.86,0),"^",3)+1 I $D(^PSD(58.86,PSDHLD)) S $P(^PSD(58.86,0),"^",3)=PSDHLD G FIND
 K DA,DIC,DLAYGO S (DIC,DLAYGO)=58.86,DIC(0)="L",(X,DINUM)=PSDHLD D ^DIC K DIC,DINUM,DLAYGO
 L -^PSD(58.86,0)
 W !!,"Your Destructions Holding number is ",PSDHLD
 K DA,DIE,DR S DIE=58.86,DA=PSDHLD,DR="13////"_PSDRN_";2////"_PSD(2)_";3////"_PSDUZ_";5////"_PSDT_";6////"_PSDS_";4////"_$S(+PSD(4):+PSD(4),1:"")_";11////"_+PSD(11)_";12////"_PSD(12)_";14////"_PSDCOMS_";18////"_+PSD(18)
 D ^DIE K DIE,DA,DR
 S RQTY=$P($G(^PSD(58.86,PSDHLD,0)),"^",3),PSDRN=$P($G(^(1)),"^")
 S PSDOK=1
PRINT ;print 2321
 W !!,"Number of copies of VA FORM 10-2321? " R NUM:DTIME I '$T!(NUM="^")!(NUM="") W !!,"No copies printed!!",!! Q
 I NUM'?1N!(NUM=0)  W !!,"Enter a whole number between 1 and 9",! G PRINT
 S Y=PSDT X ^DD("DD") S PSDYR=$P(Y,",",2),PSDYR=$E(PSDYR,1,4)
 S PG=0,RECDT=$E(PSDT,4,5)_"/"_$E(PSDT,6,7)_"/"_PSDYR I EXP S (EXP1,EXPD)=$$FMTE^XLFDT(EXP,"5D") S:'$P(EXP1,"/",2) EXPD=$P(EXP1,"/")_"/"_$P(EXP1,"/",3)
 D ^PSDGSRV2
END ;kill variables
 K %,%DT,%H,%I,ALL,CNT,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT,EXP,EXP1,EXPD,LN,LOT,MFG,NUM
 K PG,PSD,PSDANS,PSDCT,PSDCOMS,PSDHLD,PSDOK,PSDOUT,PSDRN,PSDS,PSDSN,PSDT,PSDUZ,PSDYR,RECDT,RPDT,RQTY,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
MSG W $C(7),!!,"WARNING: Holding for Destructions entry HAS NOT been created.",!!
 Q
