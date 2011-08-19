PSORXDL ;BIR/SAB - Deletes one prescription ;06/10/96
 ;;7.0;OUTPATIENT PHARMACY;**4,17,9,27,117,131,148,201,291**;DEC 1997;Build 2
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External references L, UL, PSOL, and PSOUL^PSSLOCK supported by DBIA 2789
 ;External reference to ^PS(59.7 supported by DBIA 694
 ;External reference to ^PSDRUG( supported by DBIA 221
 I '$D(^XUSEC("PSORPH",DUZ)) W !,$C(7),"Requires Pharmacy Key (PSORPH) !" Q
 I '$D(PSOPAR) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"SITE PARAMETERS MUST BE DEFINED!",! Q
 K DA,PSODEFLG,PSOHLRE,PSOHLDAH,QTY,PSOABCDA,PSOREF
 S (PSDEL,PSOXXDEL)=1,PS="DELETE",DIC("S")="I $P($G(^(0)),""^"",2),$P($G(^(""STA"")),""^"")'=13,$G(^(2))"
 D A1^PSORXVW K DIC("S") I $G(DA)<1 G KILL
 D FULL^VALM1
 S RXN=+$G(DA)
 S PSORXDFN=+$P($G(^PSRX(RXN,0)),"^",2)
 S PSOPLCK=$$L^PSSLOCK(PSORXDFN,0) I '$G(PSOPLCK) D LOCK^PSOORCPY K PSOPLCK G PSORXDL
 K PSOPLCK D PSOL^PSSLOCK(RXN) I '$G(PSOMSG) W !,$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order."),! K PSOMSG D ULP G PSORXDL
 S (REL,PSOGGFL)=0 F PSOGG=0:0 S PSOGG=$O(^PSRX(DA,1,PSOGG)) Q:'PSOGG  S:$D(^PSRX(DA,1,PSOGG,0)) PSOGGFL=PSOGG
 S REL=$S($G(PSOGGFL)&($P($G(^PSRX(DA,1,+$G(PSOGGFL),0)),"^",18))&('$P($G(^(0)),"^",16)):1,'$G(PSOGGFL)&($P($G(^PSRX(DA,2)),"^",13))&('$P($G(^(2)),"^",15)):1,1:0)
 I REL W !!,$S($G(PSOGGFL):"Refill number "_$G(PSOGGFL),1:"The Original Fill")," has already been released for Rx # "_$P($G(^PSRX(DA,0)),"^")
 I REL W !,"Drug: ",$P($G(^PSDRUG(+$P($G(^PSRX(DA,0)),"^",6),0)),"^"),?49,$P($G(^DPT(+$P($G(^PSRX(DA,0)),"^",2),0)),"^")
 I REL W ! K DIR S DIR(0)="Y",DIR("A")="Return this fill to stock and delete the prescription",DIR("B")="N" D  D ^DIR K DIR G:$G(Y)=1 PASS W !!?5,"No Action Taken.",!  D ULK,ULP,KILL G PSORXDL
 .S DIR("?")=" ",DIR("?",1)="Enter 'Y' to return this last fill to stock and continue with the deleting of",DIR("?",2)="this prescription, enter 'N' to exit."
 K DIR S DIR(0)="Y",DIR("A",1)="Are you sure you want to DELETE Rx # "_$P(^PSRX(DA,0),"^"),DIR("A",2)="Drug: "_$P(^PSDRUG($P(^PSRX(DA,0),"^",6),0),"^")
 S DIR("A")="for "_$P(^DPT($P(^PSRX(DA,0),"^",2),0),"^")
 S DIR("B")="NO" D ^DIR D:$D(DTOUT) ULK,ULP G:$D(DTOUT) KILL I $D(DIRUT)!'Y D ULK,ULP,KILL G PSORXDL
PASS N PSORXDAC K PSOXYZF S PSORXDAC=$O(^PS(52.5,"B",DA,0)) I PSORXDAC,$P($G(^PS(52.5,PSORXDAC,0)),"^",7)="L" N PSOXYZ S PSOXYZF=0 W !!,"Please wait, Rx is Loading for CMOP Transmission.." D
 .F PSOXYZ=1:1:5 W "." H 1 I $P($G(^PS(52.5,PSORXDAC,0)),"^",7)'="L" S PSOXYZF=1
 I $G(PSOXYZF)=0 W !!,"Sorry, still loading for CMOP transmission, try again later.",! D ULK,ULP,KILL K PSOXYZF G PSORXDL
 K PSOXYZF
 I $G(REL) S PSOHLRE=REL,PSOHLDAH=$G(DA)
 I $G(REL) S RXP=DA S PSODEFLG=0 D RESK I $G(PSODEFLG) D ULK,ULP,KILL G PSORXDL
 I $G(PSOHLRE) W !!?5,"Deleting prescription..",! S DA=$G(PSOHLDAH),REL=$G(PSOHLRE)
 S PSOABCDA=$G(DA) D NOOR^PSOCAN4 I $D(DIRUT) W " NO ACTION TAKEN!",! D ULK,ULP,KILL G PSORXDL
 S DA=$G(PSOABCDA) K DIR,PSOABCDA S DIR("A")="Comments",DIR("B")="Per Pharmacy Request",DIR(0)="F^5:100" D ^DIR K DIR I $D(DIRUT) W !!?5,"NO ACTION TAKEN!",! D ULK,ULP G KILL
 I $G(PKI1) N INCOM S INCOM=Y D DCV^PSOPKIV1,ULK,ULP G PSORXDL
ENQ S PSOIB=$S($D(^PSRX(DA,"IB")):^PSRX(DA,"IB"),1:0) ;Check if copay
 S RX=^PSRX(DA,0),RXN=DA
 S $P(^PSRX(RXN,"STA"),"^")=13,$P(^PSRX(RXN,"D"),"^")=$G(Y)
 S DA=RXN K ^PSRX("ACP",$P(^PSRX(DA,0),"^",2),+$P(^(2),"^",2),0,DA) D ACT
 S DA=RXN I $G(^PSRX(DA,"H"))]"" K ^PSRX("AH",+$P(^PSRX(DA,"H"),"^"),DA) S ^PSRX(DA,"H")=""
 D EN^PSOHLSN1(DA,"OC","",$P(^PSRX(DA,"D"),"^"),PSONOOR)
 S DA=$O(^PS(52.5,"B",RXN,0)) I DA S DIK="^PS(52.5," D ^DIK
 S DA=RXN I $D(^PS(52.4,RXN)) S DIK="^PS(52.4," D ^DIK
 K PSOABCDA I $G(DA) S PSOABCDA=$G(DA)
 I $O(^PS(52.41,"ARF",RXN,0)) S DA=$O(^PS(52.41,"ARF",RXN,0)),DIK="^PS(52.41," D ^DIK K DA,DIK
 I $G(PSOABCDA) S DA=$G(PSOABCDA)
 I $G(PSOABCDA) S DA=$G(PSOABCDA) K PSOABCDA
 Q:+$G(PSORX("INTERVENE"))!($G(PSVFLAG))  I $D(DA),'$G(PSOZVER) D ULK,ULP G PSORXDL
 S ^PSDRUG(+$P(RX,"^",6),660.1)=$S($D(^PSDRUG(+$P(RX,"^",6),660.1)):^(660.1),1:0)+$P(RX,"^",7)
 S DFN=+$P(RX,"^",2) F I=0:0 S I=$O(^PS(55,DFN,"P",I)) Q:'I  I +^(I,0)=RXN K ^(0) S ^(0)=$P(^PS(55,DFN,"P",0),"^",1,3)_"^"_($P(^(0),"^",4)-1)
 F I=0:0 S I=$O(^PS(55,DFN,"P","A",I)) Q:'I  I $D(^(I,RXN)) K ^(RXN)
 K STAT,COM,RX,RXN Q:+$G(PSORX("INTERVENE"))!($G(PSVFLAG))  I $G(PSDEL) D ULK,ULP G PSORXDL
 ;
KILL K PSORXDFN,PSOMSG,PSOPLCK,RXO,RX0,RX2,RESK,PSIN,PSODEF,PSOPCECT,PSDEL,I,II,J,N,PHYS,PS,RFDATE,RFL,RFL1,ST,ST0,%,%Y,D0,DA,DI,DIC,DIE,DIH,DIU,DIV,DR,Z,DIG,X,Y,PSOIB,RX,RXN,PSODEFLG,PSOREF,PSOHLRE,PSOHLDAH,PSOGG,PSODLCOM,COPAYFLG
 K DIR,RXP,DIRUT,DUOUT,DTOUT,SIGOK,REL,PSONODF,PSONOOR,PSOGGFL,PSOXYZF,TYPE,XTYPE,QDRUG,QTY,PSOWHERE,PSOLOCRL,PSOCPRX,PSODT,PSODA,PSOINVTX,IFN,PSROF,PSOABCDA,PSOXXDEL,PSOPFS
 Q
ACT ;adds activity info for deleted rx
 S (RXF,PSOREF)=0 F I=0:0 S I=$O(^PSRX(RXN,1,I)) Q:'I  S (RXF,PSOREF)=I S:I>5 RXF=I+1 K ^PSRX("ACP",$P(^PSRX(RXN,0),"^",2),$P(^PSRX(RXN,1,I,0),"^"),I,RXN)
 S DA=0 F FDA=0:0 S FDA=$O(^PSRX(RXN,"A",FDA)) Q:'FDA  S DA=FDA
 D NOW^%DTC S DA=DA+1,^PSRX(RXN,"A",0)="^52.3DA^"_DA_"^"_DA,^PSRX(RXN,"A",DA,0)=%_"^"_"D"_"^"_DUZ_"^"_RXF_"^"_"RX DELETED on "_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3)
EX W !,"...PRESCRIPTION #"_$P(RX,"^")_" MARKED DELETED!!"
 K RXF,I,FDA,DIC,DIE,%,%I,%H S DA=RXN
 ; - Sending Refill to ECME for claim REVERSAL (Rx Delete)
 D REVERSE^PSOBPSU1(RXN,PSOREF,"DE",5,,1)
 Q
RESK ;
 S RESK=1,PSIN=+$P(^PS(59.7,1,49.99),"^",2) K PSODEF S PSOPCECT=1
 S PSOLOUD=1 D:$P($G(^PS(55,+$P(^PSRX(RXP,0),"^",2),0)),"^",6)'=2 EN^PSOHLUP($P(^PSRX(RXP,0),"^",2)) K PSOLOUD
 I $S('+$P($G(^PSRX(+RXP,"STA")),"^"):0,$P(^("STA"),"^")=11:0,$P(^("STA"),"^")=12:0,$P(^("STA"),"^")=14:0,$P(^("STA"),"^")=15:0,1:1) D STAT^PSORESK1 S PSODEFLG=1 Q
 W !!?5,"Returning Medication to Stock..",!
 K DIR,PSODLCOM,COM S DIR(0)="F^10:75",DIR("A")="Comments",DIR("?")="Comments are required, 10-75 characters." W ! D ^DIR K DIR S (COM,PSODLCOM)=Y I Y["^"!($D(DIRUT)) W !!,"No Action Taken!",! S PSODEFLG=1 Q
 S QDRUG=+$P($G(^PSRX(RXP,0)),"^",6),QTY=$P($G(^(0)),"^",7) I $O(^PSRX(RXP,1,0)) G REF
 S XTYPE="O" I $P($G(^PSRX(RXP,2)),"^",15) Q
 I $P($G(^PSRX(RXP,2)),"^",2)<$G(PSIN) Q
 K PSOLOCRL,PSOWHERE S PSOLOCRL=$P($G(^PSRX(RXP,2)),"^",13)
 Q:'$G(PSOLOCRL)
 S PSOWHERE=$S($D(^PSRX("AR",$G(PSOLOCRL),RXP,0)):1,1:0)
 I +$G(^PSRX(RXP,"IB"))!($P($G(^PSRX(RXP,"PFS")),"^",2)) S COPAYFLG=1 N PSOPFS S:$P($G(^PSRX(RXP,"PFS")),"^",2) PSOPFS="1^"_$P(^PSRX(RXP,"PFS"),"^",1,2) D CP^PSORESK1 I '$G(COPAYFLG) S PSODEFLG=1 Q
 I $G(^PSDRUG(QDRUG,660.1)),$G(PSOWHERE) D INVT W:$G(PSODEFLG) !!?5,"No Action Taken!",! Q:$G(PSODEFLG)  I $G(PSOINVTX) D INVINC
 I $G(^PSDRUG(QDRUG,660.1)),'$G(PSOWHERE) D INVINC
 I $G(PSOWHERE) K ^PSRX("AR",$G(PSOLOCRL),RXP,0)
 D NOW^%DTC K DIE S DA=RXP,DIE="^PSRX(",DR="31///@;32.1///"_% D ^DIE K DIE
 ;D EN^PSOHLSN1(RXP,"ZD")
 D ACT^PSORESK1
 S DA=$O(^PS(52.5,"B",RXP,0)) I DA K DIK S DIK="^PS(52.5," D ^DIK K DIK
 D EN^PSOHLSN1(RXP,"ZD")
 W !,"Rx # "_$P($G(^PSRX(RXP,0)),"^")_" Returned to Stock.",!
 ; - Sending Rx to ECME for claim REVERSAL (Return to Stock)
 D REVERSE^PSOBPSU1(RXP,0,"RS",4,,1)
 Q
REF ;
 K TYPE F PSROF=0:0 S PSROF=$O(^PSRX(RXP,1,PSROF)) Q:'PSROF  S:$P($G(^PSRX(RXP,1,PSROF,0)),"^") TYPE=PSROF
 I '$G(TYPE) Q
 S XTYPE=1
 I $P($G(^PSRX(RXP,1,TYPE,0)),"^",16) Q
 I '$P($G(^PSRX(RXP,1,TYPE,0)),"^",18) Q
 I '$P($G(^PSRX(RXP,1,TYPE,0)),"^",18),$P($G(^(0)),"^")'<PSIN Q
 S PSOLOCRL=$P($G(^PSRX(RXP,1,TYPE,0)),"^",18)
 Q:'$G(PSOLOCRL)
 S PSOWHERE=$S($D(^PSRX("AR",$G(PSOLOCRL),RXP,TYPE)):1,1:0)
 S QTY=$P($G(^PSRX(RXP,1,TYPE,0)),"^",4)
 I +$G(^PSRX(RXP,"IB"))!($P($G(^PSRX(RXP,1,TYPE,"PFS")),"^",2)) S COPAYFLG=1 N PSOPFS S:$P($G(^PSRX(RXP,1,TYPE,"PFS")),"^",2) PSOPFS="1^"_$P(^PSRX(RXP,1,TYPE,"PFS"),"^",1,2) D CP^PSORESK1 I '$G(COPAYFLG) S PSODEFLG=1 Q
 I $G(^PSDRUG(QDRUG,660.1)),$G(PSOWHERE) D INVT W:$G(PSODEFLG) !!?5,"No Action Taken!",! Q:$G(PSODEFLG)  I $G(PSOINVTX) D INVINC
 I $G(^PSDRUG(QDRUG,660.1)),'$G(PSOWHERE) D INVINC
 I $G(PSOWHERE) K ^PSRX("AR",$G(PSOLOCRL),RXP,TYPE)
 D NOW^%DTC K DIE S DA(1)=RXP,DA=TYPE,DIE="^PSRX("_DA(1)_",1,",DR="17////@;.01///@" W ! D ^DIE K DIE
 ;D EN^PSOHLSN1(RXP,"ZD")
 D ACT^PSORESK1
 S DA=$O(^PS(52.5,"B",RXP,0)) I DA K DIK S DIK="^PS(52.5," D ^DIK K DIK
 D EN^PSOHLSN1(RXP,"ZD") W !,"Rx # "_$P($G(^PSRX(RXP,0)),"^")_" Refill Returned to Stock.",!
 ; - Sending Rx refill to ECME for claim REVERSAL (Return to Stock)
 D REVERSE^PSOBPSU1(RXP,TYPE,"RS",4,,1)
 Q
INVT ;
 S PSOINVTX=0
 K DIR,DIRUT S DIR(0)="Y",DIR("B")="N",DIR("A")="This is a CMOP Rx, do you want to increment the local inventory" D  W ! D ^DIR K DIR S:$D(DIRUT) PSODEFLG=1 Q:$G(PSODEFLG)  I $G(Y)=1 S PSOINVTX=1
 .S DIR("?")=" ",DIR("?",1)="Enter 'Y' if you want to increment the local inventory with the Quantity that",DIR("?",2)="has been released at the CMOP"
 Q
INVINC ;
 S ^PSDRUG(QDRUG,660.1)=$S($P($G(^PSDRUG(QDRUG,660.1)),"^"):$P($G(^PSDRUG(QDRUG,660.1)),"^"),1:0)+$G(QTY)
 Q
 ;
ULK ;
 I $G(RXN) D PSOUL^PSSLOCK(RXN)
 Q
ULP ;
 D UL^PSSLOCK(+$G(PSORXDFN))
 Q
