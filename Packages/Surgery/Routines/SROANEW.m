SROANEW ;BIR/MAM - CREATE NEW RISK ASSESSMENT ;01/18/07
 ;;3.0; Surgery ;**34,47,71,100,135,160**;24 Jun 93;Build 7
 W @IOF,!,?1,VADM(1)_"  "_VA("PID")
 W !! S (SRDT,CNT)=0 F I=0:0 S SRDT=$O(^SRF("ADT",DFN,SRDT)) Q:'SRDT!(SRSOUT)  S SRASS=0 F I=0:0 S SRASS=$O(^SRF("ADT",DFN,SRDT,SRASS)) Q:'SRASS!($D(SRTN))!(SRSOUT)  D LIST I $D(SRTN) G ASK
 I 'CNT W "No operations exist for this patient.  Assessment cannot be entered.",!!,"Press RETURN to continue... " R X:DTIME G END
OPT W !!,"Select Operation: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 I '$D(SRCASE(X)) W !!,"Enter the number of the desired operation" W $S('$D(SRNEWOP):".",1:", or '"_CNT_"' to enter a new case.") G OPT
 S SRTN=+SRCASE(X)
ASK I SRATYPE="N" D EXCL^SROASS
 I $P($G(^SRF(SRTN,"RA")),"^",6)="N"!($P($G(^SRF(SRTN,"RA")),"^",7)'="") W !!,"This case is currently flagged as meeting Risk Assessment exclusion criteria.",$C(7)
 W !!,"Are you sure that you want to create a Risk Assessment for this surgical",!,"case ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") K SRTN S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter 'YES' to create an assessment for this surgical case, or 'NO' to quit",!,"this option." G ASK
 I "Yy"'[SRYN K SRTN S SRSOUT=1 Q
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN) Q
 .I $P($G(^SRF(SRTN,"RA")),"^",6)="N"!($P($G(^SRF(SRTN,"RA")),"^",7)'="") D DRDEL^SRONASS
 .K DIE,DR,DA S DA=SRTN,DIE=130,DR="284////"_SRATYPE_";Q;323////Y;235////I" D ^DIE K DR,DIE,DA
 .N X S X=$P($G(^SRF(SRTN,209)),"^",12) I X="" D
 ..S DA=SRTN,DIE=130,DR="490////N" D ^DIE K DR,DIE,DA
 E  K SRTN
 Q
LIST ; list assessments
 I $P($G(^SRF(SRASS,"NON")),"^")="Y" Q
 S SRSCAN=1 I $D(^SRF(SRASS,.2)),$P(^(.2),"^",12)'="" K SRSCAN
 I $D(SRSCAN),$P($G(^SRF(SRASS,30)),"^") Q
 I $D(SRSCAN),$P($G(^SRF(SRASS,31)),"^",8) Q
 I $D(^SRF(SRASS,37)),$P(^(37),"^") Q
 I $Y+5>IOSL S SRBACK=0 D SEL Q:$D(SRTN)!(SRSOUT)  I SRBACK S CNT=0,SRASS=SRCASE(1)-1,SRDT=$P(SRCASE(1),"^",2) W @IOF,!,?1,VADM(1)_"   "_VA("PID"),! Q
 S CNT=CNT+1,SRSDATE=$P(^SRF(SRASS,0),"^",9)
DISP S SROPER=$P(^SRF(SRASS,"OP"),"^") I $O(^SRF(SRASS,13,0)) S SROTHER=0 F I=0:0 S SROTHER=$O(^SRF(SRASS,13,SROTHER)) Q:'SROTHER  D OTHER
 S SR("RA")=$G(^SRF(SRASS,"RA")) I "N"'[$P(SR("RA"),"^",6) S CNT=CNT-1 Q
 S SROP=SRASS D ^SROP1
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
SEL ; select case
 W !!!,"Select Operation, or enter <RET> to continue listing Procedures: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X="" W @IOF,!,?1,VADM(1)_"  "_VA("PID"),!! Q
 I '$D(SRCASE(X)) W !!,"Please enter the number corresponding to the Surgical Case you want to edit.",!,"If the case desired does not appear, enter <RET> to continue listing",!,"additional cases."
 I '$D(SRCASE(X)) W !!,"Press <RET> to continue  " R X:DTIME S:'$T SRSOUT=1 S SRBACK=1 Q
 S SRTN=+SRCASE(X)
 Q
TYPE K DR,DIE S DR="284////"_SRATYPE,DIE=139,DA=SRTN D ^DIE
 K DR,DA,DIE S DR="235////I",DIE=139,DA=SRTN D ^DIE K DR
END D ^SRSKILL W @IOF
 Q
