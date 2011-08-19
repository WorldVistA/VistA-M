SRSCONR ;B'HAM ISC/MAM - REQUEST CONCURRENT CASES ; [ 01/30/01  9:54 AM ]
 ;;3.0; Surgery ;**67,68,77,100**;24 Jun 93
 S SRCC=1,(SRSOUT,SRWL)=0 I $D(ORVP) S (DFN,SRSDPT)=+ORVP G DEAD
 W @IOF,! K DIC S DIC=2,DIC(0)="QEAMZ",DIC("A")="Request Concurrent Cases for which Patient ?  " D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S (DFN,SRSDPT)=+Y
DEAD D DEM^VADPT S SRNM=VADM(1),SRSSN=VA("PID")
 I $D(^DPT(SRSDPT,.35)),$P(^(.35),"^")'="" S Y=$E($P(^(.35),"^"),1,7) D D^DIQ W !!,"The records show that "_SRNM_" died on "_Y_".",!! G END
 S SRSOTH=0 D LFTOVR^SRSREQUT I SRSOTH=1 S SRSOUT=1 G END
DATE W ! K SRDUOUT,%DT S (OPT,SRSCON)=0,%DT="AEFX",%DT("A")="Make a Request for Concurrent Cases on which Date ?  " D ^%DT I Y<0 S SRSOUT=1 G END
 I Y<DT W !!,"Requests cannot be made for past dates.  Please enter a different date.",! G DATE
 S SRSDATE=Y D D^DIQ S (SREQDT,SRSDT)=Y,ST="REQUESTS",(SRSOP,SRSDAY)="",SRSST=0
 K SRLATE D LATE^SRSREQ I $D(SRLATE) G DATE
 K SRTN F SRSCON=1,2 D CON^SRSRQST I SRSOUT,SRSCON=1 Q
 I SRSOUT,SRSCON=1 S SRSOUT=0 G END
R2 I SRSOUT,SRSCON=2 K SRSCON(2) D DEL I 'SRSOUT G END
DISP K POP W @IOF,!,"The following requests have been entered."
 S SRSCON=0 F I=0:0 S SRSCON=$O(SRSCON(SRSCON)) Q:'SRSCON  D LIST
 I '$D(SRSCON(2)) S SRSCON=1,SRTN=SRSCON(1) D  G END
 .I $$LOCK^SROUTL(SRTN) D ^SRSRQST1,UNLOCK^SROUTL(SRTN)
 W !!!!,"1. Enter Request Information for Case #"_SRSCON(1),!,"2. Enter Request Information for Case #"_SRSCON(2),!
REQ K DIR S DIR("?")=" ",DIR("?",1)="Select the number corresponding to the case for which you want",DIR("?",2)="to enter request information.  Enter '^' or RETURN to exit."
 S DIR(0)="NO^1:2",DIR("A")="Select Number" D ^DIR I Y=""!$D(DUOUT) S SRSOUT=1 G END
 S SRSCON=Y S (DA,SRTN)=SRSCON(SRSCON) D  G DISP
 .I $$LOCK^SROUTL(SRTN) D ^SRSRQST1,UNLOCK^SROUTL(SRTN)
END I 'SRSOUT W ! K DIR S DIR(0)="FOA",DIR("A")=" Press RETURN to continue.  " D ^DIR
 K SRTN D ^SRSKILL W @IOF
 Q
LIST ; list stub info
 S SROPER=SRSCON(SRSCON,"OP") K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !!,SRSCON_". ",?4,"Case # "_SRSCON(SRSCON),?40,SRSDT,!,?4,"Surgeon: "_SRSCON(SRSCON,"DOC"),?40,SRSCON(SRSCON,"SS"),!,?4,"Procedure: ",?16,SROPS(1) I $D(SROPS(2)) W !,?16,SROPS(2) I $D(SROPS(3)) W !,?16,SROPS(3)
 Q
LOOP ; break procedure if greater than 60 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
DEL ; delete first request ?
 W !!,"Since you were unable to complete the information for the concurrent case, you",!,"may want to delete the first request and re-enter both at another time."
ASK W !!,"Do you want to delete the request for Case "_SRSCON(1)_" also ?  YES //  " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N"
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN S SRTN=1 W !!,"Enter RETURN to delete Case "_SRSCON(1)_", or 'NO' to continue entering information",!,"for this request." G ASK
 I "Yy"'[SRYN S SRSOUT=0 Q
 D OERR
 W !!,"  Deleting Case "_SRSCON(1)_" ..." S (DA,SRTN)=SRSCON(1),DIK="^SRF(" D ^DIK K SRTN S SRSOUT=0
 Q
OERR ; delete from ORDER file (100)
 N SRTN S SRTN=SRSCON(1) D DEL^SROERR
 Q
