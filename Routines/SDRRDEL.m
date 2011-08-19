SDRRDEL ;10N20/MAH;DELETE/EDIT RECALL REMINDERS ;01/18/2008
 ;;5.3;Scheduling;**536**;Aug 13, 1993;Build 53
 ;;THIS ROUTINE WILL USE OPTION SDRR DELETE RECALL
 ;
 S DIDEL=403.5,Q=0,(CLIN,CLINZ)=""
 S DIC=403.5,DIC(0)="AELM",DIC("A")="Select Clinic Recall Patient:  " D ^DIC  S Q=+Y I +Y<0 G EXIT
 I +Y>0 S CLIN=$P($G(^SD(403.5,+Y,0)),U,2) I $G(CLIN)]"" S CLINZ=$$GET1^DIQ(44,CLIN_",",.01)
 I +Y>0 S DIR(0)="Y",DIR("A")="Are you sure you want to delete: "_$G(CLINZ),DIR("B")="NO" D ^DIR
 I Y'=1 G EXIT
 I Y=1 G KIL
 Q
KIL      N SDRRFTR
 S Y=0
 K DIR
 S DIR(0)="SO^1:Failure to respond;2:Moved;3:Deceased;4:Doesn't want VA services;5:Received care at another VA;6:Other",DIR("A")="Reason for Removal" D ^DIR Q:$D(DIRUT) 
 I Y>0 S SDRRFTR=Y
 S DA=+Q S DIE="^SD(403.5,",DR="[SDRREMARKS]",DIE("NO^")="BACKOUTOK" D ^DIE
 S DIK="^SD(403.5,",DA=+Q D ^DIK
 W !!?20,"*** Now Deleting Patient Recall ***" H .5
EXIT     ;
 K SDRRFTR,Q,DA,DIC,X,Y,DIDEL,DIC,DIK,DIR,CLIN,CLINZ,DIE,DR,DIRUT
 Q
