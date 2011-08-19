ECPROV1 ;BIR/MAM-Event Capture Provider Summary (cont'd) ;1 May 96
 ;;2.0; EVENT CAPTURE ;**5**;8 May 96
UNIT ; get DSS Unit
 I '$D(^XUSEC("ECALLU",DUZ)) G PICKU
ALLU ; select unit
 W !!,"Do you want this report for all DSS Units ?  NO//  " R ECYN:DTIME I '$T!(ECYN="^") S ECOUT=1 Q
 S ECYN=$E(ECYN) S:ECYN="" ECYN="N" I "YyNn"'[ECYN W !!,"Enter <RET> if you would like to print this report for a specific DSS",!,"Unit, or YES to print it for all units.",!!,"Press <RET> to continue  " R X:DTIME G ALLU
 I "Yy"[ECYN S (ECD,ECDN)="ALL" D ^ECPROV2 Q
 K DIC W ! S DIC=724,DIC("A")="Select DSS Unit: ",DIC(0)="QEAMZ" S:ECL DIC("S")="I $D(^ECJ(""AP"",ECL,+Y))" D ^DIC K DIC Q:Y<0  S ECD=+Y,ECDN=$P(Y,"^",2) D ^ECPROV2 Q
PICKU S (X,CNT)=0 F I=0:0 S X=$O(^VA(200,DUZ,"EC",X)) Q:'X  S CNT=CNT+1,UNIT=$P(^VA(200,DUZ,"EC",X,0),"^"),UNIT(CNT)=UNIT_"^"_$P(^ECD(UNIT,0),"^")
 I '$D(UNIT(1)) W !!,"You do not have access to any DSS Units.  Contact your Event Capture",!,"Package Coordinator if you are responsible for generating reports for ",!,"a DSS Unit. ",!!,"Press <RET> to continue  " R X:DTIME S ECOUT=1 Q
 I '$D(UNIT(2)) S ECD=$P(UNIT(1),"^"),ECDN=$P(^ECD(ECD,0),"^") D ^ECPROV2 Q
SOMU W @IOF,!!,"Do you want this report for all accessible DSS Units ?  NO//  " R ECYN:DTIME I '$T!(ECYN="^") S ECOUT=1 Q
 S ECYN=$E(ECYN) S:ECYN="" ECYN="N"
 I "YyNn"'[ECYN W !!,"You have access to more than one DSS Unit.  If you want to print",!,"the report for only one of those units, enter <RET>.  To print the report for all of the units that you have access to, enter YES."
 I "YyNn"'[ECYN W !!,"Press <RET> to continue  " R X:DTIME G SOMU
 I "Yy"[ECYN S (ECD,ECDN)="SOME" D ^ECPROV2 Q
SELU S X=0 W @IOF,!,"DSS Units: ",! F I=0:0 S X=$O(UNIT(X)) Q:'X  W !,X_".",?5,$P(UNIT(X),"^",2)
 W !!,"Select Number: " R X:DTIME I '$T!("^"[X) S ECOUT=1 Q
 I '$D(UNIT(X)) W !!,"Select the number that corresponds with the DSS unit for which you would like",!,"print this report.",!!,"Press <RET> to continue  " R X:DTIME G SELU
 S ECD=$P(UNIT(X),"^"),ECDN=$P(UNIT(X),"^",2) D ^ECPROV2
 Q
