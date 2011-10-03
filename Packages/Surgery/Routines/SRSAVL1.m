SRSAVL1 ;B'HAM ISC/MAM - LIST REQUEST ON DISPLAY ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**50**;24 Jun 93
REQUEST ; list requests
 W !!,"Press RETURN to list Operation Requests, or '^' to quit:  " R SRX:DTIME I '$T!(SRX["^") S SRSOUT=1 Q
 S IOP=IO_";80",%ZIS="" D ^%ZIS I SR10'="" W SR10
ASK I SRX["?" W !!,"Enter RETURN to list all requests for this date, or '^' to return to the",!,"previous menu.",!!,"Press RETURN to list Operation Requests, or '^' to quit:  " R SRX:DTIME S:'$T!(SRX["^") SRSOUT=1 Q:SRSOUT  G ASK
 S SRHDR=0,Y=SRSDATE D D^DIQ S SRDT=Y I '$D(^SRF("AR",SRSDATE)) W @IOF,!,"There are no requests entered for "_SRDT_"." Q
 K ^TMP("SR",$J) S DFN=0 F  S DFN=$O(^SRF("AR",SRSDATE,DFN)) Q:'DFN  S SRTN=0 F  S SRTN=$O(^SRF("AR",SRSDATE,DFN,SRTN)) Q:'SRTN  D:$$DIV^SROUTL0(SRTN) UTIL
 S SERV=0 F  S SERV=$O(^TMP("SR",$J,SERV)) Q:SERV=""!(SRSOUT)  D HDR S CNT=0 S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,SERV,SRTN)) Q:'SRTN!(SRSOUT)  D PRINT
 Q
UTIL ; set ^TMP("SR",$J)
 S SR(0)=^SRF(SRTN,0),SERV=$P(SR(0),"^",4),SERV=$S(SERV:$P(^SRO(137.45,SERV,0),"^"),1:"SPECIALTY NOT ENTERED")
 S ^TMP("SR",$J,SERV,SRTN)=""
 Q
PRINT ; print info
 I $Y+6>IOSL D HDR I SRSOUT Q
 S SR(0)=^SRF(SRTN,0),DFN=$P(SR(0),"^") D DEM^VADPT S SRPAT=VADM(1)
 S SR(.1)=$G(^SRF(SRTN,.1)),SRSUR=$P(SR(.1),"^",4) I SRSUR S SRSUR=$P(^VA(200,SRSUR,0),"^")
 S SROPER="Procedure(s): "_$P(^SRF(SRTN,"OP"),"^") K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S SRORD=$P(SR(0),"^",11),SRHRS=$P($G(^SRF(SRTN,.4)),"^")
 S CNT=CNT+1 W !,CNT_".",?5,"Patient: "_SRPAT,?40,"Case Number: "_SRTN,!,?5,"Surgeon: "_SRSUR,?40,"Case Order:  "_SRORD
 W !,?5,SROPS(1) I $D(SROPS(2)) W !,?19,SROPS(2)
 I '$D(^SRF(SRTN,"CON")) W ! Q
 S CON=$P(^SRF(SRTN,"CON"),"^") I 'CON W ! Q
 W !!,?8,"Concurrent Case Number: "_CON
 S SROPER="Procedure: "_$P(^SRF(CON,"OP"),"^") K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,?8,SROPS(1) I $D(SROPS(2)) W !,?19,SROPS(2)
 W !
 Q
LOOP ; break procedure if greater than 60 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
HDR ; print heading
 I SRHDR W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 S SRHDR=1
 W @IOF,!,?17,"Requested Operative Procedures for "_SRDT,!,?(80-$L("Surgical Specialty: "_SERV)\2),"Surgical Specialty: "_SERV,! F LINE=1:1:80 W "-"
 Q
