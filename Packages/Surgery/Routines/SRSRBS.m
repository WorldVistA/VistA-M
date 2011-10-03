SRSRBS ;B'HAM ISC/MAM - REQUESTS BY SERVICE ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**50**;24 Jun 93
A W !!,"List requests by SPECIALTY or WARD ?  SPECIALTY// " R X:DTIME S:'$T X="^" S:X="" X="S"
 Q:X["^"  S X=$E(X) I "SsWw"'[X W !!,"Enter RETURN if you would like to sort requests by SURGICAL SPECIALTY, or ",!,"'WARD' to sort by the WARD location." G A
 I "Ww"[X G ^SRSRBW
BEG W !!,"Do you want requests for all surgical specialties ? YES// " R X:DTIME S:'$T X="^" S:X="" X="Y" G:X["^" END
 S X=$E(X) I "YyNn"'[X W !!,"Enter RETURN if you would like a list of requests for all surgical specialties,",!,"or 'NO' to list the requests for a specific specialty.",! G BEG
 I "Yy"[X G ^SRSRBS1
 W ! K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC("A")="List Requests for which Specialty ? ",DIC(0)="QEAMZ" D ^DIC K DIC G:Y<0 END S SRS=+Y,SRS("N")=$P(Y(0),"^"),SRS("C")=$P(Y(0),"^",2)
 W ! K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="Q" D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Requests by Service",ZTRTN="SER^SRSRBS",(ZTSAVE("DT"),ZTSAVE("SRS"),ZTSAVE("SRS(""N"")"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD G END
SER ; entry when queued
 S X="T-1" D ^%DT S SRSDATE=Y,(DFN,SRTN,SRQ)=0 K ^TMP("SR",$J)
 F  S SRSDATE=$O(^SRF("AR",SRSDATE)) Q:'SRSDATE  F  S DFN=$O(^SRF("AR",SRSDATE,DFN)) Q:'DFN  F  S SRTN=$O(^SRF("AR",SRSDATE,DFN,SRTN)) Q:'SRTN  I $$DIV^SROUTL0(SRTN),$P(^SRF(SRTN,0),"^",4)=SRS D SETUTL
WLIST ; get waiting list patients
 S (COUNT,SRSDATE)=0
 S SRSS=$O(^SRO(133.8,"B",SRS,0)) I SRSS F  S SRSDATE=$O(^SRO(133.8,"AWL",SRSS,SRSDATE)) Q:'SRSDATE  S SRWL=0 F  S SRWL=$O(^SRO(133.8,"AWL",SRSS,SRSDATE,SRWL)) Q:'SRWL  D SETUTL1
UTL ; loop through ^TMP("SR",$J) and print data
 U IO D HDR S (SRSDATE,SRTN)=0 F  S SRSDATE=$O(^TMP("SR",$J,SRSDATE)) Q:SRSDATE=""!SRQ  F  S SRTN=$O(^TMP("SR",$J,SRSDATE,SRTN)) Q:SRTN=""!SRQ  D PRINT
 I 'SRQ,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^SRSKILL K SRTN D ^%ZISC W @IOF
 Q
LOOP ; break procedure if greater than 65 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
SETUTL ; set ^TMP("SR",$J)
 D DEM^VADPT S SRNM=VADM(1),SRSSN=VA("PID"),SRSOP=$P(^SRF(SRTN,"OP"),"^"),SRWARD=$S($D(^DPT(DFN,.1)):$P(^(.1),"^"),1:""),Y=SRSDATE D D^DIQ S SRDATE=Y
 I SRWARD="" D WARD
 S ^TMP("SR",$J,SRSDATE,SRTN)=SRDATE_"^"_SRNM_"^"_SRWARD_"^"_SRSOP_"^"_SRSSN
 Q
SETUTL1 ; set ^TMP("SR",$J) with waiting list info
 S DFN=+^SRO(133.8,SRSS,1,SRWL,0),SRSOP=$P(^(0),"^",2)
 S SRWARD=$S($D(^DPT(DFN,.1)):$P(^(.1),"^"),1:"") D DEM^VADPT S SRNM=VADM(1),SRSSN=VA("PID"),COUNT=COUNT+1
 I SRWARD="" D WARD
 S ^TMP("SR",$J,"WL","WL"_COUNT)="WAITING LIST^"_SRNM_"^"_SRWARD_"^"_SRSOP_"^"_SRSSN
 Q
PRINT ; print information
 I $Y+6>IOSL D PAGE Q:SRQ  D HDR Q:SRQ
 S STBY=^TMP("SR",$J,SRSDATE,SRTN),SROPER=$P(STBY,"^",4) K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,$P(STBY,"^"),?14,$P(STBY,"^",2),?45,$P(STBY,"^",3),!,SRTN,?14,$P(STBY,"^",5),!,?14,SROPS(1) I $D(SROPS(2)) W !,?14,SROPS(2) I $D(SROPS(3)) W !,?14,SROPS(3)
 W ! F LINE=1:1:80 W "-"
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRQ=1 Q
 W:$Y @IOF W !,?5,"Operative Requests for "_SRS("N"),!!,"Date",?14,"Patient",?45,"Ward Location",!,"Case Number",?14,"ID #",!,?14,"Operative Procedure",! F LINE=1:1:80 W "="
 Q
PAGE ; end of screen
 I $E(IOST,1)'="P" W !!,"Press RETURN to continue or '^' to quit.  " R X:DTIME I '$T!(X="^") S SRQ=1
 Q
WARD ; check for scheduled admission
 S (X,PEND)=0 F  S PEND=$O(^DGS(41.1,"B",DFN,PEND)) Q:'PEND  S PDATE=$P(^DGS(41.1,PEND,0),"^",2) I PDATE>DT S SRWARD="ADM. PENDING",X=1
 Q:X=1  S SRWARD="OUTPATIENT"
 Q
