PRCPXDIS ;WISC/RFJ-purge distribution usage history                 ;12 Feb 92
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
 N D,DA,DIC,DIK,DISTDA
 S DISTDA=0 F  S DISTDA=$O(^PRCP(446,"AD",PRCP("I"),DISTDA)) Q:'DISTDA  S D=$P($G(^PRCP(446,DISTDA,0)),"^",2) I $E(D,1,5)<$E(STOPDATE,1,5) D
 .   W "." S DIK="^PRCP(446,",DA=DISTDA D ^DIK K DIK,DA
 W:'$G(PRCPZTSK) "  Finished!" S $P(^PRCP(445,PRCP("I"),0),"^",19)=NOWDT Q
 ;
OPTION ;;display entry text
 ;;This option will purge the distribution history for the inventory point
 ;;up to date DATE.
 ;; 
 ;;The distribution history for and after DATE will NOT be purged.
