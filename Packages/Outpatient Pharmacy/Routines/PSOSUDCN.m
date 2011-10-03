PSOSUDCN ;BHAM ISC/JMB-Counts of suspended Rx's by day ; 12/10/92
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 I '$D(PSOPAR) D ^PSOLSET I '$D(PSOPAR) D WARN Q
INIT W !!!,?5,"DAILY COUNTS OF RX'S ON SUSPENSE"
 S EXIT="" D DATE G:EXIT="" EXIT S %ZIS="QM" K IO("Q") D ^%ZIS K %ZIS Q:POP  G:$D(IO("Q")) QUEUP
START U IO S (PSD,PSDP,PST,PSTP)=0 D HD
 F J=(BEGDATE-1):0 S J=$O(^PS(52.5,"C",J)) Q:'J!(J>ENDDATE)  D CNT D:($Y+5)>IOSL HANG,HD I PSD S Y=J X ^DD("DD") W !,?10,Y,?25,$J(PSD,9),?40,$J(PSDP,9) S (PSD,PSDP)=0
 D:($Y+5)>IOSL HANG,HD W !,?10,"-----------",?25,"---------",?40,"---------",!,?10,"TOTAL",?25,$J(PST,9),?40,$J(PSTP,9),! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
EXIT K %,%DT,%H,BEGDATE,DAY,DIRUT,ENDDATE,PSPOP,EXIT,POP,PSD,PSDP,PST,PSTP,J,JJ,TIM,HR,MIN,%DT,D,X,Y,Z,G,ZTRTN,ZTSAVE,ZTSK Q
CNT F JJ=0:0 S JJ=$O(^PS(52.5,"C",J,JJ)) Q:'JJ  I $P($G(^PS(52.5,JJ,0)),"^",6)=$G(PSOSITE) S PSD=PSD+1,PST=PST+1 S:$G(^("P"))=1 PSDP=PSDP+1,PSTP=PSTP+1
 Q
DATE K BEGDATE,ENDDATE,%DT(0) W !!!,"**** DATE SELECTION ****"
 W ! S %DT="AEX",%DT("A")="   BEGIN DATE : " D ^%DT K %DT Q:Y<0  S (%DT(0),BEGDATE)=Y
 W ! S %DT="AEX",%DT("A")="   ENDING DATE: " D ^%DT Q:Y<0  S ENDDATE=Y
 S EXIT="NORMAL" Q
HANG I $E(IOST)="C" W $C(7),!!,"Press RETURN to CONTINUE!!" R X:DTIME Q
HD I $D(IOF),IOF]"" W @IOF
 D NOW^%DTC S Y=% X ^DD("DD") S DAY=$P(Y,"@"),TIM=$P(Y,"@",2)
 W !!,?9,"*** COUNTS OF RX'S IN SUSPENSE BY DAY ***"
 W !?((55-$L($P(^PS(59,$G(PSOSITE),0),"^")))\2),"FOR ",$P(^(0),"^")
 W !,?15,"AS OF ",DAY," AT ",TIM,!!,?10,"DATE",?25,"# OF RX'S",?40,"# PRINTED",!,?10,"-----------",?25,"---------",?40,"---------"
 Q
QUEUP S ZTRTN="START^PSOSUDCN",ZTDESC="Outpatient Pharmacy Count of Suspensed Prescriptions" F G="PSOSITE","BEGDATE","ENDDATE" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD G EXIT
DQ K IO(0),IOP Q
WARN W $C(7),!!,?5,"Site Parameters must be defined to use this option!",! Q
