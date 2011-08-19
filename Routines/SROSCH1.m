SROSCH1 ;B'HAM ISC/MAM - OR SCHEDULE ; [ 09/22/98  11:49 AM ]
 ;;3.0; Surgery ;**63,77,50**;24 Jun 93
EN I '$D(SRSITE) W @IOF D ^SROVAR I '$D(SRSITE) Q
 W @IOF S %DT="AEFX",%DT("A")="Print Schedule of Operations for which date ?   " D ^%DT K %DT Q:Y<1  S SRDT=Y D D^DIQ S SRDT1=Y
 D ALL G:SRYN["^" END I "Yy"[SRYN W !!,"Schedule will be queued to print at all locations defined in the SURGERY",!,"SITE PARAMETERS file...." D ^SROSCH2 W !!,"Press RETURN to continue  " R X:DTIME G END
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="SCHEDULE OF OPERATIONS",ZTRTN="SROSCH",(ZTSAVE("SRDT"),ZTSAVE("SRDT1"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD G END
 G ^SROSCH
END D ^SRSKILL,^%ZISC W @IOF
 Q
ASK I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R Z:DTIME I '$T!(Z="^") S SRQ=1 Q
 D HDR I SX'=1 W !!,?1,"OPERATING ROOM: "_SROOM,!
 Q
LOOP ; break procedure if greater than 70 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<70  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRQ=1 Q
 W:$Y @IOF W !,?(132-$L(SRINST)\2),SRINST,?123,$J("PAGE "_SRPAGE,8)
 W !,?58,"SURGICAL SERVICE",!,?55,"SCHEDULE OF OPERATIONS",?90,"SIGNATURE OF CHIEF: ",SRCHF,!
 D NOW^%DTC S Y=% D DD^%DT W "PRINTED: ",$P(Y,"@")_" "_$E($P(Y,"@",2),1,5),?58,"FOR: ",SRDT1,?110,"____________________"
 W !!!,"PATIENT",?23,"DISPOSITION",?40,"PREOPERATIVE DIAGNOSIS",?92,"REQ ANESTHESIA"
 W ?116,"SURGEON",!,"ID#",?15,"AGE",?23,"START TIME",?40,"OPERATION(S)",?92,"ANESTHESIOLOGIST",?115,"FIRST ASST.",!,"WARD",?24,"END TIME",?92,"PRIN. ANESTHETIST",?115,"ATT SURGEON",! F LINE=1:1:132 W "="
 S SRPAGE=SRPAGE+1
 Q
CON ; print concurrent procedure
 K SROPS,MM,MMM S SROPER=$P(^SRF(SRCON,"OP"),"^") S:$L(SROPER)<70 SROPS(1)=SROPER I $L(SROPER)>69 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,?26,"** Concurrent Case #"_SRCON,?53,SROPS(1) I $D(SROPS(2)) W !,?53,SROPS(2) I $D(SROPS(3)) W !,?53,SROPS(3)
 Q
DIQ ; extract time from date
 S Y=SRST D D^DIQ S SRFIND=$F(Y,":") S SRST=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 S Y=SRET D D^DIQ S SRFIND=$F(Y,":") S SRET=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 Q
TIME ; start and finish times
 S S(31)=^SRF(SRTN,31),Y=$P(S(31),"^",4) D D^DIQ S SRFIND=$F(Y,":"),SRSST=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"00:00")
 S Y=$P(S(31),"^",5) D D^DIQ S SRFIND=$F(Y,":"),SRSET=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 Q
ALL ; print to all locations ?
 I '$O(^SRO(133,SRSITE,1,0)) S SRYN="N" Q
 W @IOF,!,"Do you want to print the schedule at all locations ?  NO//  " R SRYN:DTIME I '$T!(SRYN["^") Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="N"
 I "YyNn"'[SRYN W !!,"Enter RETURN to select a specific printer, or 'YES' to print the Schedule of",!,"Operations on all of the printers specified in your SURGERY SITE",!,"PARAMETERS file."
 I "YyNn"'[SRYN W !!,"Press RETURN to continue  " R X:DTIME G ALL
 Q
OUT ; outpatient ?
 I $P(^SRF(SRTN,0),"^",12)="I" S SRSLOC="TO BE ADMITTED" Q
 I $D(^SRF(SRTN,.4)),$P(^(.4),"^",3)'="O" S SRSLOC="TO BE ADMITTED"
 Q
