PSOCAN ;BIR/JMB-Rx discontinue and reinstate ;8/3/06 12:38pm
 ;;7.0;OUTPATIENT PHARMACY;**11,21,24,27,32,37,88,117,131,185,253,251,375**;DEC 1997;Build 17
 ;External reference to File #55 supported by DBIA 2228
 ;External references L, UL, PSOL, and PSOUL^PSSLOCK supported by DBIA 2789
START S WARN=0,(DAYS360,SPCANC)=1 D KCAN1^PSOCAN3 W !! S DIR("A")="Discontinue/Reinstate by Rx# or patient name",DIR(0)="SBO^R:RX NUMBER;P:PATIENT NAME"
 S DIR("?")="Enter 'R' to discontinue/reinstate by Rx#.  Enter 'P' to discontinue/reinstate by patient name." D ^DIR K DIR
 G:$G(DIRUT) KILL^PSOCAN1 K RP S RP=Y G:RP="P" PAT^PSOCAN1
NUM D DCORD^PSONEW2
 K PSOTECCK,RXSP,PSINV,PSOWUN,PSOULRX D KCAN1^PSOCAN3 S:'$D(PSOCLC) PSOCLC=DUZ S PS="Discontinue" W ! S DIR("A")="Discontinue/Reinstate Prescription(s)#"
 S DIR(0)="FO^1:245",DIR("?")="Wand/enter barcode or enter Rx number(s) to discontinued/reinstated. If more than one, separate with commas. Do not exceed 245 characters including commas"
 D ^DIR K DIR G:$G(DIRUT) START S OUT=0 I Y["-" D PSOINST^PSOSUPAT G:OUT NUM S (IN,X)=$P(^PSRX($P(Y,"-",2),0),"^") G NO
 S IN=Y G RX:Y[","
NO I '$O(^PSRX("B",Y,0)) W " Rx Not Found!",! G NUM
 S PSPOP=0,DIC=52,DIC(0)="QEMZ" D ^DIC K DIC Q:$G(POERR)&(Y<0)
 G:Y<0 NUM S (DA,IFN,PSOULRX)=+Y,RXNUM=Y(0,0),PSODFN=+$P(^PSRX(DA,0),"^",2)
 S PSOWUN=1 S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) D LOCK^PSOORCPY K PSOPLCK G NUM
 K PSOPLCK D PSOL^PSSLOCK(IFN) I '$G(PSOMSG) W !!,$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order.") K PSOMSG D ULP G NUM
 I $P($G(^PSRX(+$G(IFN),"STA")),"^")=12,$P($G(^("PKI")),"^") W !!,"Cannot be Reinstated - Digitally Signed" D ULP G NUM
 I $P($G(^PSRX(+$G(IFN),"STA")),"^")=12 S PSOCANRZ=1
 E  S PSOCANRD=+$P($G(^PSRX(+$G(IFN),0)),"^",4)
 D:$P($G(^PS(55,PSODFN,0)),"^",6)'=2 EN^PSOHLUP(PSODFN)
LMNO D CHK S:'$G(DA)&($G(IFN)) DA=IFN
 I DEAD!$P(^PSRX(DA,"STA"),"^")'<13,$P(^("STA"),"^")'=16 S PSINV($P(^PSRX(DA,0),"^"))="" D:$G(PSOWUN) ULP,ULRX G EP1
 I $G(PSODIV),$P($G(^PSRX(DA,2)),"^",9),$P(^(2),"^",9)'=$G(PSOSITE) S RXREC=DA D DIV D:$G(POERR)&(PSPOP) ULP,ULRX Q:$G(POERR)&(PSPOP)  D:$G(PSOWUN)&($G(PSPOP)) ULP,ULRX G:PSPOP NUM
 D ICN^PSODPT(PSODFN)
 S PS=$S($P(^PSRX(DA,"STA"),"^")=12:"Reinstate",1:"Discontinue")
 I '$G(POERR) N PKIR D
 .I $P(^PSRX(DA,"STA"),"^")=1,$P($G(^("PKI")),"^") S PKIR=""
 .D ^PSORXPR
 D YN S:PS="Reinstate" PS="Discontinue" Q:$G(POERR)&('%)
 I '% D ULP,ULRX G NUM
 D REA D:'$D(REA)&($G(PSOWUN)) ULP,ULRX Q:'$D(REA)
 D COM^PSOCAN1 Q:$G(POERR)&('$D(INCOM))!($D(DIRUT))  I '$D(INCOM)!($D(DIRUT)) D ULP,ULRX G NUM
 S RX=$P(^PSRX(DA,0),"^"),PSCAN(RX)=DA_"^"_REA
 D:REA="R" REINS^PSOCAN2
 I REA="R",'$G(PSORX("DFLG")) D DCORD^PSONEW2
 K PSOTECCK
 D:$G(PSORX("DFLG")) ULP,ULRX
 Q:$G(POERR)&($G(PSORX("DFLG")))
 G NUM:$G(PSORX("DFLG"))
 D:REA="C" CAN
 Q:$G(POERR)
 D ULP,ULRX G NUM
YN D EN^PSOCMOPA I $G(XFLAG)]"" S %=0 K XFLAG Q
 W ! S DIR("A")="Are you sure you want to "_PS,DIR(0)="Y",DIR("B")="NO" D ^DIR S %=Y K DIR,DUOUT,DTOUT I 'Y!$D(DIRUT) S VALMBCK="R"
 K DIRUT Q
REA S REA=+$P(^PSRX(DA,"STA"),"^") I REA=12 S REA="R" Q
 I REA,REA'=11 W !?5,$C(7) D
 .W "Rx# "_RXNUM_" was"_$S(REA=1:" Non-Verified",REA=13:" Deleted",REA=11:" Expired",REA=5:" Suspended",REA=4:" Pending Due to Drug Interactions",REA=3:" On Hold",REA=14!(REA=15):"Discontinued",REA=16:" Provider Held",1:" In Fill Status")_"."
 I REA,REA'=1,REA'=3,REA'=5,REA'=11,REA'<13,REA'=16 K REA W !?10,"Rx Cannot Be Discontinued/Reinstated!" Q
 S REA="C" Q
CAN N PSODRUG D CAN1^PSOCAN3 Q
DIV I '$P($G(PSOSYS),"^",2) W !?10,$C(7),"RX# ",$P(^PSRX(DA,0),"^")," is not a valid choice.  (Different Division)" S PSPOP=1 Q
 I $P($G(PSOSYS),"^",3) W !?10,$C(7) S DIR("A")="RX# "_$P(^PSRX(DA,0),"^")_" is from another division.  Continue",DIR(0)="Y",DIR("B")="Y" D ^DIR K DIR S:$G(DIRUT)!('Y) PSPOP=1
 Q
CHK K VADM,DEAD S DFN=PSODFN D DEM^VADPT I $G(VADM(6))="" S DEAD=0 Q
 S (PSODEATH,DEAD)=1 W !!,?10,VADM(1)_" DIED "_$P($G(VADM(6)),"^",2) D CAN^PSOCAN3 K PSODEATH
 Q
RX N PKI S RXCNT=0,RXSP=1 D TESTRP D COM^PSOCAN1 G:'$D(INCOM)!($D(DIRUT)) NUM K PSINV,PSCAN F II=1:1 S (EN,X)=$P(IN,",",II) Q:$P(IN,",",II)']""  S DIC=52,DIC(0)="QMZ" D ^DIC K DIC S:Y'>0 PSINV(X)="" D:Y>0
 .S YY=Y,YY(0,0)=Y(0,0),(PSODFN,DFN)=$P(Y(0),"^",2) D:$P($G(^PS(55,PSODFN,0)),"^",6)'=2 EN^PSOHLUP(PSODFN)
 .D:$G(DFN)>0 CHK I DEAD!($P(^PSRX(+YY,"STA"),"^")=13)!($P(^("STA"),"^")=14) S PSINV(EN)="" Q
 .I $P(^PSRX(+YY,"STA"),"^")=12,$P($G(^("PKI")),"^") S PKI=1,PSINV(EN)="" Q
 .S DA=+YY I $P($G(^PSRX(DA,"STA")),"^")=11!($P($G(^(2)),"^",6)<DT) D EXP
 .S RX=YY(0,0) D:$D(^PSRX(DA,0)) SPEED1^PSOCAN1
 .;S DA=+YY I $P($G(^PSRX(DA,"STA")),"^")=11!($P($G(^(2)),"^",6)<DT) D EXP Q
 .;E  S RX=YY(0,0) D:$D(^PSRX(DA,0)) SPEED1^PSOCAN1
 K YY G:'$D(PSCAN) INVALD^PSOCAN1 S RX="",RXCNT=0 F  S RX=$O(PSCAN(RX)) Q:RX=""  S DA=+PSCAN(RX),REA=$P(PSCAN(RX),"^",2),RXCNT=RXCNT+1  D SHOW^PSOCAN1
ASK Q:'$D(PSCAN)  W ! S DIR("A")="OK to "_$S($G(RXCNT)>1:"Change Status",REA="C":"Discontinued",1:"Reinstate"),DIR(0)="Y",DIR("B")="N"
 N PSOCNRXV S PSOCNRXV=0
 D ^DIR K DIR Q:$G(DIRUT)  I 'Y K PSCAN D INVALD^PSOCAN1 G NUM
 K PSOPLCKZ S RX="" F  S RX=$O(PSCAN(RX)) Q:'RX  D
 .S PSODFN=+$P($G(^PSRX(+PSCAN(RX),0)),"^",2)
 .S PSOPLCK=$$L^PSSLOCK(+$G(PSODFN),0) D:'$G(PSOPLCK)&('$D(PSOPLCKZ(PSODFN))) LOCK^PSOORCPY I '$G(PSOPLCK) S PSOPLCKZ(PSODFN)=PSODFN Q
 .D PSOL^PSSLOCK(+PSCAN(RX)) I '$G(PSOMSG) D  D UL^PSSLOCK(PSODFN) Q
 ..I $P($G(PSOMSG),"^",2)'="" W !,$P($G(PSOMSG),"^",2),!,"Order "_$P($G(^PSRX(+PSCAN(RX),0)),"^")_"." Q
 ..W !,"Another person is editing order "_$P($G(^PSRX(+PSCAN(RX),0)),"^")_"."
 .D ACT D PSOUL^PSSLOCK(+PSCAN(RX)),UL^PSSLOCK(PSODFN)
 .S PSOCNRXV=1
 K PSOPLCKZ W:$G(PSOCNRXV) !,$S($G(RXCNT)>1:"Statuses Changed",REA="C":"Prescription Discontinued",1:"Prescription Reinstated") D INVALD^PSOCAN1 G NUM
ACT S DA=+PSCAN(RX),REA=$P(PSCAN(RX),"^",2),II=RX,PSODFN=$P(^PSRX(DA,0),"^",2) I REA="R" D REINS^PSOCAN2 Q
 D CAN Q
EXP ;S PSINV($P(^PSRX(DA,0),"^"))="" 
 Q:$P(^PSRX(DA,"STA"),"^")=12
 S $P(^PSRX(DA,"STA"),"^")=11 D ECAN^PSOUTL(DA)
 S STAT="SC",PHARMST="ZE",COMM="Medication Expired on "_$E($P(^PSRX(DA,2),"^",6),4,5)_"/"_$E($P(^(2),"^",6),6,7)_"/"_$E($P(^(2),"^",6),2,3) D EN^PSOHLSN1(DA,STAT,PHARMST,COMM) K COMM,STAT,PHARMST
EP1 I '$G(RXSP) D INVALD^PSOCAN1 Q:$G(POERR)  G NUM
 Q
PSD ;Called from Controlled Subs, PSDRX is internal Rx number
 S PSDRFDEL=0
 I '$G(PSDRX)!('$D(^PSRX(+$G(PSDRX),0))) Q
 I $P($G(^PSRX(PSDRX,"STA")),"^")<12 Q
 N DA,NODE,RF,PSOPSDAL,PSODRX,PSODTE,PSODL,SFN,RIFN,PSOSXP,PSOFILDL
 S PSODRX=0 F PSODLP=0:0 S PSODLP=$O(^PSRX(PSDRX,1,PSODLP)) Q:'PSODLP  S:$D(^PSRX(PSDRX,1,PSODLP,0)) PSODRX=PSODLP
 I 'PSODRX Q
 I $P($G(^PSRX(PSDRX,1,PSODRX,0)),"^",18) Q
 D PSDREF I $G(PSOFILDL) K PSOFILDL Q
 K PSOFILDL,DIE S NODE=0,PSOPSDAL=1,DA(1)=PSDRX,DA=PSODRX,DIE="^PSRX("_DA(1)_",1,",DR=".01///@" D ^DIE K DIE
 S PSDRFDEL=1
 Q
PSDREF ;
 N PRDL,PSOCNODE
 S PSOFILDL=0
 F PRDL=0:0 S PRDL=$O(^PSRX(PSDRX,4,PRDL)) Q:'PRDL  I $G(PSODRX)=$P($G(^PSRX(PSDRX,4,PRDL,0)),"^",3) S PSOCNODE=$G(^(0))
 I $G(PSOCNODE)="" Q
 I +$P(PSOCNODE,"^",4)<3 S PSOFILDL=1
 Q
TESTRP ;
 N PIIN,PIINFLAG S PIINFLAG=0 F PIIN=1:1 S X=$P(IN,",",PIIN) Q:$P(IN,",",PIIN)']""  K DIC S DIC=52,DIC(0)="QMZ" D ^DIC K DIC I +$G(Y) D
 .I $P($G(^PSRX(+Y,"STA")),"^")'=12,'$G(PIINFLAG) S PSOCANRD=+$P($G(^PSRX(+Y,0)),"^",4) S PIINFLAG=1
 I '$G(PIINFLAG) S PSOCANRZ=1
 Q
ULP ;
 D UL^PSSLOCK(+$G(PSODFN))
 Q
ULRX ;
 I $G(PSOULRX) D PSOUL^PSSLOCK(PSOULRX)
 Q
