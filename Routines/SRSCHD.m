SRSCHD ;B'HAM ISC/MAM - SCHEDULING UNREQUESTED CASES ; [ 02/25/02  7:27 AM ]
 ;;3.0; Surgery ;**77,100,131**;24 Jun 93
BEG W @IOF S SRSOUT=0
 K SRSDATE W ! S (SRNOREQ,SRSCHD,SRSC1)=1,ST="SCHEDULING"
 K %DT S %DT="AEFX",%DT("A")="Schedule a Procedure for which Date ?  " D ^%DT I Y<0 W !!,"The schedule cannot be updated without a date.",!! G END
 S SRSDATE=+Y I SRSDATE<DT W !!,"Reservations cannot be made for dates in the past.  Please select another date.",!!,"Press RETURN to continue  " R X:DTIME G BEG
 S X=SRSDATE D H^%DTC S SRDAY=%Y+1 S SRDL=$P($G(^SRO(133,SRSITE,2)),"^",SRDAY) S:SRDL="" SRDL=1
 I 'SRDL W !!,"Scheduling not allowed for "_$S(SRDAY=1:"SUNDAY",SRDAY=2:"MONDAY",SRDAY=3:"TUESDAY",SRDAY=4:"WEDNESDAY",SRDAY=5:"THURSDAY",SRDAY=6:"FRIDAY",1:"SATURDAY")_" !!",!!!,"Press RETURN to continue  " R X:DTIME G BEG
 K SRY S DIC=40.5,DR=".01;2",DA=SRSDATE,DIQ="SRY",DIQ(0)="E" D EN^DIQ1 K DA,DIC,DIQ,DR
 I $D(SRY(40.5,SRSDATE,.01,"E")),'$D(^SRO(133,SRSITE,3,SRSDATE,0)) W !!,"Scheduling not allowed for "_$G(SRY(40.5,SRSDATE,2,"E"))_" !!",!!!,"Press RETURN to continue  " R X:DTIME G BEG
 S Y=SRSDATE D D^DIQ S SREQDT=Y
 W ! S DIC=2,DIC("A")="Select Patient: ",DIC(0)="QEAMZ" D ^DIC K DIC G:Y<0 END S (DFN,SRSDPT)=+Y D DEM^VADPT S SRNM=VADM(1),SRSSN=VA("PID")
 I $D(^DPT(SRSDPT,.35)),$P(^(.35),"^")'="" S Y=$E($P(^(.35),"^"),1,7) D D^DIQ W !!,"The records show that "_SRNM_" died on "_Y_".",! G END
OR D ^SRSCHOR I SRSOUT W !!,"No surgical case has been scheduled.",! S SRSOUT=0 G END
 D ^SRSCHUN I SRSOUT S SRSOUT=0 G END
 I $$LOCK^SROUTL(SRTN) D ^SRSCHUN1,UNLOCK^SROUTL(SRTN)
END ;
 I 'SRSOUT K DIR S DIR(0)="FOA",DIR("A")=" Press RETURN to continue. " D ^DIR
 D ^SRSKILL K SRTN,SRLCK W @IOF
 Q
