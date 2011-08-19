SRSRBW1 ;B'HAM ISC/MAM - REQUESTS BY WARD (ALL) ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**50**;24 Jun 93
 W ! K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="Q" D ^%ZIS G:POP END I $D(IO("Q")) K IO("Q") S ZTDESC="Requests by Ward",ZTRTN="WARD^SRSRBW1",(ZTSAVE("DT"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD G END
WARD ; entry when queued
 S X="T-1" D ^%DT S SRSDATE=Y,(DFN,SRTN,SRQ)=0 K ^TMP("SR",$J)
 F  S SRSDATE=$O(^SRF("AR",SRSDATE)) Q:'SRSDATE  F  S DFN=$O(^SRF("AR",SRSDATE,DFN)) Q:'DFN  F  S SRTN=$O(^SRF("AR",SRSDATE,DFN,SRTN)) Q:'SRTN  I $$DIV^SROUTL0(SRTN) S SRS=$S($P(^SRF(SRTN,0),"^",4):$P(^(0),"^",4),1:"") D SETUTL
WLIST ; get waiting list patients
 S (COUNT,SRSS)=0
 F  S SRSS=$O(^SRO(133.8,"AWL",SRSS)) Q:'SRSS  S SRS=+^SRO(133.8,SRSS,0),SRSDATE=0 F  S SRSDATE=$O(^SRO(133.8,"AWL",SRSS,SRSDATE)) Q:'SRSDATE  D MOREWL
UTL ; loop through ^TMP("SR",$J) and print data
 U IO S (SRW,SRSDATE,SRTN,SRZ)=0
 F  S SRW=$O(^TMP("SR",$J,SRW)) Q:SRW=""!SRQ  D PAGE Q:SRQ  D HDR F  S SRSDATE=$O(^TMP("SR",$J,SRW,SRSDATE)) Q:SRSDATE=""!SRQ  F  S SRTN=$O(^TMP("SR",$J,SRW,SRSDATE,SRTN)) Q:SRTN=""!SRQ  D PRINT
 I 'SRQ,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^SRSKILL K SRTN D ^%ZISC W @IOF
 Q
LOOP ; break procedure if greater than 65 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
MOREWL ; continue getting patients on waiting list
 S SRWL=0 F  S SRWL=$O(^SRO(133.8,"AWL",SRSS,SRSDATE,SRWL)) Q:'SRWL  D SETUTL1
 Q
SETUTL ; set ^TMP("SR",$J)
 S SRS("N")=$S(SRS:$P(^SRO(137.45,SRS,0),"^"),1:"") D DEM^VADPT
 S SRNM=VADM(1),SRSSN=VA("PID"),SRSOP=$P(^SRF(SRTN,"OP"),"^"),SRWARD=$S($D(^DPT(DFN,.1)):$P(^(.1),"^"),1:""),Y=SRSDATE D D^DIQ S SRDATE=Y
 I SRWARD="" D NOWARD
 S ^TMP("SR",$J,SRWARD,SRSDATE,SRTN)=SRDATE_"^"_SRNM_"^"_SRS("N")_"^"_SRSOP_"^"_SRSSN
 Q
SETUTL1 ; set ^TMP("SR",$J) with waiting list info
 S DFN=+^SRO(133.8,SRSS,1,SRWL,0),SRSOP=$P(^(0),"^",2)
 S SRWARD=$S($D(^DPT(DFN,.1)):$P(^(.1),"^"),1:"") I SRWARD="" D NOWARD
 D DEM^VADPT S SRS=$P(^SRO(137.45,SRSS,0),"^"),SRS=$P(SRS,"("),SRNM=VADM(1),SRSSN=VA("PID"),COUNT=COUNT+1
 S ^TMP("SR",$J,SRWARD,"WAITING LIST","WL"_COUNT)="WAITING LIST^"_SRNM_"^"_SRS_"^"_SRSOP_"^"_SRSSN
 Q
PRINT ; print information
 I $Y+6>IOSL D PAGE Q:SRQ  D HDR Q:SRQ
 S SRZ=1,STBY=^TMP("SR",$J,SRW,SRSDATE,SRTN),SROPER=$P(STBY,"^",4) K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,$P(STBY,"^"),?14,$P(STBY,"^",2),?45,$P($P(STBY,"^",3),"("),!,SRTN,?14,$P(STBY,"^",5),!,?14,SROPS(1) I $D(SROPS(2)) W !,?14,SROPS(2) I $D(SROPS(3)) W !,?14,SROPS(3)
 W ! F LINE=1:1:80 W "-"
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRQ=1 Q
 W:$Y @IOF W !,?5,"Operative Requests for "_SRW,!!,"Date",?14,"Patient",?45,"Surgical Specialty",!,"Case Number",?14,"ID #",!,?14,"Operative Procedure",! F LINE=1:1:80 W "="
 Q
PAGE ; end of screen
 Q:'SRZ  I $E(IOST)'="P" W !!,"Press RETURN to continue or '^' to quit.  " R X:DTIME I '$T!(X="^") S SRQ=1
 Q
NOWARD ; check for scheduled admission
 S (X,PEND)=0 F  S PEND=$O(^DGS(41.1,"B",DFN,PEND)) Q:'PEND  S PDATE=$P(^DGS(41.1,PEND,0),"^",2) I PDATE>DT S SRWARD="ADM. PENDING",X=1
 Q:X=1  S SRWARD="OUTPATIENT"
 Q
