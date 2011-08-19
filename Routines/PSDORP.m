PSDORP ;BIR/JPW-Pharm CS Order Request Entry ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**58,62,67**;13 Feb 97;Build 8
 W !!,"Controlled Substances Order Entry",!! S PSDUZ=DUZ,PSDUZN=$P($G(^VA(200,PSDUZ,0)),"^"),(MSG,MSG1)=0,Y=DT X ^DD("DD") S REQD=Y
NAOU ;select NAOU to order supplies for
 K ^UTILITY($J,"W")
 N X,DIWL,DIWR,DIWF,PSD S PSD=0,DIWL=1,DIWR=80,DIWF="W"
 F  S PSD=$O(^PSD(58.8,+$P(PSDSITE,U,3),5,PSD)) Q:'PSD  S X=$G(^PSD(58.8,+$P(PSDSITE,U,3),5,PSD,0)) D ^DIWP
 D ^DIWW
 K DA,DIC S DIC=58.8,DIC(0)="QEA",DIC("A")="Select Ordering NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 D ^DIC K DIC G:Y<0 END S NAOU=+Y,NAOUN=$P(Y,"^",2)
 I '$D(^PSD(58.8,NAOU,0)) S MSG=1 D MSG G END
 I '$O(^PSD(58.8,NAOU,1,0)) S MSG=1,MSG1=2 D MSG G END
 S PSDS=+$P(^PSD(58.8,NAOU,0),"^",4) I '+PSDS S (MSG,MSG1)=1 D MSG G END
 I '$D(^PSD(58.8,+PSDS,0)) S MSG=2 D MSG G END
 I '$O(^PSD(58.8,+PSDS,1,0)) S MSG=2,MSG1=2 D MSG G END
 S TYPE=$P(^PSD(58.8,+PSDS,0),"^",2),OKTYP=$S(TYPE="M":1,TYPE="S":1,1:0) I 'OKTYP W !!,"Contact your Pharmacy Coordinator.",!,"The Pharmacy Dispensing Site is invalid for this NAOU." G END
DRUG ;select drug
 K DA,DIC S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,NAOU,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""  *** INACTIVE ***"""
 S DA(1)=+NAOU,DIC(0)="QEAM",DIC="^PSD(58.8,"_NAOU_",1,"
 D ^DIC K DIC G:Y<0 NAOU S PSDR=+Y,PSDRN=$S($P(^PSDRUG(PSDR,0),"^")]"":$P(^(0),"^"),1:"DRUG NAME MISSING")
 I '$D(^PSD(58.8,NAOU,1,PSDR,0)) D MSG G END
 I '$D(^PSD(58.8,+PSDS,1,PSDR,0)) S MSG=2 D MSG G END
 S NBKU=$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",8),NPKG=+$P(^(0),"^",9)
 I NBKU']"" S MSG1=3 D MSG G END
 I 'NPKG S MSG1=4 D MSG G END
 D LIST^PSDORL
 ;NAOU using perpetual?
 G:$P($G(^PSD(58.8,+NAOU,2)),U,5) ^PSDORP2
QTY K ORD S (CNT,PSDR(2),PSDOUT)=0
 ;DISPLAY STOCK LEVEL
 W:$P($G(^PSD(58.8,+NAOU,1,+PSDR,0)),U,3) !,"Stock Level:  ",$P($G(^(0)),U,3)," ",NBKU,!
 ;ASK QUANTITY
 S DIR(0)="NA^1:999999:0"
 S DIR("A")="QUANTITY ("_NBKU_"/"_NPKG_"): ",DIR("B")=NPKG
 D ^DIR K DIR G:Y<1 END S PSDQTY=Y
 I Y=NPKG S PSDQTY=NPKG,CNT=0 D DIE,ASK^PSDORP1 G:PSDOUT END G DRUG
 ;QUANTITY EXCEEDS PACKAGE SIZE, MULTIPLE ORDERS
 S:(PSDQTY#NPKG) CNT=1,PSDR(2)=(PSDQTY#NPKG)
 S CNT=$G(CNT)+(Y\NPKG)
 W !!,"This will be "_CNT_" separate order requests,"
 W:PSDR(2) !!,"One order for ",PSDR(2)," ",NBKU,", and"
 W !!,(PSDQTY\NPKG)," order"
 W:CNT>2!('PSDR(2)&(CNT=2)) "s"
 W " for ",NPKG," ",NBKU,"."
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want me to generate the "_CNT_" separate order requests",DIR("B")="YES",DIR("?",1)="Answer 'YES' to create the multiple order requests,"
 S DIR("?")="Answer 'NO' to edit your quantity or '^' to quit." D ^DIR K DIR G:$D(DIRUT) END
 I 'Y W !,"No order request created.  You must edit quantity.",! G QTY
 I Y W !!,"The "_CNT_" requests are being created.  You must review every request.",! S PSDQTY=$S(PSDR(2):PSDR(2),1:NPKG) D  D ^PSDORP1 S PSDQTY=NPKG
 .F ORD=1:1:CNT W !!,"Creating your order request # "_ORD_" of "_CNT_" for "_PSDRN D DIE S ORD(ORD)=PSDA
 G:'PSDOUT DRUG
END K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K NAOU,NAOUN,NBKU,NPKG,OK,OKTYP,ORD,PSDA,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDS,PSDT,PSDUZ,PSDUZA,PSDUZN,REQD,TEXT,TYPE,WORD,X,Y
 Q
DIE ;create the order request
 S:'$D(^PSD(58.8,NAOU,1,PSDR,3,0)) ^(0)="^58.800118A^^"
 S PSDA=$P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)+1 I $D(^PSD(58.8,NAOU,1,PSDR,3,PSDA)) S $P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)=$P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)+1 G DIE
 K DA,DIC,DIE,DD,DR,DO S DIC(0)="L",(DIC,DIE)="^PSD(58.8,"_NAOU_",1,"_PSDR_",3,",DA(2)=NAOU,DA(1)=PSDR,(X,DINUM)=PSDA D FILE^DICN K DIC
 D NOW^%DTC S PSDT=+$E(%,1,12) W ?10,!!,"processing now..."
 S DA=PSDA,DA(1)=PSDR,DA(2)=NAOU,DR="1////"_PSDT_";2////"_PSDS_";10////1;5////"_PSDQTY_";13;3//^S X=PSDUZN" D ^DIE K DIE,DR
 S PSDUZA=+$P($G(^PSD(58.8,NAOU,1,PSDR,3,PSDA,0)),"^",4)
 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"PSDR")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 Q
