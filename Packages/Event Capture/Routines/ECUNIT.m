ECUNIT ;BIR/MAM,JPW-Allocate DSS Units ;1 May 96
 ;;2.0; EVENT CAPTURE ;;8 May 96
 ;
 W @IOF,"Allocating DSS Units for Event Capture",!!
BEG K ECMORE S LIST="DSS Units",(CNT,ECOUT)=0 W !!,"Enter the names of the DSS Units to be assigned: ",!!
UNIT ; select DSS Unit
 K DIC,DA,DUOUT S DIC=724,DIC(0)="QEAMZ",DIC("A")="Select DSS Unit: " D ^DIC K DIC G:$D(DUOUT) END I CNT=0,Y<0 G END
 I CNT,Y<0,$D(ECMORE) Q
 I CNT,Y<0 G CONT
 S ECNOPE=0 D CHECK I ECNOPE G UNIT
 S CNT=CNT+1,UNIT(CNT)=+Y_"^"_$P(Y,"^",2) G UNIT
CONT ;
 S CNT=0 W @IOF,!,"Enter the names of the people who will have access to enter procedures",!,"for the DSS Units selected:",!!
USER ; select users
 K DIC,DA,DUOUT S DIC=200,DIC(0)="QEAMZ",DIC("A")="Select Name: " D ^DIC K DIC G:$D(DUOUT) END I CNT=0,Y<0 G END
 I CNT,Y<0,$D(ECMORE) Q
 I CNT,Y<0 G ENTER
 S CNT=CNT+1,USER(CNT)=+Y_"^"_$P(Y,"^",2) G USER
 Q
ENTER ; display DSS Units & Users
 W @IOF,!,"Allocating DSS Units for Event Capture",!,?3,LIST_": ",!
 I LIST["DSS" S CNT=0 F I=0:0 S CNT=$O(UNIT(CNT)) Q:'CNT  W:CNT#2 !,?3,CNT W:CNT#2=0 ?45,CNT W ". "_$P(UNIT(CNT),"^",2)
 I LIST["Event" S CNT=0 F I=0:0 S CNT=$O(USER(CNT)) Q:'CNT  W:CNT#2 !,?3,CNT W:CNT#2=0 ?45,CNT W ". "_$P(USER(CNT),"^",2)
 Q:$D(ECREDO)  W !!,"Do you want to modify this list ?  NO//  " R ECYN:DTIME I '$T!(ECYN="^") G END
 S ECYN=$E(ECYN) S:ECYN="" ECYN="N" I "YyNn"'[ECYN D HELP^ECUN1 G ENTER
 I LIST["DSS","Nn"[ECYN S LIST="Event Capture Users" G ENTER
 I LIST["Event","Nn"[ECYN D ^ECUN1 G BEG
ASK W !!,"Add or Delete from the List ?  ADD//  " R X:DTIME I '$T!(X="^") G ENTER
 S X=$E(X) S:X="" X="A" I "AaDd"'[X W !!,"Enter <RET> to add more "_LIST_", or ""D"" to delete a "_$S(LIST["DSS":"unit",1:"user"),!,"from the list." G ASK
 I LIST["DSS","Aa"[X D COUNT S CNT=CNT1,ECMORE=1 W @IOF D UNIT S LIST="DSS Units" D VAL G:ECOUT END G ENTER
 I LIST["Event","Aa"[X D CNT S CNT=CNT1,ECMORE=1 W @IOF D USER S LIST="Event Capture Users" D VAL G:ECOUT END G ENTER
DELUN ; delete units
 W !!,"Select Number: " R X:DTIME I '$T!("^"[X) G ENTER
 I LIST["DSS",'$D(UNIT(X)) W !!,"Enter the number corresponding to the DSS Unit that you want to remove." D DISP G DELUN
 I LIST["Event",'$D(USER(X)) W !!,"Enter the number corresponding to the Event Capture User that you",!,"want to remove." D DISP G DELUN
 I LIST["DSS" K UNIT(X) S (CNT,CNT1)=0 F I=0:0 S CNT=$O(UNIT(CNT)) Q:'CNT  S CNT1=CNT1+1 I CNT'=CNT1 S UNIT(CNT1)=UNIT(CNT) K UNIT(CNT)
 I LIST["Event" K USER(X) S (CNT,CNT1)=0 F I=0:0 S CNT=$O(USER(CNT)) Q:'CNT  S CNT1=CNT1+1 I CNT'=CNT1 S USER(CNT1)=USER(CNT) K USER(CNT)
 G ENTER
 ;
DISP ; display list
 S ECREDO=1 W !!,"Do you need to see the list again ?  NO//  " R ECYN:DTIME I '$T!(X="^") S ECOUT=1 Q
 S ECYN=$E(ECYN) S:ECYN="" ECYN="N" I "YyNn"'[ECYN W !!,"Enter YES if you would like see the list of "_LIST_"." G DISP
 I "Nn"[ECYN K ECREDO Q
 D ENTER K ECREDO
 Q
END D ^ECKILL W @IOF
 Q
COUNT ; re-number units
 S (CNT,CNT1)=0 F I=0:0 S CNT=$O(UNIT(CNT)) Q:'CNT  S CNT1=CNT1+1
 Q
CNT ; re-number users
 S (CNT,CNT1)=0 F I=0:0 S CNT=$O(USER(CNT)) Q:'CNT  S CNT1=CNT1+1
 Q
CHECK ; check for valid DSS Unit
 I $P(^ECD(+Y,0),"^",6) S ECNOPE=1 W !!,"This DSS Unit is inactive.",!!,"Press <RET> to continue  " R X:DTIME W @IOF
 Q
VAL ;check valid lists
 I LIST["DSS",'$O(UNIT(0)) S ECOUT=1 D MSG Q
 I LIST["Event",'$O(USER(0)) S ECOUT=1 D MSG Q
 Q
MSG W !!,"No action taken.",!!,"Press <RET> to continue " R X:DTIME
 Q
