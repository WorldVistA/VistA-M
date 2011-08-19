SOWKCO ;B'HAM ISC/SAB-Routine to notify Social Work service of unopened cases for high risk patients ; 25 Feb 93 / 9:17 AM [ 09/22/94  2:04 PM ]
 ;;3.0; Social Work ;**34**;27 Apr 93
DEV W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K ZTSK,%ZIS,IOP S %ZIS="QM",SOWKION=ION,%ZIS("B")="" D ^%ZIS I POP S IOP=SOWKION D ^%ZIS K POP,IOP,SOWKION G CL
 ;I $E(IOST)["C" W !!,*7,"PRINTOUT MUST BE SENT TO PRINTER !!",! G DEV
 I $D(IO("Q")) S ZTDESC="POSSIBLE HIGH RISK PATIENTS THAT HAVE NOT BEEN SEEN BY SOCIAL WORK SERVICE ",ZTRTN="EN^SOWKCO" D ^%ZTLOAD Q
EN K ^TMP($J) U IO W !,"POSSIBLE HIGH RISK PATIENT(S) THAT HAVE NOT BEEN SEEN BY SOCIAL WORK SERVICE "
 D NOW^%DTC S Y=% X ^DD("DD") S RT=Y K %,Y
 W !!,"PATIENT NAME",?35,"ID#",?47,"WARD",?60,"ADMIT DATE/TIME",!,"Run Date/Time: "_RT,! F I=1:1:IOM W "_"
 F P=0:0 S P=$O(^SOWK(655,P)) Q:'P  S A=^SOWK(655,P,0) I $P(A,"^",5)="HR",$P(A,"^",6)'="S" S C=$P(A,"^"),^TMP($J,$P(^DPT(C,0),"^"),0)=C
 S R="" F II=0:0 S R=$O(^TMP($J,R)) Q:R=""  S DFN=^TMP($J,R,0) D INP^VADPT,PID^VADPT6 D COM
CL W ! W:$E(IOST)'["C" @IOF D ^%ZISC K ^TMP($J),SOWKION,C,II,IOP,POP,%ZIS,P,R,A,B,I,DFN,RT D KVA^VADPT D:$D(ZTSK) KILL^%ZTLOAD Q
COM W !,$P(^DPT(DFN,0),"^"),?35,VA("BID"),?45,$S(+VAIN(4):$P(VAIN(4),"^",2),1:"DISCHARGED"),?60,$P(VAIN(7),"^",2)
 Q
