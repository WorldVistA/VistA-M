PSDORP2 ;BIR/JPW,LTL-Pharm CS Order Request Entry ; 22 Jun 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
QTY K ORD S (CNT,PSDR(2),PSDOUT)=0
 ;DISPLAY STOCK LEVEL
 W:$P($G(^PSD(58.8,+NAOU,1,+PSDR,0)),U,3) !,"Stock Level:  ",$P($G(^(0)),U,3)," ",NBKU,!
 ;Dispensing Sites's Max Qty per order
 S PSDR(1)=$P($G(^PSD(58.8,+PSDS,1,+PSDR,0)),U,7)
 ;ASK QUANTITY
 S DIR(0)="NA^1:999999:0"
 S DIR("A")="QUANTITY ("_NBKU_"/"_NPKG_"): ",DIR("B")=NPKG
 S:PSDR(1) DIR("A",1)="Maximum quantity per order:  "_PSDR(1)_" "_NBKU,DIR("A",2)=""
 S DIR("?",1)="Because "_NAOUN_" is keeping a perpetual inventory,"
 S DIR("?",2)=$S(PSDR(1):"a maximum quantity of "_PSDR(1)_" "_NBKU_" per order",1:"no maximum order quantity")_" has been set for "_PSDRN_"."
 S:PSDR(1) DIR("?")="If you request more than "_PSDR(1)_" "_NBKU_", multiple orders will be generated.",DIR("?",3)="for "_PSDRN_".",DIR("?",4)=""
 D ^DIR K DIR G:Y<1 END S PSDQTY=Y
 ;quantity ordered is equal to or less than max ord qty
NOMAX I 'PSDR(1)!(Y'>PSDR(1)) D DIE,ASK^PSDORP1 G:PSDOUT END G DRUG^PSDORP
 ;QUANTITY EXCEEDS MAX ORD QTY, MULTIPLE ORDERS
 S:(PSDQTY#PSDR(1)) CNT=1,PSDR(2)=(PSDQTY#PSDR(1))
 S CNT=$G(CNT)+(Y\PSDR(1))
 W !!,"This will be "_CNT_" separate order requests,"
 W:PSDR(2) !!,"One order for ",PSDR(2)," ",NBKU,", and"
 W !!,(PSDQTY\PSDR(1))," order"
 W:CNT>2!('PSDR(2)&(CNT=2)) "s"
 W " for ",PSDR(1)," ",NBKU,"."
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want me to generate the "_CNT_" separate order requests",DIR("B")="YES",DIR("?",1)="Answer 'YES' to create the multiple order requests,"
 S DIR("?")="Answer 'NO' to edit your quantity or '^' to quit." D ^DIR K DIR G:$D(DIRUT) END
 I 'Y W !,"No order request created.  You must edit quantity.",! G QTY
 I Y W !!,"The "_CNT_" requests are being created.  You must review every request.",! S PSDQTY=$S(PSDR(2):PSDR(2),1:PSDR(1)) D  D ^PSDORP1 S PSDQTY=PSDR(1)
 .F ORD=1:1:CNT W !!,"Creating your order request # "_ORD_" of "_CNT_" for "_PSDRN D DIE S ORD(ORD)=PSDA
 G:'PSDOUT DRUG^PSDORP
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
