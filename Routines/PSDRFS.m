PSDRFS ;BIR/JPW,LTL-Nurse RF Delayed Dispensing ;8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**25,50,60**;13 Feb 97
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
 I $D(PSDR),PSDR'=Y D
 .I $D(^PSDRUG(Y)),$D(^PSD(58.8,NAOU,1,Y)) D
 ..S PSDDT=$$FMDIFF^DILIBF(DT,$P(PSD(1),U,4),"")
 ..I PSDDT>365 S PSDR=Y
 .I '$D(^PSDRUG(Y)),$D(PSD(1)) D
 ..S PSDDT=$$FMDIFF^DILIBF(DT,$P(PSD(1),U,4),"")
 ..I PSDDT>365 K PSDR
 .I '$D(^PSDRUG(Y)),'$D(^PSD(58.8,NAOU,1,Y)),'$D(PSDR) W $C(7),!!,"This is not a valid Pharmacy Dispensing number for this ward.",!! G END
 D:'$G(PSDR)  G:$D(DTOUT)!($D(DUOUT)) END G:Y<1 PATIENT
 .S DIC="^PSD(58.8,NAOU,1,",DIC(0)="EMQSZ",DA(1)=NAOU
 .W ! D ^DIC K DIC I $D(DTOUT)!($D(DUOUT))!(Y<1) W $C(7),!!,"This is not a valid Pharmacy Dispensing number for this ward.",!! Q
 .S PSDR=+Y,PSDTYP=17
 I '$G(PSDR) W $C(7),!!,"This is not a valid Pharmacy Dispensing number for this ward.",!! G END
 W:$G(PSDR) !!,$P($G(^PSDRUG(PSDR,0)),U)
 ;S DIC="^PSD(58.81,",DIC(0)="EMQSZ"
 ;S DIC("S")="I $P(^(0),U,11)>3,$P(^(0),U,18)=NAOU"
 ;W ! D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT)) END G:Y<1 PATIENT
 ;S PSDR=$P(Y(0),U,5),PSDPN=$P(Y(0),U,17),PSDTYP=17
BAL S PSDR(1)=$G(^PSD(58.8,NAOU,1,PSDR,0)),OQTY=$P(PSDR(1),U,4)
 I 'OQTY,'$P($G(^PSD(58.81,+$G(PSD),9)),U) W !!,"Sorry, this drug has a zero balance." G DRUG
 ;PSD*3*25 (DAVE B)
 K PSDDAVE D ^PSDRFV I $G(PSDDAVE)=1 K PSDDAVE S PSDOUT=1 G END
 S DIR(0)="Y",DIR("A")="Starting Balance:  "_OQTY_" "_$P(PSDR(1),U,8)_"     Correct count"
 S DIR("B")="Yes",NUR1=DUZ
 S DIR("?")="Answer Yes if the amount on hand equals the starting balance."
 W ! D ^DIR K DIR G:$D(DIRUT) END
 I Y=0 D ^PSDRF2 G:$G(PSDOUT) END S $P(PSDR(1),U,4)=PSDQ(1),OQTY=PSDQ(1),PSDTYP=17
LIQ G:$P($G(^PSD(58.8,+PSDS,1,PSDR,7)),U) ^PSDRFU
QTY S DIR(0)="NA^.01:"_OQTY_":2",DIR("A")="Amount given: "
 S DIR("B")=1 W ! D ^DIR K DIR G:Y'>0 END S (PSDQ,OQTY)=Y
WASTE I PSDQ#1 D  G:$G(PSDOUT) END
 .W ?30,"Amount wasted: ",1-PSDQ#1,! S WQTY=1-PSDQ#1
WIT .S NUR2=$$WITNESS^XUVERIFY("WITNESS")
 .I NUR2=DUZ W !!,"Wait a minute, you can't witness yourself!",$C(7) G WIT
 .I NUR2'>0 S PSDOUT=1 Q
 .W !!,"Thank you, ",$S($P($G(^VA(200,NUR2,.1)),U,4)]"":$P($G(^(.1)),U,4),1:$P($G(^VA(200,NUR2,0)),U)) S PSDQ=PSDQ+(1-PSDQ#1)
 S %DT="AEPRX",%DT(0)="-NOW",%DT("A")="Date/time given: "
 W ! D ^%DT K %DT G:Y<1 END S PSDT=Y D ^PSDRFZ
 ; PSD*3*50 RJS - MODIFY TO CHECK SIGN OUT NURSE AGAINST WITNESS
ADMN S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Nurse that signed out dose: "
 W ! D ^DIC K DIC G:Y<1 END S NUR1=+Y,NUR1(1)=DUZ
 I $D(NUR2),NUR1=NUR2 W !,"Witness and Sign Out Nurse can not be the same person" G:NUR1=NUR2 ADMN
 W !!,"Remaining Balance: ",$P(PSDR(1),U,4)-PSDQ," ",$P(PSDR(1),U,8)
 D UPDAT^PSDRFT G DRUG
END W:$G(PSDOUT) !!,"No dose signed out.",$C(7),!! K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1,NUR2,WQTY
 K NAOU,NAOUN,NBKU,NPKG,OK,OKTYP,ORD,PSDA,PSDEM,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDS,PSDT,PSDUZ,PSDUZN,PSDPN,PSDTYP,OQTY,REQD,TEXT,TYPE,WORD,NUR1,X,Y
 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"Drug")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 Q
