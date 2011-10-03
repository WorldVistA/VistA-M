PSDEM4 ;BIR/JPW,LTL-Nurse CS Priority Order Status; 25 Apr 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S PSDUZ=DUZ,(MSG,MSG1)=0,Y=DT X ^DD("DD") S REQD=Y
NAOU ;select NAOU to check priority orders for
 K DA,DIC S DIC=58.8,DIC(0)="QEA",DIC("A")="Select Ordering NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 W ! D ^DIC K DIC G:Y<0 END S NAOU=+Y,NAOUN=$P(Y,"^",2)
 I '$D(^PSD(58.8,NAOU,0)) S MSG=1 D MSG G END
 I '$O(^PSD(58.8,NAOU,1,0)) S MSG=1,MSG1=2 D MSG G END
 S PSDS=+$P(^PSD(58.8,NAOU,0),"^",4),PSDS=PSDS_"^"_+$P(^PSD(58.8,+PSDS,0),"^",5) I '+PSDS S (MSG,MSG1)=1 D MSG G END
 I '$D(^PSD(58.8,+PSDS,0)) S MSG=2 D MSG G END
 I '$O(^PSD(58.8,+PSDS,1,0)) S MSG=2,MSG1=2 D MSG G END
 S TYPE=$P(^PSD(58.8,+PSDS,0),"^",2),OKTYP=$S(TYPE="M":1,TYPE="S":1,1:0) I 'OKTYP W !!,"Contact your Pharmacy Coordinator.",!,"The Pharmacy Dispensing Site is invalid for this NAOU." G END
LOOP S PSDT=DT
 W:$O(^PSD(58.81,"AEM",DT)) !!,"Today's Priority Orders:"
 F  S PSDT=$O(^PSD(58.81,"AEM",PSDT)) Q:'PSDT  S PSDT(1)=0 F  S PSDT(1)=$O(^PSD(58.81,"AEM",PSDT,+PSDS,PSDT(1))) Q:'PSDT(1)  S PSDT(2)=0 F  S PSDT(2)=$O(^PSD(58.81,"AEM",PSDT,+PSDS,PSDT(1),PSDT(2))) Q:'PSDT(2)  D
 .S PSDT(3)=$G(^PSD(58.81,PSDT(2),0)) Q:$P(PSDT(3),U,18)'=NAOU
 .S PSDT(4)=PSDT(2)
 .W !!,$P($G(^PSDRUG(PSDT(1),0)),U),"  ",$P(PSDT(3),U,6)," "
 .W $P($G(^PSD(58.8,+PSDS,1,PSDT(1),0)),U,8)
 .W !,$P($G(^PSD(58.82,$P(PSDT(3),U,11),0)),U)
 W:'$G(PSDT(4)) !!,"No Priority Orders ready for ",NAOUN,"."
END K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K NAOU,NAOUN,NBKU,NPKG,OK,OKTYP,ORD,PSDA,PSDEM,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDS,PSDT,PSDUZ,PSDUZN,REQD,TEXT,TYPE,WORD,X,Y
 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"Drug")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 Q
