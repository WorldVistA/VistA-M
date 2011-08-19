PSDRFD ;BIR/JPW,LTL-Nurse RF Dispensing ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 ;S OK=$S($D(^XUSEC("PSJ RNURSE",DUZ)):1,1:0) I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to order",!,?12,"narcotic supplies.",! K OK Q
 ;I $P($G(^VA(200,DUZ,20)),U,4)']"" N XQH S XQH="PSD ESIG" D EN^XQH G END
 S PSDUZ=DUZ,(MSG,MSG1)=0,Y=DT X ^DD("DD") S REQD=Y
NURSE ;N X,X1 D SIG^XUSESIG I X1="" G END
NAOU ;select NAOU to dispense from
 W !!,"Please enter the ward from which the drug(s) will be signed out."
 K DA,DIC S DIC=58.8,DIC(0)="QEA",DIC("A")="Select Ward: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 W ! D ^DIC K DIC G:Y<0 END S NAOU=+Y,NAOUN=$P(Y,"^",2)
 I '$D(^PSD(58.8,NAOU,0)) S MSG=1 D MSG G END
 I '$O(^PSD(58.8,NAOU,1,0)) S MSG=1,MSG1=2 D MSG G END
 I '$P(^PSD(58.8,NAOU,0),U,4) S MSG=2 D MSG G END
 S PSDS=+$P(^PSD(58.8,NAOU,0),"^",4),PSDS=PSDS_"^"_+$P(^PSD(58.8,+PSDS,0),"^",5) I '+PSDS S (MSG,MSG1)=1 D MSG G END
 I '$D(^PSD(58.8,+PSDS,0)) S MSG=2 D MSG G END
 I '$O(^PSD(58.8,+PSDS,1,0)) S MSG=2,MSG1=2 D MSG G END
 ;S TYPE=$P(^PSD(58.8,+PSDS,0),"^",2),OKTYP=$S(TYPE="M":1,TYPE="S":1,1:0) I 'OKTYP W !!,"Contact your Pharmacy Coordinator.",!,"The Pharmacy Dispensing Site is invalid for this NAOU." G END
 ;check to see if NAOU is keeping perpetual inventory
 I '$P($G(^PSD(58.8,NAOU,2)),U,5) W !!,"Sorry, Pharmacy has not set up ",$G(NAOUN)," to keep a perpetual inventory." S XQUIT=1
END W:$G(PSDOUT) !!,"No dose signed out.",$C(7),!! K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K NBKU,NPKG,OK,OKTYP,ORD,PSDA,PSDEM,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDS,PSDT,PSDUZ,PSDUZN,REQD,TEXT,TYPE,WORD,X,Y
 S:'$G(NAOU) XQUIT=1 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"Drug")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 S XQUIT=1 Q
