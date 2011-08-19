PSOVCNT ;BHAM ISC/SAB - NON-VERIFIED PRESCRIPTION COUNTS ; 06/29/92 16:02
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 K IOP,%ZIS,POP S PSOION=ION,%ZIS="MQ" D ^%ZIS I POP S IOP=PSOION D ^%ZIS K PSOION G END
 I $D(IO("Q")) S ZTRTN="EN^PSOVCNT",ZTDESC="NON-VERIFIED PRESCRIPTION COUNT" D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued to Print " K ZTSK,IO("Q") G END
EN S (PSOVR,PSOVP,PSOV,PSOOUT)=0 F I=0:0 S I=$O(^PS(52.4,I)) Q:'I  S PSOVR=PSOVR+1
 F I=0:0 S I=$O(^PS(52.4,"C",I)) Q:'I  S PSOVP=PSOVP+1
 U IO D NOW^%DTC S Y=% X ^DD("DD") W @IOF,!?24,"NON-VERIFIED PRESCRIPTION COUNTS",!?30,Y,!
 W !,"TOTAL NUMBER OF NON-VERIFIED PRESCRIPTIONS : ",PSOVR
 W !!,"NUMBER OF PATIENTS WITH ONE OR MORE NON-VERIFIED PRESCRIPTIONS : ",PSOVP
 W !!,"(NOTE: Total number of patients listed here may not always equal the number at",!,"the bottom, since some patients at the bottom may be counted more than once,",!,"possibly having non-verified Rx's entered on different days.)",!
 K ^TMP($J,"PSOV"),^TMP($J,"PSOP") F ZZ=0:0 S ZZ=$O(^PS(52.4,"LD",ZZ)) Q:'ZZ  D
 .S RXCNT=0 F RR=0:0 S RR=$O(^PS(52.4,"LD",ZZ,RR)) Q:'RR  S RXCNT=RXCNT+1
 .S ^TMP($J,"PSOV",ZZ)=RXCNT
 .F AA=0:0 S AA=$O(^PS(52.4,"LD",ZZ,AA)) Q:'AA  I $P($G(^PS(52.4,AA,0)),"^",2) S ^TMP($J,"PSOP",ZZ,$P(^PS(52.4,AA,0),"^",2))=""
 .S PCNT=0 F PP=0:0 S PP=$O(^TMP($J,"PSOP",ZZ,PP)) Q:'PP  S PCNT=PCNT+1
 .S ^TMP($J,"PSOV",ZZ)=^TMP($J,"PSOV",ZZ)_"^"_+$G(PCNT)
 D HD1
 S (TOT,PATTOT)=0
 F AA=0:0 S AA=$O(^TMP($J,"PSOV",AA)) Q:'AA  D:$Y+6>IOSL&('$G(PSOOUT)) HD W:'$G(PSOOUT) !?3,$E(AA,4,5)_"-"_$E(AA,6,7)_"-"_$E(AA,2,3),?20,$J($P(^TMP($J,"PSOV",AA),"^"),3),?42,$J($P(^(AA),"^",2),3) D
 .S TOT=TOT+$P(^TMP($J,"PSOV",AA),"^"),PATTOT=PATTOT+$P(^(AA),"^",2)
 W !?20,"----",?42,"----",!,"TOTAL",?20,TOT,?42,PATTOT I $E(IOST)'["P" W ! K DIR S DIR(0)="E" D ^DIR K DIR
END K ^TMP($J,"PSOV"),^TMP($J,"PSOP") W:$E(IOST)="P" @IOF D ^%ZISC K PSOION,I,PSOVR,PSOVP,PSOV,ZZ,RR,AA,PP,TOT,PATTOT,PCNT,PSOOUT,RXCNT S:$D(ZTQUEUED) ZTREQ="@"
 Q
HD I $E(IOST)'["P" W ! K DIR S DIR(0)="E" D ^DIR K DIR I Y'=1 S PSOOUT=1 Q
 W @IOF
HD1 W !?20,"# of",?42,"# of",!?5,"Date",?14,"Non-verified Rx's",?35,"Different Patients",!?5,"----",?14,"-----------------",?35,"------------------",!
 Q
