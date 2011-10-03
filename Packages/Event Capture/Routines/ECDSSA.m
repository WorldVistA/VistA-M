ECDSSA ;BIR/RHK,JPW-Activate/Inactivate Local Procedure Routine ;29 Apr 96
 ;;2.0; EVENT CAPTURE ;;8 May 96
SETDEAC ; Set inactivation date for local procedures
 W @IOF,!,"Inactivate Local Procedures",!
 K DA,DIC,DIE,DR S ECOUT=0
 F  S DIC="^EC(725,",DIC(0)="AEQMZ",DIC("S")="I +Y>89999",DIC("A")="Select Local Procedure: " D ^DIC K DIC Q:Y<0  D  Q:ECOUT
 .S ECRN=+Y,ECPN=$P(Y,"^",2),(ECJLP,ECOUT)=0
 .I $P($G(^EC(725,ECRN,0)),"^",3)]"" D  Q:$D(DUOUT)!($D(DTOUT))  Q:ECJLP
 ..W !!,ECPN," is currently inactive."
 ..S DIR(0)="Y",DIR("A")="Do you wish to reactivate",DIR("B")="YES"
 ..S DIR("?")="Enter YES to reactivate this local procedure or NO leave inactive."
 ..D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S ECOUT=1 Q
 ..I 'Y W !,ECPN," remains inactive.",!!
 ..I Y>0 S DIE=725,DA=ECRN,DR="2///@" D ^DIE K DA,DIE,DR W !,ECPN," has been reactivated for use.",!! S ECJLP=1
 .Q:$P($G(^EC(725,ECRN,0)),"^",3)]""
 .S DIR(0)="Y",DIR("A")="Do you wish to inactivate",DIR("B")="YES"
 .S DIR("?")="Enter YES to inactivate this local procedure or NO to leave active."
 .D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S ECOUT=1 Q
 .I 'Y W !,ECPN," remains active for use.",!!
 .I Y>0 S DIE=725,DA=ECRN,DR="2///TODAY" D ^DIE K DA,DIE,DR W !,ECPN," has been inactivated.",!!
 .K DA,DIC,DIE,DR,DTOUT,DUOUT,ECRN,ECPN
END ;kill variables
 D ^ECKILL
 Q
