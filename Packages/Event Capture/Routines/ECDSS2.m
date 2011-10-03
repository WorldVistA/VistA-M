ECDSS2 ;BIR/RHK,JPW-Local Category Routine ;1 May 96
 ;;2.0; EVENT CAPTURE ;**1**;8 May 96
EDITC ; Create/Edit local categories
 W @IOF,!,"Enter/Edit Local Categories",!
 K DA,DIC,DIE,DLAYGO,DR
 F  W ! S DIC=726,DIC(0)="AEQLMZ",DIC("A")="Select Category: ",DLAYGO=726 D ^DIC K DIC,DLAYGO Q:Y<0  D
 .S DA=+Y I $P(Y,"^",3) S $P(^EC(726,DA,0),"^",2)=$G(DT)
 .S DIE=726,DR=".01T" D ^DIE K DA,DIE,DR
 G END
SETDEAC ; Set inactivation date for local categories
 W @IOF,!,"Inactivate Categories",!
 K DA,DIC,DIE,DLAYGO,DR S ECOUT=0
 F  S DIC="^EC(726,",DIC(0)="AEQMZ",DIC("A")="Select Category: " D ^DIC K DIC Q:Y<0  D  Q:ECOUT
 .S ECC=+Y,ECCN=$P(Y,"^",2),(ECJLP,ECOUT)=0
 .I $P($G(^EC(726,ECC,0)),"^",3)]"" D  Q:$D(DUOUT)!($D(DTOUT))  Q:ECJLP
 ..W !!,ECCN," is currently inactive."
 ..S DIR(0)="Y",DIR("A")="Do you wish to reactivate",DIR("B")="YES"
 ..S DIR("?")="Enter YES to reactivate this category or NO to leave inactive."
 ..D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S ECOUT=1 Q
 ..I Y>0 S DIE=726,DA=ECC,DR="2///@" D ^DIE K DA,DIE,DR W !,ECCN," has been reactivated for use.",!! S ECJLP=1 Q
 ..I 'Y W !,ECCN," remains inactive.",!! S ECJLP=1 Q
 .S DIR(0)="Y",DIR("A")="Do you wish to inactivate",DIR("B")="YES"
 .S DIR("?")="Enter YES to inactivate this category or NO to leave active."
 .D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S ECOUT=1 Q
 .I Y>0 S DIE=726,DA=ECC,DR="2///TODAY" D ^DIE K DA,DIE,DR W !,ECCN," has been inactivated.",!!
 .K DA,DIC,DIE,DR,DTOUT,DUOUT,ECC,ECCN
END ;kill variables and exit
 D ^ECKILL
 Q
