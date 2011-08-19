ECLOC ;BIR/MAM,RHK,JPW-Flag Current Locations ;1 May 96
 ;;2.0; EVENT CAPTURE ;;8 May 96
 ;
START S (ECUNM,ECOUT)=0
 W @IOF,!,"Create/Remove current locations for Event Capture use.",!
 W !,"Do you want to create or remove access for a location ?  CREATE//  " R ECACC:DTIME I '$T!(ECACC="^") S ECOUT=1 G END
 S ECACC=$E(ECACC) S:ECACC="" ECACC="C" I "CcRr"'[ECACC W !!,"Enter <RET> to flag a location to be used in the Event Capture software, or",!,"REMOVE to delete access to a location."
 I "CcRr"'[ECACC W !!,"Press <RET> to continue  " R X:DTIME G START
 I "Cc"[ECACC G FLAG
 S ECUNM=1
FLAG ; entry to flag current locations
 W @IOF,!,$S('ECUNM:"Create",1:"Remove")," current locations for Event Capture use.",!
 K DIC S ECOUT=0,DIC=4,DIC(0)="QEAMZ" I ECUNM S DIC("S")="I $G(^DIC(4,+Y,""EC""))"
 D ^DIC K DIC S:Y<0 ECOUT=1 G:Y<0 END S ECL=+Y,ECLN=$P(Y(0),"^")
 I ECUNM G UN
 K DIE,DR S DIE=4,DR="720///1",DA=ECL D ^DIE K DIE,DR W !!,ECLN_" has been flagged for use in the Event Capture software."
 G END
UN ; unflag location
 S ECNO=0 I '$D(^DIC(4,ECL,"EC")) S ECNO=1
 I $D(^DIC(4,ECL,"EC")),+$P(^("EC"),"^")=0 S ECNO=1
 I ECNO W !!,ECLN_" has not been flagged as a current location." G END
ASK W !!,"Are you sure that you want to remove access to this location ?  NO//  " R ECYN:DTIME I '$T!(ECYN="^") S ECOUT=1 G END
 S ECYN=$E(ECYN) S:ECYN="" ECYN="N" I "YyNn"'[ECYN W !!,"If this location should no longer be used for the Event Capture software,",!,"enter YES.  Enter <RET> to leave this location flagged for use." G ASK
 G END:"Yy"'[ECYN S DIE=4,DA=ECL,DR="720///@" D ^DIE K DIE,DR
INAC W !!,"Do you wish to inactivate all event code screens",!,"for this location? " R ECYN:DTIME S ECYN=$E(ECYN) G END:'$T,END:"nN^"[ECYN
 I "yY"'[ECYN W !!,"Enter Y to inactivate all screens for this location",!,"      N or return to leave them active." G INAC
QUE ;que job to batch inactivate
 W !,"Please wait a few moments"
 S ZTRTN="DEQ^ECLOC",ZTSAVE("ECL")="",ZTIO="",ZTDESC="INACTIVATE EVENT CODE SCREENS",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS
END I 'ECOUT W !!,"Press <RET> to continue  " R X:DTIME
 D ^ECKILL S:$D(ZTQUEUED) ZTREQ="@" W @IOF
 Q
DEQ ;queued batch job to inactivate all screens for location ECLOC
 ;
 F ECX=0:0 S ECX=$O(^ECJ("AST",ECL,ECX)) Q:'ECX  S DA=ECX,DIE=720.3,DR="1///"_DT D ^DIE
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
