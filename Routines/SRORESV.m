SRORESV ;B'HAM ISC/MAM - DISPLAY O.R. RESERVATION ; 6 DEC 1991  3:50 PM
 ;;3.0; Surgery ;**7**;24 Jun 93
 S S(0)=^SRF(SRTN,0),S(.1)=$G(^SRF(SRTN,.1)),S(31)=$G(^SRF(SRTN,31)),SROPER=$P(^SRF(SRTN,"OP"),"^"),DFN=$P(S(0),"^") D DEM^VADPT
 S SRSDATE=$E($P(S(0),"^",9),1,7),SRSOR=$P(S(0),"^",2),SRSDOC=$P(S(.1),"^",4),SRATT=$P(S(.1),"^",13),SRSST=$P(S(31),"^",4),SRSET=$P(S(31),"^",5)
 S SRSDOC=$S(SRSDOC:$P(^VA(200,SRSDOC,0),"^"),1:"") D OPS
 S SRSDT1=SRSST,SRSDT2=SRSET
 S SRSST=SRSST_"0000",SRSET=SRSET_"0000",SRSST=$P(SRSST,".",2),SRSET=$P(SRSET,".",2)
 S SRSST=$E(SRSST,1,2)_"."_$E(SRSST,3,4),SRSET=$E(SRSET,1,2)_"."_$E(SRSET,3,4)
 S Y=SRSDT1 D D^DIQ S SRSTART=$P(Y,"@")_" "_$S($P(Y,"@",2)'="":$E($P(Y,"@",2),1,5),1:"00:00"),Y=SRSDT2 D D^DIQ S SREND=$P(Y,"@")_" "_$P(Y,"@",2)
 S X=$P(^SRS(SRSOR,0),"^"),SRSORN=$P(^SC(X,0),"^")
 W @IOF,!,"Operating Room Reservations:",!!,"Surgeon: "_SRSDOC,!,"Patient: "_VADM(1)
 W !,SROPS(1) I $D(SROPS(2)) W !,?15,SROPS(2) I $D(SROPS(3)) W !,?15,SROPS(3) I $D(SROPS(4)) W !,?15,SROPS(4)
 W !!,"Operating Room:  "_SRSORN,!,"Scheduled Start: "_SRSTART,!,"Scheduled End:   "_SREND
 Q
OPS S SROPER="Procedure(s): "_$P(^SRF(SRTN,"OP"),"^"),OPER=0 F  S OPER=$O(^SRF(SRTN,13,OPER)) Q:OPER=""  D OTHER
 K SROPS,MM,MMM S:$L(SROPER)<75 SROPS(1)=SROPER I $L(SROPER)>74 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 Q
LOOP ; break procedure if greater than 75 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<75  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,OPER,0),"^"))>250 S SRLONG=0,OPER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,OPER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
