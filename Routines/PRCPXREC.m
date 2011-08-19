PRCPXREC ;WISC/RFJ-purge receipts                                   ;10 Feb 92
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
 N DA,DATE,DIC,DIK,ITEMDA
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  D
 .   S DATE=0 F  S DATE=$O(^PRCP(445,PRCP("I"),1,ITEMDA,3,DATE)) Q:'DATE!(DATE'<STOPDATE)  D
 .   .   W "." S DIK="^PRCP(445,"_PRCP("I")_",1,"_ITEMDA_",3,",DA(1)=ITEMDA,DA(2)=PRCP("I"),DA=DATE D ^DIK K DIK,DA
 W:'$G(PRCPZTSK) "  Finished!" S $P(^PRCP(445,PRCP("I"),0),"^",17)=NOWDT Q
 ;
OPTION ;;display entry text
 ;;This option will purge the receipts history for all the items in the
 ;;inventory point up to the date DATE.
 ;; 
 ;;The receipts history for and after DATE will NOT be purged.
