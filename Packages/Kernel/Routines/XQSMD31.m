XQSMD31 ;SEA/MJM - Secure Menu Delegation (Cont.) ;01/19/2006
 ;;8.0;KERNEL;**372**;Jul 10, 1995;Build 3
 ;Continued from XQSMD3
DOIT ;Set up the parameters for a calls to %XY^%RCR and XQSMD2
 S %X=XQPERX
 S %Y="^TMP($J,""OP""," D %XY^%RCR K ^TMP($J,"OP",0),^("B") S DIC=19,DIC(0)="MNF"
 S XQN="" F XQI=0:0 S XQN=$O(^TMP($J,"OP",XQN)) Q:XQN=""  S X=+XQN D ^DIC I +Y>0 S ^TMP($J,"OP",+Y)="",^TMP($J,"ZN",$P(^DIC(19,+Y,0),U,1))=$P(^(0),U,2,99) K ^TMP($J,"OP",+XQN,0)
 ;
KILL ;Delete the delegated options of XQU1 and clean up.
 I XQDEL S DA(1)=XQU1Y,DA="",ZTRTN="DEL^XQSMD31",ZTSAVE("DA(")="",ZTIO="",ZTDTH=$H,ZTDESC="Delete delegated option set for "_XQU1 D ^%ZTLOAD S XQDEL=0
 K %X,%Y,DIC,XQPERX,XQU1,XQU1Y,XQU2,ZTSK
 ;
 G BUILD^XQSMD2
 ;
DEL ;Taskman entry for killing off delegated option sets
 S DIK="^VA(200,"_DA(1)_",19.5,",DA=0
 F XQI=0:0 S DA=$O(^VA(200,DA(1),19.5,DA)) Q:DA=""  D ^DIK
 K DIK,DA
 Q
 ;
DELM ;Taskman entry for deleting option sets from multiple users.
 S DA(1)=0 F XQJ=0:0 S DA(1)=$O(XQHOLD(DA(1))) Q:DA(1)=""  S DIK="^VA(200,"_DA(1)_",19.5,",DA=0 F XQI=0:0 S DA=$O(^VA(200,DA(1),19.5,DA)) Q:DA=""  D ^DIK
 Q
 ;
ZTSK ;Taskman entry for adding and deleting delegated options (XQSMD2)
 S XQLEV=XQLEV+1,DR="19////"_DUZ_";19.2///"_XQLEV,DIE=200,XQM=0
 F XQJ=1:1 S XQM=$O(XQHOLD(XQM)) Q:XQM=""  S DA=XQM D:$D(^VA(200,DA,19))[0!($O(^(19.5,0))="") ^DIE D @$S(XQDOP:"REM",1:"ADD")
 D GIVOPT ; Give USER MENU OPTION as a secondary option if the user doesn't already have it.
 K DIE,DR,DA,XQLEV,XQM,XQDOP,XQJ,XQK,XQN,XQPRO,XQUF,XQHOLD,ZTSK
 Q
 ;
ADD ;Add options that have been delegated to this user.
 S DA(1)=XQM,DIC="^VA(200,"_DA(1)_",19.5,",DIC(0)="NFL",DLAYGO=200,XQN="",XQUF=0 I '$D(^VA(200,XQM,19.5,0)) S ^(0)="^200.19P^^"
 F XQK=0:0 S XQN=$O(^TMP($J,"OP",XQN)) Q:XQN=""  D:'XQPRO CHCK I 'XQUF S (X,DINUM)=XQN D:$D(^VA(200,DA(1),19.5,X,0))[0 FILE^DICN S XQUF=0
 Q
 ;
REM ;Remove delegated options from this delegate.
 S DA(1)=XQM,DIK="^VA(200,"_DA(1)_",19.5,",XQN="",XQUF=0 F XQL=0:0 S XQN=$O(^TMP($J,"OP",XQN)) Q:XQN=""  D:'XQPRO CHCK I 'XQUF S DA=XQN D:$D(^VA(200,DA(1),19.5,DA,0)) ^DIK S XQUF=0
 Q
 ;
CHCK ;See if this person has this option before delegating it.
 S:'$D(^VA(200,DUZ,19.5,XQN,0))#2 XQUF=1 I XQUF S XQON=^DIC(19,XQN,0)
 Q
 ;
GIVOPT ; GIVE USER MENU SO HE CAN USE THE DELEGATED CAPABILITY
 ;
 S X="XQSMD USER MENU",DIC=19,DIC(0)="MX" D ^DIC Q:Y'>0
 S XQSMDX=$P(Y,U,2),DA(1)=0 F I=1:1 S DA(1)=$O(XQHOLD(DA(1))) Q:DA(1)=""  S X=XQSMDX,DIC="^VA(200,"_DA(1)_",203,",P=3.03,DIC(0)="ML",DLAYGO=200 S:'$D(@(DIC_"0)")) @(DIC_"0)")="^200.03P" D ^DIC
 K XQSMDX
 Q
 ;
OUT K DIC,DIK,DA,DISYS,DINUM,POP,XQ,XQD,XQH,XQI,XQJ,XQK,XQL,XQM,XQN,XQT,XQON,XQON0,XQAL,XQDATE,XQDEL,XQDT,XQLEV,XQLK,XQMG,XQMGR,XQNAM,XQNGO,XQUF,XQPRO,XQSTART,XQEND,XQHOLD,XQKEY,X,Y,XY,%,^TMP($J),C,XQU1L
 Q
