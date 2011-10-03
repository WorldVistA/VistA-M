SROUNV1 ;B'HAM ISC/MAM - UNVERIFIED CASES (1 SPECIALTY) ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**50**;24 Jun 93
 U IO S SRSOUT=0 K ^TMP("SR",$J) S SRSDT=SDATE-.0001,SRSEDT=EDATE+.9999
 F  S SRSDT=$O(^SRF("AC",SRSDT)) Q:'SRSDT!(SRSDT>SRSEDT)  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDT,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$MANDIV^SROUTL0(SRINSTP,SRTN) D UTIL
 S SRHDR=0 D HDR S SRHDR=1,SRSDT=0 F  S SRSDT=$O(^TMP("SR",$J,SRSDT)) Q:'SRSDT!(SRSOUT)  S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,SRSDT,SRTN)) Q:'SRTN!(SRSOUT)  K SR,SROP D SET
 I '$D(^TMP("SR",$J)) W !!,"No data for selected date range."
 Q
SET ; set variables & print info
 I $Y+8>IOSL D HDR I SRSOUT Q
 S SR(0)=^SRF(SRTN,0),DFN=$P(SR(0),"^") D DEM^VADPT S SRSNM=VADM(1),Y=$P(SR(0),"^",9) D D^DIQ S SRSDATE=$E(Y,1,12)
 S SRSSN=VA("PID")
 S SROPER=$P(^SRF(SRTN,"OP"),"^"),SRCPT=$P(^("OP"),"^",2) I SRCPT="" S SROPER=SROPER_" * CPT CODE MISSING *"
 S SR(.1)=$S($D(^SRF(SRTN,.1)):^(.1),1:"")
 S SRSUR=$P(SR(.1),"^",4) S:SRSUR="" SRSUR="NOT ENTERED" I SRSUR S SRSUR=$P(^VA(200,SRSUR,0),"^") I $L(SRSUR)>19 S SRSUR=$P(SRSUR,",")_", "_$E($P(SRSUR,",",2))
 S SRATT=$P(SR(.1),"^",13) S:SRATT="" SRATT="NOT ENTERED" I SRATT S SRATT=$P(^VA(200,SRATT,0),"^") I $L(SRATT)>19 S SRATT=$P(SRATT,",")_", "_$E($P(SRATT,",",2))
 W !,SRSDATE,?20,SRSNM_" ("_SRTN_")",?60,SRSUR,!,?20,VA("PID"),?60,SRATT,!
 K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,?20,SROPS(1) I $D(SROPS(2)) W !,?20,SROPS(2) I $D(SROPS(3)) W !,?20,SROPS(3)
 W ! F LINE=1:1:80 W "-"
 Q
UTIL ; set ^TMP("SR",$J)
 I $P($G(^SRF(SRTN,"VER")),"^")="Y" Q
 Q:'$D(^SRF(SRTN,.2))  S SR(.2)=^SRF(SRTN,.2) I $P(SR(.2),"^",12)="" Q
 I $D(^SRF(SRTN,31)),$P(^(31),"^",8)'="" Q
 I $D(^SRF(SRTN,30)),$P(^(30),"^")'="" Q
 I $P(^SRF(SRTN,0),"^",4)'=SRSPEC Q
 S ^TMP("SR",$J,SRSDT,SRTN)=""
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 I SRHDR,$E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit.  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 W:$Y @IOF W !,?5,"List of Unverified Cases for "_SRSPECN,!!,"Operation Date",?20,"Patient (Case #)",?60,"Surgeon",!,?20,"Patient ID #",?60,"Attending Surgeon",! F LINE=1:1:80 W "="
 Q
LOOP ; break procedure if greater than 59 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
