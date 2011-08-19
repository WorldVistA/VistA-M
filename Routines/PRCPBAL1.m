PRCPBAL1 ;WISC/RFJ-process barcode data                             ;04 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EEITEMS ;  called from protocol file to enter/edit invpt items
 D FULL^VALM1
 N PRC,PRCP
 D ^PRCPEILM
 D BUILD^PRCPBALB
 S VALMBCK="R"
 Q
 ;
 ;
EDITQTY ;  called from protocol file to edit quantities
 D FULL^VALM1
 N %,D0,DA,DI,DIC,DIE,DQ,DR,I,J,X,Y
 S (DIC,DIE)="^PRCT(446.4,"_PRCTDA_",2,",DA(1)=PRCTDA,DA=PRCTDA1,DR=1
 D ^DIE
 D BUILD^PRCPBALB
 S VALMBCK="R"
 Q
 ;
 ;
POST ;  called from protocol file to post quantities
 D FULL^VALM1
 S VALMBCK="R"
 N %,%H,%I,DA,DIC,DIK,INVPT,ITEMDA,QTY,RECORD,PRCPBALM
 S XP="*** ARE YOU SURE ***",XP(1)="YOU WANT TO UPDATE ON HAND BALANCES IN BARCODED INVENTORY POINTS",XH="ENTER 'YES' TO UPDATE THE QUANTITIES IN THE INVENTORY POINTS."
 W ! I $$YN^PRCPUYN(2)'=1 Q
 ;
 I $G(PRCPFSCA) D  Q:%<1
 .   K X S X(1)="Some of the items to upload have been scanned more than once.  You have the option to: 1) Upload the LAST SCAN of the item only;  or   2) ADD THE QUANTITIES together for all scans of the item." D DISPLAY^PRCPUX2(5,75,.X)
 .   S XP="Do you want to ADD THE QUANTITIES TOGETHER",XH="Enter YES to add the quantities together,",XH(1)="       NO to only upload the last scan of the item, or ^ to exit."
 .   S %=$$YN^PRCPUYN(2) S PRCPFSCA=$S(%=1:1,1:0)
 ;
 S INVPT=0 F  S INVPT=$O(^TMP($J,"PRCPBALMU",INVPT)) Q:'INVPT  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPBALMU",INVPT,ITEMDA)) Q:'ITEMDA  D
 .   S RECORD=0,QTY=0 F  S RECORD=$O(^TMP($J,"PRCPBALMU",INVPT,ITEMDA,RECORD)) Q:'RECORD  S QTY=$S('$G(PRCPFSCA):^(RECORD),1:QTY+^(RECORD))
 .   K PRCPBALM
 .   S PRCPBALM("I")=INVPT,PRCPBALM("ITEM")=ITEMDA
 .   I PRCPTYPE="U" S PRCPBALM("QTY")=-QTY,PRCPBALM("COM")="Barcode Usage",PRCPBALM("TYP")="U"
 .   I PRCPTYPE="P" S PRCPBALM("QTY")=QTY-$P($G(^PRCP(445,INVPT,1,ITEMDA,0)),"^",7),PRCPBALM("COM")="Barcode Physical Count",PRCPBALM("TYP")="P"
 .   L +^PRCP(445,INVPT,1,ITEMDA,0)
 .   S %=$$UPDATE^PRCPUSA(.PRCPBALM)
 .   L -^PRCP(445,INVPT,1,ITEMDA,0)
 .   I %="" S RECORD=0 F  S RECORD=$O(^TMP($J,"PRCPBALMU",INVPT,ITEMDA,RECORD)) Q:'RECORD  S %=$G(^PRCT(446.4,PRCTDA,2,PRCTDA1,1,RECORD,0)) I %'="" S ^(0)="*"_%
 ;
 D NOW^%DTC S Y=% D DD^%DT S $P(^PRCT(446.4,PRCTID,2,PRCTTI,0),"^",3)="FINISHED ON "_Y
 K VALMBCK
 ;  ask to purge
 K X S X(1)="NOTE:  You should PURGE all barcode uploads that have been loaded.  This will keep the database clean and prevent the barcode upload from being posted to the inventory points more than once."
 D DISPLAY^PRCPUX2(5,75,.X)
 S XP="Do you want to PURGE this upload entry",XH="Enter 'YES' to purge the entry, 'NO' or '^' to exit."
 W ! S %=$$YN^PRCPUYN(1) I '% Q
 I %=1 S DA(1)=PRCTDA,DA=PRCTDA1,DIK="^PRCT(446.4,"_PRCTDA_",2," D ^DIK
 D AUTOGEN^PRCPBAL2
 Q
