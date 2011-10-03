PSDORD3 ;BIR/LTL-Reg 2 Nurse CS Order Request Entry (batch) ; 6 Jan 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
QTY K ORD S (CNT,PSDOUT,PSDR(2))=0
 ;Dispensing Site's Maximum Quantity per Order
 S PSDR(1)=$P($G(^PSD(58.8,+PSDS,1,+PSDR,0)),U,7)
 ;Ask Quantity
 S DIR(0)="NA^1:999999:0"
 S DIR("A")="QUANTITY ("_NBKU_"/"_NPKG_"): ",DIR("B")=NPKG
 W:$P($G(^PSD(58.8,+NAOU,1,+PSDR,0)),U,3) !,"Stock Level:  ",$P($G(^(0)),U,3)," ",NBKU,!
 S:PSDR(1) DIR("A",1)="Maximum quantity per order:  "_PSDR(1)_" "_NBKU,DIR("A",2)=""
 S DIR("?",1)="Because "_NAOUN_" is keeping a perpetual inventory,"
 S DIR("?",2)="Pharmacy Service has set "_$S(PSDR(1):"a maximum quantity of "_PSDR(1)_" "_NBKU_" per order",1:"no maximum order quantity")
 S DIR("?")="for "_PSDRN_"."
 S:PSDR(1) DIR("?")="If you request more than "_PSDR(1)_" "_NBKU_", multiple orders will be generated.",DIR("?",3)="for "_PSDRN_".",DIR("?",4)=""
 D ^DIR K DIR G:Y<1 END S PSDQTY=Y
 ;Quantity ordered is equal to or less than max ord qty
NOMAX I '(Y#NPKG)&('PSDR(1)!(Y'>PSDR(1))) D DIE G:PSDOUT END G DRUG^PSDORD
 ;Quantity ordered is not divisible by package size
 D:(Y#NPKG)  G:$D(DIRUT) END G:Y<1 QTY I 'PSDR(1)!(Y<PSDR(1)) S Y=PSDQTY G NOMAX
 .S PSDQTY=Y-(Y#NPKG)
 .S DIR(0)="S^"_PSDQTY_":"_NBKU_";"_(PSDQTY+NPKG)_":"_NBKU_";*:New Quantity"
 .S DIR("A",1)="Please order "_PSDRN,DIR("A",3)=""
 .S DIR("A",2)="in multiples of "_NPKG_" "_NBKU_".",DIR("B")=PSDQTY
 .S DIR("A")="QUANTITY ("_NBKU_"/"_NPKG_")"
 .S DIR("?")="Enter an adjusted quantity or * to enter a new quantity" D ^DIR K DIR Q:Y<1  S PSDQTY=Y
 S:(PSDQTY#PSDR(1)) CNT=1,PSDR(2)=(PSDQTY#PSDR(1))
 ;Number of orders to generate
 S CNT=$G(CNT)+(PSDQTY\PSDR(1))
 W !!,"This will be "_CNT_" separate order requests,"
 W:PSDR(2) !!,"One order for ",PSDR(2)," ",NBKU,", and"
 W !!,(PSDQTY\PSDR(1))," order"
 W:CNT>2!('PSDR(2)&(CNT=2)) "s"
 W " for ",PSDR(1)," ",NBKU,"."
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want me to generate the "_CNT_" separate order requests",DIR("B")="YES",DIR("?",1)="Answer 'YES' to create the multiple order requests,"
 S DIR("?")="Answer 'NO' to edit your comments or '^' to quit." D ^DIR K DIR G:$D(DIRUT) END
 I 'Y W !,"No order request created.  You must edit quantity.",! G QTY
 I Y W !!,"The "_CNT_" requests are being created.",! S PSDQTY=$S(PSDR(2):PSDR(2),1:PSDR(1)) D  S PSDR(2)=0
 .F ORD=1:1:CNT W !!,"Creating your order request # "_ORD_" of "_CNT_" for "_PSDRN D DIE S PSDA(+PSDR,PSDA)=$G(^PSD(58.8,+NAOU,1,+PSDR,3,+PSDA,0)),PSDQTY=PSDR(1)
 G:'PSDOUT DRUG^PSDORD
END K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K NAOU,NAOUN,NBKU,NPKG,OK,OKTYP,ORD,PSDA,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDS,PSDT,PSDUZ,PSDUZN,REQD,TEXT,TYPE,WORD,X,Y
 Q
DIE ;create the order request
 S:'$D(^PSD(58.8,NAOU,1,PSDR,3,0)) ^(0)="^58.800118A^^"
 S PSDA=$P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)+1 I $D(^PSD(58.8,NAOU,1,PSDR,3,PSDA)) S $P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)=$P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)+1 G DIE
 K DA,DIC,DIE,DD,DR,DO S DIC(0)="L",(DIC,DIE)="^PSD(58.8,"_NAOU_",1,"_PSDR_",3,",DA(2)=NAOU,DA(1)=PSDR,(X,DINUM)=PSDA D FILE^DICN K DIC
 D NOW^%DTC S PSDT=+$E(%,1,12) W ?10,!!,"processing now..."
 S DA=PSDA,DA(1)=PSDR,DA(2)=NAOU,DR="1////"_PSDT_";2////"_+PSDS_";3////"_PSDUZ_";10////.5;5////"_PSDQTY_";13" D ^DIE K DIE,DR
 S PSDA(+PSDR,+PSDA)=$G(^PSD(58.8,+NAOU,1,+PSDR,3,PSDA,0))
 Q
