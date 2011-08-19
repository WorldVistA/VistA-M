SRSWL15 ;B'HAM ISC/MAM - WAITING LIST, EXTENDED-ONE ; 17 OCT 1989  7:35 AM
 ;;3.0; Surgery ;**34**;24 Jun 93
 W ! K %ZIS,POP,IOP,IO("Q") S %ZIS("A")="Print the Waiting List on which Device: ",%ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTDESC="SURGERY WAITING LIST",ZTRTN="BEG^SRSWL15" D ^%ZTLOAD G END
BEG ; entry when queued
 K ^TMP("SR",$J)
 U IO S (SRSOUT,SRHDR)=0 D NOW^%DTC S Y=% D D^DIQ S SRTIME=$E(Y,1,12)_" at "_$E(Y,14,18)
 ;
 ; The AP cross reference is used to get the Patient Number, the record
 ; number and sub-record number associated with that Patient.
 ; SRPNM is set to Patient Number; SRSS=the record #; SROFN =
 ; sub-record; SRSNM is set to the Surgical Specialty. The TMP
 ; global is set to contain the Surgical Specialty, Tentative Date
 ; of Operation, and corresponding record and sub-record numbers.
 ;
 S SRPNM="" F  S SRPNM=$O(^SRO(133.8,"AP",SRPNM)) Q:SRPNM=""  S SROFN="" F  S SROFN=$O(^SRO(133.8,"AP",SRPNM,SRSS,SROFN)) Q:SROFN=""  D MORE
 ;
 ; Below, extract information from TMP  in order of Surgical
 ; Specialty and within Surgical Specialty in order by Tentative Date
 ; of Operation.
 ;
 D HDR S SROPDT="" F  S SROPDT=$O(^TMP("SR",$J,SRSNM,SROPDT)) Q:SROPDT=""!(SRSOUT)  S SRSS="" F  S SRSS=$O(^TMP("SR",$J,SRSNM,SROPDT,SRSS)) Q:'SRSS!(SRSOUT)  D ANOTHER
END I $E(IOST)="P" W ! S SRSOUT=1 W @IOF
 I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME W @IOF
 D ^%ZISC,^SRSKILL K SRTN
 Q
MORE S SRTEMP=^SRO(133.8,SRSS,1,SROFN,0),SROPDT=$P($G(SRTEMP),"^",5),SROPDT=$S(SROPDT'="":SROPDT,1:"None Specified") S ^TMP("SR",$J,SRSNM,SROPDT,SRSS,SROFN)=""
 Q
ANOTHER S SROFN="" F  S SROFN=$O(^TMP("SR",$J,SRSNM,SROPDT,SRSS,SROFN)) Q:'SROFN!(SRSOUT)  D PRINT
 Q
PRINT ; print information
 I $Y+20>IOSL D PAGE Q:SRSOUT
 S SRW=^SRO(133.8,SRSS,1,SROFN,0),DFN=$P(SRW,"^") D DEM^VADPT S SRSDPT=VADM(1)_" ("_VA("PID")_")",SROPER=$P(SRW,"^",2),Y=$P(SRW,"^",3) D D^DIQ S SRDT=$E(Y,1,12)_" "_$E(Y,14,18)
 D OUT^SRSWL3
 Q
PAGE ; end of page
 I 'SRHDR S SRHDR=1 D HDR Q
 I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 D HDR
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S SRHDR=1 W:$Y @IOF W !,"Surgery Waiting List for ",SRSNM,!,"Printed "_SRTIME,! F LINE=1:1:80 W "="
 Q
LOOP ; break operation if greater than 59 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<59  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
AGAIN ; reprint patient name, date entered, and procedure when referring
 ; physician will not fit on first page
 Q:$Y+6<IOSL
 D PAGE Q:SRSOUT
 W !,"Patient:",?14,SRSDPT,?65,"(continued)",!,"Date Entered:",?14,SRDT,!,"Procedure:",?14,SROPS(1) I $D(SROPS(2)) W !,?14,SROPS(2)
 Q
