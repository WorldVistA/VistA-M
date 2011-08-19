PSODGDG2 ;BIR/RTR-drug drug interaction continued ;8/8/96
 ;;7.0;OUTPATIENT PHARMACY;**27,130,251,375**;DEC 1997;Build 17
 ;External reference to ^DPT supported by DBIA 10035
 ;External references to U, UL, PSOL, and PSOUL^PSSLOCK supported by DBIA 2789
 ;External reference to $$DS^PSSDSAPI supported by DBIA 5424
EN ;Activate or process an Rx
 Q:'$G(DA)
 K ^PS(52.4,"ADI",DA,1),^PSRX(DA,"DRI") F ZZZ=8,9,10 S $P(^PS(52.4,DA,0),"^",ZZZ)=""
 K ZZZ Q
PROC I '$D(PSOPAR) D ^PSOLSET I '$D(PSOPAR) W $C(7),$C(7),!!,"SITE PARAMETERS MUST BE DEFINED !",! G EX
 I '$D(^XUSEC("PSORPH",DUZ)) W $C(7),$C(7),!,"YOU MUST BE A PHARMACIST TO COMPLETE THIS PROCEDURE !",!! Q
 I $P($G(^VA(200,DUZ,20)),"^",4)']"" W $C(7),$C(7),!,"YOU DO NOT HAVE AN ELECTRONIC SIGNATURE CODE !",!! Q
BEG S DIC="^PS(52.4,",DIC(0)="AQXEZ",DIC("S")="I $D(^PS(52.4,""ADI"",+Y))!($D(^PS(52.4,""DW"",+Y)))"
 S DIC("A")=$S($$DS^PSSDSAPI:"Select RX with Order Checks: ",1:"Select RX with Drug Interaction: ")
 S DIC("W")="W ?$X+5,$P(^DPT($P(^PS(52.4,+Y,0),""^"",2),0),""^"")_"" "",?40,$E($P(^(0),""^"",9),1,3)_""-""_$E($P(^(0),""^"",9),4,5)_""-""_$E($P(^(0),""^"",9),6,9)"
 D ^DIC K DIC G:"^"[$E(X)!($D(DTOUT)) EX
ENT S (PSODFN,PSOVRDFN,DFN,PSDFN)=$P(Y(0),"^",2),PPL="",PSONAM=$P(^DPT(PSDFN,0),"^"),(PSONV,PSONVXX,IFN,DGDG)=+Y D STAT G:FLAGST BEG D ^PSOBUILD
 S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) D LOCK^PSOORCPY K PSOPLCK G BEG
 K PSOPLCK D PSOL^PSSLOCK(PSONV) I '$G(PSOMSG) D UL^PSSLOCK(PSODFN) D  K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue" D ^DIR K DIR,PSOMSG G BEG
 .I $P($G(PSOMSG),"^",2)'="" W !!,$P(PSOMSG,"^",2),! Q
 .W !!,"Another person is editing this order.",!
 D PID^VADPT
 K PSODLQT N PSOPOCK S PSOPOCK=1 D DGDGI^PSOVER
 I $G(VERLFLAG) D UL^PSSLOCK(PSOVRDFN) D PSOUL^PSSLOCK(PSONVXX) K VERLFLAG G BEG
 D PACK^PSOVER
 D UL^PSSLOCK(PSOVRDFN),PSOUL^PSSLOCK(PSONVXX)
 W !! G BEG
EX D END^PSOVER K DTOUT,DIRUT,PSORX,PSOVRDFN,PSONVXX Q
 ;
STAT ;
 S FLAGST=0
 S ST00=$P($G(^PSRX(PSONV,"STA")),"^")
 I $P($G(^PSRX(PSONV,2)),"^",6),+$P($G(^PSRX(PSONV,2)),"^",6)<DT,ST00<12 S $P(^PSRX(PSONV,"STA"),"^")=11,ST00=11
 I ST00=1!(ST00=4) Q
 S FLAGST=1
 K DIK S DA=PSONV,DIK="^PS(52.4," D ^DIK K DIK
 I ST00>10,ST00<16,$O(^PS(52.5,"B",PSONV,0)) S DA=$O(^PS(52.5,"B",PSONV,0)),DIK="^PS(52.5," D ^DIK K DIK
 I ST00>10,ST00<16,$G(^PSRX(PSONV,"H"))]"" K:$P(^PSRX(PSONV,"H"),"^") ^PSRX("AH",$P(^PSRX(PSONV,"H"),"^"),PSONV) S ^PSRX(PSONV,"H")=""
 S STEXT=$S(ST00=0:"Active",ST00=2:"Refill",ST00=3:"Hold",ST00=5:"Suspended",ST00=11:"Expired",ST00=12:"Canceled",ST00=13:"Deleted",ST00=14:"Discontinued",ST00=15:"Discontinued (Edit)",ST00=16:"Provider Hold",1:"Unknown")
 I '$G(CLFLAG) W !!?3,"Rx # ",$P($G(^PSRX(PSONV,0)),"^")," has a status of ",STEXT_".",! K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press RETURN to continue" D ^DIR W ! K DIR
 Q
