ECDEAL ;BIR/MAM,JPW-Deallocate DSS Units ;6 May 96
 ;;2.0; EVENT CAPTURE ;**13,19,25**;8 May 96
 S ECOUT=0
USER W @IOF,!!,"Do you want to remove access to all DSS Units for a specific user ?  NO//  " R ECYN:DTIME I '$T!(ECYN["^") G END
 S ECYN=$E(ECYN) S:ECYN="" ECYN="N" I "YyNn"'[ECYN W !!,"If you are removing access to a DSS Unit for one or more users, enter",!,"<RET>.  If you want to remove access to all units for an individual user,"
 I "YyNn"'[ECYN W !,"enter YES.",!!,"Press <RET> to continue  " R X:DTIME G USER
 I "Yy"[ECYN D ^ECDEAL1 G END
UNIT Q:ECOUT  W @IOF K DIC,DA S DIC(0)="QEAMZ",DIC=724,DIC("A")="Remove User Access for which DSS Unit ?   " D ^DIC K DIC G:Y<0 END S ECD=+Y,ECDN=$P(Y,"^",2)
U W !!,"Do you want to remove access to this DSS Unit for all users ?  NO//  " R ECYN:DTIME I '$T!(ECYN="^") G END
 S:ECYN="" ECYN="N" S ECYN=$E(ECYN) I "YyNn"'[ECYN W !!,"Enter <RET> if you are removing access to "_ECDN_" for an individual",!,"user or Y to remove access for ALL users." G U
 I "Yy"[ECYN D  D ALL W:ECOUT !!,"Processing cancelled" G END
 . W !!,"Access to "_ECDN_" will be removed from all users."
 W !! K DIC S DIC("S")="I $D(^VA(200,Y,""EC"",ECD))",DIC(0)="QEAMZ",DIC=200,DIC("A")="Inactivate "_ECDN_" from which User ?  " D ^DIC K DIC G:Y<0 END S ECU=+Y,ECUN=$P(Y,"^",2)
 K DIC,DA,DIK S DA=ECD,DA(1)=ECU,DIK="^VA(200,"_DA(1)_",""EC""," D ^DIK W !!,"Access to "_ECDN_" has been removed from "_ECUN_"." K DA,DIK G END
 I ECU="" W !!,"Access for "_ECDN_" will be removed from all users.",!!,"All Event Code Screens will be inactivated for "_ECDN D ALL G UNIT
 Q
ALL ; remove all units from all users
 W !!,"Do you want to inactivate "_ECDN_" ?  YES//  " R ECYN:DTIME I '$T!(ECYN="^") S ECOUT=1 Q
 S:ECYN="" ECYN="Y" S ECYN=$E(ECYN) I "YyNn"'[ECYN D  G ALL
 . W !!,"Enter <RET> if you want to inactivate this DSS Unit, or "
 . W "NO to leave it active.",!!
 . W "NOTE: If unit is inactivated it will be inaccessible during "
 . W "patient data",!,?6,"entry; i.e none of its associated EC screens "
 . W "(procedures) will be",!,?6,"available for patient data entry."
 S INACT=ECYN,ECSCN=0,ECINC=DT I "Yy"[ECYN D SCN I ECOUT Q
 I ECSCN W !!,"All Event Code Screens will be inactivated for "_ECDN
 I "Yy"[INACT K DIE,DR S DIE=724,DA=ECD,DR="5////1" D ^DIE K DIE,DR
 S ZTDESC="DEALLOCATE DSS UNIT",(ZTSAVE("ECD"),ZTSAVE("ECOUT"),ZTSAVE("ECDN"),ZTSAVE("ECSCN"),ZTSAVE("ECINC"))="",ZTRTN="DIK^ECDEAL",ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS K ZTSK Q
 Q
SCN ;prompt to inactive event code screens associated with unit
 W !!,"Do you want to inactivate all Event Code Screens associated with"
 W !,"this DSS Unit?  YES//  " R ECYN:DTIME I '$T!(ECYN="^") S ECOUT=1 Q
 S:ECYN="" ECYN="Y" S ECYN=$E(ECYN)
 I "YyNn"'[ECYN D  G SCN
 . W !!,"Enter <RET> if you want to inactivate ALL Event Code Screens "
 . W "for this DSS",!,"Unit, or NO to leave them active."
 S ECSCN=$S("Yy"[ECYN:1,1:0)
 I "Yy"[INACT,'ECSCN D
 . W !!,"The "_ECDN_" DSS Unit has been inactivated. Event Code Screens"
 . W !,"associated with that unit are no longer accessible to users."
 . W !,"If you wish to inactivate individual Event Code Screens, use the"
 . W !,"Inactivate Event Code Screens menu option."
 Q
DIK ; entry when queued
 S ECU=0 F I=0:0 S ECU=$O(^VA(200,ECU)) Q:'ECU  I $D(^VA(200,ECU,"EC",ECD)) K DA,DIK S DA(1)=ECU,DA=ECD,DIK="^VA(200,"_DA(1)_",""EC""," D ^DIK
 K DA,DIK
 I ECSCN D INSCRN
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
INSCRN ; inactivate screen codes
 S EC=0
 F EC=0:0 S EC=$O(^ECJ("AP",EC)) Q:'EC  S ECC="" F  S ECC=$O(^ECJ("AP",EC,ECD,ECC)) Q:ECC=""  S ECA="" F  S ECA=$O(^ECJ("AP",EC,ECD,ECC,ECA)) Q:ECA=""  D
 .K DA,DIE,DR S DIE="^ECJ(",DA=+$O(^ECJ("AP",EC,ECD,ECC,ECA,0))
 .I ECINC,$P($G(^ECJ(DA,0)),U,2)'="" Q
 .S DR="1///"_ECINC D ^DIE
 K EC,ECC,ECA,DA,DIE,DR
 Q
END I 'ECOUT W !!,"Press <RET> to continue  " R X:DTIME
 W @IOF D ^ECKILL K ECSCN,INACT,ECINC S:$D(ZTQUEUED) ZTREQ="@"
 Q
