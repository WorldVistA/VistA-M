SRSCPT1 ;BIR/MAM - MISSING CPTS (1 SPECIALTY) ;03/29/06
 ;;3.0; Surgery ;**59,50,88,142,144**;24 Jun 93
 F  S SRSDT=$O(^SRF("AC",SRSDT)) Q:'SRSDT!(SRSDT>SRSEDT)  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDT,SRTN)) Q:'SRTN  I $P($G(^SRF(SRTN,30)),"^")="",$D(^SRF(SRTN,0)),$$DIV^SROUTL0(SRTN) D UTIL
 S STARTDT=$E(SDATE,4,5)_"/"_$E(SDATE,6,7)_"/"_$E(SDATE,2,3),ENDATE=$E(EDATE,4,5)_"/"_$E(EDATE,6,7)_"/"_$E(EDATE,2,3)
 S (SRHDR,SRSOUT)=0 D HDR S SRHDR=1,SRSDT=0 F  S SRSDT=$O(^TMP("SR",$J,SRSDT)) Q:'SRSDT!(SRSOUT)  S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,SRSDT,SRTN)) Q:'SRTN!(SRSOUT)  K SR,SROP D SET
 I '$D(^TMP("SR",$J)) W $$NODATA^SROUTL0()
 Q
SET ; set variables & print info
 I $Y+8>IOSL D HDR I SRSOUT Q
 S SRNON=0 I $P($G(^SRF(SRTN,"NON")),"^")="Y" S SRNON=1
 S SR(0)=^SRF(SRTN,0)
 I SRFLG=1!(SRFLG=3&('SRNON)) Q:$P(SR(0),"^",4)'=SRSPEC
 I SRFLG=2!(SRFLG=3&(SRNON)) Q:$P($G(^SRF(SRTN,"NON")),"^",8)'=SRSPEC
 S DFN=+SR(0) D DEM^VADPT S SRSNM=VADM(1),SRSSN=VA("PID"),Y=$P(SR(0),"^",9) D D^DIQ S SRSDATE=$E(Y,1,12) I $L(SRSNM)>23 S SRSNM=$P(VADM(1),",")_","_$E($P(VADM(1),",",2))_"."
 S SROP(1)=$P(^SRF(SRTN,"OP"),"^")
 S CNT=1,OP=0 F  S OP=$O(^SRF(SRTN,13,OP)) Q:'OP  D
 .S CNT=CNT+1,SROP(CNT)=$P(^SRF(SRTN,13,OP,0),"^")
 S SR(.1)=$S($D(^SRF(SRTN,.1)):^(.1),1:"")
 S SRSUR=$S(SRNON:$P(^SRF(SRTN,"NON"),"^",6),1:$P(SR(.1),"^",4)) S:SRSUR="" SRSUR="NOT ENTERED" I SRSUR S SRSUR=$P(^VA(200,SRSUR,0),"^") I $L(SRSUR)>19 S SRSUR=$P(SRSUR,",")_","_$E($P(SRSUR,",",2))_"."
 W !,SRSDATE,?18,SRSNM_" ("_VA("PID")_")",?60,SRSUR,!,SRTN W:SRFLG=3&(SRNON) !,"NON-O.R."
 S CNT=0 F  S CNT=$O(SROP(CNT)) Q:'CNT  S SROPER="* "_SROP(CNT) D OPS
 W ! F LINE=1:1:80 W "-"
 Q
UTIL ; set ^TMP("SR",$J)
 S SRNON=0 I $P($G(^SRF(SRTN,"NON")),"^")="Y" S SRNON=1
 I SRFLG=1!(SRFLG=3&('SRNON)) Q:$P($G(^SRF(SRTN,.2)),"^",12)=""
 I SRFLG=2 Q:'SRNON
 S SRMISS=0 I '$P($G(^SRO(136,SRTN,0)),"^",2) S SRMISS=1
 I 'SRMISS Q
UT S ^TMP("SR",$J,SRSDT,SRTN)=""
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 I SRHDR,$E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:.  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 S SRTITLE=$S(SRFLG=1:"O.R. Surgical Procedures",SRFLG=2:"Non-O.R. Procedures",1:"O.R. Surgical and Non-O.R. Procedures")
 W:$Y @IOF W !,?(80-$L(SRINST)\2),SRINST,!,?23,"Completed Cases Missing CPT Codes",!,?(80-$L(SRTITLE)\2),SRTITLE,!,?(80-$L(SRFRTO)\2),SRFRTO
 W !,?(80-$L("Specialty: "_SRSPECN)\2),"Specialty: "_SRSPECN,!!,"Operation Date",?18,"Patient (ID#)",?60,"Surgeon/Provider",!,"Case #",! F LINE=1:1:80 W "="
 Q
OPS ; print operations
 K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,?18,SROPS(1) I $D(SROPS(2)) W !,?18,SROPS(2) I $D(SROPS(3)) W !,?18,SROPS(3) I $D(SROPS(4)) W !,?18,SROPS(4)
 Q
LOOP ; break procedure if greater than 59 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
