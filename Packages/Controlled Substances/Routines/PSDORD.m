PSDORD ;BIR/JPW,LTL - Nurse CS Order Request Entry DIR style; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**51**;13 Feb 97
 ;Any requests not ordered?
 K PSD,PSDA,PSDB S PSD=0
 W !,"Searching for ",$P($G(^VA(200,DUZ,.1)),U,4),"'s pending requests."
 F  S PSD=$O(^PSD(58.8,"AC",.5,+NAOU,PSD)) Q:'PSD  D
 .S PSD(1)=0 F  S PSD(1)=$O(^PSD(58.8,"AC",.5,+NAOU,PSD,PSD(1))) Q:'PSD(1)  W "." S:$P($G(^PSD(58.8,+NAOU,1,+PSD,3,PSD(1),0)),U,4)=DUZ PSDA(PSD,PSD(1))=$G(^(0))
 I $O(PSDA(0)) D ^PSDORD1 G:$G(PSDOUT) END
 W:'$O(PSDA(0)) "  No pending requests.",!
DRUG ;select drug
 S MSG=0 ;; PSD*3*51 - RJS
 K DA,DIC,PSDR S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" W $S('$G(^PSD(58.8,NAOU,1,Y,0)):"" NOT STOCKED BY ""_NAOUN,$P(^(0),U,14)&($P(^(0),U,14)'>DT):"" INACTIVE on ""_NAOUN,1:"""")"
 S DIC("S")="I '$P($G(^(7)),U,2),$S('$P(^(0),""^"",14):1,+$P(^(0),""^"",14)>DT:1,1:0)"
 S DA(1)=+PSDS,DIC(0)="QEAM",DIC="^PSD(58.8,"_+PSDS_",1,"
 ;one time requests not allowed by dispensing site
 D:'$P($G(^PSD(58.8,+PSDS,0)),U,13)
 .S DIC("W")="W:$P(^PSDRUG(Y,0),U,9) ""  N/F"" I $P(^PSD(58.8,NAOU,1,Y,0),U,14)]"""",$P(^(0),U,14)'>DT W $C(7),""  *** INACTIVE ***"""
 .S DIC("S")="I $S('$P(^(0),U,14):1,+$P(^(0),U,14)>DT:1,1:0)"
 .S DA(1)=+NAOU,DIC="^PSD(58.8,"_NAOU_",1,"
 D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT)) END G:Y<1&($O(PSDA(0))) ^PSDORD1 G:Y<1 END S PSDR=+Y,PSDRN=$S($P(^PSDRUG(PSDR,0),"^")]"":$P(^(0),"^"),1:"DRUG NAME MISSING")
 I $S('$D(^PSD(58.8,NAOU,1,PSDR,0)):1,$P(^(0),U,14)&($P(^(0),U,14)'>DT):1,1:0) D ^PSDORD4 G:$D(DIRUT) END G DRUG
 I '$D(^PSD(58.8,NAOU,1,PSDR,0)) D MSG G END
 I '$D(^PSD(58.8,+PSDS,1,PSDR,0)) S MSG=2 D MSG G END
 S NBKU=$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",8),NPKG=+$P(^(0),"^",9)
 I NBKU']"" S MSG1=3 D MSG G END
 I 'NPKG S MSG1=4 D MSG G END
 D LIST^PSDORL
 ;Perpetual?
 G:$P($G(^PSD(58.8,+NAOU,2)),U,5) ^PSDORD3
QTY K ORD S PSDOUT=0 S DIR(0)="58.800118,5A"
 S DIR("A")="QUANTITY ("_NBKU_"/"_NPKG_"): ",DIR("B")=NPKG
 D ^DIR K DIR G:$D(DIRUT) END G:Y<1 DRUG
 I Y=NPKG S PSDQTY=Y D DIE W ! G DRUG
 I X["?"!(X'?1.N)!(X#NPKG)!('X) W !!,"Quantity must be "_NPKG_" or a multiple of "_NPKG,! G QTY
 S CNT=X/NPKG W !!,"This will be "_CNT_" separate order requests.  The quantity is "_NPKG_" per request."
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want me to generate the "_CNT_" separate order requests",DIR("B")="YES",DIR("?",1)="Answer 'YES' to create the multiple order requests,"
 S DIR("?")="Answer 'NO' to edit your comments or '^' to quit." D ^DIR K DIR G:$D(DIRUT) END
 I 'Y W !,"No order request created.  You must edit quantity.",! G QTY
 I Y W !!,"The "_CNT_" requests are being created.",! S PSDQTY=NPKG D  W ! G DRUG
 .F ORD=1:1:CNT W !!,"Creating your order request # "_ORD_" of "_CNT_" for "_PSDRN D DIE S PSDA(+PSDR,PSDA)=$G(^PSD(58.8,+NAOU,1,+PSDR,3,+PSDA,0))
 I '$G(PSDOUT) W ! G DRUG
END K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K NAOU,NAOUN,NBKU,NPKG,OK,OKTYP,ORD,PSD,PSDA,PSDB,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDS,PSDT,PSDUZ,PSDUZN,REQD,TEXT,TYPE,WORD,X,Y
 Q
DIE ;create the order request
 S:'$D(^PSD(58.8,NAOU,1,PSDR,3,0)) ^(0)="^58.800118A^^"
 S PSDA=$P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)+1 I $D(^PSD(58.8,NAOU,1,PSDR,3,PSDA)) S $P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)=$P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)+1 G DIE
 K DA,DIC,DIE,DD,DR,DO S DIC(0)="L",(DIC,DIE)="^PSD(58.8,"_NAOU_",1,"_PSDR_",3,",DA(2)=NAOU,DA(1)=PSDR,(X,DINUM)=PSDA D FILE^DICN K DIC
 D NOW^%DTC S PSDT=+$E(%,1,12) W ?10,!!,"processing now..."
 S DA=PSDA,DA(1)=PSDR,DA(2)=NAOU,DR="1////"_PSDT_";2////"_+PSDS_";3////"_PSDUZ_";10////.5;5////"_PSDQTY_";13" D ^DIE K DIE,DR
 S PSDA(+PSDR,+PSDA)=$G(^PSD(58.8,+NAOU,1,+PSDR,3,PSDA,0))
 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"Drug")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 Q
