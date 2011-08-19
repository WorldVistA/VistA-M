PSGWSET ;BHAM ISC/PTD,CML-Set Inpatient Site ; 08 Apr 93 / 1:34 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 K XQUIT,STDA,LOC I '$D(^PS(59.4,"B")) D NONE G END
COUNT S (CNT,LOC,STDA)=0 F J=0:0 S STDA=$O(^PS(59.4,STDA)) Q:'STDA  S:($P(^(STDA,0),"^",26)=1) LOC=LOC+1,LOC(+STDA)="" S CNT=CNT+1
 ;
SITE I LOC=1 S PSGWSITE=^PS(59.4,$O(LOC(0)),0) W !!,"AR/WS Inpatient Site Name: ",$P(^(0),"^")
 I 'LOC,CNT=1 S STDA=$O(^PS(59.4,0)),$P(^(STDA,0),"^",26)=1,PSGWSITE=^(0) W !!,"AR/WS Inpatient Site Name: ",$P(^(0),"^")
MULT I CNT>1,LOC'=1 S DIC="^PS(59.4,",DIC(0)="QEAMZ",DLAYGO=59.4,DIC("A")="Enter AR/WS Inpatient Site Name: " S:LOC>1 DIC("S")="I $P(^(0),U,26)=1" S:LOC=0 DIC(0)="QEAMLZ"
 I  D ^DIC K DIC,DLAYGO S:Y<0 XQUIT="" G:Y<0 END S $P(^PS(59.4,+Y,0),"^",26)=1,PSGWSITE=^PS(59.4,+Y,0)_"^M"
 ;
 I $D(PSGWSITE),$D(^PS(59.7,1,50)) D WARN
END K DIE,LOC,X,Y,STDA,CNT,J,UPDT,DA,DR Q
 ;
NONE S (DIC,DIE)="^PS(59.4,",DIC(0)="QEAMLZ",DLAYGO=59.4,DIC("A")="Enter AR/WS Inpatient Site Name: " D ^DIC K DIC,DLAYGO I Y<0 S XQUIT="" Q
 S (DA,STDA)=+Y,DR="5.5///"_1_";4;5" D ^DIE S PSGWSITE=^PS(59.4,STDA,0)
 Q
 ;
WARN Q:'^PS(59.7,1,50)
 S Y=^PS(59.7,1,50),UPDT=$P(Y,".") X ^DD("DD") S X1=DT,X2=$S($D(UPDT):UPDT,1:"") D ^%DTC
 I X>7 W *7,*7,!!?32,"*** WARNING ***",!!,$P(Y,"@")," was the last date that AR/WS AMIS Statistics were updated.",!
 I  W "Please contact ADP and request that Taskmanager option ""PSGW UPDATE AMIS STATS""",!,"be RESCHEDULED to run nightly.  AMIS will not be current until this option runs.",!!
 Q
 ;
