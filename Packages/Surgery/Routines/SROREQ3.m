SROREQ3 ;BIR/MAM - REQUESTS FOR A DAY (SHORT FORM) ; [ 12/09/99  11:54 AM ]
 ;;3.0; Surgery ;**26,48,92**;24 Jun 93
 W ! K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print Requests for which Surgical Specialty ?  " D ^DIC I Y'>0 S SRSOUT=1 G END
 S SRSS=+Y,SRSNM=$P(Y(0),"^")
 W ! K IOP,POP,IO("Q"),%ZIS S %ZIS("A")="Print the Requests on which Device: ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="OPERATION REQUESTS (SHORT FORM)",ZTRTN="BEG^SROREQ3",(ZTSAVE("SRSDATE"),ZTSAVE("SRSS"),ZTSAVE("SRSNM"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD S SRSOUT=1 G END
BEG ; entry when queued
 K ^TMP("SR",$J) U IO S (CNT,DFN,SRSOUT)=0,Y=SRSDATE,SRDT=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3) D D^DIQ S SRSDT=$E(Y,1,12) D HDR Q:SRSOUT
 F  S DFN=$O(^SRF("AR",SRSDATE,DFN)) Q:'DFN  S SRTN=0 F  S SRTN=$O(^SRF("AR",SRSDATE,DFN,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$DIV^SROUTL0(SRTN),$P(^SRF(SRTN,0),"^",4)=SRSS D SET
 S SREQDT=0 F  S SREQDT=$O(^TMP("SR",$J,SREQDT)) Q:SREQDT=""!(SRSOUT)  S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,SREQDT,SRTN)) Q:'SRTN!(SRSOUT)  D PRINT
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 S:$E(IOST)="P" SRSOUT=1 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC D ^SRSKILL K SRTN W @IOF
 Q
SET ; set ^TMP(
 S SREQDT=$P($G(^SRF(SRTN,"1.0")),"^",11) S:'SREQDT SREQDT="ZZ" S ^TMP("SR",$J,SREQDT,SRTN)=""
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W:$Y @IOF W !,"OPERATION REQUESTS FOR "_SRSNM,?70,SRDT,! F LINE=1:1:80 W "-"
 Q
PRINT ; print request info
 I $Y+7>IOSL D PAGE I SRSOUT Q
 S SR(0)=^SRF(SRTN,0),DFN=$P(^SRF(SRTN,0),"^"),CNT=CNT+1
 D DEM^VADPT S SRNAME=VADM(1),SROPER=$P(^SRF(SRTN,"OP"),"^")
 S SRSUR=$P($G(^SRF(SRTN,.1)),"^",4),SRSUR=$S(SRSUR:$P(^VA(200,SRSUR,0),"^"),1:"NOT ENTERED")
 S SRHRS=$P($G(^SRF(SRTN,.4)),"^"),SRSDT=$E(SRSDATE,4,5)_"/"_$E(SRSDATE,6,7)_"/"_$E(SRSDATE,2,3)
 S:SRHRS="" SRHRS="NOT ENTERED" S C=$P(^DD(130,.035,0),"^",2),Y=$P(SR(0),"^",10) D:Y'="" Y^DIQ S SRTYPE=Y,SRANES=$P($G(^SRF(SRTN,"1.0")),"^"),Y=SRANES,C=$P(^DD(130,1.01,0),"^",2) D:Y'="" Y^DIQ S SRANES=Y
 S SRSORD=$P(SR(0),"^",11),SSN=VA("PID"),SRWARD=$S($D(^DPT(DFN,.1)):^(.1),1:"") I SRTYPE'="" S SRTYPE=" ("_$P(SRTYPE,"(")_")"
 K SROPS,MM,MMM S SROPER=SROPER_SRTYPE S:$L(SROPER)<63 SROPS(1)=SROPER I $L(SROPER)>62 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !!,CNT_".",?5,"Case Number: "_SRTN,?40,"Operation Date: "_SRSDT,!,?5,"Patient: ",?16,SRNAME,?40,"Ward: ",SRWARD,!,?5,"ID#: ",?16,VA("PID"),?40,"Surgeon: "_SRSUR,!,?5,"Procedure: "_SROPS(1)
 I $D(SROPS(2)) W !,?16,SROPS(2) I $D(SROPS(3)) W !,?16,SROPS(3) I $D(SROPS(4)) W !,?16,SROPS(4)
 W !,?5,"Estimated Case Length: "_SRHRS W:SRSORD'="" !,?5,"Case Schedule Order: "_SRSORD W:SRANES'="" !,?5,"Requested Anesthesia:  "_SRANES
 K SRSCON I $D(^SRF(SRTN,"CON")),$P(^("CON"),"^") S SRSCON=$P(^("CON"),"^") K A S SROPER=$P(^SRF(SRSCON,"OP"),"^") S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MM=""
 I $D(SRSCON) W !,"Concurrent Case # "_SRSCON,!,SROPS(1) I $D(SROPS(2)) W !,SROPS(2) I $D(SROPS(3)) W !,SROPS(3)
 Q
LOOP ; break procedure if greater than 63 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<63  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
PAGE I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I X["^" S SRSOUT=1 Q
 D HDR
 Q
