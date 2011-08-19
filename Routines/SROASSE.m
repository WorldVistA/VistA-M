SROASSE ;B'HAM ISC/MAM - SELECT ASSESSMENT ; 27 FEB 1992  11:00 am
 ;;3.0; Surgery ;;24 Jun 93
 K SRTN W !! S SRSOUT=0 K DIC S DIC("A")="Select Patient: ",DIC=2,DIC(0)="QEAM" D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S DFN=+Y D DEM^VADPT S SRANM=VADM(1)_"  "_VA("PID")
START ; start display
 G:SRSOUT END W @IOF,!,?1,SRANM
 I $D(^DPT(DFN,.35)),$P(^(.35),"^") S SRDT=$P(^(.35),"^") W "         * DIED "_$E(SRDT,4,5)_"/"_$E(SRDT,6,7)_"/"_$E(SRDT,2,3)_" *"
 W !! S (SRDT,CNT)=0 F I=0:0 S SRDT=$O(^SRF("ADT",DFN,SRDT)) Q:'SRDT!(SRSOUT)  S SRASS=0 F I=0:0 S SRASS=$O(^SRF("ADT",DFN,SRDT,SRASS)) Q:'SRASS!($D(SRTN))!(SRSOUT)  D LIST
 I $D(SRTN) Q
 I '$D(SRCASE(1)) W !!,"There are no Surgery Risk Assessments entered for "_VADM(1)_"." Q
OPT W !!!,"Select Surgical Case: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 I '$D(SRCASE(X)) W !!,"Enter the number of the desired assessment." W:$D(SRNEW) "  Select '"_CNT_"' to create a",!,"new risk assessment entry." G OPT
 S SRTN=+SRCASE(X)
 Q
LIST ; list assessments
 I $Y+5>IOSL S SRBACK=0 D SEL Q:$D(SRTN)!(SRSOUT)  I SRBACK S CNT=0,SRASS=SRCASE(1)-1,SRDT=$P(SRCASE(1),"^",2) W @IOF,!,?1,VADM(1)_"   "_VA("PID"),! Q
 S CNT=CNT+1,SRSDATE=$P(^SRF(SRASS,0),"^",9)
DISP S SROPER=$P(^SRF(SRASS,"OP"),"^") I $O(^SRF(SRASS,13,0)) S SROTHER=0 F I=0:0 S SROTHER=$O(^SRF(SRASS,13,SROTHER)) Q:'SROTHER  D OTHER
 S SR("RA")=$G(^SRF(SRASS,"RA")),Z=$P(SR("RA"),"^"),STATUS=$S(Z="I":"INCOMPLETE",Z="C":"COMPLETED",Z="T":"TRANSMITTED",1:"INCOMPLETE")
 I "N"[$P(SR("RA"),"^",6) S STATUS="NO ASSESSMENT"
 S SROPER=SROPER_" ("_STATUS_")"
 K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 I '$D(SRTN) W CNT_". "
CASE W $E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3),?14,SROPS(1) I $D(SROPS(2)) W !,?14,SROPS(2) I $D(SROPS(3)) W !,?14,SROPS(3)
 I $D(SROPS(4)) W !,?14,SROPS(4)
 I $D(SRTN) Q
 W !! S SRCASE(CNT)=SRASS_"^"_SRDT
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRASS,13,SROTHER,0),"^"))>235 S SRLONG=0,SROTHER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRASS,13,SROTHER,0),"^")
 S SROPER=SROPER_$S(SROPERS'=" ...":", "_SROPERS,1:SROPERS)
 Q
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
END W:SRSOUT @IOF D ^SRSKILL
 Q
SEL ; select case
 W !!!,"Select Operation, or enter <RET> to continue listing Procedures: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X="" W @IOF,!,?1,VADM(1)_"  "_VA("PID"),!! Q
 I '$D(SRCASE(X)) W !!,"Please enter the number corresponding to the Surgical Case you want to edit.",!,"If the case desired does not appear, enter <RET> to continue listing",!,"additional cases."
 I '$D(SRCASE(X)) W !!,"Press <RET> to continue  " R X:DTIME S:'$T SRSOUT=1 S SRBACK=1 Q
 S SRTN=+SRCASE(X)
 Q
