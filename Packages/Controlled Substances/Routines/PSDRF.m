PSDRF ;BIR/JPW,LTL - Nurse RF Dispensing ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**25,51,60,68**;13 Feb 97;Build 12
 ;Reference to ^PSD(58.8 are covered by DBIA #2711
 ;Reference to ^PSD(58.81 are covered by DBIA #2808
 ;Reference to ^PSDRUG( are covered by DBIA #221
 ;Reference to $$WITNESS^XUVERIFY are covered by DBIA #1513
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 ;S OK=$S($D(^XUSEC("PSJ RNURSE",DUZ)):1,1:0) I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to order",!,?12,"narcotic supplies.",! K OK Q
 I $P($G(^VA(200,DUZ,20)),U,4)']"" N XQH S XQH="PSD ESIG" D EN^XQH G END
 S PSDUZ=DUZ,(MSG,MSG1)=0,Y=DT X ^DD("DD") S REQD=Y
NURSE N X,X1 D SIG^XUSESIG I X1="" G END
NAOU ;select NAOU to dispense from
 I $G(NAOU) S PSDS=+$P(^PSD(58.8,NAOU,0),U,4) G PATIENT
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
PATIENT N DIC,DTOUT,DUOUT,X,Y,PSDOUT S DIC="^DPT(",DIC(0)="AEMQ"
 S DIC("A")="Scan/Enter Patient: "
 W ! D ^DIC K DIC G:Y<1 END S PAT=+Y
DRUG ;select drug
 N DIR,PSD,PSDR,PSDQ,WQTY,PSDDT
 S DIR(0)="FAO^1:40"
 S DIR("A")="Scan Drug Label or Enter Label # or Drug: "
 W ! D ^DIR K DIR G:Y="" PATIENT G:$D(DIRUT) END
 I $L(Y)=1,Y'=" " W $C(7),!!,"Please enter more than one character.",! G DRUG
 I $O(^PSD(58.81,"D",Y,0)) D
 .S PSD=0
 .F  S PSD=$O(^PSD(58.81,"D",Y,PSD)) Q:'PSD  S PSD(1)=$G(^PSD(58.81,PSD,0)) I $P(PSD(1),U,11)>3,$P(PSD(1),U,18)=NAOU S PSDR=$P(PSD(1),U,5),PSDPN=$P(PSD(1),U,17),PSDTYP=17
 I $D(PSDR),PSDR'=Y D  G:$G(PSDEND) END
 .I $D(^PSDRUG(Y)),$D(^PSD(58.8,NAOU,1,Y)) D
 ..S PSDDT=$$FMDIFF^DILIBF(DT,$P(PSD(1),U,4),"")
 ..I PSDDT>365 S PSDR=Y,PSDPN="" ;;<*68 - RJS
 .I '$D(^PSDRUG(Y)),$D(PSD(1)) D
 ..S PSDDT=$$FMDIFF^DILIBF(DT,$P(PSD(1),U,4),"")
 ..I PSDDT>365 K PSDR
 .I '$D(^PSDRUG(Y)),'$D(^PSD(58.8,NAOU,1,Y)),'$D(PSDR) W $C(7),!!,"This is not a valid Pharmacy Dispensing number for this ward.",!! S PSDEND=1
 D:'$G(PSDR)  G:$D(DTOUT)!($D(DUOUT)) END G:Y<1 PATIENT
 .S DIC="^PSD(58.8,NAOU,1,",DIC(0)="EMQSZ",DA(1)=NAOU
 .W ! D ^DIC K DIC I $D(DTOUT)!($D(DUOUT))!(Y<1) W $C(7),!!,"This is not a valid Pharmacy Dispensing number for this ward.",!! Q
 .S PSDR=+Y,PSDTYP=17
 I '$G(PSDR) W $C(7),!!,"This is not a valid Pharmacy Dispensing number for this ward.",!! G END
 W:$G(PSDR) !!,$P($G(^PSDRUG(PSDR,0)),U)
BAL S PSDR(1)=$G(^PSD(58.8,NAOU,1,PSDR,0)),OQTY=$P(PSDR(1),U,4)
 W:'OQTY&$D(Y(0,0)) !,?12,Y(0,0)
 I 'OQTY,'$P($G(^PSD(58.81,+$G(PSD),9)),U) W !!,"Sorry, this drug has a zero balance." G DRUG
 ;PSD*3*25 (DAVE B)
 K PSDDAVE D ^PSDRFV I $G(PSDDAVE)=1 K PSDDAVE S PSDOUT=1 G END
 S DIR(0)="Y",DIR("A")="Starting Balance:  "_OQTY_" "_$P(PSDR(1),U,8)_"     Correct count"
 S DIR("B")="Yes",NUR1=DUZ
 S DIR("?")="Answer Yes if the amount on hand equals the starting balance."
 W ! D ^DIR K DIR G:$D(DIRUT) END
 I Y=0 D ^PSDRF2 G:$G(PSDOUT) END S $P(PSDR(1),U,4)=PSDQ(1),OQTY=PSDQ(1),PSDTYP=17
 G:'$G(PSDS) END
LIQ G:$P($G(^PSD(58.8,+PSDS,1,PSDR,7)),U) ^PSDRFL
QTY S DIR(0)="NA^.01:"_OQTY_":2",DIR("A")="Amount given: "
 S DIR("B")=1 W ! D ^DIR K DIR G:Y'>0 END S (PSDQ,OQTY)=Y
WASTE I PSDQ#1 D  G:$G(PSDOUT) END
 .W ?30,"Amount wasted: ",1-PSDQ#1,! S WQTY=1-PSDQ#1
 .W !,"You have sixty seconds to find a witness.",!
WIT .W:$G(NUR2(1)) !,"OK, sixty more seconds, but that's it.",!
 .S NUR2=$$WITNESS^XUVERIFY("WITNESS"),NUR2(1)=$G(NUR2(1))+1
 .I NUR2=DUZ W !!,"Wait a minute, you can't witness yourself!",$C(7) G WIT
 .G:NUR2'>0&(NUR2(1)<2) WIT I NUR2'>0 S PSDOUT=1 Q
 .W !!,"Thank you, ",$S($P($G(^VA(200,NUR2,.1)),U,4)]"":$P($G(^(.1)),U,4),1:$P($G(^VA(200,NUR2,0)),U)) S PSDQ=PSDQ+(1-PSDQ#1)
 W !!,"Remaining Balance: ",$P(PSDR(1),U,4)-PSDQ," ",$P(PSDR(1),U,8)
 D UPDAT^PSDRF1 G DRUG
END W:$G(PSDOUT) !!,"No dose signed out.",$C(7),!! K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K NAOU,NAOUN,NBKU,NPKG,NUR1,NUR2,OK,OKTYP,ORD,PAT,PSDA,PSDEM,PSDEND,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDS,PSDT,PSDUZ,PSDUZN,OQTY,REQD,TEXT,TYPE,WORD,X,Y
 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"Drug")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 Q
