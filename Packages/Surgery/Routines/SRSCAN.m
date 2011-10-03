SRSCAN ;B'HAM ISC/MAM - CANCEL SCHEDULED OPERATION ; [ 01/30/01  2:16 PM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 S SRSOUT=0 W ! K DIC S DIC=2,DIC(0)="AEQM",DIC("A")="Cancel a Scheduled Procedure for which Patient: " D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S DFN=+Y D DEM^VADPT S SRNAME=VADM(1)_" ("_VA("PID")_")" W @IOF,!,SRNAME,!
LOOK W ! S (SRTN,CNT)=0 F I=0:0 S SRTN=$O(^SRF("B",DFN,SRTN)) Q:SRTN=""  S CNT=CNT+1,SROP1(CNT)=SRTN D LIST
 I '$D(SROP1(1)) D DEM^VADPT W !!,"There are no procedures scheduled for "_VADM(1)_".",!! W !!,"Press RETURN to continue  " R X:DTIME G END
ASK R !!,"Select Number: ",SRNUM:DTIME I '$T!("^"[SRNUM) G END
 I SRNUM["?" W !!,"Enter the number which corresponds to the case that you want to cancel." G ASK
 I '$D(SROP1(SRNUM)) W !!,"You have entered an invalid number, please select again. " G ASK
 S (SRTN,SRTOLD)=SROP1(SRNUM)
 I $D(^SRF(SRTN,.2)),$P(^(.2),"^",2)'="" W !!,$C(7),"This operation already has a start time and cannot be cancelled.",!!,"Press RETURN to continue  " R X:DTIME G END
 I $P(^SRF(SRTN,31),"^",4)="" W !!,"This operation is not scheduled." H 1 G END
 D ^SRSCAN1
OK R !!,"Is this the correct operation ?  YES//  ",SRYN:DTIME I '$T!(SRYN["^") G END
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter RETURN if this is the scheduled procedure that you want",!,"to cancel, or 'NO' to quit this option." G OK
 I "Yy"'[SRYN G END
 I $$LOCK^SROUTL(SRTN) D ^SRSCAN0
END D ^SRSKILL K SRTN W @IOF
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,OPER,0),"^"))>235 S SRLONG=0,OPER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,OPER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
LOOP ; break procedure if greater than 60 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
LIST ; list cases
 S SRSDATE=$P(^SRF(SRTN,0),"^",9),SRSDATE=$E(SRSDATE,4,5)_"/"_$E(SRSDATE,6,7)_"/"_$E(SRSDATE,2,3)
OPS S SROPER=$P(^SRF(SRTN,"OP"),"^"),OPER=0 F I=0:0 S OPER=$O(^SRF(SRTN,13,OPER)) Q:OPER=""  D OTHER
 S SROP=SRTN D ^SROP1
 I SROPER'["SCHEDULED" K SROP1(CNT) S CNT=CNT-1 Q
 K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,CNT_".  "_SRSDATE,?15,SROPS(1) I $D(SROPS(2)) W !,?15,SROPS(2) I $D(SROPS(3)) W !,?15,SROPS(3) I $D(SROPS(4)) W !,?15,SROPS(4) I $D(SROPS(5)) W !,?15,SROPS(5)
