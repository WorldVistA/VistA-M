ECDEAL1 ;BIR/MAM,JPW-DeAllocate all Units for a User ;6 May 96
 ;;2.0; EVENT CAPTURE ;**13**;8 May 96
USER ; get user
 W @IOF,!! K DIC S DIC=200,DIC("S")="I $D(^VA(200,Y,""EC"")),+$O(^VA(200,Y,""EC"",0))",DIC(0)="QEAMZ",DIC("A")="Remove Access to DSS Units for which User ?  " D ^DIC K DIC I Y<0 S ECOUT=1 Q
 S ECU=+Y,ECUN=$P(Y(0),"^")
 W !!,"Removing access to all DSS Units for "_ECUN_"..."
 S DA(1)=ECU,DA=0 F I=0:0 S DA=$O(^VA(200,DA(1),"EC",DA)) Q:'DA  S DIK="^VA(200,"_DA(1)_",""EC""," D ^DIK
 K DA,DIK
 W !!,"Press <RET> to continue  " R X:DTIME
 G USER
