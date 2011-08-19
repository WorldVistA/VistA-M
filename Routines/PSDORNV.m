PSDORNV ;BIR/JPW,LTL-Nurse CS Infusion Order Request Entry ;12/14/99  16:36
 ;;3.0; CONTROLLED SUBSTANCES ;**20**;13 Feb 97
 ;
 ; Reference to XUSEC( supported by DBIA # 10076
 ; Reference to VA(200 supported by DBIA # 10060
 ; Reference to DD("DD" supported by DBIA # 10017
 ; Reference to DPT( supported by DBIA # 10035
 ; Reference to PS(52.6 supported by DBIA # 1880
 ; Reference to PS(52.7 supported by DBIA # 3013
 ; Reference to PSDRUG( supported by DBIA # 221
 ; Reference to $$FMADD^XLFDT( supported by DBIA # 10103
 ; Reference to DD(52.6 supported by DBIA # 10154
 ; Reference to PSD(58.8 supported by DBIA # 2711
 ; Reference to PSD(58.81 supported by DBIA # 2808
 ; Line tag ENHS^PSJEEU0 supported by DBIA # 486
 ; Line tag EN^XQH supported by DBIA # 10074
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RNURSE",DUZ)):1,$D(^XUSEC("PSJ RPHARM",DUZ)):2,$D(^XUSEC("PSJ PHARM TECH",DUZ)):2,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Coordinator for access to order",!,?12,"narcotic supplies.",!!,"PSJ RNURSE, PSJ RPHARM, or PSJ PHARM TECH security key required.",! K OK Q
 I $P($G(^VA(200,DUZ,20)),U,4)']"" N XQH S XQH="PSD ESIG" D EN^XQH G END
 G:OK=2 ^PSDORP
 S PSDUZ=DUZ,(MSG,MSG1)=0,Y=DT X ^DD("DD") S REQD=Y
NAOU ;select NAOU to order supplies for
 K DA,DIC S DIC=58.8,DIC(0)="QEA",DIC("A")="Select Ordering NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 W ! D ^DIC K DIC G:Y<0 END S NAOU=+Y,NAOUN=$P(Y,"^",2)
 I '$D(^PSD(58.8,NAOU,0)) S MSG=1 D MSG G END
 I '$O(^PSD(58.8,NAOU,1,0)) S MSG=1,MSG1=2 D MSG G END
 S PSDS=+$P(^PSD(58.8,NAOU,0),"^",4)
 S:PSDS PSDS=PSDS_"^"_+$P(^PSD(58.8,+PSDS,0),"^",5)
 I '+PSDS S (MSG,MSG1)=1 D MSG G END
 I '$D(^PSD(58.8,+PSDS,0)) S MSG=2 D MSG G END
 I '$O(^PSD(58.8,+PSDS,1,0)) S MSG=2,MSG1=2 D MSG G END
 S TYPE=$P(^PSD(58.8,+PSDS,0),"^",2),OKTYP=$S(TYPE="M":1,TYPE="S":1,1:0) I 'OKTYP W !!,"Contact your Pharmacy Coordinator.",!,"The Pharmacy Dispensing Site is invalid for this NAOU." G END
 K ^UTILITY($J,"W") W ! N X,DIWL,DIWR,DIWF,PSD
 S PSD=0,DIWL=1,DIWR=80,DIWF="W",X="IORVON;IORVOFF" D ENDR^%ZISS W IORVON
 F  S PSD=$O(^PSD(58.8,+PSDS,5,PSD)) Q:'PSD  S X=$G(^PSD(58.8,+PSDS,5,PSD,0)) D ^DIWP
 D ^DIWW W IORVOFF D KILL^%ZISS
PAT N DFN,DIC,DTOUT,DUOUT,X,Y,PAT,PSDOUT S DIC="^DPT(",DIC(0)="AEMQ"
 S DIC("A")="Scan/Enter Patient: "
 W ! D ^DIC K DIC G:Y<1 END S (DFN,PAT)=+Y
PCA S DIR(0)="S^I:Infusion;P:PCA Syringe" W ! D ^DIR K DIR G:$D(DIRUT) END
 I Y="P" D ^PSDORNC G PAT
 W !!,"Checking for active Controlled Substance IV orders."
 D ENHS^PSJEEU0 K ^UTILITY("PSG",$J),^TMP("PSG",$J) S PSD(1)=0
 F  S PSD=$O(^UTILITY("PSIV",$J,PSD)) Q:'PSD  F  S PSD(1)=$O(^UTILITY("PSIV",$J,PSD,"A",PSD(1))) Q:'PSD(1)  S PSD(2)=$G(^UTILITY("PSIV",$J,PSD,"A",PSD(1))) D:$P($G(^PSDRUG(+$P($G(^PS(52.6,+$P(PSD(2),U),0)),U,2),2)),U,3)["N"
 .W !,$P($P(PSD(2),U),";",2)," ",$P(PSD(2),U,2),"  "
 .W $P($P($G(^UTILITY("PSIV",$J,PSD,"S",PSD(1))),U),";",2)," ",$P($G(^(PSD(1))),U,2)
 F  S PSD=$O(^TMP("PSIV",$J,PSD)) Q:'PSD  F  S PSD(1)=$O(^TMP("PSIV",$J,PSD,"A",PSD(1))) Q:'PSD(1)  S PSD(2)=$G(^TMP("PSIV",$J,PSD,"A",PSD(1))) D:$P($G(^PSDRUG(+$P($G(^PS(52.6,+$P(PSD(2),U),0)),U,2),2)),U,3)["N"
 .W !,$P($P(PSD(2),U),";",2)," ",$P(PSD(2),U,2),"  "
 .W $P($P($G(^TMP("PSIV",$J,PSD,"S",PSD(1))),U),";",2)," ",$P($G(^(PSD(1))),U,2)
 K ^UTILITY("PSIV",$J),^TMP("PSIV",$J)
DRUG ;select drug
 W !
 K DA,DIC,PSDR
 S DIC="^PS(52.6,",DIC(0)="AEMQZ",DIC("A")="Select the primary Controlled Substance for this infusion: ",DIC("S")="I $P($G(^PSDRUG(+$P($G(^PS(52.6,+Y,0)),U,2),2)),U,3)[""N"""
 D ^DIC K DIC G:Y<0 END S PSDR=$P(Y(0),U,2),(PSDR(1),PSDR(2))=Y(0),PSDRN=$S($P(^PSDRUG(PSDR,0),"^")]"":$P(^(0),"^"),1:"DRUG NAME MISSING")
 ;zero balance in vault
 I '$P($G(^PSD(58.8,+PSDS,1,PSDR,0)),U,4) D ENS^%ZISS W IOBON,!!,?20,"ZERO BALANCE IN PHARMACY",IOBOFF D KILL^%ZISS
 ;I $S('$D(^PSD(58.8,NAOU,1,PSDR,0)):1,$P(^(0),U,14)&($P(^(0),U,14)'>DT):1,1:0) D ^PSDORNO G:$D(DIRUT) END G TYPE
 I '$D(^PSD(58.8,+PSDS,1,PSDR,0)) S MSG=2 D MSG G END
 S NBKU=$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",8),NPKG=+$P(^(0),"^",9)
 I NBKU']"" S MSG1=3 D MSG G END
 I 'NPKG S MSG1=4 D MSG G END
 D LIST^PSDORL
CHEC W !,"Checking for the last order for ",$P($G(^DPT(PAT,0)),U),".",!
 N PSD
 S PSD=$$FMADD^XLFDT(DT,-1)
 F  S PSD=$O(^PSD(58.81,"ACT",PSD)) Q:'PSD  S PSD(1)=0 F  S PSD(1)=$O(^PSD(58.81,"ACT",PSD,+PSDS,PSDR,2,PSD(1))) Q:'PSD(1)  I $P($G(^PSD(58.81,PSD(1),9)),U)=PAT S PSD(2)=PSD(1) S PSD(3)=$G(^PSD(58.81,PSD(1),0))
 I $G(PSD(3)) S PSDT(8)=$P(PSD(3),U,6),PSDR(1)=$P($G(^PSD(58.81,+PSD(2),2,1,0)),U)
QTY K ORD S PSDOUT=0
 ;W ! S DIR(0)="58.85,5A"
 ;S DIR("A")="QUANTITY ("_NBKU_"/"_NPKG_"): "
 ;S:$G(PSDT(8)) DIR("B")=$G(PSDT(8))
 ;D ^DIR K DIR G:$D(DIRUT) END
 D:$G(PSD(3))  G:$D(DIRUT) DRUG
 .K ^UTILITY($J,"W") W ! N X,DIWL,DIWR,DIWF,PSD1
 .S PSD1=0,DIWL=1,DIWR=80,DIWF="W"
 .F  S PSD1=$O(^PSD(58.81,PSD(2),2,PSD1)) Q:'PSD1  S X=$G(^PSD(58.81,PSD(2),2,PSD1,0)) D ^DIWP
 .D ^DIWW
 .S DIR(0)="Y",DIR("A")="Change" D ^DIR K DIR S PSD(4)=Y
 I $G(PSD(4))']""!($G(PSD(4))=1) D  G:$D(DIRUT)!($G(Y)<1) DRUG
 .S PSDT(8)=0,Y=$P(PSDR(2),U,3),C=$P(^DD(52.6,2,0),U,2) D Y^DIQ
 .S PSDR(1)=Y,DIR(0)="NA^0:99999:3",DIR("A")="Dosage in "_PSDR(1)_"s: "
 .W ! D ^DIR K DIR Q:$D(DIRUT)  S PSDR(1)=Y_" "_PSDR(1)
 .S DIC="^PS(52.7,",DIC(0)="AEMQZ" W ! D ^DIC K DIC Q:Y<1
 .S PSDR(1)=PSDR(1)_" in "_$P(Y(0),U,3)_" of "_$P(Y,U,2) W PSDR(1)
 S DIR(0)="DA^NOW::AEFT",DIR("A")="Date/time required: "
 S DIR("?",1)="You are on the verge of creating a priority order."
 S DIR("?",2)="If this is a mistake, enter ""^"" to create a scheduled order, otherwise,"
 S DIR("?")="Pharmacy needs to know how soon you need this order."
 W ! D ^DIR K DIR G:$D(DIRUT) DRUG X ^DD("DD") S PSDT(9)=Y
 S PSDQTY=PSDT(8),CNT=0 D DIE^PSDORN0 G:$G(PSDOUT) END D ^PSDORN2 K PSDEM G:PSDOUT END G PAT
 I PSDT(8)["?"!(PSDT(8)'?1.N)!(PSDT(8)#NPKG)!('PSDT(8)) W !!,"Quantity must be "_NPKG_" or a multiple of "_NPKG,! G QTY
 S CNT=PSDT(8)/NPKG W !!,"This will be "_CNT_" separate order requests.  The quantity is "_NPKG_" per request."
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want me to generate the "_CNT_" separate order requests",DIR("B")="YES",DIR("?",1)="Answer 'YES' to create the multiple order requests,"
 S DIR("?")="Answer 'NO' to edit your comments or '^' to quit." D ^DIR K DIR G:$D(DIRUT) END
 I 'Y W !,"No order request created.  You must edit quantity.",! G QTY
 I Y W !!,"The "_CNT_" requests are being created.  You must review every request.",! S PSDQTY=NPKG D  G:$G(PSDOUT) END D ^PSDORN1
 .F ORD=1:1:CNT W !!,"Creating your order request # "_ORD_" of "_CNT_" for "_PSDRN D DIE^PSDORN0 Q:$G(PSDOUT)  S ORD(ORD)=PSDA
 G:'PSDOUT DRUG
END K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K NAOU,NAOUN,NBKU,NPKG,OK,OKTYP,ORD,PSDA,PSDEM,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDS,PSDT,PSDUZ,PSDUZN,REQD,TEXT,TYPE,WORD,X,Y
 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"Drug")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 Q
