PRCPXTRA ;WISC/RFJ-purge transaction register                       ;10 Feb 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,%H,%I,DATE,NOWDT,STOPDATE,X,Y
 D NOW^%DTC S NOWDT=$E(X,1,5)_"01",X1=$E(X,1,5)_"15",X2=-395 D C^%DTC S (Y,STOPDATE)=$E(X,1,5)_"01" D DD^%DT S DATE=Y
 W ! F %=1:1 S X=$P($T(OPTION+%),";",3,99) Q:X=""  S:X["DATE" X=$P(X,"DATE")_DATE_$P(X,"DATE",2) W !,X
 W ! S XP="ARE YOU SURE",XH="ENTER 'YES' TO START THE PURGE, 'NO' OR '^' TO EXIT."
 I $$YN^PRCPUYN(2)'=1 Q
 W !!,"<*> please wait <*>"
DQ ;  automatic purge starts here
 N D,DA,DIC,DIK,ITEMDA,TRANDA
 S TRANDA=0 F  S TRANDA=$O(^PRCP(445.2,"B",PRCP("I"),TRANDA)) Q:'TRANDA  S D=$P($G(^PRCP(445.2,TRANDA,0)),"^",17) I D<STOPDATE D
 .   W "." S DIK="^PRCP(445.2,",DA=TRANDA D ^DIK K DIK,DA
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.2,"ABEG",PRCP("I"),ITEMDA)) Q:'ITEMDA  S D=0 F  S D=$O(^PRCP(445.2,"ABEG",PRCP("I"),ITEMDA,D)) Q:'D  I D<$E(STOPDATE,1,5) K ^PRCP(445.2,"ABEG",PRCP("I"),ITEMDA,D)
 W:'$G(PRCPZTSK) "  Finished!" S $P(^PRCP(445,PRCP("I"),0),"^",18)=NOWDT Q
 ;
OPTION ;;display entry text
 ;;This option will purge the register of all transactions that affect the
 ;;inventory point up to date DATE.
 ;; 
 ;;The transaction register for and after DATE will NOT be purged.
