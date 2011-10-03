PSDRFW ;BIR/JPW,LTL-Nurse RF Dispensing ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**25,53,60**;13 Feb 97
 ;Reference to $$WITNESS^XUVERIFY are covered by DBIA #1513
 ;Reference to ^PSD(58.8 are covered by DBIA #2711
 ;Reference to ^PSD(58.81 are covered by DBIA #2808
 ;Reference to ^PSDRUG( are covered by DBIA #221
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
PATIENT W !!,"Wastage can only be recorded within "
 S NAOU(1)=$S($P($G(^PSD(58.8,NAOU,6)),U,2):$P(^(6),U,2),1:12)
 W NAOU(1)," hours after signing out a dose.",!!
 W "(except for PCA syringes and Infusions)"
 N DIC,DTOUT,DUOUT,X,Y,PSDOUT S DIC="^DPT(",DIC(0)="AEMQ"
 S DIC("A")="Scan/Enter Patient: "
 W ! D ^DIC K DIC G:Y<1 END S PAT=+Y
DRUG ;select drug
 N DIR,PSD,PSDA,PSDR,PSDQ,PSDDT
 S DIR(0)="FAO^1:40",DIR("A")="Scan Drug Label or Enter Label # or Drug: "
 W ! D ^DIR K DIR G:$D(DIRUT) END
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
BAL S PSDR(1)=$G(^PSD(58.8,NAOU,1,PSDR,0)),OQTY=$P(PSDR(1),U,4)
 ;PSD*3*25 (DAVE B)
 K PSDDAVE D ^PSDRFV I $G(PSDDAVE)=1 K PSDDAVE S PSDOUT=1 G END
 I '$G(PSDA(1)) W !!,"No doses signed out",!! G END
 S OQTY=$P($G(^PSD(58.81,PSDA(1),0)),U,6)
 I $$FMADD^XLFDT(PSDA(3),"",NAOU(1))<$$NOW^XLFDT W !!,"The last dose was signed out at ",PSDA(2),", over ",NAOU(1)," hours ago.",!!,"It is too late to record wastage.",!! G END
 I PSDA(4)'=DUZ W !!,"Sorry, only the person that signed out the dose can record delayed wastage.",!! G END
 ;S DIR(0)="Y",DIR("A")="Starting Balance:  "_OQTY_" "_$P(PSDR(1),U,8)_"     Correct count"
 ;S DIR("B")="Yes",NUR1=DUZ
 ;S DIR("?")="Answer Yes if the amount on hand equals the starting balance."
 ;W ! D ^DIR K DIR G:$D(DIRUT) END
 ;I Y=0 D ^PSDRF2 G:$G(PSDOUT) END S $P(PSDR(1),U,4)=PSDQ(1),OQTY=PSDQ(1)
QTY S DIR(0)="NA^0:"_OQTY_":2"
 S DIR("A")="Amount actually given at "_PSDA(2)_": "
 W ! D ^DIR K DIR I $D(DIRUT)!(Y=OQTY) S PSDOUT=1 G END
 S PSDQ=Y
WASTE I PSDQ'=OQTY D  G:$G(PSDOUT) END
 .I (OQTY-PSDQ)>1 D  Q:$G(PSDOUT)  G REA
 ..S DIR(0)="N^1:"_(OQTY-PSDQ)_":2",DIR("A")="Amount wasted"
 ..S DIR("B")=OQTY-PSDQ D ^DIR K DIR I $D(DIRUT) S PSDOUT=1 Q
 ..S WQTY=Y S:OQTY-WQTY PSDQ(2)=OQTY-WQTY
 .S WQTY=$S('$G(PSDQ(1)):OQTY-PSDQ,1:PSDQ)
 .W ?55,"Amount wasted: ",WQTY,!
REA .S DIR(0)="58.81,15" D ^DIR K DIR I $D(DIRUT) S PSDOUT=1 Q
 .S PSDRE=Y
WIT .W ! S NUR2=$$WITNESS^XUVERIFY("WITNESS")
 .I NUR2=DUZ W !!,"Wait a minute, you can't witness yourself!",$C(7) G WIT
 .I NUR2'>0 S PSDOUT=1 Q
 .W !!,"Thank you, ",$S($P($G(^VA(200,NUR2,.1)),U,4)]"":$P($G(^(.1)),U,4),1:$P($G(^VA(200,NUR2,0)),U))
 ;VMP OIFO BAY PINES;VGF;PSD*3.0*53;REMOVED CALL TO WASTE^PSDRFR
 D EDIT^PSDRFX
END I $G(PSDQ(1)),$G(PSDOUT) S $P(^PSD(58.81,PSDA(1),0),U,6)=PSDQ
 W:$G(PSDOUT) !!,"No wastage recorded.",$C(7),!! K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1,PSDTYP,NUR2
 K NAOU,NAOUN,NBKU,NPKG,OK,OKTYP,ORD,PAT,PSDA,PSDEM,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRE,PSDRN,PSDS,PSDT,PSDUZ,PSDUZN,PSDPN,REQD,TEXT,TYPE,WQTY,OQTY,PSDQ,WORD,NUR1,X,Y
 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"Drug")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 Q
