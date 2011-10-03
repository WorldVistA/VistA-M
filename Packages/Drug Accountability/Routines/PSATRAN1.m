PSATRAN1 ;BIR/JMB-Transfer Drugs between Pharmacies - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**64**; 10/24/97;Build 4
 ;This routine updates the dispensing and receiving locations. The drug
 ;balance & monthly activity are updated. It creates an activity in 58.8,
 ;a transaction in 58.81, sends a mail message if the drug is new to the
 ;receiving location, and stores the data so the signature sheet can
 ;print. It is called by PSATRAN.
 ;
UPDATE ;update location balances
 D CHK Q:PSALES  W !!,"Updating pharmacy on-hand balances now..."
 S (PSATODA,PSAFRDA)=0
 F PSALCNT=1:1:2 D CALC
 I PSATODA,PSAFRDA D
 .S DIE="^PSD(58.81,",DA=PSATODA,DR="16///^S X=PSAFRDA"
 .F  L +^PSD(58.81,DA,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .D ^DIE L -^PSD(58.81,DA,0) K DA
 .S DA=PSAFRDA,DR="16///^S X=PSATODA"
 .F  L +^PSD(58.81,DA,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .D ^DIE L -^PSD(58.81,DA,0) K DA,DIE
 W !,"Done!" H 1 S ^TMP("PSASIG",$J,+PSAFROM,+PSATO,PSAFRDA)=""
 D:PSADD MSG I 'PSADD H 1
 S (PSADD,PSAOUT)=0
 Q
CALC ;sub/add qty from dsp sites
 W "." S PSATEMP=+$S(PSALCNT=1:PSAFROM,1:PSATO),PSATQTY=-PSATQTY
 F  L +^PSD(58.8,PSATEMP,1,PSADRG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D NOW^%DTC S PSADT=+%
 S PSABAL(PSALCNT)=$P(^PSD(58.8,PSATEMP,1,PSADRG,0),"^",4),$P(^(0),"^",4)=$P(^(0),"^",4)+PSATQTY,$P(PSABAL(PSALCNT),"^",2)=(+PSABAL(PSALCNT)+PSATQTY)
 L -^PSD(58.8,PSATEMP,1,PSADRG,0)
ADD ;find entry number
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSAREC=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSAREC)) S $P(^PSD(58.81,0),"^",3)=PSAREC G FIND
 K DIC,DLAYGO S DIC(0)="L",DIC="^PSD(58.81,",DLAYGO=58.81,(X,DINUM)=PSAREC D ^DIC K DIC,DINUM,DLAYGO
 L -^PSD(58.81,0) W "."
 S:PSALCNT=1 PSAFRDA=PSAREC S:PSALCNT=2 PSATODA=PSAREC
TRANS ;update transaction data
 K DA,DIE,DR S DA=PSAREC,DIE=58.81
 S DR="1////24;2////"_PSATEMP_";4////"_PSADRG_";3////"_PSADT_";5////"_PSATQTY_";6////"_PSADUZ_";9////"_$P(PSABAL(PSALCNT),"^")
 D ^DIE K DA,DIE,DR W "."
ACT ;update location drug info
 S:'$D(^PSD(58.8,PSATEMP,1,PSADRG,4,0)) ^PSD(58.8,PSATEMP,1,PSADRG,4,0)="^58.800119PA^^"
 I '$D(^PSD(58.8,PSATEMP,1,PSADRG,4,PSAREC,0)) K DA,DD,DO S DIC(0)="L",DIC="^PSD(58.8,"_PSATEMP_",1,"_PSADRG_",4,",DA(2)=PSATEMP,DA(1)=PSADRG,(X,DINUM)=PSAREC D ^DIC K DA,DIC,DINUM W "."
MON ;update monthly activity node
 S:'$D(^PSD(58.8,PSATEMP,1,PSADRG,5,0)) ^(0)="^58.801A^^"
 I '$D(^PSD(58.8,PSATEMP,1,PSADRG,5,$E(PSADT,1,5)*100,0)) D
 .S DIC="^PSD(58.8,"_PSATEMP_",1,"_PSADRG_",5,",DIC(0)="LM"
 .S DA(2)=PSATEMP,DA(1)=PSADRG,(X,DINUM)=($E(PSADT,1,5)*100),DLAYGO=58.8 D ^DIC K DIC,DINUM,DLAYGO W "." S DA=+Y
 .S DIE="^PSD(58.8,"_PSATEMP_",1,"_PSADRG_",5,",DA(2)=PSATEMP,DA(1)=PSADRG,DR="1////^S X="_+PSABAL(PSALCNT) D ^DIE K DIE
 .S X="T-1M" D ^%DT
 .S DIC="^PSD(58.8,"_PSATEMP_",1,"_PSADRG_",5,",DIC(0)="LM",DA(2)=PSATEMP,DA(1)=PSADRG,(X,DINUM)=($E(Y,1,5)*100),DLAYGO=58.8 D ^DIC K DINUM,DLAYGO
 ;.S DIE=DIC,DR="3////^S X="_($P($G(^PSD(58.8,PSATEMP,1,PSADRG,0)),"^",4)-PSATQTY) K DIC D ^DIE K DA,DIE W "."
 S DA=($E(PSADT,1,5)*100),PSANODE=$G(^PSD(58.8,PSATEMP,1,PSADRG,5,DA,0)) Q:'$D(PSANODE)
 S PSAREC=$P(PSANODE,"^",3),PSADJ=$P(PSANODE,"^",5),PSADISP=$P(PSANODE,"^",6),PSARET=$P(PSANODE,"^",7),PSATF=$P(PSANODE,"^",9)+PSATQTY
 S PSABAL=$P(PSANODE,"^",2)+PSAREC+PSADJ-PSADISP+PSARET+PSATF
 S DIE="^PSD(58.8,"_PSATEMP_",1,"_PSADRG_",5,",DA(2)=PSATEMP,DA(1)=PSADRG
 S DR="13////^S X="_($P($G(^PSD(58.8,PSATEMP,1,PSADRG,5,DA,0)),"^",9)+PSATQTY)_";3////^S X="_PSABAL
 D ^DIE K DA,DIE W "."
 Q
CHK ;check for valid bal
 S PSALES=0 D:PSATQTY>$P(^PSD(58.8,PSAFROM,1,PSADRG,0),"^",4)
 .W $C(7),!!,"=>   The drug balance is "_+$P(^PSD(58.8,PSAFROM,1,PSADRG,0),"^",4)_".  You cannot transfer "_PSATQTY_" for this drug.",! S PSALES=1
 .W "No action taken.",!
 Q
MSG ;send mailman message with transfer info
 K XMY,^TMP("PSATRAN",$J)
 S ^TMP("PSATRAN",$J,1,0)="Drug: "_PSADRGN
 S ^TMP("PSATRAN",$J,2,0)="Quantity  : "_PSATQTY_" ("_PSADU_")",^TMP("PSATRAN",$J,3,0)="Pharmacist: "_PSADUZN,^TMP("PSATRAN",$J,4,0)=" "
 S ^TMP("PSATRAN",$J,5,0)="Transferred from:",^TMP("PSATRAN",$J,6,0)=PSAFROMN,^TMP("PSATRAN",$J,7,0)=" "
 S ^TMP("PSATRAN",$J,8,0)="Transferred and Added to:",^TMP("PSATRAN",$J,9,0)=PSATON
 S XMSUB="Drug Transfer Between Pharmacies",XMTEXT="^TMP(""PSATRAN"",$J,",XMDUZ="Drug Accountability System"
 F PSAJJ=0:0 S PSAJJ=$O(^XUSEC("PSAMGR",PSAJJ)) Q:'PSAJJ  S XMY(PSAJJ)=""
 G:'$D(XMY) QUIT D ^XMD
QUIT K XMY,^TMP("PSATRAN",$J)
 Q
