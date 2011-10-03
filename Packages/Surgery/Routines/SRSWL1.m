SRSWL1 ;B'HAM ISC/MAM - WAITING LIST, BRIEF-ALL ; 17 OCT 1989  7:35 AM
 ;;3.0; Surgery ;;24 Jun 93
 W ! K %ZIS,POP,IOP,IO("Q") S %ZIS("A")="Print the Waiting List on which Device: ",%ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTDESC="SURGERY WAITING LIST",ZTRTN="BEG^SRSWL1" D ^%ZTLOAD G END
BEG ; entry when queued
 U IO S (SRSOUT,SRHDR)=0 D NOW^%DTC S Y=% D D^DIQ S SRTIME=$E(Y,1,12)_" at "_$E(Y,14,18)
 S SRSS=0 F  S SRSS=$O(^SRO(133.8,"AWL",SRSS)) Q:'SRSS!(SRSOUT)  S SRSNM=$P(^SRO(133.8,SRSS,0),"^"),SRSNM=$P(^SRO(137.45,SRSNM,0),"^") D PAGE S SRSDT=0 F  S SRSDT=$O(^SRO(133.8,"AWL",SRSS,SRSDT)) Q:'SRSDT!(SRSOUT)  D MORE
END I $E(IOST)="P" S SRSOUT=1 W @IOF
 I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME W @IOF
 D ^%ZISC,^SRSKILL K SRTN
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S SRHDR=1 W:$Y @IOF W !,"Surgery Waiting List for "_SRSNM,!,"Printed "_SRTIME,!!,"Date Entered",?15,"Patient",?40,"Operative Procedure",! F LINE=1:1:80 W "="
 Q
MORE ; continue looping on 'WL' x-ref
 S SROFN=0 F  S SROFN=$O(^SRO(133.8,"AWL",SRSS,SRSDT,SROFN)) Q:'SROFN!(SRSOUT)  D PRINT
 Q
PRINT ; print information
 I $Y+5>IOSL D PAGE Q:SRSOUT
 S SRW=^SRO(133.8,SRSS,1,SROFN,0),DFN=$P(SRW,"^") D DEM^VADPT S SRSDPT=VADM(1),SROPER=$P(SRW,"^",2),Y=SRSDT D D^DIQ S SRDT=$E(Y,1,12)
 S Y=$P(SRW,"^",4) S:Y="" SRADT="" I Y D D^DIQ S SRADT=$E(Y,1,12)
 S (Y,SROPDT)=$P(SRW,"^",5) I Y D D^DIQ S SROPDT=Y
 S SRSDPT=$S($L(SRSDPT)<24:SRSDPT,1:$E(SRSDPT,1,23))
 K SROP,MM,MMM S:$L(SROPER)<40 SROP(1)=SROPER I $L(SROPER)>39 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,SRDT,?15,SRSDPT,?40,SROP(1),!,"Tentative Admission: "_SRADT I $D(SROP(2)) W ?40,SROP(2)
 I SROPDT'="" W !,"Tentative Date of Operation: "_SROPDT
 S SROLD=0 D OLD^SRSWLST I SROLD W !,"* Procedure performed since entry on list ("_SROLD("DATE")_")"
 W ! F LINE=1:1:80 W "-"
 Q
LOOP ; break operation if greater than 39 characters
 S SROP(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROP(M))+$L(MM)'<39  S SROP(M)=SROP(M)_MM_" ",SROPER=MMM
 Q
PAGE ; end of page
 I 'SRHDR S SRHDR=1 D HDR Q
 I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 D HDR
 Q
