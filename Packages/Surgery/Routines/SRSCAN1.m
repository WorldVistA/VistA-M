SRSCAN1 ;B'HAM ISC/MAM - CANCEL SCHEDULED OPERATION; 06/24/88  11:20
 ;;3.0; Surgery ;;24 Jun 93
 S S(0)=^SRF(SRTN,0),S(31)=^SRF(SRTN,31),SRSDOC=$P(^SRF(SRTN,.1),"^",4),SRSDATE=$E($P(S(0),"^",9),1,7),SRSOR=$P(S(0),"^",2)
 S SRSST=$P(S(31),"^",4),SRSET=$P(S(31),"^",5)
 K SRSEDT S SRSDT1=SRSST,SRSDT2=SRSET,MM=$E(SRSET,1,7),XX=$P(SRSST,1,7) I MM>XX S SRSET1=SRSET,SRSEDT=MM
 I '$D(SRSEDT) S SRSEDT=SRSDATE
 S Y=SRSST D D^DIQ S SRFIND=$F(Y,":"),SRSST=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"00:00") S Y=SRSET D D^DIQ S SRFIND=$F(Y,":"),SRSET=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 W !!,"Reservation for "_$S(SRSOR="":"",'$D(^SRS(SRSOR,0)):"",$D(^SC($P(^(0),"^"),0)):$P(^(0),"^"),1:"")
 W !,"Scheduled Start Time: "_$E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3)_" "_SRSST,!,"Scheduled End Time:   "_$E(SRSEDT,4,5)_"-"_$E(SRSEDT,6,7)_"-"_$E(SRSEDT,2,3)_" "_SRSET
 S SRSST=$P(SRSST,":")_"."_$P(SRSST,":",2),SRSET=$P(SRSET,":")_"."_$P(SRSET,":",2)
MM S DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT S SRNM=VADM(1) W !,"Patient:   "_SRNM
 K SROPS,MM,MMM S SROPER=$P(^SRF(SRTN,"OP"),"^") S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 I SRSDOC S USER=$S($D(^VA(200,SRSDOC,0)):$P(^(0),"^"),1:"")
 I SRSDOC="" S USER="NOT ENTERED"
 W !,"Physician: "_USER
 W !,"Procedure: "_SROPS(1) I $D(SROPS(2)) W !,?11,SROPS(2) I $D(SROPS(3)) W !,?11,SROPS(3) I $D(SROPS(4)) W !,?11,SROPS(4)
 Q
LOOP ; break procedure if greater than 60 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
