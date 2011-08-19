PRCPOPD ;WISC/RFJ/DWA-delete distribution order ;27 Sep 93
V ;;5.1;IFCAP;**24,52**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ORDRDELM ;  delete distribution order (ask first)
 ;  called from protocol
 S VALMBCK="R"
 S XP="Do you want to DELETE the distribution order"
 S XH="Enter 'YES' to delete the order, 'NO' or '^' to retain the order on file."
 W ! I $$YN^PRCPUYN(1)'=1 Q
 ;
 D VARIABLE^PRCPOPU
 N ITEMDA,PRCPSTOP,QTY
 S PRCPSTOP=0
 ;
 ;  if order is released or backordered, cancel dueins and dueouts
 I $P(PRCPORD(0),"^",6)'="" D  I PRCPSTOP QUIT
 .   W !
 . I $P(^PRCP(445.3,+ORDERDA,0),"^",10)]"",$$REFILL(+ORDERDA) D  I PRCPSTOP QUIT
 . . N DA,DIR,DR
 . . S DIR(0)="Y"
 . . S DIR("A",1)="The supply station received items on this order."
 . . S DIR("A",2)="WARNING: IF YOU DELETE THE ORDER, GIP WILL NOT BE UPDATED."
 . . S DIR("A",3)=" "
 . . S DIR("A")="Are you sure you want to delete the order"
 . . S DIR("?")="Enter 'Y' or 'YES' to delete the current order."
 . . S DIR("?",1)="Enter 'N' or 'NO' to retain the order and exit deletion."
 . . D ^DIR
 . . I $D(DUOUT)!$D(DTOUT) S PRCPSTOP=1 Q
 . . I Y=0 S PRCPSTOP=1 Q
 . I $P(PRCPORD(0),"^",2)'="" W !,"<*> Cancelling DUE-OUTS in ",$P(PRCPORD(0),"^",2)
 . I $P(PRCPORD(0),"^",3)'="" W !,"<*> Cancelling DUE-INS  in ",$P(PRCPORD(0),"^",3)
 . S ITEMDA=0
 . F  S ITEMDA=$O(^PRCP(445.3,ORDERDA,1,ITEMDA)) Q:'ITEMDA  D
 . . S QTY=$P(^PRCP(445.3,ORDERDA,1,ITEMDA,0),"^",2)
 . . I QTY D DUEOUTIN^PRCPOPU(PRCPPRIM,PRCPSECO,ITEMDA,-QTY,0)
 ;
 D DELORDER(ORDERDA)
 ;  pause so user can see msg
 D R^PRCPUREP
 ;  kill valmbck to exit LM
 K VALMBCK
 Q
 ;
 ;
DELORDER(ORDERDA)         ;  delete distribution order from file 445.3
 ;  cancel due-ins and due-outs first
 I '$D(^PRCP(445.3,+ORDERDA,0)) Q
 I $P(^PRCP(445.3,+ORDERDA,0),"^",10)]"",$P(^PRCP(445.3,+ORDERDA,0),"^",6)="R" D MESSAGE(+ORDERDA,1)
 N %,DA,DIC,DIK,X,Y
 W !!,"DELETING distribution order..."
 S DA=+ORDERDA,DIK="^PRCP(445.3," D ^DIK
 Q
 ;
 ;
ITEMDELM ;  delete an item from a distribution order
 D FULL^VALM1
 S VALMBCK="R"
 ;
 D VARIABLE^PRCPOPU
 N %,ITEMDA,QTY
 ;
 F  S ITEMDA=+$$ITEMSEL^PRCPOPUS(ORDERDA,PRCPPRIM,0) Q:'ITEMDA  D
 .   S XP="Do you want to DELETE the item from the distribution order",XH="Enter 'YES' to delete the item, 'NO' or '^' to retain the item on the order."
 .   I $$YN^PRCPUYN(1)'=1 Q
 .   ;
 .   S QTY=$P($G(^PRCP(445.3,ORDERDA,1,ITEMDA,0)),"^",2)
 .   I 'QTY D DELITEM(ORDERDA,ITEMDA) W !?5,"* * * ITEM DELETED * * *" Q
 .   ;
 .   I $P(PRCPORD(0),"^",6)'="" D DUEOUTIN^PRCPOPU(PRCPPRIM,PRCPSECO,ITEMDA,-QTY,1)
 .   D DELITEM(ORDERDA,ITEMDA)
 .   W !?5,"* * * ITEM DELETED * * *"
 D INIT^PRCPOPL
 Q
 ;
MESSAGE(ORDER,ACTIVITY) ; tell user of items filled by supply station
 ; 
 ; ORDER - ien of file 445.3 
 ; ACTIVITY:  1- ORDER DELETED, 2 - SUPPLY STATION FLAG REMOVED
 ;
 N ITEM,LN,ORDERNO,PRCPSEC,PRCPXMY,REFILL,XMB,XMDUZ,XMTEXT,XMY
 S ITEM=$G(^PRCP(445.3,ORDER,0)) I ITEM']"" QUIT
 S ORDERNO=$P(ITEM,"^",1)
 S PRCPSEC=$P(ITEM,"^",3)
 I '$$REFILL(ORDER) QUIT
 D GETUSER^PRCPXTRM(PRCPSEC) Q:'$O(PRCPXMY(""))  ; quit if no users in inv point
 S ITEM=0
 ; restrict message to managers
 F  S ITEM=$O(PRCPXMY(ITEM)) Q:ITEM'>0  I PRCPXMY(ITEM)=1 S XMY(ITEM)=""
 K ^TMP($J,"PRCPSSORDER")
 S XMTEXT="^TMP($J,""PRCPSSORDER"",1,"
 S XMB="PRCP_ORDER_PARTIALLY_LOST"
 S XMB(1)=ORDERNO
 S XMB(2)=$$INVNAME^PRCPUX1(PRCPSEC)
 I ACTIVITY=1 D
 . S XMB(3)="deleted"
 . S XMB(4)="If refilled, enter an emergency or call-in order to update GIP."
 I ACTIVITY=2 D
 . S XMB(3)="flagged for completion on GIP"
 . S XMB(4)="If refilled, adjust the quantity ordered to the refill amount."
 S XMB(5)="If not refilled, adjust the supply station down and the secondary up"
 S XMB(6)="                 by the same value for each affected item"
 S XMDUZ="SUPPLY STATION INTERFACE"
 S ITEM=0,LN=0
 F  S ITEM=$O(^PRCP(445.3,ORDER,1,ITEM)) Q:'+ITEM  D
 . I $P($G(^PRCP(445.3,ORDER,1,ITEM,0)),"^",7)>0 D
 . . N QTY,NAME,PRIMVN
 . . S LN=LN+1
 . . S QTY=$P(^PRCP(445.3,ORDER,1,ITEM,0),"^",7)
 . . S PRIMVN=$P(^PRCP(445.3,ORDER,0),"^",2)_";PRCP(445,"
 . . S X=$$GETVEN^PRCPUVEN(PRCPSEC,ITEM,PRIMVN,1)
 . . S X=$P(X,"^",4) ; pkg multiple (conversion factor)
 . . I 'X S X=1
 . . S QTY=QTY*X
 . . S NAME=$P(^PRC(441,ITEM,0),"^",2)
 . . S ^TMP($J,"PRCPSSORDER",1,LN,0)=$E("        ",$L(QTY)+1,8)_QTY_"  "_"("_ITEM_") "_NAME
 S ^TMP($J,"PRCPSSORDER",1)=LN
 D EN^XMB
 K ^TMP($J,"PRCPSSORDER")
 Q
 ;
REFILL(ORDER) ;
 ;
 ; This subroutine will return 1 if the order has any refill activity
 ; and 0 if there is none
 ;
 ; ORDER  ien of file 445.3
 ;
 N REFILL
 S ITEM=0,REFILL=0
 F  S ITEM=$O(^PRCP(445.3,ORDER,1,ITEM)) Q:'+ITEM!REFILL  D
 . I $P($G(^PRCP(445.3,ORDER,1,ITEM,0)),"^",7)>0 S REFILL=1
 QUIT REFILL
 ;
 ;
DELITEM(ORDERDA,ITEMDA)     ;  delete item from distribution order
 I '$D(^PRCP(445.3,+ORDERDA,1,+ITEMDA,0)) Q
 N %,DA,DIC,DIK,X,Y
 S DA(1)=+ORDERDA,DA=+ITEMDA,DIK="^PRCP(445.3,"_ORDERDA_",1," D ^DIK Q
