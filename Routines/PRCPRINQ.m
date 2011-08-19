PRCPRINQ ;WISC/RFJ-inquire to inventory files                       ;10 Feb 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,COSTDA,DA,DATETIME,DIC,DIR,DR,GROUPDA,ITEMDA,ORDERDA,PRCPFILE,PRCPFLAG,PRCPPRIV,STOREDA,TRANDA,X,Y
 S DIR(0)="SO^"
 F %=2:1 S X=$P($T(FILES+%),";",3,4) Q:X=""  I $P(X,";",2)[PRCP("DPTYPE") S DIR(0)=DIR(0)_$P(X,";")_";"
 S DIR("A")="Select FILE for inquiry"
 W ! D ^DIR I Y'>444 Q
 S PRCPFILE=+Y,PRCPPRIV=1
 ;  file 445
 I PRCPFILE=445 D  Q:$G(PRCPFLAG)
 .   S XP="Do you want to see the inventory point parameters",XH="Enter YES to see the inventory point data, NO to just see item data, ^ to exit."
 .   W ! S %=$$YN^PRCPUYN(2) I %'=1 S:%=0 PRCPFLAG=1 Q
 .   W !?10,PRCP("RV1"),"*** I N V E N T O R Y   D A T A ***",PRCP("RV0")
 .   N DA,DIC,DR
 .   S DIC="^PRCP(445,",DA=PRCP("I"),DR="0;2;3;4;DEV"
 .   D EN^DIQ
 ;  file 445 and 445.1
 I PRCPFILE=445!(PRCPFILE=445.1) D  Q
 .   F  W ! S ITEMDA=$$ITEM^PRCPUITM(PRCP("I"),0,"","") Q:'ITEMDA  D
 .   .   W !?10,PRCP("RV1"),"*** I N V E N T O R Y   P O I N T   I T E M   D A T A ***",PRCP("RV0")
 .   .   N DA,DIC,DR
 .   .   S DIC="^PRCP("_PRCPFILE_","_PRCP("I")_",1,",DA=ITEMDA
 .   .   D EN^DIQ
 ;  file 445.2
 I PRCPFILE=445.2 D  Q
 .   F  W ! S TRANDA=$$SELECT^PRCPUTRS(PRCP("I")) Q:'TRANDA  D
 .   .   W !?10,PRCP("RV1"),"*** T R A N S A C T I O N   R E G I S T E R   D A T A ***",PRCP("RV0")
 .   .   N DA,DIC,DR
 .   .   S DIC="^PRCP(445.2,",DA=TRANDA
 .   .   D EN^DIQ
 ;  file 445.3
 I PRCPFILE=445.3 D  Q
 .   F  W ! S ORDERDA=$$ORDERSEL^PRCPOPUS(PRCP("I"),0,"*",0) Q:'ORDERDA  D
 .   .   W !?10,PRCP("RV1"),"*** D I S T R I B U T I O N   O R D E R   D A T A ***",PRCP("RV0")
 .   .   N DA,DIC,DR
 .   .   S DIC="^PRCP(445.3,",DA=ORDERDA
 .   .   D EN^DIQ
 ;  file 445.4
 I PRCPFILE=445.4 D  Q
 .   F  W ! S STOREDA=$$STORE^PRCPESTO(PRCP("I")) Q:'STOREDA  D
 .   .   W !?10,PRCP("RV1"),"*** S T O R A G E   L O C A T I O N   D A T A ***",PRCP("RV0")
 .   .   N DA,DIC,DR
 .   .   S DIC="^PRCP(445.4,",DA=STOREDA
 .   .   D EN^DIQ
 ;  file 445.6
 I PRCPFILE=445.6 D  Q
 .   F  W ! S GROUPDA=$$GROUP^PRCPEGRP(PRCP("I"),"") Q:'GROUPDA  D
 .   .   W !?10,PRCP("RV1"),"*** G R O U P   C A T E G O R Y   D A T A ***",PRCP("RV0")
 .   .   N DA,DIC,DR
 .   .   S DIC="^PRCP(445.6,",DA=GROUPDA
 .   .   D EN^DIQ
 ;  file 445.7
 I PRCPFILE=445.7 D  Q
 .   F  W ! S ITEMDA=$$SELECT^PRCPCED0("C",0,PRCP("I")) Q:'ITEMDA  D
 .   .   W !?10,PRCP("RV1"),"*** C A S E   C A R T   I T E M   D A T A ***",PRCP("RV0")
 .   .   N DA,DIC,DR
 .   .   S DIC="^PRCP(445.7,",DA=ITEMDA
 .   .   D EN^DIQ
 ;  file 445.8
 I PRCPFILE=445.8 D  Q
 .   F  W ! S ITEMDA=$$SELECT^PRCPCED0("K",0,PRCP("I")) Q:'ITEMDA  D
 .   .   W !?10,PRCP("RV1"),"*** I N S T R U M E N T   K I T   I T E M   D A T A ***",PRCP("RV0")
 .   .   N DA,DIC,DR
 .   .   S DIC="^PRCP(445.8,",DA=ITEMDA
 .   .   D EN^DIQ
 ;  file 446
 I PRCPFILE=446 D  Q
 .   F  W ! S COSTDA=$$SELCOSTS^PRCPUCC(PRCP("I")) Q:'COSTDA  D
 .   .   W !?10,PRCP("RV1"),"*** D I S T R I B U T I O N   C O S T   D A T A ***",PRCP("RV0")
 .   .   N DA,DIC,DR
 .   .   S DIC="^PRCP(446,",DA=COSTDA
 .   .   D EN^DIQ
 ;  file 446.1
 I PRCPFILE=446.1 D  Q
 .   F  W ! S DATETIME=$$SELECT^PRCPUPAT Q:'DATETIME  D
 .   .   W !?10,PRCP("RV1"),"*** P A T I E N T   D I S T R I B U T E D   S U P P L I E S ***",PRCP("RV0")
 .   .   N DA,DIC,DR
 .   .   S DIC="^PRCP(446.1,",DA=DATETIME
 .   .   D EN^DIQ
 Q
 ;
 ;
FILES ;  list of files to select from
 ;  filenumber:filename;inventory point type allowed
 ;;445:GENERIC INVENTORY;WPS
 ;;445.1:INVENTORY BALANCES;WPS
 ;;445.2:INVENTORY TRANSACTION;WPS
 ;;445.3:INTERNAL DISTRIBUTION ORDER;P
 ;;445.4:STORAGE LOCATION;WPS
 ;;445.6:GROUP CATEGORY;WPS
 ;;445.7:CASE CARTS;PS
 ;;445.8:INSTRUMENT KITS;PS
 ;;446:DISTRIBUTION/USAGE HISTORY;WP
 ;;446.1:INVENTORY DISTRIBUTED PATIENT SUPPLIES;PS
