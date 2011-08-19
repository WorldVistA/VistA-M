PSOCAN1 ;BIR/BHW - modular rx cancel with speed cancel ability ;2/22/93
 ;;7.0;OUTPATIENT PHARMACY;**8,20,24,27,32,131,163,185,238**;DEC 1997
 ;External reference to File #55 supported by DBIA 2228
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^DPT supported by DBIA 10035
 ;External references L, PSOL, and PSOUL^PSSLOCK supported by DBIA 2789
 ;
PAT S RXCNT=0 K X,PSODFN,ASKED,BC,DELCNT,WARN W ! S DIR("A")="Are you entering the patient name or barcode",DIR(0)="SBO^P:Patient Name;B:Barcode"
 S DIR("?")="Enter a P if you are going to enter the patient name.  Enter a B if you are going to enter or wand the barcode."
 D ^DIR K DIR G:$D(DIRUT) ^PSOCAN S BC=Y
BC D KCAN1^PSOCAN3 S OUT=0 I BC="B" W ! S DIR("A")="Enter/wand barcode",DIR(0)="FO^5:20",DIR("?")="Enter the barcode number or wand the barcode to discontinue all prescriptions for one patient" D ^DIR K DIR G:$G(DIRUT) PAT S BCNUM=Y D
 .D PSOINST^PSOSUPAT Q:OUT  S RX=$P(BCNUM,"-",2) D:$D(^PSRX(RX,0))
 ..S PSODFN=$P(^PSRX(RX,0),"^",2) W " ",$P($G(^DPT(PSODFN,0)),"^")
 ..D ICN^PSODPT(PSODFN)
 .I '$D(^PSRX(RX,0)) W !,$C(7),"No Prescription record for this barcode." S OUT=1
 G:OUT BC
NAM D KCAN^PSOCAN3 S PSOCANRA=1 I BC="P" W ! S DIC(0)="AEMZQ",DIC="^DPT(" D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<0) PAT S PSODFN=+Y S PSOLOUD=1 D:$P($G(^PS(55,PSODFN,0)),"^",6)'=2 EN^PSOHLUP(PSODFN) K PSOLOUD
 N PSONEW,PSORX S PSFROM="N" D CHK^PSOCAN G:DEAD NAM K PSOSD D ^PSOBUILD S PSOOPT=-1 D ^PSODSPL G:'$D(PSOSD) NAM
 S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) D LOCK^PSOORCPY K PSOPLCK G PAT
 W ! S DIR("A")="Discontinue all or specific Rx#'s?",DIR(0)="SBO^A:ALL Rx's;S:SPECIFIC Rx's"
 S DIR("?")="Enter the letter A for all listed Rx's OR the letter for specific Rx's." D ^DIR K DIR I $D(DIRUT) D ULP^PSOCAN G PAT
 S ALL=Y G:Y="S" LINE D RTESTA D COM I '$D(INCOM)!($D(DIRUT)) D ULP^PSOCAN G NAM
 K PSOSDX,PSOSDXY,PENCAN,PSOCANPN S SPEED=1,(DRG,DRUG,IN,STA)="",II=0 F  S STA=$O(PSOSD(STA)) Q:STA=""  F  S DRUG=$O(PSOSD(STA,DRUG)) Q:DRUG=""  S II=II+1,DRG=DRUG D
 .I STA="PENDING" S DA=$P(PSOSD(STA,DRG),"^",10) S PSOSDX(DA)="" Q
 .;PSO*7*238
 .I STA="ZNONVA" D  Q
 ..D NOW^%DTC
 ..N TMP
 ..S TMP(55.05,PSOOI_","_PSODFN_",",5)=1
 ..S TMP(55.05,PSOOI_","_PSODFN_",",6)=%
 ..D FILE^DIE("","TMP")
 .S PSOCANPN=1
 .D PSPEED
 K SPEED D ASK D:$G(REA)="C"&('$G(PSOSDXY))&($O(PSOSDX(0)))&($G(PSOCANPN))  D:'$G(PSOCANPN)  K PSOCANPN,PSOSDX,PSOSDXY,PENCAN D ULP^PSOCAN G PAT
 .S PENCAN="" F  S PENCAN=$O(PSOSDX(PENCAN)) Q:'PENCAN  S DA=PENCAN D PSOL^PSSLOCK(DA_"S") I $G(PSOMSG) D PEN,PSOUL^PSSLOCK(DA_"S")
LINE W !! S DIR(0)="LO^1:"_$S($G(PSOHI):PSOHI,1:PSOSD),DIR("A")="ENTER THE LINE #",DIR("?",1)="Enter the line number(s) displayed to the left of the Rx#."
 S DIR("?",2)="   Separate the numbers with commas (Example: 3,8,10,7),",DIR("?",3)="   OR a dash (Example: 12-20), OR a combination of commas and",DIR("?",4)="   dashes (Example: 3-5,1,12)."
 S DIR("?")="Do not exceed 245 characters including commas and dashes." D ^DIR K DIR D:$D(DIRUT) ULP^PSOCAN G:$G(DIRUT) KILL I Y["." W !?53,$C(7),"INVALID LINE NUMBER(S)." G LINE
 S LINE=Y K PSCAN,PSOCAN S (DRG,IN,STA)="",CNT=0
 F  S STA=$O(PSOSD(STA))  Q:STA=""  F  S DRG=$O(PSOSD(STA,DRG)) Q:DRG=""  S CNT=CNT+1,PSOCAN(CNT)=$S(STA'="PENDING":$P(PSOSD(STA,DRG),"^"),1:$P(PSOSD(STA,DRG),"^",10)_"^P")
 F CNT=1:1 S PLINE=$P(LINE,",",CNT) Q:'$P(LINE,",",CNT)  S IN=$S(IN="":PSOCAN(PLINE),1:IN_","_PSOCAN(PLINE))
 D RTEST D SPEED D ULP^PSOCAN G:BC="P" NAM G:BC="B" BC
PSPEED S (YY,DA)=$P(PSOSD(STA,DRG),"^"),RX=$P($G(^PSRX(DA,0)),"^") D SPEED1 Q:PSPOP!($D(PSINV(RX)))
 Q:$G(SPEED)&(REA="R")
SHOW S DRG=+$P(^PSRX(DA,0),"^",6),DRG=$S($D(^PSDRUG(DRG,0)):$P(^(0),"^"),1:"")
PSHOW S LC=0 W !,$P(^PSRX(DA,0),"^"),"  ",DRG,?52,$S($D(^DPT(+$P(^PSRX(DA,0),"^",2),0)):$P(^(0),"^"),1:"PATIENT UNKNOWN")
 I REA="C" W !?25,"Rx to be Discontinued",! G SHOW1
 W !?21,"*** Rx to be Reinstated ***",!
SHOW1 ;S LC=LC+3 I LC>20 R !,"Press return to continue",X:DTIME G:X'="" SHOW1 S LC=0
 I $Y+4>IOSL K DIR,DUOUT,DTOUT,DIRUT S DIR(0)="E",DIR("A")="Press Return to Continue",DIR("?")="Press Return to continue Listing Orders" D ^DIR K DIR,DTOUT,DIRUT,DUOUT W @IOF
 Q
SPEED1 S PSPOP=0 I $G(PSODIV),+$P($G(^PSRX(DA,2)),"^",9)'=$G(PSOSITE) D:'$G(SPEED) DIV^PSOCAN
 K STAT S STAT=+$P(^PSRX(DA,"STA"),"^"),REA=$E("C00CCCCCCCCCR000C",STAT+1)
 Q:$G(SPEED)&(REA="R")
 I REA="R",$P($G(^PSRX(DA,"PKI")),"^") S PKI=1 S PSINV(RX)="" Q
 I REA=0!(PSPOP)!($P(^PSRX(+YY,"STA"),"^")>12),$P(^("STA"),"^")<16 S PSINV(RX)="" Q
 S:REA'=0&('PSPOP) PSCAN(RX)=DA_"^"_REA,RXCNT=$G(RXCNT)+1
 Q
AREC S:'$G(DEAD) REA=$S($G(REA)="L":"L",1:$P(PSCAN($P(^PSRX(DA,0),"^")),"^",2)) S ACNT=0 F SUB=0:0 S SUB=$O(^PSRX(DA,"A",SUB)) Q:'SUB  S ACNT=SUB
 S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(DA,1,RF)) Q:'RF  S RFCNT=RF S:RF>5 RFCNT=RF+1
 D NOW^%DTC S ^PSRX(DA,"A",0)="^52.3DA^"_(ACNT+1)_"^"_(ACNT+1) S ^PSRX(DA,"A",ACNT+1,0)=%_"^"_REA_"^"_DUZ_"^"_RFCNT_"^"_$S($G(MSG)]"":MSG,1:$G(ACOM)_$G(INCOM)) S ACOM=""
 I $D(PKIR) N J S J=ACNT+2 D ADR^PSOPKIV1
 D EXP^PSOHELP1
 Q
SPEED D COM Q:'$D(INCOM)!($D(DIRUT))  N PKI K PSINV,PSCAN F II=1:1 S DA=$P(IN,",",II) Q:'$P(IN,",",II)  D
 .I $P(DA,"^",2)="P" S DA=+DA D  Q
 ..D PSOL^PSSLOCK(DA_"S") I $G(PSOMSG) D PEN D PSOUL^PSSLOCK(DA_"S")
 .I $D(^PSRX(DA,0)) S YY=DA,RX=$P(^(0),"^") S:DA<0 PSINV(RX)="" D:DA>0 SPEED1
 G:'$D(PSCAN) INVALD S II="",RXCNT=0 F  S II=$O(PSCAN(II)) Q:II=""  S DA=+PSCAN(II),REA=$P(PSCAN(II),"^",2),RXCNT=RXCNT+1  D SHOW
 ;
ASK G:'$D(PSCAN) INVALD W ! S DIR("A")="OK to "_$S($G(RXCNT)>1:"Change Status",REA="C":"Discontinue",1:"Reinstate"),DIR(0)="Y",DIR("B")="N" D ^DIR K DIR I $D(DIRUT) S:$O(PSOSDX(0)) PSOSDXY=1 Q
 I 'Y S:$O(PSOSDX(0)) PSOSDXY=1 K PSCAN D INVALD Q
 S RX="" F  S RX=$O(PSCAN(RX)) Q:RX=""  D PSOL^PSSLOCK(+PSCAN(RX)) I $G(PSOMSG) D ACT D PSOUL^PSSLOCK(+PSCAN(RX))
 D INVALD Q
ACT S DA=+PSCAN(RX),REA=$P(PSCAN(RX),"^",2),II=RX,PSODFN=$P(^PSRX(DA,0),"^",2) I REA="R" D REINS^PSOCAN2 Q
 D CAN^PSOCAN Q
INVALD K PSCAN Q:'$D(PSINV)  W !! F I=1:1:80 W "="
 W $C(7),!!,"The Following Rx Number(s) Are Invalid Choices, Expired, "_$S($G(PKI):"Digitally Signed",1:""),!,"Discontinued by Provider, or Marked As Deleted:" S II="" F  S II=$O(PSINV(II)) Q:II=""  W !?10,II
 K PSINV I $G(PSOERR)!($G(SPEED)) K DIR,DUOUT,DTOUT,DIRUT S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DTOUT,DIRUT,DUOUT
 G KILL Q
LISTPAT S X="?",DIC(0)="EMQ",DIC="^DPT(" D ^DIC K DIC Q
 ;
COM W !
 K MSG  ;Added to prevent INCOM from being superseded in AREC tag if DC comments entered.
 S DIR("A")="Comments"_$S($D(PKIR):"/Reason for DCing",1:""),DIR(0)="F^5:75"
 S DIR("?")="Comments must be entered.  Comments must be 5 to 75 characters and must not contain embedded uparrow"
 S:$D(INCOM) DIR("B")=INCOM
 D ^DIR I $D(DIRUT) K DIR,DTOUT,DUOUT,Y Q
 S INCOM=Y S:$D(PKIR) PKIR=Y K DIR,DTOUT,DIRUT,DUOUT
 D NOOR^PSOCAN4
 Q
KILL D KILL^PSOCAN2
 K PSOMSG,PSOPLCK,PSOWUN,PSOULRX
 Q
PEN ;discontinue pending orders
 S PSODAPND=DA
 K ^PS(52.41,"AOR",$P(^PS(52.41,DA,0),"^",2),+$P($G(^PS(52.41,DA,"INI")),"^"),DA) S $P(^PS(52.41,DA,0),"^",3)="DC",^PS(52.41,DA,4)=INCOM_" Discontinued by Pharmacy."
 D EN^PSOHLSN(+^PS(52.41,DA,0),"OC",INCOM,PSONOOR)
 S DA=PSODAPND K PSODAPND
 Q
RTEST ;
 Q:'$G(LINE)
 N PCIN,PCINFLAG,PCINX
 S PCINFLAG=0 F PCIN=1:1 S PCINX=$P(LINE,",",PCIN) Q:$P(LINE,",",PCIN)']""  D
 .Q:'$G(PCINX)
 .Q:'$G(PSOCAN(PCINX))
 .I PSOCAN(PCINX)'["^P" I $P($G(^PSRX(+$G(PSOCAN(PCINX)),"STA")),"^")'=12,'$G(PCINFLAG) S PSOCANRD=+$P($G(^PSRX($G(PSOCAN(PCINX)),0)),"^",4) S PCINFLAG=1
 .I PSOCAN(PCINX)["^P",'$G(PCINFLAG) S PSOCANRD=+$P($G(^PS(52.41,+$P(PSOCAN(PCINX),"^"),0)),"^",5) S PCINFLAG=1
 I '$G(PCINFLAG) S PSOCANRZ=1
 Q
RTESTA ;
 N PFIN,PFINZ,PFINFLAG
 S PFINFLAG=0 S PFIN="" F  S PFIN=$O(PSOSD(PFIN)) Q:PFIN=""  S PFINZ="" F  S PFINZ=$O(PSOSD(PFIN,PFINZ)) Q:PFINZ=""  D
 .I $G(PFIN)'="PENDING" I $P($G(^PSRX(+$P($G(PSOSD(PFIN,PFINZ)),"^"),"STA")),"^")'=12,'$G(PFINFLAG) S PSOCANRD=+$P($G(^(0)),"^",4),PFINFLAG=1
 .I $G(PFIN)="PENDING",'$G(PFINFLAG) S PSOCANRD=+$P($G(^PS(52.41,+$P($G(PSOSD(PFIN,PFINZ)),"^",10),0)),"^",5) S PFINFLAG=1
 I '$G(PFINFLAG) S PSOCANRZ=1
 Q
