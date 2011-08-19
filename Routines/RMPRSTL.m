RMPRSTL ;PHX/RFM,RVD-ISSUE FROM STOCK ;8/29/1994
 ;;3.0;PROSTHETICS;**14,28,33,41**;Feb 09, 1996
 ;modified for cpt modifier
 ;Per VHA Directive 10-93-142, this routine should not be modified.
NEX K DIR,Y,X I $G(RMPRGIP) G INV1
 I $P(R1(0),U,14)="C" S DIR(0)="667.3,3",DIR("A")="UNIT COST"
 ;DISPLAY DEFAULT UNIT COST FOR NON-GIP ISSUES
 ;
 I  S RO=0 I $O(^PRC(441,$P(R3("D"),U,6),2,RO))'="" D
 .Q:'$D(^PRC(441,$P(R3("D"),U,6),2,$P(R1(0),U,9),0))
 .S (RMPRUCST,DIR("B"))=$J($P(^PRC(441,$P(R3("D"),U,6),2,$P(R1(0),U,9),0),U,2)/$S($P(^(0),U,10)]"":$P(^(0),U,10),1:1),9,2),(RMPRUCST,DIR("B"))=$$STRIP^XLFSTR(RMPRUCST," ")
 S:+$P(R1(0),U,16) DIR("B")=$P(R1(0),U,16)/$P(R1(0),U,7)
 I $G(RMLOC),$G(RMHCDA),$G(RMITDA) S (DIR("B"),RMPRUCST)=$P($G(^RMPR(661.3,RMLOC,1,RMHCDA,1,RMITDA,0)),U,10) G:RMPRUCST>0 QTY
 I $P(R1(0),U,14)="C" D ^DIR K DIR I +$P(R1(0),U,16)&($D(DUOUT)) G LIST
 I $D(DUOUT) X CK Q
 I $D(DTOUT) X CK1 Q
 I $P(R1(0),U,14)="C" S RMPRUCST=Y S:$P(R1(0),U,16) $P(R1(0),U,16)=RMPRUCST*$P(R1(0),U,7) I $D(DIRUT) X CK Q
 I $P(R1(0),U,6)="C" S $P(R1(0),U,16)=Y,$P(R3("D"),U,16)=Y
 I $P(R1(0),U,14)="V" S $P(R1(0),U,16)=0,RMPRUCST=0
QTY K DIR,Y S DIR(0)="660,5" S:$P(R1(0),U,7) DIR("B")=$P(R1(0),U,7) D ^DIR I $P(R1(0),U,7)'=""&$D(DUOUT) G LIST
 I $D(DTOUT) X CK1 Q
 I $D(DIRUT) X CK Q
 S $P(R1(0),U,7)=Y,$P(R1(0),U,16)=Y*RMPRUCST K DIR
 ;SET DELIVERY DATE to today
 ;
DATE ;K DIR,Y S DIR(0)="660,10" S:$P(R3("D"),U,12)'="" DIR("B")=$P(R3("D"),U,12) D ^DIR K DIR G:X["^" LIST I $D(DTOUT) X CK1 Q
 ;W:$P(R1(0),U,12)&(X="@") $C(7),!?5,"Deleted..." I $P(R1(0),U,12)=""&(X="@") W ?17,"??" G DATE
 S $P(R1(0),U,12)=DT,Y=DT D DD^%DT S $P(R3("D"),U,12)=Y
LI S DIR(0)="660,9" S:$P(R1(0),U,11)'="" DIR("B")=$P(R1(0),U,11) D ^DIR I $D(DTOUT) X CK1 Q
 G:$D(DUOUT) LIST
 I X["^" W !,"Jumping not allowed" G LI
 I $P(R1(0),U,11)'=""&(X="@") S $P(R1(0),U,11)="" W $C(7),!?5,"Deleted..." H 1 G LOT
 S $P(R1(0),U,11)=X
LOT K DIR S DIR(0)="660,21" S:$P(R1(0),U,24)'="" DIR("B")=$P(R1(0),U,24) D ^DIR I $D(DTOUT) X CK1 Q
 G:$D(DUOUT) LIST
 I X["^" W !,"Jumping not allowed" G LOT
 I $P(R1(0),U,24)'=""&(X="@") S $P(R1(0),U,24)="" W $C(7),!?5,"Deleted..." H 1 G REMA
 S $P(R1(0),U,24)=X
REMA K DIR S DIR(0)="660,16" S:$P(R1(0),U,18)'="" DIR("B")=$P(R1(0),U,18) D ^DIR I $D(DTOUT) X CK1 Q
 G:$D(DUOUT) LIST
 I X["^" W !,"Jumping not allowed" G REMA
 I $P(R1(0),U,18)'=""&(X="@") S $P(R1(0),U,18)="" W $C(7),!?5,"Deleted..." H 1 G LIST
 S $P(R1(0),U,18)=X
LIST ;ENTRY POINT FOR STOCK ISSUE ROUTINES TO DISPLAY TRANSACTION DATA
 I $G(RMLOC),$G(RMITDA) S RMINVF="PROS INVENTORY"
 D:$D(RMCPT) CHK^RMPRED5
 K DIR D ^RMPRST2
 S DIR("A")="Do you wish to POST this entry",DIR("B")="YES",DIR(0)="Y",DIR("?")="Answer `YES` to post the transaction, `NO` to delete/edit the transaction" D ^DIR K DIR G:Y=1 POST G:Y=0 DEA I $D(DIRUT) X CK Q
DEA S DIR("A")="Do you wish to Delete this entry",DIR("?")="Answer `YES` to delete the transaction, `NO` to edit the transaction, `^` to exit",DIR("B")="NO",DIR(0)="Y"
 D ^DIR K DIR I Y=1 W $C(7),?50,"Deleted..." H 2 G RES^RMPRSTK
 I Y=0 S REDIT=1 G 1^RMPRSTK
 G:$D(DUOUT) LIST I $D(DIRUT) X CK Q
POST I $G(RMPRGIP) S PRCP("QTY")=$P(R1(0),U,7)*-1,PRCP("TYP")="R" D ^PRCPUSA
 I $D(PRCP("ITEM")) W !!,"Error encountered while posting to GIP. Inventory Issue did not post, Patient 10-2319 not updated!! Please check with your Application Coordinator." H 10 G RES^RMPRSTK
 I RMPRG'="" G GGC
 L +^RMPR(669.9,RMPRSITE,0):999 I $T=0 S RMPRG=DT_99 G GGC
 S RMPRG=$P(^RMPR(669.9,RMPRSITE,0),U,7),RMPRG=RMPRG-1,$P(^RMPR(669.9,RMPRSITE,0),U,7)=RMPRG L -^RMPR(669.9,RMPRSITE,0)
GGC S $P(RMPRI("AMS"),U,1)=RMPRG,RMSER=$P(R1(0),U,11)
 ;update inventory balance
 S RMHCPC=$P(R1(1),U,4)
 I $P(^RMPR(661.1,RMHCPC,0),U,9)=1&($D(RMLOC)) S RMQTY=$P(R1(0),U,7) D ADD^RMPR5NU1 I '$D(RMLOC) X CK Q
 S:$D(RMLOC) $P(R1(1),U,2)=RDESC,$P(R1(0),U,13)=11,$P(R1(1),U,5)=RM6612
 ;
 ;create 2319
 K Y,DD,DO,DA S DIC="^RMPR(660,",DIC(0)="L",X=DT,DLAYGO=660 D FILE^DICN K DLAYGO I Y'>0 W !,"** Error posting to 2319...entry deleted..." G RES^RMPRSTK
 S ^RMPR(660,+Y,0)=R1(0),^(1)=R1(1),^("AM")=R1("AM"),^("AMS")=RMPRI("AMS") S:$G(RMPRGIP)=1 $P(^(1),U,3)=$G(RMPRIP)
 I $D(RMLOC) MERGE ^RMPR(660,+Y,"DES")=^RMPR(661.1,RMDAHC,2) S $P(^RMPR(660,+Y,"DES",0),U,2)=""
 S DIK="^RMPR(660,",DA=+Y D IX1^DIK K DIC
 G RES^RMPRSTK
 ;
EXIT ;EXIT FOR STOCK ISSUES
 N RMPRSITE,RMPR D KILL^XUSCLEAN
 Q
ERR W !,"PLEASE EDIT GIP IN YOUR SITE PARAMETER FILE!" G EXIT
INV1 I $P(R1(0),U,14)="C" S $P(R1(0),U,16)=RMPRUCST*$P(R1(0),U,7)
 G QTY
