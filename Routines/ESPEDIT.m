ESPEDIT ;WASH/ERC - Police Officer Add/Edit ; 5 Apr 00 11:56 AM
 ;;1.0;POLICE & SECURITY;**31,44**;Mar 31, 1994;Build 1
 ; Routine will allow Police personnel to add/edit the Police Officer
 ; Rank and Badge Numer fields.
 ; (Previously an edit type option, changed with patch 31)
EN ;
 N D,DA,DIC,DIE,DR,ESPFLG,Y
 W @IOF
 W !!!,"This option will allow the editing of Badge Number and Rank on those",!,"people holding the ESP POLICE security key.",!
EN1 ;
 S DIC="^VA(200,"
 S DIC(0)="AEQ"
 S DIC("A")="Select POLICE NAME: "
 S D="AK.ESP POLICE"
 D IX^DIC
 I +Y=-1 K DIC Q
 I '$O(^VA(200,"AK.ESP POLICE",$P(Y,U,2),0)) D
 . W !!,"Only employees who hold the ESP POLICE security key can be edited.",!!
 . S ESPFLG=1
 I $G(ESPFLG)=1 S ESPFLG=0 G EN1
EDIT ;
 S DIE=DIC K DIC
 S DA=+Y
 S DR="910.1;910.2"
 D ^DIE G EN1
 Q
