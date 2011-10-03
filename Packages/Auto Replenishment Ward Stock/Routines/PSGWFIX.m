PSGWFIX ;BHAM ISC/KKA - Patch to Remove Lock from PSGWMGR ; 21 Dec 94 / 1:56 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;**4**;4 JAN 94
 K DIC,DIE,DR,DA S DIC="^DIC(19,",DIC(0)="MZ",X="PSGWMGR" D ^DIC S DA=+Y I +Y'<0 D
 .W !,"Now deleting the PSGWMGR key from the PSGWMGR menu....."
 .S DIE="^DIC(19,",DR="3///@" D ^DIE
 .W !!,"Deletion complete.",!!!,"You may now delete the routine PSGWFIX."
 K DIC,DIE,DR,DA,X,Y Q
