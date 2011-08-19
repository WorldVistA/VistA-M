SROERR1 ;B'HAM/ADM - ORDER ENTRY ROUTINE ; 25 JUNE 1992  10:00 AM
 ;;3.0; Surgery ;**109**;24 Jun 93
 S DFN=+ORVP D DEM^VADPT S SRNAME=VADM(1),SRSSN=VA("PID"),SRAGE=ORAGE,SRWARD=$S($D(^DPT(DFN,.1)):^(.1),1:"NOT ENTERED")
 S SROERR=SRTN D STATUS^SROERR0 K SROERR S SRSTAT=" "_SRSTATUS
 S SRSS=$P(^SRF(SRTN,0),"^",4),SRSNM=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^"),1:"UNKNOWN")
 S SROSUR=$P(^SRF(SRTN,.1),"^",4),SROATT=$P(^(.1),"^",13)
 S SROR=$P(^SRF(SRTN,0),"^",2),Y=$P(^SRF(SRTN,0),"^",9) D D^DIQ S SRSDATE=Y
 S SROPER=$P(^SRF(SRTN,"OP"),"^") K SROP S (X,CNT)=0 F  S X=$O(^SRF(SRTN,13,X)) Q:'X  S CNT=CNT+1,SROP(CNT)=$P(^SRF(SRTN,13,X,0),"^")
 K SROPS,MM,MMM S:$L(SROPER)<56 SROPS(1)=SROPER I $L(SROPER)>55 S SROPER=SROPER_"  ",J=55 F M=1:1 D LOOP Q:MMM=""
 S:SROSUR SROSUR=$P(^VA(200,SROSUR,0),"^") S SROATT=$S(SROATT:$P(^VA(200,SROATT,0),"^"),1:"NOT ENTERED")
 S SRDIAG=$S($D(^SRF(SRTN,33)):$P(^(33),"^"),1:"") I SRDIAG="" S SRDIAG="NOT ENTERED"
 S SR("1.0")=$G(^SRF(SRTN,"1.0")),A=$P(SR("1.0"),"^"),SRANES=$S(A="G":"GENERAL",A="L":"LOCAL",A="S":"SPINAL",A="B":"BLOCK",A="C":"CHOICE",A="MAC":"MONITORED ANES CARE",A="E":"EPIDURAL",1:"NOT ENTERED")
 K SREST S (X,CNT)=0 F I=0:0 S X=$O(^SRF(SRTN,20,X)) Q:'X  S CNT=CNT+1,Y=$P(^SRF(SRTN,20,X,0),"^"),SREST(CNT)=$P(^SRO(132.05,Y,0),"^")
 K BLOOD S (CNT,X)=0 F I=0:0 S X=$O(^SRF(SRTN,11,X)) Q:'X  S CNT=CNT+1,Y=$P(^SRF(SRTN,11,X,0),"^"),MM=$P(^(0),"^",2) S BLOOD(CNT)=Y_"  "_MM_" UNITS" ;RLM
 S SRLENGTH=$P($G(^SRF(SRTN,.4)),"^") I SRLENGTH="" S SRLENGTH="NOT ENTERED"
 S SRORDER=$P(^SRF(SRTN,0),"^",11) I ORSTS=8 D SCHED
 I $P($G(^SRF(SRTN,.2)),"^",2) D OPTM
 I $P($G(^SRF(SRTN,30)),"^") S Y=$P(^(30),"^") D D^DIQ S SRCAN=Y,X=$P($G(^SRF(SRTN,31)),"^",8) I X S SREAS=$P(^SRO(135,X,0),"^")
PRINT ;
 I $E(IOST)="C" W @IOF,!,"Patient: "_SRNAME,?40,"ID#: "_VA("PID"),?65,"Age: "_SRAGE,!,"Ward: "_SRWARD,?40,"Surgical Case #"_SRTN_SRSTAT,! F LINE=1:1:80 W "-"
 I $E(IOST)'="C" W !,"Ward: "_SRWARD,?40,"Surgical Case #"_SRTN_SRSTAT
 W !,"Date of Operation: "_SRSDATE,?40,"Estimated Case Length: "_SRLENGTH
 I ORSTS=8 W !,"Scheduled Start Time: "_SRST,?40,"Scheduled End Time: "_SRET
 I ORSTS=1 W !,"Cancel Date: "_SRCAN,?34,"Cancel Reason: "_SREAS
 I $P($G(^SRF(SRTN,.2)),"^",2) W !,"Time Operation Began: "_SRSTART,?40,"Time Operation Ended: "_SREND
 I SROR W !,"Operating Room: "_$P(^SC($P(^SRS(SROR,0),"^"),0),"^")
 W !!,"Surgical Specialty: "_SRSNM,!,"Surgeon: "_SROSUR,?40,"Attending: "_SROATT,!,"Preoperative Diagnosis: "_SRDIAG
 W !!,"Principal Procedure:",?22,SROPS(1) I $D(SROPS(2)) W !,?22,SROPS(2) I $D(SROPS(3)) W !,?22,SROPS(3) I $D(SROPS(4)) W !,?22,SROPS(4) I $D(SROPS(5)) W !,?22,SROPS(5)
 I $O(SROP(0)) W !,"Other Procedures:",?22,SROP(1) S CNT=1 F I=0:0 S CNT=$O(SROP(CNT)) Q:'CNT  W !,?22,SROP(CNT)
 I ORSTS=5,SRORDER'="" W !,"Case Schedule Order: "_SRORDER
 W !,"Requested Anesthesia Technique: "_SRANES
 I $O(BLOOD(0)) W !!,"Blood Requested: ",?18,BLOOD(1) I $D(BLOOD(2)) W !,?18,BLOOD(2) I $D(BLOOD(3)) W !,?18,BLOOD(3)
 I $O(SREST(0)) W !,"Restraints: ",?18,SREST(1) I $D(SREST(2)) W ", "_SREST(2) I $D(SREST(3)) W ", "_SREST(3) I $D(SREST(4)) W ", "_SREST(4)
 I $O(^SRF(SRTN,5,0)) W !!,"Comments: " S X=0 F I=0:0 S X=$O(^SRF(SRTN,5,X)) Q:'X  W !,^SRF(SRTN,5,X,0)
CON K SRSCON I $P($G(^SRF(SRTN,"CON")),"^") S SRSCON=$P(^("CON"),"^") K SROPS S SROPER=$P(^SRF(SRSCON,"OP"),"^") S:$L(SROPER)<80 SROPS(1)=SROPER I $L(SROPER)>79 S SROPER=SROPER_"  ",J=79 F M=1:1 D LOOP Q:MMM=""
 I $D(SRSCON) W !!,"Concurrent Case #"_SRSCON,!,SROPS(1) I $D(SROPS(2)) W !,SROPS(2) I $D(SROPS(3)) W !,SROPS(3)
 Q
LOOP ; break procedure if greater than J characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<J  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
SCHED ; find scheduling times
 S (SRST,Y)=$P($G(^SRF(SRTN,31)),"^",4) I Y D D^DIQ S SRFIND=$F(Y,":"),SRST=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 S (SRET,Y)=$P($G(^SRF(SRTN,31)),"^",5) I Y D D^DIQ S SRFIND=$F(Y,":"),SRET=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 Q
OPTM ; find begin and end times
 S (SRSTART,Y)=$P($G(^SRF(SRTN,.2)),"^",2) I Y D D^DIQ S SRFIND=$F(Y,":"),SRSTART=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 S (SREND,Y)=$P($G(^SRF(SRTN,.2)),"^",3) I Y D D^DIQ S SRFIND=$F(Y,":"),SREND=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 Q
