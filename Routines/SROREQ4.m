SROREQ4 ;BIR/MAM - OPERATION REQUESTS (SHORT) ; [ 12/09/99  11:54 AM ]
 ;;3.0; Surgery ;**26,48,92,161**;24 Jun 93;Build 5
BEG ; entry when queued
 K ^TMP("SR",$J) U IO S (CNT,DFN,SRSOUT)=0
 S Y=SRSDATE,SRDT=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3) D D^DIQ S SRSDT=$E(Y,1,12)
 F  S DFN=$O(^SRF("AR",SRSDATE,DFN)) Q:'DFN  S SRTN=0 F  S SRTN=$O(^SRF("AR",SRSDATE,DFN,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$DIV^SROUTL0(SRTN) D SET
 W:$Y @IOF S SRSNM=0 F  S SRSNM=$O(^TMP("SR",$J,SRSNM)) Q:SRSNM=""!(SRSOUT)  D HDR S (SREQDT,CNT)=0 F  S SREQDT=$O(^TMP("SR",$J,SRSNM,SREQDT)) Q:SREQDT=""!(SRSOUT)  D MORE
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 S:$E(IOST)="P" SRSOUT=1 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC K SRTN D ^SRSKILL W @IOF
 Q
MORE ; continue looping
 S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,SRSNM,SREQDT,SRTN)) Q:'SRTN!(SRSOUT)  D PRINT
 Q
SET ; set ^TMP(
 S SRSS=$P(^SRF(SRTN,0),"^",4),SRSNM=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^"),1:"ZZ")
 S SREQDT=$P($G(^SRF(SRTN,"1.0")),"^",11) S:'SREQDT SREQDT="ZZ"
 S ^TMP("SR",$J,SRSNM,SREQDT,SRTN)=""
 Q
PRINT ; print from ^TMP("SR",$J)
 I $Y+7>IOSL D PAGE I SRSOUT Q
 S S(0)=$G(^SRF(SRTN,0)) Q:'S(0)  ; << RJS *161
 S DFN=$P(S(0),"^"),CNT=CNT+1
 D DEM^VADPT S SRNAME=VADM(1),SROPER=$P(^SRF(SRTN,"OP"),"^"),SRSUR=$P($G(^SRF(SRTN,.1)),"^",4),SRSUR=$S(SRSUR:$P(^VA(200,SRSUR,0),"^"),1:"NOT ENTERED")
 S SRHRS=$P($G(^SRF(SRTN,.4)),"^"),SRD=$E(SRSDATE,4,5)_"/"_$E(SRSDATE,6,7)_"/"_$E(SRSDATE,2,3)
 S:SRHRS="" SRHRS="NOT ENTERED" S C=$P(^DD(130,.035,0),"^",2),Y=$P(S(0),"^",10) D:Y'="" Y^DIQ S SRTYPE=Y,SRANES=$P($G(^SRF(SRTN,"1.0")),"^"),Y=SRANES,C=$P(^DD(130,1.01,0),"^",2) D:Y'="" Y^DIQ S SRANES=Y
 S SRSORD=$P(S(0),"^",11),SSN=VA("PID"),SRWARD=$S($D(^DPT(DFN,.1)):^(.1),1:"") I SRTYPE'="" S SRTYPE=" ("_$P(SRTYPE,"(")_")"
 K SROPS,MM,MMM S SROPER=SROPER_SRTYPE S:$L(SROPER)<63 SROPS(1)=SROPER I $L(SROPER)>62 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !!,CNT_".",?5,"Case Number: "_SRTN,?40,"Operation Date: "_SRD,!,?5,"Patient: ",?14,SRNAME,?40,"Ward: ",SRWARD,!,?5,"ID#: ",?14,VA("PID"),?40,"Surgeon: "_SRSUR,!,?5,"Procedure: "_SROPS(1)
 I $D(SROPS(2)) W !,?16,SROPS(2) I $D(SROPS(3)) W !,?16,SROPS(3) I $D(SROPS(4)) W !,?16,SROPS(4)
 W !,?5,"Estimated Case Length: "_SRHRS W:SRSORD'="" !,?5,"Case Schedule Order:   "_SRSORD W:SRANES'="" !,?5,"Requested Anesthesia:  "_SRANES
 K SRSCON I $D(^SRF(SRTN,"CON")),$P(^("CON"),"^") S SRSCON=$P(^("CON"),"^") K A S SROPER=$P(^SRF(SRSCON,"OP"),"^") S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MM=""
 I $D(SRSCON) W !,"Concurrent Case # "_SRSCON,!,SROPS(1) I $D(SROPS(2)) W !,SROPS(2) I $D(SROPS(3)) W !,SROPS(3)
 Q
PAGE I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I X["^" S SRSOUT=1 Q
 W:$Y @IOF
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 I $Y+4>IOSL D PAGE Q
 W !! F LINE=1:1:80 W "="
 W !,"REQUESTS FOR "_$S(SRSNM'="ZZ":SRSNM,1:"UNKNOWN"),?70,SRDT,! F LINE=1:1:80 W "-"
 Q
LOOP ; break procedure if greater than 63 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<63  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
