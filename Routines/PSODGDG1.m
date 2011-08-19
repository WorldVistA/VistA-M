PSODGDG1 ;BHAM ISC/SAB - DRUG INTERACTION PROCESSOR ;02/25/94 9:14
 ;;7.0;OUTPATIENT PHARMACY;**251**;DEC 1997;Build 202
 G PROC^PSODGDG2
PROCESS ;verification
 Q:$P(^PSRX(PSONV,"STA"),"^")=13
 W @IOF W !,$P(^DPT(DFN,0),"^"),?40,"ID#:"_VA("PID")_"  RX #"_$P(INT,"^")
 D CUTDATE^PSOFUNC:'$G(PSODTCUT),^PSOBUILD:'+$G(PSOZVER),^PSODSPL
 S DIR("?",1)="Answer 'YES' if you DO want to "_$S($P(SER,"^",4)=1:"continue processing",1:"enter an intervention for")_" this medication,"
 S DIR("?",2)="       'NO' if you DON'T want to "_$S($P(SER,"^",4)=1:"continue processing",1:"enter an intervention for")_" this medication,",DIR("?")="    or 'P' to review medication profile."
 W $C(7),$C(7) S DIR("A",1)="",DIR("A",2)="***"_$S($P(SER,"^",4)=1:"CRITICAL",1:"SIGNIFICANT")_"*** "_"Drug Interaction with RX #"_$P(^PSRX($P($P(MED,",",INA),"^"),0),"^"),DIR("A",3)="               Drug: "_$P($G(^PSDRUG($P(^(0),"^",6),0)),"^")
 S DIR(0)="SA^1:YES;0:NO;P:PROFILE",DIR("A")="Do you want to "_$S($P(SER,"^",4)=1:"Continue? ",1:"Intervene? "),DIR("B")="Y" D ^DIR I Y="P" W ! K Y G PROCESS
 I 'Y,$P(SER,"^",4)=1 S PSVERFLG=1
 I Y,$P(SER,"^",4)=1 S PSORX("INTERVENE")=1 K DIR,DTOUT,DIRUT,DIROUT,DUOUT D CRI Q 
 I Y,$P(SER,"^",4)=2 S PSORX("INTERVENE")=2,DA=IFN D INV
 K DIR,DTOUT,DIRUT,DIROUT,DUOUT Q
 Q
CRI ;new interactions
 K DIR I $P(RX,"^",15)=4 D CRITN Q
 S DIR("A",1)="",DIR("A",2)="Do you want to Process or Cancel medication?"
 S DIR("A")="Rx #"_$P($G(^PSRX(DA,0)),"^")_"   "_"Drug: "_$P($G(^PSDRUG($P(^PSRX(DA,0),"^",6),0)),"^")_": "
 S DIR(0)="SA^1:PROCESS;0:CANCEL MEDICATION",DIR("B")="PROCESS"
 K ANSDIR
 S DIR("?",1)="Enter '1' or 'P' to Activate medication",DIR("?")="      '^' to EXIT Process",DIR("?",2)="      '0' or 'C' to Cancel Medication" D ^DIR K DIR
 I $D(DIRUT) S (PSORX("DFLG"),PSVERFLG)=1 Q
 S ANSDIR=Y,PSONV=DA
 D SIG^XUSESIG I X1="" S (PSORX("DFLG"),PSVERFLG)=1 K ANSDIR Q
 I 'ANSDIR N PSOHDINV D  G Q1
 .D NOOR^PSOCAN4 I $D(DIRUT) D UPOUT Q
 .S DA=PSONV D RXV S DA=PSONV,PSORX("INTERVENE")=1 D INV S DA=PSONV
 .D PSDEL,HLDINVS,DEL K PSORX("INTERVENE")  S PSVERFLG=1
 I ANSDIR&'$G(PSODIR) S DA=PSONV D HLDINV,INV S DA=PSONV D
 .I '$G(PSVERFLG) D ^PSODGDG2 S $P(^PSRX(PSONV,"STA"),"^")=1 S ZONE=PSONV D ONE
Q1 K DIK,DTOUT,DIRUT,DIROUT,DUOUT,LST,ANSDIR,PSONOOR S PSVERFLG=1
 Q
HLDINV           ;
 I $G(PSORX("INTERVENE")) S PSOHDINV=$G(PSORX("INTERVENE"))
 Q
 ;
 ;
HLDINVS ;
 I $G(PSOHDINV) S PSORX("INTERVENE")=PSOHDINV
 Q
 ;
CRITN ;multiple interactions
 S PSOTHER=$P($P(MED,",",INA),"^") N PSONV
 K DIR S DIR("A",1)="",DIR("A",2)="Do you want to: ",DIR("A",3)=" 1.  Cancel Rx #"_$P(INT,"^")_"  DRUG: "_$P(^PSDRUG($P(INT,"^",6),0),"^")
 S DIR("A",4)=" 2.  Cancel Rx #"_$P(RX,"^")_"  DRUG: "_$P(^PSDRUG($P(RX,"^",6),0),"^"),DIR("A",5)=" 3.  Cancel Both 1 and 2",DIR("A")=" 5.  Leave Both Non-verified (do nothing) ?: ",DIR("A",6)=" 4.  Process Both 1 and 2"
 S DIR(0)="SA^1:1 to be Canceled;2:2 to be Canceled;3:Cancel BOTH 1 and 2;4:ACTIVATE 1 and 2;5:DO NOTHING TO 1 and 2"
 S DIR("?",1)="Enter '1' to Cancel Rx #"_$P(INT,"^")_"  DRUG: "_$P(^PSDRUG($P(INT,"^",6),0),"^"),DIR("?",2)="      '2' to Cancel Rx #"_$P(RX,"^")_"  DRUG: "_$P(^PSDRUG($P(RX,"^",6),0),"^")
 S DIR("?",3)="      '3' or 'B' to Cancel Both 1 and 2",DIR("?",4)="      '4' or 'A' to Activate both RXs",DIR("?")="      '5' or 'D' to do nothing/leave both RXs in a Pending Status" D ^DIR K DIR I Y["^"!(Y=5)!($D(DIRUT)) S PSVERFLG=1 G CRIZ
 S PSAN=Y D SIG^XUSESIG I X1="" K PSAN S (PSORX("DFLG"),PSVERFLG)=1 G CRIZ
 I PSAN=1 D  D KILL Q
 .D NOOR^PSOCAN4 I $D(DIRUT) D UPOUT,KILL K PSONORR,PSORX("INTERVENE") Q
 .S DA=IFN D RXV
 .S DA=IFN D PSDEL,DEL
 .S:$G(PSOSD) PSOSD=PSOSD-1 S DA=IFN D INV S DA=$P(MED,",",INA) S DA=PSOTHER
 .D INV S DA=PSOTHER S $P(^PSRX(PSOTHER,"STA"),"^")=1,ZONE=PSOTHER
 .D ONE K PSONOOR
 I PSAN=2 D  D KILL K PSONOOR Q
 .D NOOR^PSOCAN4 I $D(DIRUT) D UPOUT,KILL K PSONOOR,PSORX("INTERVENE") Q
 .S DA=$P(MED,",",INA) D PSDEL,DEL
 .K PSONOOR S:$G(PSOSD) PSOSD=PSOSD-1 S DA=$P(MED,",",INA)
 .D INV S DA=IFN D INV S DA=IFN
 .I 'PSVERFLG,'$P(MED,",",(INA+1)) D ^PSODGDG2 S DA=IFN,$P(^PSRX(DA,"STA"),"^")=1 S ZONE=DA D ONE
 I PSAN=3 D  D KILL K PSONOOR Q
 .D NOOR^PSOCAN4 I $D(DIRUT) D UPOUT,KILL K PSONOOR,PSORX("INTERVENE") Q
 .F DA=$P(MED,",",INA),IFN S PSHOLDDA=DA D PSDEL,DEL S DA=PSHOLDDA D INV K DTOUT,DIROUT,DIRUT,DUOUT,PSAN,PSHOLDDA
 I $G(PSAN)=4 S LST=1,PPL="" D
 .S DA=$P(MED,",",INA) D INV S $P(^PSRX(PSOTHER,"STA"),"^")=1 S ZONE=PSOTHER S PSOTHER(PSOTHER)=PSOTHER D ONE
 .S DA=IFN D INV I 'PSVERFLG,'$P(MED,",",(INA+1)) D ^PSODGDG2 S DA=IFN,$P(^PSRX(DA,"STA"),"^")=1 S ZONE=DA D ONE
 .S:$G(PSOSD) PSOSD=PSOSD-2
 D KILL
CRIZ ;
 Q
RXV S DIK="^PS(52.4," D ^DIK Q  ;251;verify there's no dosing checks before deleting
INV D EN1^PSORXI(.DA) K PSORX("INTERVENE") Q
PSDEL Q:$G(STAT)']""
 S STA="ACTIVE^NON-VERIFIED^R^HOLD^NON-VERIFIED^ACTIVE^^^^^^ACTIVE^DISCONTINUE^^DISCONTINUE^DISCONTINUE^HOLD",STAT=$P(STA,"^",$P(^PSRX(DA,"STA"),"^")+1)
 I $P($G(PSOSD(STAT,$P(^PSDRUG($P(^PSRX(DA,0),"^",6),0),"^"))),"^")=DA K PSOSD(STAT,$P(^PSDRUG($P(^PSRX(DA,0),"^",6),0),"^"))
 E  K PSOSD(STAT,$P(^PSDRUG($P(^PSRX(DA,0),"^",6),0),"^")_"^"_DA)
 Q
DEL W !!,"Canceling Rx: "_$P($G(^PSRX(DA,0)),"^")_"   "_"Drug: "_$P($G(^PSDRUG($P(^PSRX(DA,0),"^",6),0)),"^"),!
 D ENQ^PSORXDL S PSORX("DFLG")=1
 S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue" D ^DIR K DIR
 I $G(PSOPOCK) S VALMBCK="Q"
 Q
ONE S STA="ACTIVE^NON-VERIFIED^R^HOLD^NON-VERIFIED^ACTIVE^^^^^^ACTIVE^DISCONTINUE^^DISCONTINUE^DISCONTINUE^HOLD",STAT=$P(STA,"^",$P(^PSRX(ZONE,"STA"),"^")+1)
 I $P($G(PSOSD(STAT,$P(^PSDRUG($P(^PSRX(ZONE,0),"^",6),0),"^"))),"^")=ZONE S $P(PSOSD(STAT,$P(^PSDRUG($P(^PSRX(ZONE,0),"^",6),0),"^")),"^",2)=1
 E  I $G(PSOSD(STAT,$P(^PSDRUG($P(^PSRX(ZONE,0),"^",6),0),"^")_"^"_ZONE)) S $P(PSOSD(STAT,$P(^PSDRUG($P(^PSRX(ZONE,0),"^",6),0),"^")_"^"_ZONE),"^",2)=1
 K ZONE,STA,STAT Q
KILL K DIR,DIK,DTOUT,DIROUT,DIRUT,DUOUT,LST,PPL,PSAN Q
 ;
UPOUT W " ACTION NOT TAKEN!",! K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue" D ^DIR K DIR S PSVERFLG=1 Q
