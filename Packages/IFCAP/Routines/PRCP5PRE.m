PRCP5PRE ;WISC/RFJ-pre init for inventory version 5                 ;29 Jun 94
 ;;5.0;IFCAP;;4/21/95
 ;
 ;
START ;  start pre init to delete all PRCP options (except PRCPZ)
 N %,DA,DIK,DIU,MENUDA,MENUDA1,PRCPDA,PRCPOPT,X
 K X S X(1)="This pre-init to the Generic Inventory Package will delete all PRCP options (except PRCPZ) from the OPTION file.  It will also clean up all menu pointers which reference the deleted PRCP options."
 S X(2)="The pre-init to the Generic Inventory Package will also delete all PRCP input templates, sort templates, and print templates except the PRCPZ namespaced entries." D DISPLAY^PRCPUX2(1,78,.X)
 ;
 W ! S PRCPOPT="PRCP" F  S PRCPOPT=$O(^DIC(19,"B",PRCPOPT)) Q:$E(PRCPOPT,1,4)'="PRCP"!($E(PRCPOPT,1,5)="PRCPZ")  S PRCPDA=0 F  S PRCPDA=$O(^DIC(19,"B",PRCPOPT,PRCPDA)) Q:'PRCPDA  D
 .   I PRCPOPT="PRCP MAIN MENU"!(PRCPOPT="PRCP2 MAIN MENU")!(PRCPOPT="PRCPW MAIN MENU")!(PRCPOPT="PRCP ALL") Q
 .   ;  do not delete queued taskman options
 .  I PRCPOPT="PRCP OPEN BALANCES TASKMAN SET"!(PRCPOPT="PRCP PURGE AUTOMATIC RUN") Q
 .   W !,"  deleting option: ",PRCPOPT
 .   ;  clean up menus first
 .   S MENUDA=0 F  S MENUDA=$O(^DIC(19,"AD",PRCPDA,MENUDA)) Q:'MENUDA  S MENUDA1=0 F  S MENUDA1=$O(^DIC(19,"AD",PRCPDA,MENUDA,MENUDA1)) Q:'MENUDA1  D
 .   .   N DA,DIK S DIK="^DIC(19,"_MENUDA_",10,",DA(1)=MENUDA,DA=MENUDA1 D ^DIK Q
 .   ;  remove option
 .   S DIK="^DIC(19,",DA=PRCPDA D ^DIK W "  deleted!"
 ;
 ;  delete input, sort, and print templates
 W !!,"deleting INPUT TEMPLATES:" S PRCPOPT="PRCP" F  S PRCPOPT=$O(^DIE("B",PRCPOPT)) Q:$E(PRCPOPT,1,4)'="PRCP"!($E(PRCPOPT,1,5)="PRCPZ")  S PRCPDA=0 F  S PRCPDA=$O(^DIE("B",PRCPOPT,PRCPDA)) Q:'PRCPDA  D
 .   W !?9,PRCPOPT S DIK="^DIE(",DA=PRCPDA D ^DIK W "  deleted!"
 W !!,"deleting SORT TEMPLATES:" S PRCPOPT="PRCP" F  S PRCPOPT=$O(^DIBT("B",PRCPOPT)) Q:$E(PRCPOPT,1,4)'="PRCP"!($E(PRCPOPT,1,5)="PRCPZ")  S PRCPDA=0 F  S PRCPDA=$O(^DIBT("B",PRCPOPT,PRCPDA)) Q:'PRCPDA  D
 .   W !?9,PRCPOPT S DIK="^DIBT(",DA=PRCPDA D ^DIK W "  deleted!"
 W !!,"deleting PRINT TEMPLATES:" S PRCPOPT="PRCP" F  S PRCPOPT=$O(^DIPT("B",PRCPOPT)) Q:$E(PRCPOPT,1,4)'="PRCP"!($E(PRCPOPT,1,5)="PRCPZ")  S PRCPDA=0 F  S PRCPDA=$O(^DIPT("B",PRCPOPT,PRCPDA)) Q:'PRCPDA  D
 .   W !?9,PRCPOPT S DIK="^DIPT(",DA=PRCPDA D ^DIK W "  deleted!"
 ;
 ;  clean inventory dd field descriptions
 D DESCRIP^PRC5INS1(445,447)
 W !!
 Q
