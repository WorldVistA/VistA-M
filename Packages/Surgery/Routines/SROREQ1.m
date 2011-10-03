SROREQ1 ;BIR/MAM - REQUESTS FOR A DAY (LONG FORM) ; [ 12/09/99  11:54 AM ]
 ;;3.0; Surgery ;**48,77,92,109**;24 Jun 93
 ;
 ; Reference to ^LAB(66 supported by DBIA #210
 ;
BEG ; entry when queued
 K ^TMP("SR",$J) U IO S Y=SRSDATE D D^DIQ S SRSDT=Y
 W @IOF S (SRSOUT,DFN)=0 F  S DFN=$O(^SRF("AR",SRSDATE,DFN)) Q:'DFN  S SRTN=0 F  S SRTN=$O(^SRF("AR",SRSDATE,DFN,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$DIV^SROUTL0(SRTN) D SET
 S (SRSNM,SRHDR)=0 F  S SRSNM=$O(^TMP("SR",$J,SRSNM)) Q:SRSNM=""!SRSOUT  D PAGE S SREQDT=0 F  S SREQDT=$O(^TMP("SR",$J,SRSNM,SREQDT)) Q:SREQDT=""!(SRSOUT)  D MORE
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC W @IOF K SRTN D ^SRSKILL
 Q
MORE S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,SRSNM,SREQDT,SRTN)) Q:'SRTN!(SRSOUT)  D PRINT
 Q
SET ; set ^TMP(
 S SRSS=$P(^SRF(SRTN,0),"^",4),SRSNM=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^"),1:"UNKNOWN")
 S SREQDT=$P($G(^SRF(SRTN,"1.0")),"^",11) S:'SREQDT SREQDT="ZZ" S ^TMP("SR",$J,SRSNM,SREQDT,SRTN)=DFN
 Q
PRINT ; print requests
 I $Y+20>IOSL D PAGE I SRSOUT Q
 S DFN=^TMP("SR",$J,SRSNM,SREQDT,SRTN) D DEM^VADPT S SRNAME=VADM(1),SRSSN=VA("PID"),SRWARD=$S($D(^DPT(DFN,.1)):^(.1),1:"NOT ENTERED"),AGE=VADM(4)
 S SR(.1)=$S($D(^SRF(SRTN,.1)):^(.1),1:"")
 S SROSUR=$P(SR(.1),"^",4),SROATT=$P(SR(.1),"^",13),SROPER=$P(^SRF(SRTN,"OP"),"^") K SROP S (X,CNT)=0 F  S X=$O(^SRF(SRTN,13,X)) Q:'X  S CNT=CNT+1,SROP(CNT)=$P(^SRF(SRTN,13,X,0),"^")
 K SROPS,MM,MMM S:$L(SROPER)<56 SROPS(1)=SROPER I $L(SROPER)>55 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S:SROSUR SROSUR=$P(^VA(200,SROSUR,0),"^") I SROATT S SROATT=$P(^VA(200,SROATT,0),"^")
 S SRDIAG=$S($D(^SRF(SRTN,33)):$P(^(33),"^"),1:"") I SRDIAG="" S SRDIAG="NOT ENTERED"
 S Y=SREQDT D D^DIQ S SREQDAY=$S('$E(Y):$E(Y,1,12)_" "_$E(Y,14,18),1:"") S SR("1.0")=$G(^SRF(SRTN,"1.0"))
 S SRSPER=$P(SR("1.0"),"^",10) S:SRSPER SRSPER=$P(^VA(200,SRSPER,0),"^")
ANES S Y=$P(SR("1.0"),"^"),C=$P(^DD(130,1.01,0),"^",2) D:Y'="" Y^DIQ S SRANES=$S(Y'="":Y,1:"NOT ENTERED")
 K BLOOD S (CNT,X)=0 F  S X=$O(^SRF(SRTN,11,X)) Q:'X  S CNT=CNT+1,Y=$P(^SRF(SRTN,11,X,0),"^"),MM=$P(^(0),"^",2) S BLOOD(CNT)=Y_"  "_MM_" UNITS" ;RLM
 K SRPOS S (X,CNT)=0 F  S X=$O(^SRF(SRTN,42,X)) Q:'X  S CNT=CNT+1,Y=$P(^SRF(SRTN,42,X,0),"^"),SRPOS(CNT)=$P(^SRO(132,Y,0),"^")
 S SRLENGTH=$P($G(^SRF(SRTN,.4)),"^") I SRLENGTH="" S SRLENGTH="NOT ENTERED"
 S SRORDER=$P(^SRF(SRTN,0),"^",11)
 W ! F LINE=1:1:80 W "-"
 W !!,"Patient: "_SRNAME,?40,"ID #: "_VA("PID"),!,"Age: "_AGE,?40,"Ward: "_SRWARD,!!,"Surgeon: "_SROSUR,?40,"Attending: "_SROATT,!,"Preoperative Diagnosis: "_SRDIAG
 W !!,"Principal Procedure:",?22,SROPS(1) I $D(SROPS(2)) W !,?22,SROPS(2) I $D(SROPS(3)) W !,?22,SROPS(3) I $D(SROPS(4)) W !,?22,SROPS(4) I $D(SROPS(5)) W !,?22,SROPS(5)
 I $O(SROP(0)) W !,"Other Procedures:",?22,SROP(1) S CNT=1 F  S CNT=$O(SROP(CNT)) Q:'CNT  W !,?22,SROP(CNT)
 W !,"Estimated Case Length: "_SRLENGTH I $O(SRPOS(0)) W ?40,"Position: ",SRPOS(1) I $D(SRPOS(2)) W !,?50,SRPOS(2) I $D(SRPOS(3)) W !,?50,SRPOS(3) I $D(SRPOS(4)) W !,?50,SRPOS(4)
 I SRORDER'="" W !,"Case Schedule Order: "_SRORDER
 W !,"Requested Anesthesia Technique: "_SRANES
 I $O(BLOOD(0)) W !!,"Blood Requested: ",?18,BLOOD(1) I $D(BLOOD(2)) W !,?18,BLOOD(2) I $D(BLOOD(3)) W !,?18,BLOOD(3)
 I SRSPER'="" W !!,"Requested by: "_SRSPER W:SREQDAY'="" " on "_SREQDAY
 I $O(^SRF(SRTN,5,0)) W !!,"Comments: " S X=0 F  S X=$O(^SRF(SRTN,5,X)) Q:'X  W !,^SRF(SRTN,5,X,0)
 W ! Q
PAGE I SRHDR,$E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I X["^" S SRSOUT=1 Q
 D HDR^SROREQ Q
LOOP ; break procedure if greater than 55 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<55  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
