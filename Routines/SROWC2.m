SROWC2 ;B'HAM ISC/ADM - WOUND CLASSIFICATION REPORT (CONT.) ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**50**;24 Jun 93
 S (SRHDR,SRSOUT)=0,PAGE=1 K ^TMP("SR",$J)
 F  S SRSD=$O(^SRF("AC",SRSD)) Q:'SRSD!(SRSD>SRED)  S SRCASE=0 F  S SRCASE=$O(^SRF("AC",SRSD,SRCASE)) Q:'SRCASE  I $D(^SRF(SRCASE,0)),$$MANDIV^SROUTL0(SRINSTP,SRCASE) D UTIL
 D CLIST
 S SRWC="" F  S SRWC=$O(^TMP("SR",$J,SRWC)) Q:SRWC=""!(SRSOUT)  S SRSS="" F  S SRSS=$O(^TMP("SR",$J,SRWC,SRSS)) Q:SRSS=""!(SRSOUT)  D SPEC
 I '$D(^TMP("SR",$J)) D HDR W !!,"No data for selected date range."
 D END
 Q
SPEC S SRSPEC=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^"),1:"NO SPECIALTY ENTERED") D HDR
 S SRCASE="" F  S SRCASE=$O(^TMP("SR",$J,SRWC,SRSS,SRCASE)) Q:'SRCASE!(SRSOUT)  D CASE
 Q
UTIL ; set ^TMP
 Q:$P($G(^SRF(SRCASE,30)),"^")'=""
 Q:$P($G(^SRF(SRCASE,.2)),"^",12)=""
 S SRSS=$P(^SRF(SRCASE,0),"^",4) S:SRSS="" SRSS="ZZ" I SRSP,'$D(SRSP(SRSS)) Q
 S SRWC=$P($G(^SRF(SRCASE,"1.0")),"^",8) I SRCLASS'="ALL",SRWC'=SRCLASS Q
 S:SRWC="" SRWC="ZZ" S ^TMP("SR",$J,SRWC,SRSS,SRCASE)=""
 Q
CASE ; print individual cases
 I $Y+7>IOSL D HDR I SRSOUT Q
 S S(0)=^SRF(SRCASE,0),DFN=$P(S(0),"^") D DEM^VADPT S SRNM=VADM(1),SRSSN=VA("PID"),Y=$P(S(0),"^",9) D D^DIQ S SRSDATE=$E(Y,1,12)
 K SROP S SROP(1)=$P(^SRF(SRCASE,"OP"),"^")
 S CNT=1,OP=0 F  S OP=$O(^SRF(SRCASE,13,OP)) Q:'OP  S CNT=CNT+1,SROP(CNT)=$P(^SRF(SRCASE,13,OP,0),"^")
 S SRSUR=$P($G(^SRF(SRCASE,.1)),"^",4) I SRSUR S SRSUR=$P(^VA(200,SRSUR,0),"^")
 W !,SRSDATE,?18,SRNM,?50,SRSUR,!,SRCASE,?18,VA("PID"),!
 S CNT=0 F  S CNT=$O(SROP(CNT)) Q:'CNT  S SROPER="* "_SROP(CNT) D OPS W !
 F LINE=1:1:80 W "-"
 Q
OPS ; print operations
 K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W ?18,SROPS(1) I $D(SROPS(2)) W !,?18,SROPS(2) I $D(SROPS(3)) W !,?18,SROPS(3) I $D(SROPS(4)) W !,?18,SROPS(4)
 Q
LOOP ; break procedure if greater than 59 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 I SRHDR,$E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 W:$Y @IOF W !,?17,"List of Surgical Cases by Wound Classification",?75,"Page:"
 W !,?(80-$L(SRFRTO)\2),SRFRTO,?77,PAGE
 I SRWC'="" S SRWD="Wound Classification: "_SRCODE(SRWC) W !,?(80-$L(SRWD)\2),SRWD,!,SRPRINT
 W !!,"Operation Date",?18,"Patient",?50,"Surgeon/Provider",!,"Case #",?18,"ID #",! F LINE=1:1:80 W "="
 I $D(SRSPEC) W !,?(80-$L(">> "_SRSPEC_" <<")\2),">> "_SRSPEC_" <<",!
 S SRHDR=1,PAGE=PAGE+1
 Q
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC,^SRSKILL W @IOF
 Q
CLIST ; get list of wound class codes
 N SRLIST,SRC,SRP,I,J,X,Y D HELP^DIE(130,"",1.09,"S","SRLIST")
 F I=2:1:SRLIST("DIHELP") S X=SRLIST("DIHELP",I),Y=$F(X," "),SRC=$E(X,1,Y-2) F J=Y:1 I $E(X,J)'=" " S SRP=$E(X,J,99),SRCODE(SRC)=SRP Q
 S SRCODE("ZZ")="NO CLASS ENTERED"
 Q
