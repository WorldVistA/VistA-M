SROREQ2 ;BIR/MAM - REQUEST FOR A DAY (CONT) ; [ 12/09/99  11:54 AM ]
 ;;3.0; Surgery ;**48,77,92,109**;24 Jun 93
 ;
 ; Reference to ^LAB(66 supported by DBIA #210
 ;
BEG ; entry when queued
 K ^TMP("SR",$J) U IO S Y=SRSDATE D D^DIQ S SRSDT=Y
 S (SRHDR,SRSOUT)=0 D PAGE Q:SRSOUT
 S DFN=0 F  S DFN=$O(^SRF("AR",SRSDATE,DFN)) Q:'DFN  S SRTN=0 F  S SRTN=$O(^SRF("AR",SRSDATE,DFN,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$DIV^SROUTL0(SRTN),$P(^SRF(SRTN,0),"^",4)=SRSS D SET
 S SREQDT=0 F  S SREQDT=$O(^TMP("SR",$J,SREQDT)) Q:SREQDT=""!(SRSOUT)  S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,SREQDT,SRTN)) Q:'SRTN!(SRSOUT)  D PRINT
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC W @IOF K SRTN D ^SRSKILL
 Q
PAGE I SRHDR,$E(IOST)'="P" W !!,"Press <RET to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 D HDR^SROREQ
 Q
SET ; set ^TMP(
 S SREQDT=$P($G(^SRF(SRTN,"1.0")),"^",11) S:'SREQDT SREQDT="ZZ" S ^TMP("SR",$J,SREQDT,SRTN)=DFN
 Q
PRINT ; print requests
 I $Y+20>IOSL D PAGE I SRSOUT Q
 S DFN=^TMP("SR",$J,SREQDT,SRTN) D DEM^VADPT S SRNAME=VADM(1),SRSSN=VA("PID"),SRWARD=$S($D(^DPT(DFN,.1)):^(.1),1:"NOT ENTERED"),AGE=VADM(4)
 S SR(.1)=$S($D(^SRF(SRTN,.1)):^(.1),1:"")
 S SROSUR=$P(SR(.1),"^",4),SROATT=$P(SR(.1),"^",13),SROPER=$P(^SRF(SRTN,"OP"),"^") K SROP S (X,CNT)=0 F  S X=$O(^SRF(SRTN,13,X)) Q:'X  S CNT=CNT+1,SROP(CNT)=$P(^SRF(SRTN,13,X,0),"^")
 K SROPS,MM,MMM S:$L(SROPER)<56 SROPS(1)=SROPER I $L(SROPER)>55 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S:SROSUR SROSUR=$P(^VA(200,SROSUR,0),"^") I SROATT S SROATT=$P(^VA(200,SROATT,0),"^")
 S SRDIAG=$S($D(^SRF(SRTN,33)):$P(^(33),"^"),1:"") I SRDIAG="" S SRDIAG="NOT ENTERED"
 S Y=SREQDT D D^DIQ S SREQDAY=$S('$E(Y):$E(Y,1,12)_" "_$E(Y,14,18),1:"") S SR("1.0")=$S($D(^SRF(SRTN,"1.0")):^("1.0"),1:"")
 S SRSPER=$P(SR("1.0"),"^",10) S:SRSPER SRSPER=$P(^VA(200,SRSPER,0),"^")
 S Y=$P(SR("1.0"),"^"),C=$P(^DD(130,1.01,0),"^",2) D:Y'="" Y^DIQ S SRANES=$S(Y'="":Y,1:"NOT ENTERED")
 K BLOOD S (CNT,X)=0 F  S X=$O(^SRF(SRTN,11,X)) Q:'X  S CNT=CNT+1,Y=$P(^SRF(SRTN,11,X,0),"^"),MM=$P(^(0),"^",2) S BLOOD(CNT)=Y_"  "_MM_" UNITS" ;RLM
 S SRPOS=$S($D(^SRF(SRTN,.5)):$P(^(.5),"^",3),1:"") I SRPOS S SRPOS=$P(^SRO(132,SRPOS,0),"^")
 S SRLENGTH=$S($D(^SRF(SRTN,.4)):$P(^(.4),"^"),1:"NOT ENTERED")
 S SRORDER=$P(^SRF(SRTN,0),"^",11)
 W ! F LINE=1:1:80 W "-"
 W !!,"Patient: "_SRNAME,?40,"ID #: "_VA("PID"),!,"Age: "_AGE,?40,"Ward: "_SRWARD,!!,"Surgeon: "_SROSUR,?40,"Attending: "_SROATT,!,"Preoperative Diagnosis: "_SRDIAG
 W !!,"Principal Procedure:",?22,SROPS(1) I $D(SROPS(2)) W !,?22,SROPS(2) I $D(SROPS(3)) W !,?22,SROPS(3) I $D(SROPS(4)) W !,?22,SROPS(4) I $D(SROPS(5)) W !,?22,SROPS(5)
 I $O(SROP(0)) W !,"Other Procedures:",?22,SROP(1) S CNT=1 F I=0:0 S CNT=$O(SROP(CNT)) Q:'CNT  W !,?22,SROP(CNT)
 W !,"Estimated Case Length: "_SRLENGTH I SRPOS'="" W ?40,"Position: "_SRPOS
 I SRORDER W !,"Case Schedule Order: "_SRORDER
 W !!,"Req. Anesthesia Technique: "_SRANES
 I $O(BLOOD(0)) W !,"Blood Requested: ",?22,BLOOD(1) I $D(BLOOD(2)) W !,?22,BLOOD(2) I $D(BLOOD(3)) W !,?22,BLOOD(3)
 I SRSPER'="" W !,"Requested by: "_SRSPER W:SREQDAY'="" " on "_SREQDAY
 I $O(^SRF(SRTN,5,0)) W !!,"Comments: " S X=0 F  S X=$O(^SRF(SRTN,5,X)) Q:'X  W !,^SRF(SRTN,5,X,0)
 W ! Q
LOOP ; break procedure if greater than 55 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<55  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
