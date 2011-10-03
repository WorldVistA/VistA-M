FBAAOB ;AISC/GRR-OPEN BATCHES ;29JUL86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D:'$D(DT) DT^DICRW D:'$D(FBSITE(1)) SITEP^FBAAUTL G:+$G(FBPOP) KILL
 I '$D(^FBAA(161.4,1,0)) W !!,*7,"Site Parameters have not been entered. Must be entered",!,"before using this option",! Q
 S DIC="^FBAA(161.7,",DIC(0)="LQ",DLAYGO=161.7
RMED S DIR(0)="Y",DIR("A")="Want to create a Medical batch",DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT) KILL I Y D MED,KILL Q
RPHARM S DIR(0)="Y",DIR("A")="Want to create a Pharmacy Batch",DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT) KILL I Y D PHARM,KILL Q
 Q:$D(FBPHOPT)
RTRAV S DIR(0)="Y",DIR("A")="Want to create a Travel Batch",DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT) KILL I Y D TRAV,KILL Q
 D KILL Q
TRAV D GETNXB^FBAAUTL W !!,"Travel Batch number assigned is: ",FBBN
 W !! S X=FBBN,DIC(0)="LEQ",(DIE,DIC)="^FBAA(161.7,",DIC("DR")="",DLAYGO=161.7 D ^DIC K DLAYGO G:Y<0 UHOH S FBDA=+Y
 D GETOB Q:'$D(FBSTN)  S DA=FBDA,DR="[FBAA TRAV IFCAP]" D ^DIE,KILL
 Q
MED D GETNXB^FBAAUTL W !!,"Medical Batch number assigned is: ",FBBN
 W !! S X=FBBN,DIC(0)="LEQ",(DIE,DIC)="^FBAA(161.7,",DIC("DR")="",DLAYGO=161.7 D ^DIC K DLAYGO G:Y<0 UHOH S FBDA=+Y,FBY=Y K DR
 D GETOB Q:'$D(FBSTN)  S DA=FBDA,DR="[FBAA MED IFCAP]" D ^DIE,KILL
 Q
PHARM D GETNXB^FBAAUTL W !!,"Pharmacy Batch number assigned is: ",FBBN
 W !! S X=FBBN,DLAYGO=161.7,DIC(0)="LEQ",(DIE,DIC)="^FBAA(161.7,",DIC("DR")="" D ^DIC G:Y<0 UHOH S FBDA=+Y,FBY=Y K DR,DLAYGO
 D GETOB Q:'$D(FBSTN)  S DA=FBDA,DR="[FBAA PHARM IFCAP]" D ^DIE,KILL
 Q
RCHNH I '$D(FBSITE(1)) D SITEP^FBAAUTL G:FBPOP KILL
 S DIR(0)="Y",DIR("A")="Want to create a Community Nursing Home batch",DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT) KILL I Y D CHNH,KILL
 D KILL Q
CHNH D GETNXB^FBAAUTL W !!,"Batch number assigned is: ",FBBN
 W !! S X=FBBN,DLAYGO=161.7,DIC(0)="LQ",(DIE,DIC)="^FBAA(161.7,",DIC("DR")="" D ^DIC G:Y<0 UHOH S FBDA=+Y K DR,DLAYGO
 D GETOB Q:'$D(FBSTN)  S DA=FBDA,DR="[FB CHNH OPEN BATCH]" D ^DIE,KILL
 Q
GETOB S PRCS("A")="Select Obligation Number: " K PRCS("X"),DR S PRCS("TYPE")="FB" D EN1^PRCS58 G:Y=-1 BACKOUT S FBSTN=$E($P(Y,"^",2),1,3),FBOBN=$P($P(Y,"^",2),"-",2) K PRCS D:$S($G(FBSTN)']"":1,$G(FBOBN)']"":1,1:0) BACKOUT Q
 ;
BACKOUT S DIK="^FBAA(161.7,",DA=FBDA D ^DIK W !,*7,"Batch # ",FBBN," deleted because Obligation number was not selected!",!,"You must be an authorized user in IFCAP package to select an obligation." K FBSTN Q
 ;
RCHOP I '$D(FBSITE(1)) D SITEP^FBAAUTL G:FBPOP KILL
 S DIR(0)="Y",DIR("A")="Want to create a Contract Hospital Batch",DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT)!('Y) KILL I Y D CH
 ;FBAABE is set from FBCHEP to ask user to open a new batch
 I $D(FBAABE) S FBAABE=FBDA
 D KILL Q
CH D GETNXB^FBAAUTL W !!,"Batch number assigned is: ",FBBN
 S DLAYGO=161.7
 W !! S X=FBBN,DIC(0)="LQ",(DIE,DIC)="^FBAA(161.7,",DIC("DR")="",DLAYGO=161.7 D ^DIC G:Y<0 UHOH S FBDA=+Y K DR,DLAYGO
 D GETOB Q:'$D(FBSTN)  S DA=FBDA,DR="[FB CH OPEN BATCH]" D ^DIE
 Q
ANCOB I '$D(FBSITE(1)) D SITEP^FBAAUTL G:FBPOP KILL
 S DLAYGO=161.7
 S DIR(0)="Y",DIR("A")="Want to create an Ancillary Payment Medical Batch",DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT) KILL I Y D MED,KILL
 D KILL Q
UHOH W !!,*7,"Batch was not created!" Q
KILL K DA,D,DR,DIC,DIE,DIK,FBDA,FBOBN,FBPOP,FBSTN,FBSITE,Y,FBY,PRC,X,FBBN,Z,DLAYGO,D0,DQ,DIRUT,PRCSCPAN
 Q
