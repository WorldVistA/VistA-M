PSDSTK ;BIR/JPW-Stock Drugs Enter/Edit ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**44,47**;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
STOCK ;entry for  NAOU stocked drugs into file 58.8
 W ! K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("A")="Select NAOU: ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$P(^(0),""^"",2)'=""P""" D ^DIC K DIC G:Y<0 END
 S PSDA=+Y,PSDS=+$P(Y(0),"^",4),TYPE=$P(Y(0),"^",2) D DRUG
 G:('PSDOUT)!(FLAG1) STOCK
END K ADD,DA,DIC,DIE,DINUM,DIR,DIRUT,DIROUT,DLAYGO,DR,DTOUT,DUOUT,FLAG,FLAG1,NAOU,NEW,OK,PSDA,PSDR,PSDRN,PSDRG,PSDOUT,PSDS,TYPE,SITE,X,Y
 Q
DRUG ;add drugs
 S (FLAG,FLAG1,PSDOUT)=0
 W !! K DA,DIR,DIRUT S DIR(0)="SOA^A:ADD;E:EDIT",DIR("A")="Do you wish to ADD or EDIT stock drugs? "
 S DIR("?",1)="Answer 'ADD' to add new CS stock drugs, or",DIR("?")="answer 'EDIT' to edit existing stock drugs, or '^' to quit."
 S DIR("B")="ADD" D ^DIR K DIR I $D(DIRUT) S PSDOUT=1 Q
 S ADD=Y
 I TYPE'="M",ADD="A" D VAULT Q:(PSDOUT)!(FLAG1)  G:FLAG DRUG G DIE
 W ! K DA,DIC S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,PSDA,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***"""
 I TYPE="M",ADD="A",'$D(^PSD(58.8,PSDA,1,0)) S ^(0)="^58.8001IP^^"
 S DA(1)=+PSDA,DIC(0)=$S(ADD="E":"QEAMZ",1:"QEAMLZ"),DIC="^PSD(58.8,"_PSDA_",1,",DLAYGO=58.8 D ^DIC K DIC,DLAYGO Q:Y<0  S PSDR=+Y
 ;DIE;Modified DIE DR string;teh/OIFO Bay Pines
 ;D CHKID I OK D
 ;.K DA,DIE,DR S DIE="^PSD(58.8,"_PSDA_",1,",DA(1)=+PSDA,DA=+PSDR D
 ;..I $P(^PSD(58.8,PSDA,0),U,2)'="N" D
 ;...S DR=16,DR(2,58.800116)=.01 D ^DIE
 ;...S DR=15,DR(2,58.800115)=.01 D ^DIE
 ;...K DR S DR="2;4;5" D ^DIE
 ;..I $P(^PSD(58.8,PSDA,0),U,2)="N" D
 ;...S DR="9;7;8;26;28;29;8.5;10;11" D ^DIE
 ;K DA,DIE,DR
 ; PSD*3*47 RETURN ORIGINAL FUNCTIONALITY
DIE D CHKID I OK K DA,DIE,DR S DIE="^PSD(58.8,"_PSDA_",1,",DA(1)=+PSDA,DA=+PSDR,DR="1;I $P(^PSD(58.8,PSDA,0),""^"",2)'=""N"" S Y=16;15;16;2;4;5;I $P(^PSD(58.8,PSDA,0),""^"",2)=""N"" S Y=9;7;8;26;28;29;8.5;9;10;11" D ^DIE K DA,DIE,DR
 G DRUG
 ;
CHKID ;check for current inactivation date
 I $P($G(^PSD(58.8,PSDA,1,PSDR,0)),"^",14)="" D CHKNP Q
 D CHKNP Q:'OK
 W $C(7),!!,?5,"This Drug is currently defined for this NAOU with an INACTIVATION DATE.",!!,?5,"If you want to add this Drug as a new standard Stock Drug for this NAOU",!,?5,"you must delete the INACTIVATION DATE.",!
 K DA,DIE,DR S OK=1,DA(1)=PSDA,DA=PSDR,DIE="^PSD(58.8,"_PSDA_",1,",DR="13" D ^DIE K DIE S:$P($G(^PSD(58.8,PSDA,1,PSDR,0)),"^",14)]"" OK=0 W !
 Q
CHKNP ;check for non-CS entries in file 50
 S OK=$S($P($G(^PSDRUG(PSDR,2)),"^",3)["N":1,1:0) Q:OK
 I $P($G(^PSD(58.8,PSDA,1,PSDR,0)),"^",14)="" K DA,DIE,DR S DA(1)=PSDA,DA=PSDR,DIE="^PSD(58.8,"_PSDA_",1,",DR="13///"_DT_";14////O;14.5////NON-CS DRUG" D ^DIE K DIE
 W $C(7),!!,?5,"This stocked drug is currently defined for this NAOU but appears to be",!,?5,"a non-CS drug.  It has been inactivated as of " S Y=$P($G(^PSD(58.8,PSDA,1,PSDR,0)),"^",14) X ^DD("DD") W Y,!
 Q
VAULT ;check for stock drugs in vault
 I '$O(^PSD(58.8,PSDS,1,0)) W !!,"There are no CS stocked drugs for your dispensing vault.",!! S PSDOUT=1 Q
 W !!,"You may select only CS drugs stocked in your dispensing vault.",!!
 W ! K DA,DIC S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,PSDS,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***"""
 S DA(1)=+PSDS,DIC(0)="QEAM",DIC="^PSD(58.8,"_PSDS_",1," D ^DIC K DIC I Y<0 S FLAG1=1 Q
 S PSDR=+Y I $D(^PSD(58.8,PSDA,1,PSDR,0)) Q
 S PSDRN=$P($G(^PSDRUG(PSDR,0)),"^")
 S:'$D(^PSD(58.8,PSDA,1,0)) ^(0)="^58.8001IP^^"
 S NEW=+$P(^PSD(58.8,PSDA,1,0),"^",4)+1
 K DA,DIR,DIRUT,Y S DIR(0)="YO",DIR("A")="ARE YOU ADDING '"_PSDRN_"' AS A NEW DRUG (FOR THIS DRUG ACCOUNTABILITY STATS)",DIR("B")="Y"
 D ^DIR K DIR I $D(DIRUT) S PSDOUT=1 Q
 I 'Y S FLAG=1 Q
 K DA,DIC,DD,DO S DA(1)=PSDA,DIC(0)="L",(X,DINUM)=PSDR,DIC="^PSD(58.8,"_PSDA_",1," D FILE^DICN K DIC I Y<0 S PSDOUT=1 Q
 Q
