LRARU ;DALISC/CKA - LAB ARCHIVING MISC. ;4/19/95
 ;;5.2;LAB SERVICE;**59,150**;July 31, 1995
NEW ;SET UP INITIAL ARCHIVAL ACTIVITY
 ;CALLED FROM LRARWKD,LRARLMW,LRARBI
 ;LRART=FILE # OF FILE BEING ARCHIVED
 D NOW^%DTC
 S X=$P(^LAB(95.11,0),U,3) F X=X:1 L +^LAB(95.11,X):0 Q:$T&'$D(^(X))  L -^LAB(95.11,X)
 S Z="1////"_LRART_";4////"_DT_$S($D(^VA(200)):";7////1;7.5////"_DUZ,1:"")_";12////"_LRAR_";13////"_%_$S($D(^VA(200)):";14////"_DUZ,1:"")_";15////"_$S(LRART=64.1:64.19999,LRART=65:65.9999,LRART=67.9:67.99999,1:0)
 S DINUM=X,DIC("DR")=Z
 K DD,DO S DIC="^LAB(95.11,",DLAYGO=95.11,DIC(0)="L"
 D FILE^DICN S LRARC=+Y K DIC,DINUM,DLAYGO,DR,X,Z
 Q
 ;
FILE ;LOOKUP LAB ARCHIVING ACTIVITY
 S DIC="^LAB(95.11,"
 I $D(LRARFL1) S DIC("S")="I $P(^(0),U,2)=LRART"
 I LRAR=""!(LRAR=99) S DIC(0)="AEQIMZ" I '$D(DIC("A")) S DIC("A")="Select LAB ARCHIVAL ACTIVITY: "
 I LRAR'="",LRAR'=99 S DIC(0)="Z",X=LRARC
 D ^DIC K DIC I Y<0!$D(DUOUT)!$D(DTOUT) K LRARC Q
 I $P(Y(0),U,14) D ER1 K LRARC Q
 S LRARC=+Y,LRARF=$P(Y(0),U,2),LRARU=$P(Y(0),U,3),LRARP=$P(Y(0),U,4),LRARST=$P(Y(0),U,8)
 I LRAR=LRARST D ER3 K LRARC Q
 I LRAR=90,LRARST=90!(LRARST="") D ER4 K LRARC Q
 I LRAR=99 D:LRARST=3 MSG I LRARST>6 D ER5 K LRARC Q
 Q
 ;
CHECK ;Check LAB ARCHIVAL ACTIVITY FILE
 I $D(^LAB(95.11,"C",LRART)) D
 .  S LRARC=0 F X=0:0 S LRARC=$O(^LAB(95.11,"C",LRART,LRARC)) Q:LRARC=""  S LRARST=$P(^LAB(95.11,LRARC,0),U,8) I LRARST>0,LRARST'=90 D
 ..  W !!!!,$C(7),"There is an outstanding archival activity."
 ..  W !,"Please finish or cancel this activity before you begin another."
 ..  W !!
 ..  S LRARFL=1
 K LRARST,X
 Q
ENTC ;CANCEL
 S LRAR=99,DIC("A")="CANCEL WHICH LAB ARCHIVING SELECTION:  " D FILE^LRARU G EXIT:'$D(LRARC)
 S DIR("A")="Are you sure you want to CANCEL this LAB ARCHIVING ACTIVITY",DIR("B")="NO",DIR(0)="Y"
 S DIR("??")="^W !!?5,""Enter YES to stop this activity and start again from the beginning."""
 D ^DIR G EXIT:$D(DUOUT)!$D(DTOUT),EXIT:'Y
 D MRK^LRARU1
 S DIK="^LAB(95.11,",DA=LRARC D ^DIK
 S LRARNRB=0 I $S(LRARF=64.1:$P($G(^LAR(64.19999,0)),U,4),LRARF=67.9:$P($G(^LAR(67.99999,0)),U,4),LRARF=65:$P($G(^LRD(65.9999,0)),U,4)) D ASK G EXIT:$D(DUOUT)!$D(DTOUT) I 'LRARNRB D KILL
 D COMP^LRARU1
 W !!,">>> DONE <<<"
 G EXIT
 Q
ER1 W $C(7),!!!,"The following Archival Activity is in progress--no access allowed!",!
 S LRARX=Y(0),Y=$P(Y(0),U,14),C=$P(^DD(95.11,13,0),U,2) D Y^DIQ W Y_"     STARTED: " S Y=$P(LRARX,U,14) X:Y ^DD("DD") W Y_"    BY: " W:$D(^VA(200,+$P(LRARX,U,15),0)) $P(^(0),U,1) W ! Q
ER3 S:LRARST=90 LRARST=4 W !!,$C(7),"This activity has already been "_$P($P($P(^DD(95.11,7,0),U,3),";",LRARST),":",2),"!" Q
ER4 W !!,$C(7),"Data ALREADY purged!",! Q
ER5 W !!,$C(7),"Cannot cancel archiving record after archiving has been complete--this now",!,"acts as your history!!" Q
MSG W !!,$C(7),"Just a reminder--you have already archived these records to permanent storage.",!,"You probably won't want to save the sequential storage media since you",!,"are cancelling this archiving activity!!",! Q
 Q
ASK W !!,$C(7),"This archival activity has already updated the archived file.",!
 S DIR("A")="Delete the archived file entries created by this lab archival activity",DIR("B")="YES",DIR(0)="Y"
 S DIR("??")="^W !!?5,""Enter YES to rollback the archived file to its state before the update."""
 D ^DIR I 'Y S LRARNRB=1
 Q
KILL W !!,"I will now CLEAR out the global."
 G:LRARF=64.1 AWD G:LRARF=67.9 ALMW G:LRARF=65 ABI
 Q
AWD S LRARX="" F LRARI=0:0 S LRARX=$O(^LAR(64.19999,LRARX)) Q:LRARX=""  K ^LAR(64.19999,LRARX)
 S ^LAR(64.19999,0)="ARCHIVED WKLD DATA^64.19999"
 Q
ALMW S LRARX="" F LRARI=0:0 S LRARX=$O(^LAR(67.99999,LRARX)) Q:LRARX=""  K ^LAR(67.99999,LRARX)
 S ^LAR(67.99999,0)="ARCHIVED LAB MONTHLY WORKLOADS^67.99999"
 Q
ABI S LRARX="" F LRARI=0:0 S LRARX=$O(^LRD(65.9999,LRARX)) Q:LRARX=""  K ^LRD(65.9999,LRARX)
 S ^LRD(65.9999,0)="ARCHIVED BLOOD INVENTORY^65.9999"
 Q
DEV ;ASK ARCHIVE DEVICE LABEL AND STORE IN ARCHIVAL ACTIVITY FILE
 S DIR(0)="95.11,16" D ^DIR
 G:$D(DUOUT)!($D(DTOUT))!(Y="") EXIT K DIR
 S DA=LRARC,DIE="^LAB(95.11,",DR="16////"_Y
 D ^DIE
 G EXIT
 Q
DEL ;DELETE ARCHIVED FILE ENTRIES AFTER ARCHIVAL ACTIVITY IS CANCELED
 S DIR(0)="S^1:ARCHIVED WKLD DATA;2:ARCHIVED LAB MONTHLY WORKLOADS"
 S DIR("A")="FILE"
 D ^DIR K DIR
 I $D(DIRUT)!('Y) G EXIT
 S LRART=$S(Y=1:64.1,Y=2:67.9,1:0)
 I 'LRART G EXIT
 I '$P($G(^LAR(LRART_"9999",0)),U,4) W $C(7),!!,"No data in file.",! G EXIT
 S LRARFL=""
 I $D(^LAB(95.11,"C",LRART)) D
 .  S LRARC=0 F X=0:0 S LRARC=$O(^LAB(95.11,"C",LRART,LRARC)) Q:LRARC=""  S LRARST=$P(^LAB(95.11,LRARC,0),U,8) I LRARST>0,LRARST'=90 D
 ..  W !!!!,$C(7),"There is an outstanding archival activity."
 ..  S LRARFL=1
 K LRARST,X
 I LRARFL W !!,"This option is for use only after the archival activity is canceled.",! G EXIT
 S LRARF=LRART
 D KILL
 W !!,"Done."
EXIT K DA,DIC,DIE,DIK,DIR,D0,DR,DTOUT,DUOUT,LRAR,LRARC,LRARF,LRARI,LRARNRB,LRARP,LRARST,LRARU,LRARX,Y
 D CLN^LRARU1
 Q
