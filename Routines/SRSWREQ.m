SRSWREQ ;BIR/MAM - REQUEST FROM WAITING LIST ;08/11/05
 ;;3.0; Surgery ;**58,77,105,146**;24 Jun 93
 S SRWL=1,SRSOUT=0 I $D(ORVP) S (DFN,SRSDPT)=+ORVP G DEAD
 W @IOF,! K DIC S DIC=2,DIC(0)="QEAMZ",DIC("A")="Make a request from the waiting list for which patient ?  " D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S (DFN,SRSDPT)=+Y
DEAD D DEM^VADPT S SRNM=VADM(1),SRSSN=VA("PID")
 I $D(^DPT(DFN,.35)),$P(^(.35),"^")'="" S Y=$E($P(^(.35),"^"),1,7) D D^DIQ W !!,"The records show that "_SRNM_" died on "_Y_".",! G END
 I '$O(^SRO(133.8,"AP",DFN,0)) W !!,"There are no entries on the Waiting List for "_SRNM_"." G END
LIST W @IOF,!,"Procedures Entered on the Waiting List for "_SRNM_": ",!! K SRW S (CNT,SRSS)=0
 F  S SRSS=$O(^SRO(133.8,"AP",DFN,SRSS)) Q:'SRSS  S SROFN=0 F  S SROFN=$O(^SRO(133.8,"AP",DFN,SRSS,SROFN)) Q:'SROFN  D ARRAY
 I '$D(SRW(2)) S SRW=1 D OK G:"Yy"[SRYN REQ S SRSOUT=1 G END
 W !!!,"Select Number: " R SRW:DTIME I '$T!("^"[SRW) S SRSOUT=1 G END
 I '$D(SRW(SRW)) W !!,"Select the number corresponding to the entry for which the request will",!,"be made.",!!,"Press RETURN to continue  " R X:DTIME G LIST
REQ S SRSOTH=0
 D LFTOVR^SRSREQUT I SRSOTH S SRSOUT=1 G END
DATE W ! K %DT S %DT="AEFX",%DT("A")="Make a request for which Date ?  " D ^%DT I Y<0 S SRSOUT=1 G END
 S SRSDATE=+Y,SRSST=0 I SRSDATE<DT W !!,"Requests cannot be made for past dates.",!!,"Press RETURN to continue  " G DATE
 D D^DIQ S SREQDT=Y
 K SRLATE D LATE^SRSREQ I $D(SRLATE) G DATE
 S SRSS=$P(SRW(SRW),"^"),SRSOP=$P(SRW(SRW),"^",5) F SRI=6:1:12 S SRCL(SRI+10)=$P(SRW(SRW),"^",SRI)
 K DIR I $D(ORNP) S DIR("B")=$P(^VA(200,ORNP,0),"^")
 S ST="REQUEST"
 D ^SRSRQST
END I 'SRSOUT W ! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue: " D ^DIR
 K SRTN D ^SRSKILL W @IOF
 Q
ARRAY ; set array for waiting list info
 S CNT=CNT+1,SRSER=$P(^SRO(133.8,SRSS,0),"^"),SRSERV=$P(^SRO(137.45,SRSER,0),"^")
 S SROPER=$P(^SRO(133.8,SRSS,1,SROFN,0),"^",2),Y=$P(^(0),"^",3) D D^DIQ S SRDT=$E(Y,1,12),SRW(CNT)=SRSER_"^"_SROFN_"^"_SRSERV_"^"_SRDT_"^"_SROPER_"^"_$P(^SRO(133.8,SRSS,1,SROFN,0),"^",16,22)
 W !,CNT_". "_SRSERV,?40,"Date Entered on List: "_SRDT,!,?3,SROPER,!
 Q
OK W !!,"Is this the correct procedure ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N" Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y" I "YyNn"'[SRYN W !!,"Enter RETURN if this is the procedure that you would like to make into a",!,"request.  Otherwise, enter 'NO'." G OK
 Q
