PRCPHL70 ;WISC/CC-PROCESS QUEUED INCOMING ORDERS ;4/00
V ;;5.1;IFCAP;**1,24**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
 ; background job to process 447.1 entries sequentially by IP
 ; kicked off by TASKMAN option PRCP2 SUPPLY STATION TXN RUN
 ;
NEWMSG L +^PRCP(447.1,"PROCESS QUEUE"):3 I $T=0 Q
 N DA,DIC,DIE,DIK,DR,PRCPDA,PRCPDONE,PRCPMGTP,PRCPSEC,PRCPSIT,X
 ;
START S PRCPSIT=0
 ;
 ; for each site/station
 F  S PRCPSIT=$O(^PRCP(447.1,"C",PRCPSIT)) Q:'+PRCPSIT  D
 . S PRCPSEC=0
 . ;
 . ; for each inventory point at that site/station
 . F  S PRCPSEC=$O(^PRCP(447.1,"C",PRCPSIT,PRCPSEC)) Q:'+PRCPSEC  D
 . . S PRCPDA=0,PRCPDONE=0
 . . L +^PRCP(445,PRCPSEC,1):3 I $T=0 Q  ; lock inventory point items
 . . D ADD^PRCPULOC(445,PRCPSEC_"-1",0,"HL7 Transaction Processing")
 . . ;
 . . ; process each supply station transaction sequentially
 . . F  S PRCPDA=$O(^PRCP(447.1,"C",PRCPSIT,PRCPSEC,PRCPDA)) Q:'+PRCPDA  D  I 'PRCPDONE Q  ; If not processed sucessfully, don't get next txn
 . . . S PRCPMGTP=$P(^PRCP(447.1,PRCPDA,0),"^",5)
 . . . L +^PRCP(447.1,PRCPDA):3 I $T=0 Q  ; lock file 447.1 entry
 . . . ;
 . . . ; Quantity on hand queries (OSR^Q06 messages)
 . . . I $E(PRCPMGTP,1,3)="OSR" D
 . . . . L +^PRCP(445,PRCPSEC,6):1 I $T=0 Q
 . . . . D ADD^PRCPULOC(445,PRCPSEC_"-6",0,"HL7 Transaction Processing")
 . . . . D GETMSG^PRCPHLQU(PRCPDA,.PRCPDONE)
 . . . . L -^PRCP(445,PRCPSEC,6)
 . . . . D CLEAR^PRCPULOC(445,PRCPSEC_"-6",0)
 . . . . Q
 . . . ;
 . . . ; Order refill/complete (ORM^O01 messages)
 . . . I $E(PRCPMGTP,1,3)="ORM" D PROCESS^PRCPHLPO(PRCPDA,.PRCPDONE)
 . . . ;
 . . . ; Item Utilization/Adjustments (RAS^O01 messages)
 . . . I $E(PRCPMGTP,1,3)="RAS" D PROCESS^PRCPHLUT(PRCPDA,.PRCPDONE)
 . . . ;
 . . . ; maintain 447.1
 . . . I PRCPDONE D  ; processed successfully, kill entry
 . . . . S DA=PRCPDA,DIK="^PRCP(447.1," D ^DIK
 . . . ;
 . . . L -^PRCP(447.1,PRCPDA)
 . . ;
 . . L -^PRCP(445,PRCPSEC,1)
 . . D CLEAR^PRCPULOC(445,PRCPSEC_"-1",0)
 ;
Q I $O(^PRCP(447.1,0))]"" G START ; loop until queue is empty
 L -^PRCP(447.1,"PROCESS QUEUE")
 Q
 ;
 ;
NAME(PRCPSEC,ITEM,NAME,TYPE,PRCPHL7)    ; notify users of name mismatches
 ;
 ; PRCPSEC  secondary inventory point ien
 ; ITEM     item's ien
 ; NAME     item name as it appears on the supply station
 ; TYPE     supply station approach to item names
 ;          O = only 1 name per item per system
 ;          S = each station may have different name for same item
 ; PRCPHL7  (file 773 IEN).(file 772 IEN).447.1 for the HL7 transaction
 ;
 N PRCPXMY,USER,XMB,XMDUZ,XMTEXT
 S ^TMP($J,"PRCPHL7",1,1,0)=" " ; blank line
 I TYPE="S" S ^TMP($J,"PRCPHL7",1,2,0)="ON GIP: "_$P($G(^PRCP(445,PRCPSEC,1,ITEM,6)),"^",1)
 I TYPE="O" S ^TMP($J,"PRCPHL7",1,2,0)="ON GIP: "_$P($G(^PRC(441,ITEM,0)),"^",2)
 S ^TMP($J,"PRCPHL7",1,3,0)="STATION: "_NAME
 S ^TMP($J,"PRCPHL7",1,4,0)=""
 S ^TMP($J,"PRCPHL7",1,5,0)=""
 I PRCPHL7 S ^TMP($J,"PRCPHL7",1,5,0)="(Information acquired from HL7 txn# "_PRCPHL7_")"
 S ^TMP($J,"PRCPHL7",1)=5
 D GETUSER^PRCPXTRM(PRCPSEC) Q:'$O(PRCPXMY(""))  ; send message to primary inventory point users
 S USER=0
 ; restrict message to managers
 F  S USER=$O(PRCPXMY(USER)) Q:USER'>0  I PRCPXMY(USER)=1 S XMY(USER)=""
 S XMTEXT="^TMP($J,""PRCPHL7"",1,"
 S XMB(1)=$$INVNAME^PRCPUX1(PRCPSEC)
 S XMB(2)=ITEM
 S XMB="PRCP_ITEM_NAME"
 S XMDUZ="SUPPLY STATION INTERFACE"
 D EN^XMB
 K ^TMP($J,"PRCPHL7")
 Q
 ;
 ;
QTYDISC(PRCPSEC,PRCPITEM,PRCPITNM,QTY,PRCPLEFT,PRCPHL7) ; tell user qty left is wrong
 ; 
 ; PRCPSEC = the secondary IP ien
 ; PRCPITEM = the item ien
 ; PRCPITNM = the item name from the transaction
 ; QTY = the actual quantity in GIP after this transaction
 ; PRCPLEFT = the quantity on the supply station after this transaction
 ; PRCPHL7 = (file 773 IEN).(file 772 IEN).447.1 for the HL7 transaction
 ;
 N ITEM,PRCPXMY,REFILL,XMB,XMDUZ,XMTEXT,XMY
 D GETUSER^PRCPXTRM(PRCPSEC) Q:'$O(PRCPXMY(""))  ; quit if no users in inv point
 S ITEM=0
 ; restrict message to managers
 F  S ITEM=$O(PRCPXMY(ITEM)) Q:ITEM'>0  I PRCPXMY(ITEM)=1 S XMY(ITEM)=""
 K ^TMP($J,"PRCPHL7")
 S XMTEXT="^TMP($J,""PRCPHL7"",1,"
 S REFILL=$$REFILLS^PRCPRDIS(PRCPITEM,PRCPSEC) I REFILL]"" D
 . S ^TMP($J,"PRCPHL7",1,1,0)=" "
 . S ^TMP($J,"PRCPHL7",1,2,0)=" "
 . S ^TMP($J,"PRCPHL7",1,3,0)="NOTE: This item has "_$P(REFILL,":",1)_" on:"
 . S ^TMP($J,"PRCPHL7",1,4,0)=$P(REFILL,":",2)
 . S ^TMP($J,"PRCPHL7",1)=4
 S XMB="PRCP_QTY_MISMATCH"
 S XMB(1)=$$INVNAME^PRCPUX1(PRCPSEC)
 S XMB(2)=PRCPITNM_" ("_PRCPITEM_")"
 S XMB(3)=QTY
 S XMB(4)=PRCPLEFT
 S XMB(5)=PRCPHL7
 S XMDUZ="SUPPLY STATION INTERFACE"
 D EN^XMB
 K ^TMP($J,"PRCPHL7")
 Q
 ;
 ;
 ; cleans out file 447.1 - not invoked by any routine or option
CLEAN N A,DA,DIK
 S A=0
 S DIK="^PRCP(447.1,"
 F  S A=$O(^PRCP(447.1,A)) Q:'+A  S DA=A D ^DIK
 Q
