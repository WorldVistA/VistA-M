PSDTRV ;BIR/JPW-Transfer CS Drugs between Vaults ; 10 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**71**;13 Feb 97;Build 29
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ))&('$D(^XUSEC("PSD TECH ADV",DUZ))) D  Q
 .W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to transfer",!,?12,"controlled substances between dispensing sites.",!!,"PSJ RPHARM or PSD TECH ADV security key required.",!
 I $P($G(^VA(200,DUZ,20)),U,4)']"" N XQH S XQH="PSD ESIG" D EN^XQH Q
 S PSDUZ=DUZ,PSDUZN=$P($G(^VA(200,PSDUZ,0)),"^")
 N X,X1 D SIG^XUSESIG G:X1="" END
FROM ;select FROM disp site
 S (ADD,PSDOUT)=0
 K DA,DIC W ! S DIC=58.8,DIC(0)="QEA",DIC("A")="Transfer from Dispensing Site: ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)=""M"":1,$P(^(0),""^"",2)=""S"":1,1:0)"
 D ^DIC K DIC G:Y<0 END S PSDS=+Y,PSDSN=$P(Y,"^",2)
DRUG ;select drug
 I '$O(^PSD(58.8,PSDS,1,0)) W !!,"There are no CS stocked drugs for your dispensing vault.",!! S PSDOUT=1 G END
 W ! K DA,DIC S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,PSDS,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***"""
 S DIC("A")="Select DRUG From "_PSDSN_": "
 S DA(1)=+PSDS,DIC(0)="QEAM",DIC="^PSD(58.8,"_PSDS_",1," D ^DIC K DIC
 I ($D(DTOUT))!($D(DUOUT)) S PSDOUT=1 G END
 I Y<0,'PSDOUT G FROM
 S PSDR=+Y,PSDRN=$P($G(^PSDRUG(PSDR,0)),"^"),QTY=+$P($G(^PSD(58.8,PSDS,1,PSDR,0)),"^",4),NBKU=$P(^(0),"^",8),NPKG=$P(^(0),"^",9),MFG=$P(^(0),"^",10),LOT=$P(^(0),"^",11),EXP=$P(^(0),"^",12)
 I 'QTY W $C(7),!!,PSDRN," has a zero balance.",!,"Please select another drug to transfer.",!! G DRUG
QTY ;enter quantity
 W !!,?5,"Breakdown Unit: ",NBKU,?35,"Package Size: ",NPKG,!
 K DIR,DA S DIR(0)="NO^1:"_QTY_":0"
 S DIR("A")="Enter Quantity to Transfer"
 S DIR("?")="Answer with a whole number between 1 and "_QTY
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)  D MSG G END
 S TQTY=+Y
TO ;transfer TO disp site (not restricted to inpat site)
 K DA,DIC W ! S DIC=58.8,DIC(0)="QEA",DIC("A")="Transfer to Dispensing Site: ",DIC("S")="I $S($P(^(0),""^"",2)=""M"":1,$P(^(0),""^"",2)=""S"":1,1:0)"
 D ^DIC K DIC G:Y<0 END S VAULT=+Y,VAULTN=$P(Y,"^",2)
CHK I VAULT=PSDS W $C(7),!!,?5,"** NOT ALLOWED to transfer out of and into SAME Dispensing Site! **" G END
 I '$D(^PSD(58.8,VAULT,1,PSDR,0)) W $C(7),!!,?5,"** ",VAULTN," does not stock ",PSDRN,"! **",! D ADD G:PSDOUT END G ASK
 I $P(^PSD(58.8,VAULT,1,PSDR,0),"^",8)'=NBKU W $C(7),!!,"** The Narcotic Breakdown Unit does not match." D MSG G END
ASK ;ask ok
 W !!,"Transferring: ",TQTY," (",NBKU,")",!,"From: ",PSDSN,"    To: ",VAULTN,!!
 K DIR,DIRUT S DIR(0)="Y",DIR("A")="Is this OK",DIR("B")="NO"
 S DIR("?")="Answer 'YES' to post this transfer, 'NO' or '^' to quit."
 D ^DIR K DIR I 'Y!$D(DIRUT) D MSG G END
 D:ADD ADD1 D ^PSDTRV1 G:'PSDOUT DRUG
END K %,%H,%I,ADD,BAL,CNT,DA,DD,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DLAYGO,DO,DR,DTOUT,DUOUT,EXP,JJ,LOT,MFG,NBKU,NPKG,PSDT,PSDLES,PSDOUT,PSDR,PSDREC,PSDRN,PSDS,PSDSN
 K PSDUZ,PSDUZN,QTY,RDT,TEMP,TQTY,VAULT,VAULTN,X,XMDUZ,XMSUB,XMTEXT,XMY,Y
 Q
MSG W $C(7),!!,"No action taken.",!!
 Q
ADD ;ask to add drug
 K DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want to continue"
 S DIR("?")="Answer 'YES' to continue with this transfer, 'NO' or '^' to quit."
 D ^DIR K DIR I 'Y!$D(DIRUT) D MSG S PSDOUT=1 Q
 S ADD=1
 Q
ADD1 ;add drug
 Q:$D(^PSD(58.8,VAULT,1,PSDR,0))
 S:'$D(^PSD(58.8,VAULT,1,0)) ^PSD(58.8,VAULT,1,0)="^58.8001IP^^"
 K DA,DIC,DD,DO S DIC(0)="L",DIC="^PSD(58.8,"_+VAULT_",1,",DA(1)=+VAULT,(X,DINUM)=+PSDR D FILE^DICN K DA,DIC
