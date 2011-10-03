PSDORNC ;BIR/JPW,LTL-Nurse CS PCA Order Request Entry ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**20**;13 Feb 97
 ;
 ; Reference to PSDRUG( supported by DBIA # 221
 ; Reference to DD("DD" supported by DBIA # 10017
 ; Reference to PSD(58.8 supported by DBIA # 2711
 ; 
DRUG ;select drug
 K DA,DIC,PSDR
 S DIC("W")="W:$P(^PSDRUG(Y,0),U,9) ""   N/F"" W $S('$G(^PSD(58.8,NAOU,1,Y,0)):""  NOT STOCKED BY ""_NAOUN,$P(^(0),U,14)&($P(^(0),U,14)'>DT):"" INACTIVE on ""_NAOUN,1:"""")"
 S DIC("S")="I '$P($G(^(7)),U,2),$P($G(^(7)),U,3),$S('$P(^(0),""^"",14):1,+$P(^(0),""^"",14)>DT:1,1:0)"
 S DA(1)=+PSDS,DIC(0)="QEAM",DIC="^PSD(58.8,"_+PSDS_",1,"
 ;no one-time requests allowed by dispensing site
 D:'$P($G(^PSD(58.8,+PSDS,0)),U,13)
 .S DIC("W")="W:$P(^PSDRUG(Y,0),U,9) ""  N/F"" I $P(^PSD(58.8,NAOU,1,Y,0),U,14)]"""",$P(^(0),U,14)'>DT W $C(7),""  *** INACTIVE ***"""
 .S DIC("S")="I $S('$P(^(0),U,14):1,+$P(^(0),U,14)>DT:1,1:0)"
 .S DA(1)=+NAOU,DIC="^PSD(58.8,"_NAOU_",1,"
 D ^DIC K DIC G:Y<0 END S PSDR=+Y,PSDRN=$S($P(^PSDRUG(PSDR,0),"^")]"":$P(^(0),"^"),1:"DRUG NAME MISSING")
 ;zero balance in vault
 I '$P($G(^PSD(58.8,+PSDS,1,PSDR,0)),U,4) D ENS^%ZISS W IOBON,!!,?20,"ZERO BALANCE IN PHARMACY",IOBOFF D KILL^%ZISS
 I $S('$D(^PSD(58.8,NAOU,1,PSDR,0)):1,$P(^(0),U,14)&($P(^(0),U,14)'>DT):1,1:0) D ^PSDORNO G:$D(DIRUT) END G PAT^PSDORNV
 I '$D(^PSD(58.8,+PSDS,1,PSDR,0)) S MSG=2 D MSG G END
 S NBKU=$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",8),NPKG=+$P(^(0),"^",9)
 I NBKU']"" S MSG1=3 D MSG G END
 I 'NPKG S MSG1=4 D MSG G END
 D LIST^PSDORL
 ;Perpetual?
 G:$P($G(^PSD(58.8,+NAOU,2)),U,5) ^PSDOR2
QTY K ORD S PSDOUT=0 W !!,"QUANTITY ("_NBKU_"/"_NPKG_"): "_NPKG_"// " R X:DTIME S PSDT(8)=X I '$T!(X["^") G END
 S DIR(0)="DA^NOW::AEFT",DIR("A")="Date/time required: "
 S DIR("?",1)="You are on the verge of creating a priority order."
 S DIR("?",2)="If this is a mistake, enter ""^"" to create a scheduled order, otherwise,"
 S DIR("?")="Pharmacy needs to know how soon you need this order."
 W ! D ^DIR K DIR G:$D(DIRUT) DRUG X ^DD("DD") S PSDT(9)=Y
 S:PSDT(8)="" PSDT(8)=NPKG I PSDT(8)=NPKG S PSDQTY=NPKG,CNT=0 D DIE^PSDORN0 G:$G(PSDOUT) END D ASK^PSDORN1 K PSDEM G:PSDOUT END G DRUG
 I PSDT(8)["?"!(PSDT(8)'?1.N)!(PSDT(8)#NPKG)!('PSDT(8)) W !!,"Quantity must be "_NPKG_" or a multiple of "_NPKG,! G QTY
 S CNT=PSDT(8)/NPKG W !!,"This will be "_CNT_" separate order requests.  The quantity is "_NPKG_" per request."
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want me to generate the "_CNT_" separate order requests",DIR("B")="YES",DIR("?",1)="Answer 'YES' to create the multiple order requests,"
 S DIR("?")="Answer 'NO' to edit your comments or '^' to quit." D ^DIR K DIR G:$D(DIRUT) END
 I 'Y W !,"No order request created.  You must edit quantity.",! G QTY
 I Y W !!,"The "_CNT_" requests are being created.  You must review every request.",! S PSDQTY=NPKG D  G:$G(PSDOUT) END D ^PSDORN1
 .F ORD=1:1:CNT W !!,"Creating your order request # "_ORD_" of "_CNT_" for "_PSDRN D DIE^PSDORN0 Q:$G(PSDOUT)  S ORD(ORD)=PSDA
 G:'PSDOUT DRUG
END K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K NAOUN,NBKU,NPKG,OK,OKTYP,ORD,PSDA,PSDEM,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDT,PSDUZ,PSDUZN,REQD,TEXT,TYPE,WORD,X,Y
 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"Drug")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 Q
