PSGWAOUI ;BHAM ISC/CML-Enter/Edit AOU Inactivation Dates ; 21 Aug 96 / 2:37 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;**7,8**;4 JAN 94
 W !!,"Enter AOU Inactivation Dates" S QFLG=0
 K DIC F Q=0:0 S DIC="^PSI(58.1,",DIC(0)="QEAM" W ! D ^DIC K DIC Q:Y'>0  S (DA,AOU)=+Y,PRE="" S:$D(^PSI(58.1,DA,"I")) PRE=^("I") S DIE="^PSI(58.1,",DR="3" W ! D ^DIE Q:$D(Y)  D CHK Q:QFLG
QUIT K %,%DT,%Y,AOU,ASKFLG,C,D0,DA,DI,DIE,DIC,DIYS,DQ,DR,FOUND,INDT,ITM,JJ,POST,PRE,PRTDT,Q,QFLG,X,Y Q
CHK ; Do checks on AOU inactivation date
 S POST="" I $D(^PSI(58.1,AOU,"I")) S POST=^("I") Q:PRE=""&(POST="")
 I PRE=POST!(PRE=""&(POST]"")) W !,"...One moment, please..." D ITMCHK D:ASKFLG ASK Q
 I PRE]""&(POST="") D REACT Q
 I PRE'=POST W !,"...Hmm, one moment..." D ITMCHK D:ASKFLG ASK
 Q
ITMCHK ; Look for any currently active items or items with an inactive date AFTER TODAY
 S ASKFLG=0 F ITM=0:0 S ITM=$O(^PSI(58.1,AOU,1,ITM)) Q:'ITM  I $P(^PSI(58.1,AOU,1,ITM,0),"^",3)=""!($P(^(0),"^",3)>DT) S ASKFLG=1 Q
 Q
ASK ; Ask if currently active items are to be inactivated
 S INDT=POST S Y=INDT X ^DD("DD") S PRTDT=Y W !!,"There are items in this AOU that are currently active.",!,"You may, at this time, inactivate all of them as of ",Y,"."
 F JJ=0:0 W !!,"Do you want to do this" S %=1 D YN^DICN Q:%  D HELP
 D:%=1 INACT S:%<0 QFLG=1 Q
INACT ; Inactivate items
 S DA(1)=AOU,DIE="^PSI(58.1,"_DA(1)_",1,",DR="30///"_$P(PRTDT,"@")_";31///O;33///AOU INACTIVATED" W !!,"Now inactivating all currently active items as of ",PRTDT
 F ITM=0:0 S ITM=$O(^PSI(58.1,AOU,1,ITM)) Q:'ITM  I $D(^PSI(58.1,AOU,1,ITM,0)) I $P(^(0),"^",3)=""!($P(^(0),"^",3)>DT) S DA=ITM D ^DIE W "."
 Q
REACT ; Reactivate items
 S DA(1)=AOU,DIE="^PSI(58.1,"_DA(1)_",1,",DR="30///@" W !!,"Now deleting the inactivation dates for any items that were inactivated when",!,"this AOU was inactivated" S FOUND=0
 F ITM=0:0 S ITM=$O(^PSI(58.1,AOU,1,ITM)) Q:'ITM  I $D(^PSI(58.1,AOU,1,ITM,0)),$P(^(0),"^",9)="AOU INACTIVATED" S DA=ITM D ^DIE W "." S FOUND=1
 I 'FOUND W *7,"   ...None found!"
 Q
HELP ;
 W !!?5,"Enter 'Y' if you want to inactivate all currently active items.",!?5,"Enter 'N' if you do not wish to inactivate all currently active items.",!?5,"Enter ""^"" to Exit." Q
