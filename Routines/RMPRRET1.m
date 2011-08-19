RMPRRET1 ;PHX/RFM-RETURN ITEM FROM 2319 ;8/29/1994
 ;;3.0;PROSTHETICS;;Feb 09, 1996
 D DIV4^RMPRSIT,HOME^%ZIS G:$D(X) EXIT
 ;ENTRY POINT FOR ADDITIONAL RETURNS
EN K ^TMP($J),DIK,DFN,DIC,DIE,DR,IEN,PRCP,RMPRIEN,RMPRITEM,RMPRITM,RMPRSER,RO,RZ,S660 S DIC="^RMPR(665,",DIC(0)="AEQMZ",DIC("A")="Select PATIENT: " D ^DIC G:Y<0 EXIT S DFN=+Y
 K DIR S DIR(0)="Y",DIR("A")="Are You Returning an Auto-Adaptive Equipment Item",DIR("B")="NO" D ^DIR G:$D(DIRUT) EXIT G:Y=1 EN^RMPRRET2
EN1 I '$D(^RMPR(660,"C",DFN)) G ^RMPRRET2
 D WAIT^DICD
 ;H 1
 S RP=0 F I=1:1 S RP=$O(^RMPR(660,"C",DFN,RP)) Q:RP=""  D CK
 G TMP
CK Q:$P(^RMPR(660,RP,0),U,20)!('$P(^(0),U,6))!($P(^(0),U,4)["X")  S ^TMP($J,RP)=$P(^PRC(441,$P(^RMPR(661,$P(^RMPR(660,RP,0),U,6),0),U),0),U,2)
 Q
TMP I '$D(^TMP($J)) W !,"No items available on patient 10-2319 for return." G ^RMPRRET2
TMP1 W !!?15,"*ITEMS RECORDED ON PATIENT'S 2319*",!!,?15,"ITEM",?30,"DATE ISSUED",?43,"SERIAL NUMBER"
 S RO=0 F I=1:1 S RO=$O(^TMP($J,RO)) Q:RO=""!($D(RMPRKILL))  S RZ(I)=RO D WRI I $D(RMPRIEN)!(X="^")!($D(DTOUT)) Q
 G:$D(DTOUT) EXIT G:$D(RMPRKILL)!('$D(RMPRIEN)) CON I $D(^PRCP(445,"AE",RMPRITEM)),$P(^RMPR(669.9,RMPRSITE,0),U,3) G INV
 G POS
WRI I $D(RMPRHELP) K RMPRHELP G WRI
 W !,I_".",?7,$P(^RMPR(660,RO,0),U,15),$E($P(^TMP($J,RO),U),1,20) S Y=$P(^RMPR(660,RO,0),U,3) D DD^%DT W ?30,Y W ?43,$P(^RMPR(660,RO,0),U,11)
SEL I I#15=0!($O(^TMP($J,RO))="") D  Q:(X="^")!(X="")
 .W !! K DIR S DIR(0)="NO^1:"_I,DIR("A")="Please enter a number" D ^DIR  Q:(X="^")!(X="")!($D(DTOUT))
 .S (ZRMP,RMPRIEN)=RZ(X),RMPRSER=$P(^RMPR(660,RMPRIEN,0),U,11),RMPRITM=$P(^(0),U,6),(PRCP("ITEM"),RMPRITEM)=$P(^RMPR(661,RMPRITM,0),U,1)
 Q
CON W $C(7),!!,"You have not selected an item posted to the Patient's 10-2319.",! G ^RMPRRET2
POS ;POST TRANSACTION TO 660.1 AND GIP
 S DIC="^RMPR(660.1,",DIC(0)="L",X=DT,DLAYGO="660.1" K DD,DO D FILE^DICN S IEN=+Y K DLAYGO
 S S660=^RMPR(660,RMPRIEN,0),^RMPR(660.1,IEN,0)=DT_U_$P(S660,U,2)_U_RMPRITM_U_$P(S660,U,7)_U_$P(S660,U,16)_U_$P(S660,U,11)_"^^^"_2_"^^^"_$S($D(RMPRINV):RMPRINV,1:"")_"^^^"_RMPR("STA")_U_RMPRIEN_"^^"_$S($D(^RMPR(660,RMPRIEN,1)):$P(^(1),U),1:"")
 L +^RMPR(660.1,IEN,0):1 I $T=0 W $C(7),?5,!,"Someone else is editing this record" G EXIT
 S DIE=DIC,DA=IEN,DR="@3;10R;I $P(^RMPR(660.1,DA,0),U,11)<$P(S660,U,3) W !,$C(7),""Date of Return must be equal to or greater than the date the item was issued"" S $P(^(0),U,11)="""",Y=""@3"";13R;5" D ^DIE
 L -^RMPR(660.1,IEN,0) I '$P(^RMPR(660.1,IEN,0),U,11)!('$P(^(0),U,14)) S DIK="^RMPR(660.1,",DA=IEN D ^DIK W $C(7),!?10,"Deleted..." G EXIT
 S $P(^RMPR(660,RMPRIEN,0),U,11)=$P(^RMPR(660.1,IEN,0),U,6),$P(^RMPR(660,RMPRIEN,0),U,20)=$P(^RMPR(660.1,IEN,0),U,11)
 S DIK="^RMPR(660.1,",DA=IEN D IX1^DIK
 I $D(OK) K OK S PRCP("TYP")="A",PRCP("QTY")=$P(^RMPR(660.1,IEN,0),U,4) D ^PRCPUSA I $D(PRCP("ITEM")) D
 .W !,$C(7),$C(7),"Error encountered while trying to post this item to GIP.  Please",!,"post this item manually,",! Q
 D WAIT^DICD
 ;H 1
 W @IOF G EN
INV I '$D(^PRCP(445,"AD",DUZ)) S %=2 W $C(7),!,"You are not an Inventory Point user and the item you have selected is in",!,"Inventory. Do you wish to continue" D YN^DICN G:%=2!(%<0) EXIT G:%=1 POS W !,"Answer `YES` or `NO`" G INV
 I $D(^RMPR(660,RMPRIEN,1)),$D(^PRCP(445,+$P(^(1),U,3),1,RMPRITEM)) K DIC S DIC("B")=$P(^RMPR(660,RMPRIEN,1),U,3)
 I $D(^RMPR(660,RMPRIEN,1)),$P(^RMPR(660,RMPRIEN,1),U,3),'$D(^PRCP(445,"AD",DUZ,+$P(^RMPR(660,RMPRIEN,1),U,3))) D
 .W $C(7),!!,"The item you have selected was issued from inventory.  You are not an",!,"inventory user and cannot add this item back into the same inventory.."
QUE S %=1 W !,"Would you like to add this item back into inventory" D YN^DICN G:%<0 EXIT G:%=2 POS
 I %=0 W !!,"Enter `YES` to add item back into inventory, `NO` to not.",! H 2 G QUE
 S (PRCPPRIV,OK)=1,DIC="^PRCP(445,",DIC(0)="AEQM",DIC("A")="Select INVENTORY POINT: ",DIC("S")="I $P(^(0),U,2)=""Y"",$D(^PRCP(445,+Y,4,DUZ,0))" D ^DIC G:Y<0 EXIT S (RMPRINV,PRCP("I"))=+Y
INVITEM K DIC S DIC="^RMPR(661,",DIC(0)="AEQM",DIC("A")="Select ITEM: ",DIC("B")=RMPRITEM D ^DIC G:+Y<0 EXIT I '$D(^PRCP(445,PRCP("I"),1,$P(Y,U,2),0)) W $C(7),!,"The Item you selected is not in this Inventory Point." G INVITEM
 S PRCP("ITEM")=$P(Y,U,2),RMPRITM=+Y
 G POS
EXIT N RMPR,RMPRSITE D KILL^XUSCLEAN Q
