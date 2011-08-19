SRSWL4 ;B'HAM ISC/MAM - WAITING LIST, EXTENDED-ONE SPECIALTY ; 17 OCT 1989  7:35 AM [ 09/12/94  1:00 PM ]
 ;;3.0; Surgery ;**34**;24 Jun 93
 W ! K %ZIS,POP,IOP,IO("Q") S %ZIS("A")="Print the Waiting List on which Device: ",%ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTDESC="SURGERY WAITING LIST",ZTRTN="BEG^SRSWL4",(ZTSAVE("SRSS"),ZTSAVE("SRSNM"))="" D ^%ZTLOAD G END
BEG ; entry when queued
 U IO S SRSOUT=0 D NOW^%DTC S Y=% D D^DIQ S SRTIME=$E(Y,1,12)_" at "_$E(Y,14,18) D HDR
 S SRSDT=0 F  S SRSDT=$O(^SRO(133.8,"AWL",SRSS,SRSDT)) Q:'SRSDT!(SRSOUT)  S SROFN=0 F  S SROFN=$O(^SRO(133.8,"AWL",SRSS,SRSDT,SROFN)) Q:'SROFN!(SRSOUT)  D PRINT
END I $E(IOST)="P" S SRSOUT=1 W @IOF
 I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME W @IOF
 D ^%ZISC,^SRSKILL K SRTN
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W:$Y @IOF W !,"Surgery Waiting List for "_SRSNM,!,"Printed "_SRTIME,! F LINE=1:1:80 W "="
 Q
PRINT ; print information
 I $Y+20>IOSL D PAGE Q:SRSOUT
 S SRW=^SRO(133.8,SRSS,1,SROFN,0),DFN=$P(SRW,"^") D DEM^VADPT S SRSDPT=VADM(1)_" ("_VA("PID")_")",SROPER=$P(SRW,"^",2),Y=SRSDT D D^DIQ S SRDT=$E(Y,1,12)_" "_$E(Y,14,18)
 D OUT^SRSWL3
 Q
LOOP ; break operation if greater than 59 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<59  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
PAGE ; end of page
 I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 D HDR
 Q
