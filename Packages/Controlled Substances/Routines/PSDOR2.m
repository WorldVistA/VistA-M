PSDOR2 ;BIR/LTL-Reg 2 Nurse CS Order Request Entry ;12/14/99  12:44
 ;;3.0; CONTROLLED SUBSTANCES ;**20**;13 Feb 97
 ;
 ; Reference to PSD(58.8 supported by DBIA # 2711
 ; Reference to DD("DD" supported by DBIA # 10017
 ;
QTY K ORD S (CNT,PSDOUT,PSDR(2))=0
 S DIR(0)="DA^NOW::AEFT",DIR("A")="Date/time required: "
 S DIR("?",1)="You are on the verge of creating a priority order."
 S DIR("?",2)="If this is a mistake, enter ""^"" to create a scheduled order, otherwise,"
 S DIR("?")="Pharmacy needs to know how soon you need this order."
 W ! D ^DIR K DIR G:$D(DIRUT) END X ^DD("DD") S PSDT(9)=Y
 ;Dispensing Site's Maximum Quantity per Order
 S PSDR(1)=$P($G(^PSD(58.8,+PSDS,1,+PSDR,0)),U,7)
 ;Ask Quantity
 S DIR(0)="NA^1:"_$S(PSDR(1):PSDR(1),1:999999)_":0"
 S DIR("A")="QUANTITY ("_NBKU_"/"_NPKG_"): ",DIR("B")=NPKG
 W:$P($G(^PSD(58.8,+NAOU,1,+PSDR,0)),U,3) !,"Stock Level:  ",$P($G(^(0)),U,3)," ",NBKU,!
 S:PSDR(1) DIR("A",1)="Maximum quantity per order:  "_PSDR(1)_" "_NBKU,DIR("A",2)=""
 S DIR("?",1)="Because "_NAOUN_" is keeping a perpetual inventory,"
 S DIR("?",2)="Pharmacy Service has set "_$S(PSDR(1):"a maximum quantity of "_PSDR(1)_" "_NBKU_" per order",1:"no maximum order quantity")
 S DIR("?")="for "_PSDRN_"."
 D ^DIR K DIR G:Y<1 END S PSDQTY=Y
 ;Quantity ordered is equal to or less than max ord qty
NOMAX I '(Y#NPKG)&('PSDR(1)!(Y'>PSDR(1))) D DIE,ASK^PSDORN1 G:PSDOUT END K PSDEM G DRUG^PSDORN
 ;Quantity ordered is not divisible by package size
 D:(Y#NPKG)  G:$D(DIRUT) END G:Y<1 QTY I 'PSDR(1)!(Y>PSDR(1)) S Y=PSDQTY G QTY
 .S PSDQTY=Y-(Y#NPKG)
 .S DIR(0)="S^"_PSDQTY_":"_NBKU_";"_(PSDQTY+NPKG)_":"_NBKU_";*:New Quantity"
 .S DIR("A",1)="Please order "_PSDRN,DIR("A",3)=""
 .S DIR("A",2)="in multiples of "_NPKG_" "_NBKU_".",DIR("B")=PSDQTY
 .S DIR("A")="QUANTITY ("_NBKU_"/"_NPKG_")"
 .S DIR("?")="Enter an adjusted quantity or * to enter a new quantity" D ^DIR K DIR Q:Y<1  S PSDQTY=Y
 D DIE,ASK^PSDORN1 G:PSDOUT END K PSDEM G DRUG^PSDORN
END K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K NBKU,NPKG,OK,OKTYP,ORD,PSDA,PSDEM,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDT,REQD,TEXT,TYPE,WORD,X,Y
 Q
DIE ;create the order request
 S:$G(ORD)<2 PSDEM=1
 S:'$D(^PSD(58.8,NAOU,1,PSDR,3,0)) ^(0)="^58.800118A^^"
 S PSDA=$P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)+1 I $D(^PSD(58.8,NAOU,1,PSDR,3,PSDA)) S $P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)=$P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)+1 G DIE
 K DA,DIC,DIE,DD,DR,DO S DIC(0)="L",(DIC,DIE)="^PSD(58.8,"_NAOU_",1,"_PSDR_",3,",DA(2)=NAOU,DA(1)=PSDR,(X,DINUM)=PSDA D FILE^DICN K DIC
 D NOW^%DTC S PSDT=+$E(%,1,12) W ?10,!!,"processing now..."
 S DA=PSDA,DA(1)=PSDR,DA(2)=NAOU,DR="1////"_PSDT_";2////"_+PSDS_";3////"_PSDUZ_";10////1;5////"_PSDQTY_";24////"_$G(PSDEM)_";13" D ^DIE K DIE,DR
 Q
