SRSWL14 ;BIR/MAM - WAITING LIST, BRIEF-ONE ; [ 12/06/99  11:10 AM ]
 ;;3.0; Surgery ;**92**;24 Jun 93
 W ! K %ZIS,POP,IOP,IO("Q") S %ZIS("A")="Print the Waiting List on which Device: ",%ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTDESC="SURGERY WAITING LIST",ZTRTN="BEG^SRSWL14" D ^%ZTLOAD G END
BEG ; entry when queued
 K ^TMP("SR",$J)
 U IO S (SRSOUT,SRHDR)=0 D NOW^%DTC S Y=% D D^DIQ S SRTIME=$E(Y,1,12)_" at "_$E(Y,14,18)
 ;
 ; The AP cross reference is used to get the Patient Number, the record
 ; number and sub-record number associated with that Patient.
 ; SRPNM is set to Patient Number; SRSS = the record #; SROFN =
 ; sub-record; SRSNM is set to the Surgical Specialty. The TMP 
 ; global is set to contain the Surgical Specialty, Tentative Date
 ; of Operation, and corresponding record and sub-record numbers.
 ;
 S SRPNM="" F  S SRPNM=$O(^SRO(133.8,"AP",SRPNM)) Q:SRPNM=""  S SROFN="" F  S SROFN=$O(^SRO(133.8,"AP",SRPNM,SRSS,SROFN)) Q:SROFN=""  D MORE
 ;
 ; Below, extract information from TMP in order of Surgical
 ; Specialty and within Surgical Specialty by Tentative Date of
 ; Operation.
 ;
 D PAGE S SROPDT="" F  S SROPDT=$O(^TMP("SR",$J,SRSNM,SROPDT)) Q:SROPDT=""!SRSOUT  S SRSS="" F  S SRSS=$O(^TMP("SR",$J,SRSNM,SROPDT,SRSS)) Q:SRSS=""!SRSOUT  D ANOTHER
END I $E(IOST)="P" S SRSOUT=1 W @IOF
 I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME W @IOF
 D ^%ZISC,^SRSKILL K SRTN
 Q
MORE S SRTEMP=^SRO(133.8,SRSS,1,SROFN,0),SROPDT=$P($G(SRTEMP),"^",5),SROPDT=$S(SROPDT'="":SROPDT,1:"None Specified"),^TMP("SR",$J,SRSNM,SROPDT,SRSS,SROFN)=""
 Q
ANOTHER S SROFN="" F  S SROFN=$O(^TMP("SR",$J,SRSNM,SROPDT,SRSS,SROFN)) Q:'SROFN!SRSOUT  D PRINT
 Q
PRINT ; print information
 I $Y+5>IOSL D PAGE Q:SRSOUT
 S SRW=^SRO(133.8,SRSS,1,SROFN,0),DFN=$P(SRW,"^") D DEM^VADPT S SRSDPT=VADM(1),SROPER=$P(SRW,"^",2),Y=$P(SRW,"^",3) D D^DIQ S SRDT=$E(Y,1,12)
 S Y=$P(SRW,"^",4) S:Y="" SRADT="" I Y D D^DIQ S SRADT=$E(Y,1,12)
 S TEMPDT=SROPDT
 I TEMPDT?7N S Y=TEMPDT D D^DIQ S TEMPDT=$E(Y,1,12)
 S SRSDPT=$S($L(SRSDPT)<24:SRSDPT,1:$E(SRSDPT,1,23))
 K SROP,MM,MMM S:$L(SROPER)<40 SROP(1)=SROPER I $L(SROPER)>39 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,SRDT,?15,SRSDPT,?40,SROP(1),!,"Tentative Admission: "_SRADT I $D(SROP(2)) W ?40,SROP(2)
 W !,"Tentative Date of Operation: "_TEMPDT
 S SROLD=0 D OLD^SRSWLST I SROLD W !,"* Procedure performed since entry on list ("_SROLD("DATE")_")"
 W ! F LINE=1:1:80 W "-"
 Q
PAGE ; end of page
 I 'SRHDR S SRHDR=1 D HDR Q
 I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 D HDR
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S SRHDR=1 W:$Y @IOF W !,"Surgery Waiting List for ",SRSNM,!,"Printed "_SRTIME,!!,"Date Entered",?15,"Patient",?40,"Operative Procedure",! F LINE=1:1:80 W "="
 Q
LOOP ; break operation if greater than 39 characters
 S SROP(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROP(M))+$L(MM)'<39  S SROP(M)=SROP(M)_MM_" ",SROPER=MMM
 Q
