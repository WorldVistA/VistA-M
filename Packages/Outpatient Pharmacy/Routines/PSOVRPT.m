PSOVRPT ;BHAM ISC/SAB - log of non-verified rx's sorted by patient or user code ;06/29/92 16:56
 ;;7.0;OUTPATIENT PHARMACY;**251**;DEC 1997;Build 202
 ;External reference to $$DS^PSSDSAPI supported by DBIA 5424
SORT S DIR("A")="Sort By Patient or Clerk: ",DIR("B")="P",DIR(0)="SA^P:PATIENT;C:CLERK" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S PSOQUIT=1 G END
 S PSRT=Y
 K IOP,%ZIS S PSOION=ION,%ZIS="MQ" D ^%ZIS I POP S IOP=PSOION D ^%ZIS K PSOION S PSOQUIT=1 G END
 I $D(IO("Q")) S ZTRTN="START^PSOVRPT",ZTDESC="REPORT OF NON-VERIFIED RXs SORTED BY PATIENT OR CLERK",ZTSAVE("PSRT")="" D ^%ZTLOAD W:$D(ZTSK) !,"Task Queued " K PSOION,ZTSK S PSOQUIT=1 G END
START U IO
 N PAGE,PSOQUIT,LINE,ZPAT,CLERK,RDATE,ZCLK,ZZZZ,PNAME,COUNT,ZZZ,ZSORT,PATNAME,EOFLAG,IDATE,CLNAME,CLINT,PNODE,PSOCT,SSS,PSORX
 K ^TMP($J,"PSOVR"),^TMP($J,"PSOCR") S PAGE=1,PSOQUIT=0,$P(LINE,"-",79)=""
 D NOW^%DTC S Y=% X ^DD("DD") S RDATE=Y
 I $G(PSRT)="C" G CLERK
PAT ;sort by patient
 F ZPAT=0:0 S ZPAT=$O(^PS(52.4,"C",ZPAT)) Q:'ZPAT  S COUNT=0 F ZZZ=0:0 S ZZZ=$O(^PS(52.4,"C",ZPAT,ZZZ)) Q:'ZZZ  S PATNAME=$P($G(^DPT(ZPAT,0)),"^") D:PATNAME'=""&($D(^PS(52.4,ZZZ,0)))
 .I $G(ZSORT),$P($G(^PS(52.4,ZZZ,0)),"^",3)'=$G(CLINT) Q
 .I $D(^PSRX(ZZZ,0)) S COUNT=COUNT+1,^TMP($J,"PSOVR",PATNAME,COUNT)=ZZZ_"^"_$P($G(^PSDRUG(+$P(^PSRX(ZZZ,0),"^",6),0)),"^")_"^"_$P(^PSRX(ZZZ,0),"^",13)_"^"_$P(^PS(52.4,ZZZ,0),"^",3)
 I $G(ZSORT) Q
 D HD I '$D(^TMP($J,"PSOVR")) W !!,"NO NON-VERIFIED PRESCRIPTIONS TO PRINT.",! D:$E(IOST)="C"  G END
 .K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
CLPT ;
 S PNAME="" F  S PNAME=$O(^TMP($J,"PSOVR",PNAME)) Q:PNAME=""!(PSOQUIT)  S PSOCT=0 F SSS=0:0 S SSS=$O(^TMP($J,"PSOVR",PNAME,SSS)) Q:'SSS!(PSOQUIT)  D
 .S PSOCT=PSOCT+1,PNODE=^TMP($J,"PSOVR",PNAME,SSS)
 .S EOFLAG=0 I ($Y+5)>IOSL D  Q:PSOQUIT
 ..I $E(IOST)="C" W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue,'^' to exit" D ^DIR K DIR S:'Y PSOQUIT=1 I 'PSOQUIT S EOFLAG=1 D HD
 ..I $E(IOST)'="C" S EOFLAG=1 D HD
 .S ZZZZ=0 I PSOCT=1 W !!?3,PNAME S ZZZZ=1
 .I 'ZZZZ,$G(EOFLAG) W !!?3,PNAME_" (continued)"
 .W !,$P($G(^PSRX(+$P(PNODE,"^"),0)),"^")
 .S IDATE=$P(PNODE,"^",3),PSORX="",PSORX=$O(^PS(52.4,"B",+$P(PNODE,"^")))
 .W ?13,$E(IDATE,4,5)_"/"_$E(IDATE,6,7)_"/"_$E(IDATE,2,3)
 .W ?22,$S($O(^PS(52.4,"ADI",+$P(PNODE,"^"),0))!($$DS^PSSDSAPI&($$GET1^DIQ(52.4,+PNODE,8,"I"))):"#",1:" "),$P(PNODE,"^",2)
 .I $G(PSRT)="P" W ?63,$J(+$P(PNODE,"^",4),15)
 Q:$G(PSRT)="C"
 G END
 ;
CLERK ;sort by clerk
 F ZCLK=0:0 S ZCLK=$O(^PS(52.4,"D",ZCLK)) Q:'ZCLK  S COUNT=0 F ZZZ=0:0 S ZZZ=$O(^PS(52.4,"D",ZCLK,ZZZ)) Q:'ZZZ  D:$P($G(^VA(200,ZCLK,0)),"^")'=""&($D(^PS(52.4,ZZZ,0)))
 .S CLERK=$P($G(^VA(200,+$P($G(^PS(52.4,ZZZ,0)),"^",3),0)),"^")
 .I $D(^PSRX(ZZZ,0)),CLERK'="" S ^TMP($J,"PSOCR",CLERK,ZCLK)=""
 I '$D(^TMP($J,"PSOCR")) D HD W !!,"NO NON-VERIFIED PRESCRIPTIONS TO PRINT.",! D:$E(IOST)="C"  G END
 .K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 S CLNAME="" F  S CLNAME=$O(^TMP($J,"PSOCR",CLNAME)) Q:CLNAME=""!(PSOQUIT)  S CLINT=$O(^TMP($J,"PSOCR",CLNAME,0)) D
 .S ZSORT=1 D PAT D:$D(^TMP($J,"PSOVR")) HD D:$D(^TMP($J,"PSOVR")) CLPT D:$E(IOST)="C"&('$G(PSOQUIT))  K ZSORT,^TMP($J,"PSOVR")
 ..K DIR W ! S DIR(0)="E",DIR("A")="Press Return to continue,'^' to exit" D ^DIR K DIR S:Y'=1 PSOQUIT=1 Q
END D:$E(IOST)="C"&($G(PSRT)="P")&('$G(PSOQUIT))  K ^TMP($J,"PSOVR"),^TMP($J,"PSOCR") K PSRT W:$E(IOST)="P" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
 .W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 ;
HD W:$G(PAGE)'=1!($E(IOST)="C") @IOF W !?29,"NON-VERIFIED PRESCRIPTIONS",!?29,"AS OF "_$G(RDATE),!,?34,"SORTED BY "_$S($G(PSRT)="P":"PATIENT",1:"CLERK")
 I $$DS^PSSDSAPI W !?30,"(# indicates Order Check)"
 E  W !?23,"(# indicates Critical Drug Interaction)"
 W !?3,"Patient name",?70,"Page: ",$G(PAGE),!,"Rx #",?13,"Issued",?23,"Drug" D:$G(PSRT)="C"  W:$G(PSRT)="P" ?70,"Entry By" W !,LINE S PAGE=PAGE+1
 .W ?35,"CLERK-> "_$G(CLNAME)
 Q
