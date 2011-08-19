SRTPTRAN ;BIR/SJA - TRANSPLANT DATA ENTRY ;02/27/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 N SR,SRVA,SRNOVA K SRTPP
 D:'$D(SRTPP) ^SRTPSS I '$D(SRTPP)!$G(SRSOUT) Q
 I $D(SRTPP) S SR("RA")=$G(^SRT(SRTPP,"RA")),SRVA=$P(SR("RA"),"^",5),SRNOVA=$S(SRVA="N":1,1:0),SRTTYPE=$P(SR("RA"),"^",2)
ENTER ; edit, delete, complete, or change indicator
 I $D(SRPRINT)!'($D(SRNEW)) Q
 I $P(SR("RA"),"^")="T"!($P(SR("RA"),"^")="C") D TRANS I 'SRYN K SRASS,SRTPP S SRSOUT=1 G END
 S DFN=$P(^SRT(SRTPP,0),"^") D DEM^VADPT D HDR^SRTPSS S SRANM=VADM(1)_"  "_VA("PID")
 W @IOF,!,?1,SRANM,!! S SRSDATE=$P(^SRT(SRTPP,0),"^",2) S SRASS=SRTPP D DISP^SRTPASS
 W !!,"1. Enter Transplant Assessment Information",!,"2. Delete Transplant Assessment Entry",!,"3. Update Transplant Assessment Status to 'COMPLETE'"
 W !,"4. Change VA/Non-VA Transplant Indicator"
 W !!,"Select Number: 1// " R X:DTIME I '$T!(X["^") K SRTN,SRASS S SRSOUT=1 G END
 S:X="" X=1 I X<1!(X>4)!(X'?.N) D HELP G ENTER
 I X=2 D DEL^SRTPVAN W !!,"Press <RET> to continue  " R X:DTIME W @IOF K SRTN,SRTPP G END
 I X=3 D ^SRTPCOM G END
 I X=4 D ^SRTPVAN G END
 I X=1 D @$S(SRTTYPE="K":"^SRTPKID1",SRTTYPE="LI":"^SRTPLIV1",SRTTYPE="LU":"^SRTPLUN1",1:"^SRTPHRT1")
END S:'$D(SRSOUT) SRSOUT=1 W:SRSOUT @IOF K SRTPP D ^SRSKILL
 Q
HELP ;
 W !!,"Enter <RET> or '1' to enter or edit information related to this ",!,"Assessment entry.  If you want to delete the Assessment, enter '2'."
 W !,"Enter '3' to update the status of this Assessment to 'COMPLETE'.",!,"Enter '4' to change the Assessment type from VA to Non-VA or vice versa"
 W !!,"Press <RET> to continue  " R X:DTIME
 Q
TRANS W !!,"This assessment has a status of "_$S($P(SR("RA"),"^")="T":"TRANSMITTED.",1:"COMPLETED."),!
 S SRYN=0 K DIR S DIR("A")="Do you wish to change the status of this assessment to 'INCOMPLETE'",DIR("B")="NO",DIR(0)="Y" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S SRYN=Y I 'SRYN Q
 K DA,DIE,DR S DIE=139.5,DA=SRTPP,DR="181////I;183////1" D ^DIE K DA,DIE,DR
 W !!,"The Assessment Status has been changed to 'INCOMPLETE'."
 Q
