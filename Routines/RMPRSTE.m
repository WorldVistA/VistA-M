RMPRSTE ;HINCIO/RVD-ISSUE FROM STOCK / CONT. ;11/06/00
 ;;3.0;PROSTHETICS;**53,62,78**;Feb 09, 1996
 ;modified for cpt modifier
 ;RVD patch #62 - modified for PCE interface.
 ;TH  Patch #78 - Add Date of Service/Shipment Date 
 ;Per VHA Directive 10-93-142, this routine should not be modified.
NEX K DIR,Y,X
 S $P(R1(0),U,16)=RMPRUCST*$P(R1(0),U,7)
 S $P(R3("D"),U,16)=RMPRUCST*$P(R1(0),U,7)
QTY K DIR,Y S DIR(0)="660,5" S:$P(R1(0),U,7) DIR("B")=$P(R1(0),U,7)
 D ^DIR I $P(R1(0),U,7)'=""&$D(DUOUT) G LIST
 I $D(DTOUT) X CK2 G ^RMPRSTI
 I $D(DIRUT) G LOC^RMPRSTI
 I $G(RMUBA),((RMUBA-Y)<0) D LOWBA^RMPRSTI G LOC^RMPRSTI
 S $P(R1(0),U,7)=Y,$P(R1(0),U,16)=Y*RMPRUCST K DIR
 ;SET DELIVERY DATE to today
 ;
DATE ;delivery date and date of service/shipment date is set to today's date
 S $P(R1(0),U,12)=DT,$P(R1(1),U,8)=DT,Y=DT D DD^%DT S $P(R3("D"),U,12)=Y
LI S DIR(0)="660,9" S:$P(R1(0),U,11)'="" DIR("B")=$P(R1(0),U,11)
 D ^DIR I $D(DTOUT) X CK1 Q
 G:$D(DUOUT) LIST
 I X["^" W !,"Jumping not allowed" G LI
 I $P(R1(0),U,11)'=""&(X="@") S $P(R1(0),U,11)="" W $C(7),!?5,"Deleted..." H 1 G LOT
 S $P(R1(0),U,11)=X
 ;
LOT ;
 ;
 K DIR S DIR(0)="660,21" S:$P(R1(0),U,24)'="" DIR("B")=$P(R1(0),U,24)
 D ^DIR I $D(DTOUT) X CK1 Q
 G:$D(DUOUT) LIST
 I X["^" W !,"Jumping not allowed" G LOT
 I $P(R1(0),U,24)'=""&(X="@") S $P(R1(0),U,24)="" W $C(7),!?5,"Deleted..." H 1 G REMA
 S $P(R1(0),U,24)=X
 ;
REMA ;
 ;
 K DIR S DIR(0)="660,16" S:$P(R1(0),U,18)'="" DIR("B")=$P(R1(0),U,18)
 D ^DIR I $D(DTOUT) X CK1 Q
 G:$D(DUOUT) LIST
 I X["^" W !,"Jumping not allowed" G REMA
 I $P(R1(0),U,18)'=""&(X="@") S $P(R1(0),U,18)="" W $C(7),!?5,"Deleted..." H 1 G LIST
 S $P(R1(0),U,18)=X
 ;
LIST ;ENTRY POINT FOR STOCK ISSUE ROUTINES TO DISPLAY TRANSACTION DATA
 S RMDAHC=$P(R1(1),U,4)
 D NODE2^RMPRSTI
 D:$D(RMCPT) CHK^RMPRED5
 D ^RMPRST2
 K DIR,RQUIT
 S DIR(0)="SBO^P:POST;E:EDIT;D:DELETE"
 S DIR("A")="Would you like to POST/EDIT/DELETE this entry"
 S DIR("B")="P"
 S DIR("?")="Answer `P` to post the transaction, `E` to edit the transaction,'D' to delete the transaction"
 D ^DIR K DIR G:Y="P" POST G:Y="D" DEA
 I Y="E" S REDIT=1 G 1^RMPRSTI
 I $D(DIRUT)!$D(DUOUT)!$D(DTOUT) G ^RMPRSTI
 ;
DEA ;
 K DIR
 S DIR("A")="Are you sure you want to DELETE this entry"
 S DIR("B")="N",DIR(0)="Y"
 D ^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT) X CK Q
 I Y=1 W !!,$C(7),?50," Deleted..." H 2 K DIR G RES^RMPRSTI
 G LIST
 ;
POST ;
 ;
 I RMPRG'="" G GGC
 L +^RMPR(669.9,RMPRSITE,0):999 I $T=0 S RMPRG=DT_99 G GGC
 S RMPRG=$P(^RMPR(669.9,RMPRSITE,0),U,7),RMPRG=RMPRG-1
 S $P(^RMPR(669.9,RMPRSITE,0),U,7)=RMPRG L -^RMPR(669.9,RMPRSITE,0)
GGC S $P(RMPRI("AMS"),U,1)=RMPRG,RMSER=$P(R1(0),U,11)
 ;update inventory balance
 I $G(RMLOC) S RMQTY=$P(R1(0),U,7) D ADD^RMPR5NU1 I $D(RQUIT) X CK Q
 I '$D(RMLOC) X CK Q
 S:$D(RMLOC) $P(R1(1),U,2)=RDESC,$P(R1(0),U,13)=11,$P(R1(1),U,5)=RM6612
 ;
 ;create 2319
 K Y,DD,DO,DA S DIC="^RMPR(660,",DIC(0)="L",X=DT,DLAYGO=660
 D FILE^DICN K DLAYGO
 I Y'>0 W !,"** Error posting to 2319...entry deleted..." G RES^RMPRSTI
 S ^RMPR(660,+Y,0)=R1(0),^(1)=R1(1),^("AM")=R1("AM"),^(2)=R1(2)
 S $P(R1(1),U,8)=DT
 S ^("AMS")=RMPRI("AMS")
 I $D(RMLOC) MERGE ^RMPR(660,+Y,"DES")=^RMPR(661.1,RMDAHC,2) S $P(^RMPR(660,+Y,"DES",0),U,2)=""
 S DIK="^RMPR(660,",(RM60,DA)=+Y D IX1^DIK K DIC
 S ^TMP($J,"RMPRPCE",660,DA)=RMPRG_"^"_$G(RMPRDFN)
 ;
 W !,"Posted to 2319..." H 3
 G RES^RMPRSTI
 ;
EXIT ;EXIT FOR STOCK ISSUES
 K ^TMP($J)
 N RMPRSITE,RMPR D KILL^XUSCLEAN
 Q
 ;
ERR0 ;delete entry & print error message if posting fails.
 ;K DIK
 ;S DIK="^RMPR(660,",DA=RM60 D ^DIK
 ;W !,"** Error posting to 2319...entry deleted...",!! H 3
 ;Q
 ;
 ;
INV1 I $P(R1(0),U,14)="C" S $P(R1(0),U,16)=RMPRUCST*$P(R1(0),U,7)
 G QTY
