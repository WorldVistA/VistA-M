SRSWL6 ;B'HAM ISC/MAM - WAITING LIST, BRIEF-ALL ; 17 OCT 1989  7:35 AM
 ;;3.0; Surgery ;**34**;24 Jun 93
 ; Sort by Surgical Specialty then by Patient
 W ! K %ZIS,POP,IOP,IO("Q") S %ZIS("A")="Print the Waiting List on which Device: ",%ZIS="Q" D ^%ZIS Q:POP
 ;
 I $D(IO("Q")) K IO("Q") S ZTDESC="SURGERY WAITING LIST",ZTRTN="BEG^SRSWL6" D ^%ZTLOAD G END
BEG ; entry when queued
 K ^TMP("SR",$J)
 U IO S (SRSOUT,SRHDR)=0 D NOW^%DTC S Y=% D D^DIQ S SRTIME=$E(Y,1,12)_" at "_$E(Y,14,18)
 ;
 ;
 S SS="",ST="",SR="",SRW="",SRNAME="",SRRECNO="",SRSUB="",DFN="",SRSDPT="",SRSNM="",NAME="",STNAME=""
 ;
 F  S SRW=$O(^SRO(133.8,"AP",SRW)) Q:SRW=""  F  S SRRECNO=$O(^SRO(133.8,"AP",SRW,SRRECNO)) Q:SRRECNO=""  F  S SRSUB=$O(^SRO(133.8,"AP",SRW,SRRECNO,SRSUB)) Q:SRSUB=""  D MORE
 ;
 F  S NAME=$O(^TMP("SR",$J,NAME)) Q:NAME=""!(SRSOUT)  F  S SS=$O(^TMP("SR",$J,NAME,SS)) Q:SS=""!(SRSOUT)  F  S SR=$O(^TMP("SR",$J,NAME,SS,SR)) Q:SR=""!(SRSOUT)  F  S ST=$O(^TMP("SR",$J,NAME,SS,SR,ST)) Q:ST=""!(SRSOUT)  D PRINT
END I $E(IOST)="P" S SRSOUT=1 W @IOF
 I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME W @IOF
 D ^%ZISC,^SRSKILL K SRTN
 Q
PRINT ; print information
 I $Y+5>IOSL!(STNAME'=NAME) S STNAME=NAME D PAGE Q:SRSOUT
 ;
 S SRSDPT=SS,SRSS=SR,SROFN=ST
 ;
 S SRW=^SRO(133.8,SRSS,1,SROFN,0),DFN=$P(SRW,"^"),SROPER=$P(SRW,"^",2),Y=$P(SRW,"^",3) D D^DIQ S SRDT=$E(Y,1,12)
 ;
 S Y=$P(SRW,"^",4) S:Y="" SRADT="" I Y D D^DIQ S SRADT=$E(Y,1,12)
 ;
 S (Y,SROPDT)=$P(SRW,"^",5) I Y D D^DIQ S SROPDT=Y
 ;
 S SRSDPT=$S($L(SRSDPT)<24:SRSDPT,1:$E(SRSDPT,1,23))
 ;
 K SROP,MM,MMM S:$L(SROPER)<40 SROP(1)=SROPER I $L(SROPER)>39 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 ;
 W !,SRDT,?15,SRSDPT,?40,SROP(1),!,"Tentative Admission: "_SRADT I $D(SROP(2)) W ?40,SROP(2)
 ;
 I SROPDT="" S SROPDT="None Specified"
 W !,"Tentative Date of Operation: "_SROPDT
 ;
 S SROLD=0 D OLD^SRSWLST I SROLD W !,"* Procedure performed since entry on list ("_SROLD("DATE")_")"
 ;
 W ! F LINE=1:1:80 W "-"
 Q
LOOP ; break operation if greater than 39 characters
 S SROP(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROP(M))+$L(MM)'<39  S SROP(M)=SROP(M)_MM_" ",SROPER=MMM
 Q
PAGE ; end of page
 I 'SRHDR S SRHDR=1 D HDR Q
 ;
 I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 D HDR
 Q
 ;
MORE S DFN=SRW D DEM^VADPT S SRSDPT=VADM(1) S SRSNM=$P(^SRO(133.8,SRRECNO,0),"^"),SRSNM=$P(^SRO(137.45,SRSNM,0),"^") S ^TMP("SR",$J,SRSNM,SRSDPT,SRRECNO,SRSUB)=""
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S SRHDR=1 W:$Y @IOF W !,"Surgery Waiting List for "_NAME,!,"Printed "_SRTIME,!!,"Date Entered",?15,"Patient",?40,"Operative Procedure",! F LINE=1:1:80 W "="
 Q
