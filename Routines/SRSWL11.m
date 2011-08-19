SRSWL11 ;B'HAM ISC/MAM - WAITING LIST, EXTENDED-ALL ; 17 OCT 1989  7:35 AM
 ;;3.0; Surgery ;**34**;24 Jun 93
 W ! K %ZIS,POP,IOP,IO("Q") S %ZIS("A")="Print to Device: ",%ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTDESC="SURGERY WAITING LIST",ZTRTN="BEG^SRSWL11" D ^%ZTLOAD G END
 ;
BEG ; entry when queued
 K ^TMP("SR",$J)
 U IO S (SRSOUT,SRHDR)=0 D NOW^%DTC S Y=% D D^DIQ S SRTIME=$E(Y,1,12)_" at "_$E(Y,14,18)
 S SS="",ST="",SR="",SRW="",SRNAME="",SRRECNO="",SRSUB="",DFN="",SRSDPT="",SRHDR=0
 ;
 F  S SRW=$O(^SRO(133.8,"AP",SRW)) Q:SRW=""  F  S SRRECNO=$O(^SRO(133.8,"AP",SRW,SRRECNO)) Q:SRRECNO=""  F  S SRSUB=$O(^SRO(133.8,"AP",SRW,SRRECNO,SRSUB)) Q:SRSUB=""  D MORE
 W @IOF D HDR
 ;
 F  S SS=$O(^TMP("SR",$J,SS)) Q:SS=""!(SRSOUT)  F  S SR=$O(^TMP("SR",$J,SS,SR)) Q:SR=""!(SRSOUT)  F  S ST=$O(^TMP("SR",$J,SS,SR,ST)) Q:ST=""!(SRSOUT)  D PRINT
END ;
 I $E(IOST)="P" W ! S SRSOUT=1 W @IOF
 I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME W @IOF
 D ^%ZISC,^SRSKILL K SRTN
 Q
PRINT ; print information
 S SRSDPT=SS,SRSS=SR,SROFN=ST
 I $Y+20>IOSL S SRHDR=0 D PAGE S SRHDR=1 Q:SRSOUT
 S SRW=^SRO(133.8,SRSS,1,SROFN,0),DFN=$P(SRW,"^",1),SROPER=$P(SRW,"^",2),(SRDT,Y)=$P(SRW,"^",3) I Y D D^DIQ S SRDT=$E(Y,1,12)_" "_$E(Y,14,18)
 D OUT^SRSWL3
 Q
LOOP ; break operation if greater than 59 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<59  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
PAGE ; end of page
 I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 D HDR
 Q
MORE S SRNAME=$P(^SRO(133.8,SRRECNO,0),"^"),SRNAME=$P(^SRO(137.45,SRNAME,0),"^")
 I SRNAME=SRSNM S DFN=SRW D DEM^VADPT S SRSDPT=VADM(1)_" ("_VA("PID")_")",^TMP("SR",$J,SRSDPT,SRRECNO,SRSUB)=""
 Q
 ;
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W:$Y @IOF W !,"Surgery Waiting List sorted by Patient",!,"Surgical Specialty is "_SRSNM,!,"Printed "_SRTIME,! F LINE=1:1:80 W "="
 S SRHDR=1
 Q
