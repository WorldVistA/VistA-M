SRSCHUP ;B'HAM ISC/MAM - UPDATE SCHEDULED OPERATION ; 6 Jan 1989  10:56 AM
 ;;3.0; Surgery ;**7**;24 Jun 93
 W ! K DIC S SRSOUT=0,DIC=2,DIC(0)="AEQM",DIC("A")="Select Patient: " D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S (DFN,SRSDPT)=+Y K Y D DEM^VADPT S SRNM=VADM(1),SRSSN=VA("PID"),SRNAME=VADM(1)_" ("_VA("PID")_")"
LOOK W @IOF,!,SRNAME,!! S (SRTN,CNT)=0 F I=0:0 S SRTN=$O(^SRF("B",DFN,SRTN)) Q:SRTN=""  S CNT=CNT+1,SROP1(CNT)=SRTN D LIST
 I '$D(SROP1(1)) D DEM^VADPT W !!,"There are no procedures scheduled for "_VADM(1)_".",!! W !!,"Press RETURN to continue  " R X:DTIME G END
ASK R !!,"Select Number: ",SRNUM:DTIME I '$T!("^"[SRNUM) G END
 I SRNUM["?" W !!,"Enter the number which corresponds to the case that you want to update." G ASK
 I '$D(SROP1(SRNUM)) W !!,"You have entered an invalid number, please select again. " G ASK
 S SRTN=SROP1(SRNUM) I $P(^SRF(SRTN,0),"^",4)="" D SS I SRSOUT G END
 G ^SRSUP1
END D ^SRSKILL K SRTN
 W @IOF
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,OPER,0),"^"))>235 S SRLONG=0,OPER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,OPER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
LIST ; list cases
 S SRSDATE=$P(^SRF(SRTN,0),"^",9),SRSDATE=$E(SRSDATE,4,5)_"/"_$E(SRSDATE,6,7)_"/"_$E(SRSDATE,2,3)
OPS S SROPER=$P(^SRF(SRTN,"OP"),"^"),OPER=0 F I=0:0 S OPER=$O(^SRF(SRTN,13,OPER)) Q:OPER=""  D OTHER
 S SROP=SRTN D ^SROP1
 I SROPER'["SCHEDULED" K SROP1(CNT) S CNT=CNT-1 Q
 K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,CNT_".  "_SRSDATE,?15,SROPS(1) I $D(SROPS(2)) W !,?15,SROPS(2) I $D(SROPS(3)) W !,?15,SROPS(3) I $D(SROPS(4)) W !,?15,SROPS(4) I $D(SROPS(5)) W !,?15,SROPS(5)
 Q
LOOP ; break procedure if greater than 60 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
SS ; enter missing specialty
 W !!,"To continue, a Surgical Specialty MUST be defined for this case.",! K DA,DIE,DR S DIE=130,DA=SRTN,DR=".04T" D ^DIE I $D(Y)!$D(DTOUT) S SRSOUT=1
 Q
