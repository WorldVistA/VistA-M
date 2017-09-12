SOWK55 ;B'HAM ISC/MAM - Correct Package File ; 13 April 1998 8:00 am
 ;;3.0; Social Work ;**55**;27 Apr 93
PATCH ; update SOCIAL WORK PATCH Entry in the PACKAGE file
 ; set PREFIX equal to ZZSW
 ;
 K DIC,X S X="SOCIAL WORK PATCH",DIC(0)="XZ",DIC="^DIC(9.4," D ^DIC K DIC S X=+Y
 I X>0 S SOWKPRE="ZZSW" D PREFIX
 ;
SOW ; update PREFEX for SOCIAL WORK entry in PACKAGE file
 ; set PREFIX equal to SOW
 K DIC,X S X="SOCIAL WORK",DIC(0)="XZ",DIC="^DIC(9.4," D ^DIC K DIC S X=+Y
 I X>0,$P(^DIC(9.4,X,0),"^",2)'="SOW" S SOWKPRE="SOW" D PREFIX
 K SOWKPRE,X,Y,DIC,DA,DR,DIE
 Q
 ;
PREFIX ; reset PREFIX in PACKAGE file
 ;
 S DIE=9.4,DA=X,DR="1///"_SOWKPRE D ^DIE
 Q
