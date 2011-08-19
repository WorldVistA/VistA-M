ECTP13 ;B'ham ISC/PTD - Patch Routine to Update the National Service File ;11/02/93 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;**13**;
 I '$O(^ECC(730,0)) W !,"National Service File - #730 does not exist on your system.",!,"This routine is unable to update the file!" G EXIT
 W !!,"This routine will update your National Service File - #730.",!,"The following changes will be made:"
 W !!,"BUILDING MANAGEMENT will be changed to ENVIRONMENTAL MANAGEMENT.",!,"LABORATORY will be changed to PATHOLOGY & LABORATORY MEDICINE."
 W !,"PERSONNEL will be changed to HUMAN RESOURCES MANAGEMENT.",!,"REHABILITATION MEDICINE will be changed to PHYSICAL MEDICINE & REHABILITATION."
 S DIR(0)="Y",DIR("A")="Do you wish to continue?",DIR("B")="NO" D ^DIR I Y'=1 W !!,"No change has been made to File 730!",! G EXIT
 L +^ECC(730) W ! F JJ=1:1 S ECTSRV=$P($T(TEXT+JJ),";;",2) Q:ECTSRV=""  D LOOP
 L -^ECC(730) K ^ECC(730,"B") S DIK="^ECC(730,",DIK(1)=".01^B" D ENALL^DIK
EXIT K DA,DIC,DIK,DIR,DTOUT,DUOUT,DIRUT,DIROUT,ECTDA,ECTNEW,ECTOLD,ECTSRV,JJ,X,Y
 Q
 ;
LOOP ;Make change to individual file entry.
 S ECTDA=$P(ECTSRV,"^"),ECTOLD=$P(ECTSRV,"^",2),ECTNEW=$P(ECTSRV,"^",3)
 I $D(^ECC(730,ECTDA,0)),$P(^(0),"^")=ECTNEW Q  ;Entry previously converted.
 S $P(^ECC(730,ECTDA,0),"^")=ECTNEW W !,ECTOLD," has been changed to ",ECTNEW,"."
 Q
 ;
TEXT ;Services to be updated: Internal DA#^Old Service Name^New Service Name
 ;;6^BUILDING MANAGEMENT^ENVIRONMENTAL MANAGEMENT
 ;;20^LABORATORY^PATHOLOGY & LABORATORY MEDICINE
 ;;29^PERSONNEL^HUMAN RESOURCES MANAGEMENT
 ;;39^REHABILITATION MEDICINE^PHYSICAL MEDICINE & REHABILITATION
