ECDSSCRN ;BIR/RHK - Enter Event Code Screens ;30 Mar 95
 ;;2.0; EVENT CAPTURE ;;8 May 96
 ;Routine for entering event code screens
START ; Check for location
 W @IOF
 I $O(^DIC(4,"LOC",""))="" W !,"You have no locations flagged for event cature.",!! Q
UNIT ; Select unit
 K DIC S ECNOPE="",DIC=724,DIC(0)="QEAMZ",DIC("A")="Select DSS Unit: ",DIC("S")="I $P(^(0),U,8)" D ^DIC K DIC G:Y<0 END
 S ECU=+Y,ECUN=$P(Y,U,2) D CHECK
 I $D(DUOUT)!($D(DTOUT)) G END
 I ECNOPE G UNIT
CAT ; Check if unit uses categories
 I $P(^ECD(ECU,0),U,11) D  S ECUDIR=$S($D(DUOUT):"END",$D(ECUERR):"UNIT",1:"PROC") W @IOF G @ECUDIR
 .S DIC=726
 .S DIC(0)="AEQMZ"
 .S DIC("S")="I '$P(^(0),U,3)!($P(^(0),U,3)>DT)"
 .S DIC("A")="Select Category: "
 .D ^DIC K DIC Q:$D(DUOUT)
 .I Y<0 S ECUERR=1 Q
 .S ECUCAT=+Y
PROC ; Set procedures
 ; Find highest entry number
 F ECUP=0:0 S ECUP=$O(^ECD(ECU,"PRO",ECUP)) Q:+$O(^(ECUP))'>0
 S ECUP=ECUP+1
 I '$D(ECUCAT) S ECUCAT=""
 S DIR(0)="724.011,.01",DIR("A")="Select Procedure" D ^DIR K DIR
 I +Y'>0 G END
 S ECUPRO=Y
 I $D(^ECD(ECU,"PRO","CB",ECUCAT,ECUPRO)) D  G PROC
 .W !,"That procedure already exists.",!!
 .S ECUPROP=$O(^ECD(ECU,"PRO","CB",ECUCAT,ECUPRO,""))
 .I $P(^ECD(ECU,"PRO",ECUPROP,0),U,3),($P(^(0),U,3)<DT) D
 ..S Y=$P(^ECD(ECU,"PRO",ECUPROP,0),U,3) X ^DD("DD")
 ..W "This procedure was inactivated on ",Y,".  You may use the 'Inactivate",!,"Event Code Screen option to change this date.",!!
 .K ECUP
 S ^ECD(ECU,"PRO",ECUP,0)=Y_"^"_ECUCAT
 I '$D(^ECD(ECU,"PRO",0)) S ^ECD(ECU,"PRO",0)="^724.011AV^^"
 ; Set the cross references for this entry
 S ^ECD(ECU,"PRO","B",Y,ECUP)=""
 S ^ECD(ECU,"PRO","C",ECUCAT,ECUP)=""
 K DA,ECUP,Y,X G PROC
STOP ; Stop loop and check for another category
 G CAT
END ;
 K DA,DIE,DIK,DR,ECNOPE,ECU,ECUCAT,ECUDIR,ECUERR,ECUN,ECUP,ECUPRO,ECUPROP,X,Y
 Q
CHECK ; Check to see if active unit
 I $P(^ECD(ECU,0),U,6) S ECNOPE=1
 I ECNOPE W !!,"This DSS Unit has not been activated for use in Event",!,"Capture software.",!! S DIR(0)="E" D ^DIR K DIR
 Q
