SROERR2 ;B'HAM/ADM - ORDER ENTRY ROUTINE ; 25 JUNE 1992  10:00 AM
 ;;3.0; Surgery ;;24 Jun 93
 S DFN=+ORVP D DEM^VADPT S SRNAME=VADM(1),SRSSN=VA("PID"),SRAGE=ORAGE,SRWARD=$S($D(^DPT(DFN,.1)):^(.1),1:"NOT ENTERED")
 S SRSS=$P(^SRF(SRTN,"NON"),"^",8),SRSNM=$S(SRSS:$P(^ECC(723,SRSS,0),"^"),1:"UNKNOWN")
 S SROSUR=$P(^SRF(SRTN,"NON"),"^",6),SROATT=$P(^("NON"),"^",7)
 S SROR=$P(^SRF(SRTN,"NON"),"^",2),Y=$P(^SRF(SRTN,"NON"),"^",3) D D^DIQ S SRSDATE=Y
 S SROPER=$P(^SRF(SRTN,"OP"),"^") K SROP S (X,CNT)=0 F  S X=$O(^SRF(SRTN,13,X)) Q:'X  S CNT=CNT+1,SROP(CNT)=$P(^SRF(SRTN,13,X,0),"^")
 K SROPS,MM,MMM S:$L(SROPER)<56 SROPS(1)=SROPER I $L(SROPER)>55 S SROPER=SROPER_"  ",J=55 F M=1:1 D LOOP Q:MMM=""
 S:SROSUR SROSUR=$P(^VA(200,SROSUR,0),"^") S SROATT=$S(SROATT:$P(^VA(200,SROATT,0),"^"),1:"NOT ENTERED")
 S SRDIAG=$S($D(^SRF(SRTN,33)):$P(^(33),"^"),1:"") I SRDIAG="" S SRDIAG="NOT ENTERED"
 S SRSTAT=$S($P($G(^SRF(SRTN,30)),"^"):" (ABORTED)",$P($G(^SRF(SRTN,"NON")),"^",5):" (COMPLETED)",1:" (NOT COMPLETE)")
 I $P($G(^SRF(SRTN,"NON")),"^",4) D OPTM
PRINT ;
 I $E(IOST)="C" W @IOF,!,"Patient: "_SRNAME,?40,"ID#: "_VA("PID"),?65,"Age: "_SRAGE,!,"Ward: "_SRWARD,?40,"Case #"_SRTN_SRSTAT,! F LINE=1:1:80 W "-"
 I $E(IOST)'="C" W !,"Ward: "_SRWARD,?40,"Case #"_SRTN_SRSTAT
 W !,"Date of Procedure: "_SRSDATE
 I $P($G(^SRF(SRTN,"NON")),"^",4) W !,"Time Procedure Began: "_SRSTART,?40,"Time Procedure Ended: "_SREND
 I SROR W !,"Non-O.R. Location: "_$P(^SC(SROR,0),"^")
 W !!,"Medical Specialty: "_SRSNM,!,"Provider: "_SROSUR,?40,"Attending: "_SROATT,!,"Preoperative Diagnosis: "_SRDIAG
 W !!,"Principal Procedure:",?22,SROPS(1) I $D(SROPS(2)) W !,?22,SROPS(2) I $D(SROPS(3)) W !,?22,SROPS(3) I $D(SROPS(4)) W !,?22,SROPS(4) I $D(SROPS(5)) W !,?22,SROPS(5)
 I $O(SROP(0)) W !,"Other Procedures:",?22,SROP(1) S CNT=1 F I=0:0 S CNT=$O(SROP(CNT)) Q:'CNT  W !,?22,SROP(CNT)
 I $O(^SRF(SRTN,5,0)) W !!,"Comments: " S X=0 F I=0:0 S X=$O(^SRF(SRTN,5,X)) Q:'X  W !,^SRF(SRTN,5,X,0)
 Q
LOOP ; break procedure if greater than J characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<J  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
OPTM ; find begin and end times
 S (SRSTART,Y)=$P($G(^SRF(SRTN,"NON")),"^",4) I Y D D^DIQ S SRFIND=$F(Y,":"),SRSTART=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 S (SREND,Y)=$P($G(^SRF(SRTN,"NON")),"^",5) I Y D D^DIQ S SRFIND=$F(Y,":"),SREND=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 Q
