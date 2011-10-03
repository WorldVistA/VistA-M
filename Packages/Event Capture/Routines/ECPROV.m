ECPROV ;BIR/MAM,RHK,JPW-Event Capture Provider Summary ;1 May 96
 ;;2.0; EVENT CAPTURE ;;8 May 96
LOC S (CNT,ECOUT,LOC)=0 F I=0:0 S LOC=$O(^DIC(4,"LOC",LOC)) Q:LOC=""  S CNT=CNT+1,ECLOC(CNT)=LOC_"^"_$O(^DIC(4,"LOC",LOC,0))
 I '$D(ECLOC(1)) W !!,"There are no current locations defined for this facility.  please contact",!,"the Event Capture Package Coordinator." G END
 I '$D(ECLOC(2)) S ECL=$P(ECLOC(1),"^",2),ECLN=$P(ECLOC(1),"^") D UNIT^ECPROV1 G END
ALL W @IOF,!!,"Do you want to print this report for all locations ?  YES// " R ECYN:DTIME I '$T!(ECYN="^") S ECOUT=1 G END
 S ECYN=$E(ECYN) S:ECYN="" ECYN="Y"
 I "YyNn"'[ECYN W !!,"If you would like to generate this report for all divisions within",!,"this facility, enter <RET>.  If you want a report containing procedures for",!,"a specific division, enter NO"
 I "YyNn"'[ECYN W !!,"Press <RET> to continue  " R X:DTIME G ALL
 I "Yy"[ECYN S ECL="ALL" D UNIT^ECPROV1 G END
SELL ;
 D ^ECL I '$D(ECL) G END
 D UNIT^ECPROV1
END W ! I 'ECOUT,$E(IOST,1,2)="C-" W !!,"Press <RET> to continue  " R X:DTIME
 D ^ECKILL W @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
