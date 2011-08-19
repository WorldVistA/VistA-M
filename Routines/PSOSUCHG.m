PSOSUCHG ;BIR/RTR-CHANGE SUSPENSE AND FILL AND REFILL DATES ;4/29/93
 ;;7.0;OUTPATIENT PHARMACY;**20,26,130,235,148**;DEC 1997
 ;External reference A^PSXCH is supported by DBIA 2205
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
 ;External reference P^PSXCH is supported by DBIA 2205
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^DPT supported by DBIA 10035
 I '$D(PSOPAR) D ^PSOLSET I '$D(PSOPAR) D WARN^PSOSUDCN Q
LU N PSOSDLK,PSOLKQT,PSODELLK,PSOSSTP W !! S DIR("A")="Change a specific Rx# or all Rx's for one patient",DIR(0)="SBO^S:SPECIFIC RX;A:ALL RXs FOR ONE PATIENT"
 S DIR("?",1)="Enter 'S' to change a single prescription suspense date.",DIR("?")="Enter 'A' to change all of the prescription suspense dates for one patient."
 D ^DIR K DIR G:$G(DIRUT)!(Y="") EXIT S ACT=Y D:ACT="A" ALL D:ACT="S" SPEC D ULK G LU
EXIT D ULK K ISFLAG,ACT,BC,BCNUM,CBD,CNT,COM,D1,DA,DEAD,DEL,DELCNT,DFN,DIRUT,DR,DTOUT,DUOUT,HDSFN,I,II,INDT,OLD,OUT,PSPOP,RF,RFCNT,RX,RXDATE,RXREC,SFN,STOP,SUB,SUSCNT,VADM,WARN,X,Y,XOK,SRXPAR,SRXREC,SUSDOD,RECORD,PSOPOPUP,PSOSDLK,DELFLAG
 K VADM,VA("PID"),VA("BID"),PSDIVCHK,PSOMSG,PSOLKQT,PSODELLK,PSOSSTP Q
SPEC D ULK K INDT S (DELCNT,WARN,PSPOP,OUT)=0 W ! S DIR("A")="Select SUSPENDED Rx #: ",DIR(0)="FOA",DIR("?")="Enter the prescription# or wand the barcode.  To obtain a list of suspense prescriptions, type '??'",DIR("??")="^D LISTSUS^PSOSUCH1"
 D ^DIR K DIR Q:$D(DIRUT)  D:Y["-" PSOINST^PSOSUPAT G:$G(OUT) SPEC D  W ! S DIC("S")="I $D(^PSRX(+$P(^PS(52.5,+Y,0),""^""),0))",DIC="^PS(52.5,",DIC(0)="ZQE" D ^DIC K DIC W ! Q:$D(DTOUT)!($D(DUOUT))
 .I Y["-" S Y=$P(Y,"-",2),X=+$P($G(^PSRX(Y,0)),"^") Q
 .S X=Y
 G:Y<0 SPEC S DEAD=0,(SFN,DA)=+Y,RXREC=+Y(0),DFN=$P(^PS(52.5,SFN,0),"^",3),RXDATE=$P(Y(0),"^",2),STOP=$P(^PSRX(RXREC,2),"^",6),STAT=$P($G(^("STA")),"^") D  Q:$G(PSOLKQT)  D TST G:$T P^PSXCH
 .K PSOMSG,PSOLKQT D PSOL^PSSLOCK(RXREC) I '$G(PSOMSG) W !,"Rx number: "_$P($G(^PSRX(RXREC,0)),"^")_" cannot be changed because" D LMES,PAUSE S PSOLKQT=1 K PSOMSG Q
 .K PSOMSG S PSOSDLK(RXREC)=""
RTN I STAT=11!(STOP<DT)!(STAT=12) D EXPCAN Q
 D:$P($G(^PSRX(RXREC,"STA")),"^")<9 CHKDEAD^PSOSUCH1 Q:DEAD  I $G(PSODIV),+$P($G(^PS(52.5,SFN,0)),"^",6)'=PSOSITE S PSPOP=0 D CKDIV^PSOSUPAT Q:PSPOP
 S DA=SFN,DIE=52.5,DR=".02;S INDT=X" D ^DIE K DIE D  Q:$D(Y)  W !
 .I $D(INDT),INDT'=RXDATE,INDT<+$P($G(^PSRX(RXREC,0)),"^",13) S DA=SFN,DIE=52.5,DR=".02///"_RXDATE D ^DIE K DIE S Y="" W !!,"Suspense date cannot be before Issue Date of Rx!",!
 I $D(X),X'=RXDATE S DA=RXREC D CHANGE^PSOSUCH1(RXREC)
 D DEL G:ACT="A" ALL G:ACT="S" SPEC
ALL D ULK K INDT S (DELCNT,PSDIVCHK,DELFLAG,PSPOP,PSOPOPUP,WARN,SUSCNT)=0 W ! S DIR("A")="Are you entering the patient name or barcode?",DIR(0)="SBO^P:Patient Name;B:Barcode"
 S DIR("?")="Enter 'P' if you are going to enter the patient name.  Enter 'B' to enter or wand the barcode." D ^DIR K DIR Q:$D(DIRUT)  S BC=Y
BC S OUT=0 I BC="B" W ! S DIR("A")="Enter/wand barcode",DIR(0)="FO^5:20",DIR("?")="Enter the barcode number or wand the barcode to change all of the prescription suspense dates for one patient" D ^DIR K DIR G:$G(DIRUT) ALL S BCNUM=Y D
 .S RX=$P(BCNUM,"-",2) I '$G(RX) S OUT=1 W $C(7),!!?5,"Invalid Barcode!" Q
 .I $D(^PSRX(RX,0)) D PSOINST^PSOSUPAT Q:OUT  S DFN=$P(^PSRX(RX,0),"^",2) W " ",$P($G(^DPT(DFN,0)),"^")
 G:OUT BC
 I BC="B",'$D(^PSRX(RX,0)) W $C(7),!!?5,"Invalid Barcode!",! G BC
 I BC="B",'$D(^PS(52.5,"AC",DFN)) W !!?3,"This patient has no Rx's in suspense that have not already been printed!",! G BC
NAM I BC="P" W ! S DIC(0)="AEMZQ",DIC="^DPT(",DIC("S")="I $D(^PS(52.5,""AC"",+Y))!($D(^PS(52.5,""AG"",+Y)))" D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<0) ALL S DFN=+Y
 F CBD=0:0 S CBD=$O(^PS(55,DFN,"P",CBD)) Q:CBD'>0!($G(PSOPOPUP))  S:$D(^PS(55,DFN,"P",CBD,0)) RXREC=+^(0) D:$D(^PS(52.5,"B",RXREC)) TEST D ULK
 G:ACT="A" ALL G:ACT="S" SPEC
TEST S SFN=+$O(^PS(52.5,"B",RXREC,0)) Q:'SFN  Q:$P($G(^PS(52.5,SFN,"P")),"^")'=0  S STOP=$P(^PSRX(RXREC,2),"^",6),STAT=$P($G(^("STA")),"^") D  Q:$G(PSOLKQT)  D TST D:$T A^PSXCH Q:$G(XOK)=0  I STAT=11!(STOP<DT)!(STAT=12) D EXPCAN Q
 .K PSOMSG,PSOLKQT D PSOL^PSSLOCK(RXREC) I '$G(PSOMSG) W !!,"Rx number: "_$P($G(^PSRX(RXREC,0)),"^")_" cannot be changed because" D LMES,PAUSE S PSOLKQT=1 K PSOMSG Q
 .K PSOMSG S PSOSDLK(RXREC)=""
 S PSPOP=0 D:PSODIV&('$G(PSDIVCHK)) DIV^PSOSUPAT S PSDIVCHK=1 S:PSPOP PSOPOPUP=1 I 'PSPOP D:$P($G(^PSRX(RXREC,"STA")),"^")<9 CHKDEAD^PSOSUCH1 Q:DEAD  D BEG
 Q
BEG S RXDATE=$P(^PS(52.5,SFN,0),"^",2),ISFLAG=0
 I 'SUSCNT S DA=SFN,DIE=52.5,DR=".02;S INDT=X" D ^DIE D SI Q:ISFLAG  K:$G(^PS(52.5,SFN,"P"))=1 ^PS(52.5,"AC",DFN,+$P(^PS(52.5,SFN,0),"^",2),SFN) S:$D(Y) PSOPOPUP=1 Q:X=""!($D(DTOUT))!($G(PSOPOPUP))  S SUSCNT=1
 I SUSCNT D IS Q:$G(ISFLAG)  S DA=SFN,DIE=52.5,DR=".02///"_INDT D ^DIE K DIE K:$G(^PS(52.5,SFN,"P"))=1 ^PS(52.5,"AC",DFN,+$P($G(^PS(52.5,SFN,0)),"^",2),SFN) I $D(DTOUT)!($D(DUOUT))!($D(Y)) S PSOPOPUP=1 Q
 D CHANGE^PSOSUCH1(RXREC)
DEL I 'DELCNT W !! S DIR("A")="Do you want to delete"_$S($G(ACT)="S":" this Rx ",1:" Rx's ")_"from suspense"_$S($G(ACT)="A":" for this patient",1:""),DIR("B")="N",DIR(0)="Y" D ^DIR K DIR S DELCNT=1 S DEL=Y Q:'Y  I $D(DIRUT) S PSOPOPUP=1 Q
 I $G(ACT)="A",DELCNT,$G(DEL),'$G(DELFLAG) W !!,"Deleting Rx's from suspense..",! S DELFLAG=1 D DEL1 Q
 Q:'DEL
 I '$D(PSOSDLK(RXREC)) D  Q:$G(PSODELLK)
 .K PSOMSG,PSODELLK D PSOL^PSSLOCK(RXREC) I '$G(PSOMSG) W !,"Rx number: "_$P($G(^PSRX(RXREC,0)),"^")_" cannot be deleted from suspense because" D LMES,PAUSE S PSODELLK=1 K PSOMSG Q
 .K PSOMSG S PSOSDLK(RXREC)=""
 I DEL S DA=$O(^PS(52.5,"B",RXREC,0)) D RF S DIK="^PS(52.5," D ^DIK K DIK D:$P(^PSRX(RXREC,"STA"),"^")=5  W:$G(ACT)="S" !!,"Rx# ",$P($G(^PSRX(RXREC,0)),"^")," has been deleted from suspense!",!
 .S $P(^PSRX(RXREC,"STA"),"^")=0
 .N PSOZZD S PSOZZD="Removed from suspense" D EN^PSOHLSN1(RXREC,"SC","ZU",PSOZZD) K PSOZZD Q
 Q
EXPCAN S DIK="^PS(52.5,",DA=SFN D ^DIK K DIK S Y=STOP D DD^%DT S PSOSSTP=Y I STOP<DT!(STAT=11) D:STAT'=11  W $C(7),!,"Rx# "_$P($G(^PSRX(RXREC,0)),"^")_" expired "_$G(PSOSSTP)_"."
 .S $P(^PSRX(RXREC,"STA"),"^")=11
 .N PSOZZD S PSOZZD="Expired while suspended" D EN^PSOHLSN1(RXREC,"SC","ZE",PSOZZD) K PSOZZD
 W:STAT=12 $C(7),!,"Rx# "_$P(^PSRX(RXREC,0),"^")_" was discontinued "_Y_"." K STAT,STOP Q
TST N X S X="PSXCH" X ^%ZOSF("TEST") K X Q
 ;
RF ;
 S PSSHLDDA=DA,PSODFS=0
 S SNODE=$G(^PS(52.5,DA,0)),PSINN=+SNODE D DAREC^PSOSUCH1 I '$G(PSINN)!($P(SNODE,"^",5)) K PSINN,SNODE,PSODFS S DA=PSSHLDDA Q
 S PSIFN=0 F  S PSIFN=$O(^PSRX(PSINN,1,PSIFN)) Q:'PSIFN  D
 .I $P($G(^PSRX(PSINN,1,PSIFN,0)),"^")=$P(SNODE,"^",2),'$P($G(^PSRX(PSINN,1,PSIFN,0)),"^",18),$P($G(^PS(52.5,+$G(PSSHLDDA),"P")),"^")=0 D
 ..N DIK,DA S DIK="^PSRX("_PSINN_",1,",DA(1)=PSINN,DA=PSIFN D ^DIK
 ..S PSODFS=1,PSUSD=$P(SNODE,"^",2) D DATE
 I '$G(PSODFS) G RFPS
 S PSIFN=0 F  S PSIFN=$O(^PSRX(PSINN,1,PSIFN)) Q:'PSIFN  I '$O(^PSRX(PSINN,1,PSIFN)) S $P(^PSRX(PSINN,3),"^")=+$P(^PSRX(PSINN,1,PSIFN,0),"^")
 I '$O(^PSRX(PSINN,1,0)) S $P(^PSRX(PSINN,3),"^")=$P(^PSRX(PSINN,2),"^",2)
 S PSOX("IRXN")=PSINN D NEXT^PSOUTIL(.PSOX) S PSONEXT=$P(PSOX("RX3"),"^",2),DA=PSINN,DIE=52,DR="102///"_PSONEXT D ^DIE K DIE K PSONEXT,PSOX
RFPS K PSODFS,ZZZ,PSINN,PSIFN,PSUSD,PNOD,SNODE S DA=PSSHLDDA K PSSHLDDA Q
DATE S PNOD=0 F ZZZ=0:0 S ZZZ=$O(^PSRX(PSINN,1,ZZZ)) Q:'ZZZ  S PNOD=ZZZ
 I PNOD=1 S $P(^PSRX(PSINN,3),"^",4)=$P(^PSRX(PSINN,2),"^",2) Q
DATEX I $G(PNOD) S PNOD=PNOD-1 G:'$D(^PSRX(PSINN,1,PNOD,0)) DATEX
 I PNOD=0 S $P(^PSRX(PSINN,3),"^",4)=$P(^PSRX(PSINN,2),"^",2) Q
 S $P(^PSRX(PSINN,3),"^",4)=$P(^PSRX(PSINN,1,PNOD,0),"^") Q
 Q
IS K DIE I $G(INDT),$G(INDT)<+$P($G(^PSRX(RXREC,0)),"^",13) S DIE=52.5,DA=SFN,DR=".02///"_RXDATE D ^DIE K DIE W !!,"Suspense date cannot be before Issue Date for Rx# ",$P($G(^PSRX(RXREC,0)),"^") S ISFLAG=1
 Q
SI ;
 S SUSCNT=1
 I $D(Y) S (ISFLAG,PSOPOPUP)=1
 G IS
DEL1 ;
 S PSOSUPOP=1
 F WW=0:0 S WW=$O(^PS(55,DFN,"P",WW)) Q:WW'>0  S:$D(^PS(55,DFN,"P",WW,0)) RXREC=+^(0) D:$D(^PS(52.5,"B",+$G(RXREC)))
 .I '$D(PSOSDLK(RXREC)) K PSODELLK D DELONE Q:$G(PSODELLK)
 .I $P($G(^PSRX(RXREC,"STA")),"^")=11!($P($G(^PSRX(RXREC,2)),"^",6)<DT) D EXPCAN1 Q
 .S DA=$O(^PS(52.5,"B",RXREC,0)) D RF S DIK="^PS(52.5," D ^DIK K DIK D:$P(^PSRX(RXREC,"STA"),"^")=5  W:$G(ACT)="S" !!,"Rx# ",$P($G(^PSRX(RXREC,0)),"^")," has been deleted from suspense!",!
 ..S $P(^PSRX(RXREC,"STA"),"^")=0
 ..N PSOZZD S PSOZZD="Removed from suspense" D EN^PSOHLSN1(RXREC,"SC","ZU",PSOZZD) K PSOZZD Q
 Q
ULK ;Unlock prescriptions
 I '$O(PSOSDLK("")) Q
 N PSOSDLKR S PSOSDLKR="" F  S PSOSDLKR=$O(PSOSDLK(PSOSDLKR)) Q:PSOSDLKR=""  D PSOUL^PSSLOCK(PSOSDLKR)
 K PSOSDLK
 Q
PAUSE ;
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR W !
 Q
LMES ;
 W !,$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order.")
 Q
DELONE ;
 K PSOMSG,PSODELLK D PSOL^PSSLOCK(RXREC) I '$G(PSOMSG) W !,"Rx number: "_$P($G(^PSRX(RXREC,0)),"^")_" cannot be deleted from suspense because" D LMES,PAUSE S PSODELLK=1 K PSOMSG Q
 K PSOMSG S PSOSDLK(RXREC)=""
 Q
EXPCAN1 ;
 N SFN,Y,PSOSSTP,STAT,STOP
 S STAT=$P($G(^PSRX(RXREC,"STA")),"^"),STOP=$P($G(^PSRX(RXREC,2)),"^",6)
 S SFN=+$O(^PS(52.5,"B",RXREC,0)) Q:'SFN
 S DIK="^PS(52.5,",DA=SFN D ^DIK K DIK S Y=STOP D DD^%DT S PSOSSTP=Y I STOP<DT!(STAT=11) D:STAT'=11  W $C(7),!,"Rx# "_$P($G(^PSRX(RXREC,0)),"^")_" expired "_$G(PSOSSTP)_"."
 .S $P(^PSRX(RXREC,"STA"),"^")=11
 .N PSOZZD S PSOZZD="Expired while suspended" D EN^PSOHLSN1(RXREC,"SC","ZE",PSOZZD) K PSOZZD
 Q
