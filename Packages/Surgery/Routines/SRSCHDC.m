SRSCHDC ;B'HAM ISC/MAM - SCHEDULE CONCURRENT CASES ; [ 02/25/02  7:47 AM ]
 ;;3.0; Surgery ;**67,77,100,131**;24 Jun 93
 W @IOF,! S SRCC=1,SRSOUT=0 K DIC S DIC=2,DIC(0)="QEAMZ",DIC("A")="Schedule Concurrent Cases for which Patient ?  " D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S (DFN,SRSDPT)=+Y D DEM^VADPT S SRNM=VADM(1),SRSSN=VA("PID")
DEAD I $D(^DPT(SRSDPT,.35)),$P(^(.35),"^")'="" S Y=$E($P(^(.35),"^"),1,7) D D^DIQ W !!,"The records show that "_SRNM_" died on "_Y_".",!! G END
DATE W ! K SRDUOUT,%DT,SRSDATE S %DT="AEFX",%DT("A")="Schedule Concurrent Procedures for which Date ?  " D ^%DT I Y<0 S SRSOUT=1 G END
 I Y<DT W !!,"Cases cannot be scheduled for past dates.  Please enter a different date.",! G DATE
 S (SRSDATE,X)=+Y D H^%DTC S SRDAY=%Y+1 S SRDL=$P($G(^SRO(133,SRSITE,2)),"^",SRDAY) S:SRDL="" SRDL=1
 I 'SRDL W !!,"Scheduling not allowed for "_$S(SRDAY=1:"SUNDAY",SRDAY=2:"MONDAY",SRDAY=3:"TUESDAY",SRDAY=4:"WEDNESDAY",SRDAY=5:"THURSDAY",SRDAY=6:"FRIDAY",1:"SATURDAY")_" !!",!! G DATE
 K SRY S DIC=40.5,DR=".01;2",DA=SRSDATE,DIQ="SRY",DIQ(0)="E" D EN^DIQ1 K DA,DIC,DIQ,DR
 I $D(SRY(40.5,SRSDATE,.01,"E")),'$D(^SRO(133,SRSITE,3,SRSDATE,0)) W !!,"Scheduling not allowed for "_$G(SRY(40.5,SRSDATE,2,"E"))_" !!",!! G DATE
 S Y=SRSDATE D D^DIQ S (SREQDT,SRSDT)=Y,ST="SCHEDULING"
OR D ^SRSCHOR I SRSOUT W !!,"No surgical case has been scheduled.",! S SRSOUT=0 G END
 K SRTN F SRSCON=1,2 D CON^SRSCHUN I SRSOUT,SRSCON=1 Q
 I SRSOUT,SRSCON=1 W !!,"No surgical case has been scheduled.",! S SRTN("OR")=SRSOR,SRTN("START")=SRSDT1,SRTN("END")=SRSDT2,SRSEDT=$E(SRSDT2,1,7) D ^SRSCG S SRSOUT=0 G END
 I SRSOUT,SRSCON=2 K SRSCON(2) D DEL I SRSOUT G END
DISP W @IOF,!,"The following cases have been entered."
 S CON=0 F I=0:0 S CON=$O(SRSCON(CON)) Q:'CON  D LIST
 I '$D(SRSCON(2)) S SRSCON=1,SRTN=SRSCON(1) N SRLCK S SRLCK=$$LOCK^SROUTL(SRTN) D ^SRSCHUN1 D:$G(SRLOCK) UNLOCK^SROUTL(SRTN) G END
 W !!!!,"1. Enter Information for Case #"_SRSCON(1),!,"2. Enter Information for Case #"_SRSCON(2),!
REQ K DIR S DIR("?")=" ",DIR("?",1)="Select the number corresponding to the case for which you want",DIR("?",2)="to enter information.  Enter '^' or RETURN to exit."
 S DIR(0)="NO^1:2",DIR("A")="Select Number" D ^DIR I Y=""!$D(DUOUT) S SRSOUT=1 G END
 N SRLCK S SRSCON=Y S (DA,SRTN)=SRSCON(SRSCON),SRLCK=$$LOCK^SROUTL(SRTN) D ^SRSCHUN1 D:$G(SRLCK) UNLOCK^SROUTL(SRTN) G DISP
END I 'SRSOUT W ! K DIR S DIR(0)="FOA",DIR("A")=" Press RETURN to continue. " D ^DIR
 K SRTN D ^SRSKILL W @IOF
 Q
LIST ; list stub info
 S SROPER=SRSCON(CON,"OP") K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !!,CON_". ",?4,"Case # "_SRSCON(CON),?40,SRSDT,!,?4,"Surgeon: "_SRSCON(CON,"DOC"),?40,SRSCON(CON,"SS"),!,?4,"Procedure: ",?16,SROPS(1) I $D(SROPS(2)) W !,?16,SROPS(2) I $D(SROPS(3)) W !,?16,SROPS(3)
 Q
LOOP ; break procedure if greater than 60 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
DEL ; delete first request ?
 W !!,"Since you were unable to complete the information for the concurrent case, you",!,"may want to delete the first case and re-enter both at another time."
ASK W !!,"Do you want to delete the entry for Case "_SRSCON(1)_" also ?  YES //  " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="Y"
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN S SRTN=1 W !!,"Enter RETURN to delete Case "_SRSCON(1)_", or 'NO' to continue entering information",!,"for this case." G ASK
 I "Yy"'[SRYN S SRSOUT=0 Q
 S SRTN=SRSCON(1),SRTN("OR")=SRSOR,SRTN("START")=SRSDT1,SRTN("END")=SRSDT2,SRSEDT=$E(SRSDT2,1,7) D ^SRSCG
 D OERR
 W !!,"  Deleting Case "_SRSCON(1)_" ..." S DA=SRSCON(1),DIK="^SRF(" D ^DIK K SRTN
 Q
OERR ; delete from ORDER file (100)
 N SRTN S SRTN=SRSCON(1) D DEL^SROERR
 Q
