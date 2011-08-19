YSD4PRE0 ;DALISC/LJA - Mental Health 5.01 Pre-init ;[ 04/10/94  10:39 AM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
OUT ;Place out of order message on all DSM options
 W !!,"Placing Options Out of Order" H 2
 N DA,DIE,DR
 S (DA,YSOPTION)=""
 F YSOPTION="YSCENED","YSCENDIA","YSCENGED","YSCENMEDS","YSCENPP","YSCENTMHX","YSCENWL","YSDIAGE","YSDIAGP-DX","YSDIAGP-DXLS","YSPATPROF","YSPLDX" D
 .  S DA=+$O(^DIC(19,"B",YSOPTION,0)) QUIT:DA'>0
 .  I $P($G(^DIC(19,+DA,0)),U,3)="" D  QUIT
 .  .  S DIE=19,DR="2///Out of Order - Installing Mental Health V. 5.01"
 .  .  D ^DIE
 QUIT
 ;
PCKCHG ;  Rename package file entry...
 I $O(^DIC(9.4,"B","MENTAL HEALTH",0))>0&($O(^DIC(9.4,"B","MENTAL HEALTH SYSTEM",0))>0) D
 .  N DIE,DA,DR
 .  ;
 .  ;  Get IEN
 .  S DA=+$O(^DIC(9.4,"B","MENTAL HEALTH",0))
 .  QUIT:DA'>0  ;->
 .  ;
 .  ;  Set other variables and call DIE
 .  S DIE=9.4,DR=".01///OLD MENTAL HEALTH"
 .  D ^DIE
 .  ; I $P($G(^DIC(9.4,+DA,0)),U)="OLD MENTAL HEALTH" W "  done..."
 .  N DIE,DA,DR
 .  W !!,"Renaming the 'Mental Health System' package file entry..."
 .  ;
 .  ;  Get IEN
 .  S DA=+$O(^DIC(9.4,"B","MENTAL HEALTH SYSTEM",0))
 .  QUIT:DA'>0  ;->
 .  ;
 .  ;  Set other variables and call DIE
 .  S DIE=9.4,DR=".01///MENTAL HEALTH"
 .  D ^DIE
 .  I $P($G(^DIC(9.4,+DA,0)),U)="MENTAL HEALTH" W "  done..."
 ;
 I $O(^DIC(9.4,"B","MENTAL HEALTH SYSTEM",0))>0 D
 .  N DIE,DA,DR
 .  W !!,"Renaming the 'Mental Health System' package file entry..."
 .  ;
 .  ;  Get IEN
 .  S DA=+$O(^DIC(9.4,"B","MENTAL HEALTH SYSTEM",0))
 .  QUIT:DA'>0  ;->
 .  ;
 .  ;  Set other variables and call DIE
 .  S DIE=9.4,DR=".01///MENTAL HEALTH"
 .  D ^DIE
 .  I $P($G(^DIC(9.4,+DA,0)),U)="MENTAL HEALTH" W "  done..."
 QUIT
 ;
DELMHPN ; Delete files ..........
 I $D(^YSP(606))!($P(^GMR(121.99,1,"CONV"),U,3)'=1) D
 .
 .  W !!,"Deleting the Progress Note file, #606 ...."
 .  S DIU(0)="DST",DIU="^YSP(606," D EN^DIU2
 .
 .  W !,"Deleting the Progress Note Type file, #606.5 ...."
 .  S DIU="^YSP(606.5," D EN^DIU2 K DIU
 .
 .  ; Delete options ........
 .  W !,"Deleting YSPN* options .... "
 .  S YSPNOPT="YSPN",DIK="^DIC(19,",DA=""
 .  F  S YSPNOPT=$O(^DIC(19,"B",YSPNOPT)) Q:$E(YSPNOPT,1,4)'="YSPN"!(YSPNOPT'="")  D
 .  .  F  S DA=+$O(^DIC(19,"B",YSPNOPT,DA)) Q:DA'>0  D
 .  .  .  I $D(^DIC(19,"AC",+DA)) D  QUIT
 .  .  .  .  W !!,"The "_YSPNOPT_" option is being used by other options"
 .  .  .  .  W " and cannot be deleted",!!
 .  .  .  I $D(^DIC(19,+DA,0)) D ^DIK W "."
 .  W !!?5,"***  Pre-Init Clean-Up is complete, remember to delete YSPN* routines ***",!
 QUIT
 ;
ICD I '$D(^ICD9(0)) W !!,$C(7),"NOTE:  " D  H 3
 .  W "You are not required to have the ICD Diagnosis file #80 installed"
 .  W !,"but the Final Discharge Note within Progress Notes points to this file."
 .  W !,"If you wish to use this type of note, please install this file.",!
 QUIT
 ;
EOR ;YSD4PRE0 - Mental Health 5.01 Pre-init ;4/10/94 9:25
