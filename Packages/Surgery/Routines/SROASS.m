SROASS ;BIR/MAM - SELECT ASSESSMENT ;01/18/07
 ;;3.0; Surgery ;**38,47,64,94,121,100,160,166**;24 Jun 93;Build 6
PST K:$D(DUZ("SAV")) SRNEW K SRTN W !! S SRSOUT=0
 N SRSEL D ^SROPSEL G:'$D(DFN) END S SRANM=VADM(1)_"  "_VA("PID")
START ; start display
 G:SRSOUT END W:SRSEL=1 @IOF,!,?1,SRANM
 I $D(^DPT(DFN,.35)),$P(^(.35),"^") S SRDT=$P(^(.35),"^") W "         * DIED "_$E(SRDT,4,5)_"/"_$E(SRDT,6,7)_"/"_$E(SRDT,2,3)_" *"
 I SRSEL=2 S CNT=0 D ^SROASSN G:$D(SRTN) ENTER G PST
 D ^SROASS1 I SRSOUT G END
 I $D(SRTN) G ENTER
 I $D(SRNEW) S CNT=CNT+1,SRCASE(CNT)="" W CNT,".   ----     CREATE NEW ASSESSMENT"
 I '$D(SRCASE(1)) W !!,"There are no Surgery Risk Assessments entered for "_VADM(1)_".",!! K DIR S DIR(0)="FOA",DIR("A")="  Press RETURN to continue.  " D ^DIR Q
OPT W !!!,"Select Surgical Case: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 I '$D(SRCASE(X)) W !!,"Enter the number of the desired assessment." W:$D(SRNEW) "  Select '"_CNT_"' to create an",!,"assessment for another surgical case." G OPT
 I $D(SRNEW),X=CNT D ^SROANEW G END
 I '$D(SRTN) S SRTN=+SRCASE(X)
ENTER ; edit, complete, or delete
 I $D(SRPRINT)!'($D(SRNEW)) Q
 S SR("RA")=$G(^SRF(SRTN,"RA")) I $P(SR("RA"),"^")="T" D TRANS I 'SRYN K SRASS,SRTN S:SRSEL=2 SRSOUT=1 G START
 I SRATYPE="N"&($P(SR("RA"),"^",2)="C") W !!,"You've selected a Cardiac assessment, using a Non-Cardiac Option," K DIR S DIR(0)="Y",DIR("A")="Do you wish to continue",DIR("B")="NO" D ^DIR S X=$E(X) I "Yy"'[X K SRTN S SRSOUT=1 G END
 I SRATYPE="C"&($P(SR("RA"),"^",2)="N") W !!,"You've selected a Non-Cardiac assessment, using a Cardiac Option," K DIR S DIR(0)="Y",DIR("A")="Do you wish to continue",DIR("B")="NO" D ^DIR S X=$E(X) I "Yy"'[X K SRTN S SRSOUT=1 G END
 W @IOF,!,?1,SRANM,!! S SRSDATE=$P(^SRF(SRTN,0),"^",9) S SRASS=SRTN D DISP^SROASS1
 I SRATYPE="N" D EXCL
 W !!,"1. Enter Risk Assessment Information",!,"2. Delete Risk Assessment Entry",!,"3. Update Assessment Status to 'COMPLETE'"
 W !!,"Select Number:  1//  " R X:DTIME I '$T!(X["^") K SRTN,SRASS S SRSOUT=1 G END
 S:X="" X=1 I X<1!(X>3)!(X'?.N) D HELP G ENTER
 I X=2 D ^SROADEL W !!,"Press <RET> to continue  " R X:DTIME W @IOF K SRTN G END
 I X=3 D @($S($P(SR("RA"),"^",2)="C":"^SROACOM1",1:"^SROACOM")) K SRTN G END
 Q
EXCL I $P($G(^SRO(136,SRTN,10)),"^"),'$$XL^SROAX(SRTN) D
 .W !!,">>> Based on CPT Codes assigned for this case, this case should be excluded." Q
 N SRPROC,SRL S SRL=49 D CPTS^SROAUTL0 I SRPROC(1)="NOT ENTERED" D
 .W !!,">>> No CPT Codes have been assigned for this case."
 Q
END S:'$D(SRSOUT) SRSOUT=1 W:SRSOUT @IOF D ^SRSKILL
 Q
HELP ;
 W !!,"Enter <RET> or '1' to enter or edit information related to this Risk ",!,"Assessment entry.  If you want to delete the Assessment, enter '2'."
 W !,"Enter '3' to update the status of this Assessment to 'COMPLETE'."
 W !!,"Press <RET> to continue  " R X:DTIME
 Q
TRANS W @IOF,!,"This assessment has already been transmitted.  The information contained",!,"in it cannot be altered unless you first change the status to 'INCOMPLETE'."
 S SRYN=0 K DIR S DIR("A")="Do you wish to change the status of this assessment to 'INCOMPLETE'",DIR("B")="NO",DIR(0)="Y" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S SRYN=Y I 'SRYN Q
 I $$LOCK^SROUTL(SRTN) K DA,DIE,DR S DIE=130,DA=SRTN,DR="235////I;393////1" D ^DIE K DA,DIE,DR D UNLOCK^SROUTL(SRTN)
 Q
