PRCPHLPO ;WISC/CC-REFILL AND POST ORDER FROM 447.1 ENTRY ;4/00
V ;;5.1;IFCAP;**1,24**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PROCESS(PRCPDA,PRCPDONE) ;
 N CONV,DIE,DR,ERR,I,ITEM,LOCKORD,LOCKPRIM,ORDERDA,X,PRCPITDA,PRIM
 N PRCPAMT,PRCPDATA,PRCPHL7,PRCPITEM,PRCPITNM,PRCPLEFT,PRCPNOIT
 N PRCPORD,PRCPPOST,PRCPPRIM,PRCPSECO,PRCPSS,PRCPSSFL,PRCPTIME,PRCPUSER
 ;
 S PRCPDONE=0,LOCKORD=0,LOCKPRIM=0,ERR=0
 S PRCPDATA=^PRCP(447.1,PRCPDA,0)
 S PRCPHL7=$P(PRCPDATA,"^",6)_".447.1"
 S ORDERDA=$P(PRCPDATA,"^",7)
 S PRCPSECO=$P(PRCPDATA,"^",3)
 S PRCPTIME=$P(PRCPDATA,"^",8)
 S PRCPUSER=$P(PRCPDATA,"^",10)
 S PRCPPOST=$P(PRCPDATA,"^",11)
 ;
 L +^PRCP(445.3,ORDERDA):3 I $T=0 S PRCPDONE=0 Q
 D ADD^PRCPULOC(445.3,ORDERDA_"-1",0,"HL7 Distribution Order Processing")
 S LOCKORD=1
 ;
 I PRCPPOST'="FU" D  I $D(ERR),+ERR>0 G ERR
 . S PRCPITDA=0
 . S PRCPITDA=$O(^PRCP(447.1,PRCPDA,1,PRCPITDA))
 . I '+PRCPITDA S ERR="6F" Q  ; no item in transaction
 . S PRCPDATA=^PRCP(447.1,PRCPDA,1,PRCPITDA,0)
 . S PRCPITEM=$P(PRCPDATA,"^",1)
 . S PRCPAMT=$P(PRCPDATA,"^",3) ; REFILL QTY - restock issue units
 . S PRCPLEFT=$P(PRCPDATA,"^",2)
 . S PRCPITNM=$P(PRCPDATA,"^",4)
 ;
 I '$D(^PRCP(445.3,ORDERDA)) S ERR="2A" G ERR ; order not in GIP
 S PRCPPRIM=$P(^PRCP(445.3,ORDERDA,0),"^",2)
 I $P(^PRCP(445.3,ORDERDA,0),"^",6)="P" S ERR="2B" G ERR ; order is posted
 I $P(^PRCP(445.3,ORDERDA,0),"^",10)']"" S ERR="2C" G ERR ; order not to be completed by supply station
 I '$D(^PRCP(445,PRCPSECO)) S ERR="3A" G ERR ; secondary not in GIP
 I $P(^PRCP(445,PRCPSECO,0),"^",3)'="S" S ERR="3B" G ERR ; not a secondary
 I PRCPPOST="FU" D  G:ERR>0 ERR G UPDATE
 . I $P($G(^PRCP(445,PRCPSECO,5)),"^",1)']"" S ERR="3F" ; not a supply station secondary
 ;
 I PRCPITDA']"" S ERR="6F" G ERR ; no item information
 I '$D(^PRCP(445.3,ORDERDA,1,PRCPITEM)) S ERR="6A" G ERR ; not on the GIP order"
 I '$D(^PRCP(445,PRCPSECO,1,PRCPITEM)) S ERR="6C" G ERR ; "Not in this inventory point"
 I $P(^PRCP(445,PRCPSECO,1,PRCPITEM,0),"^",9)'>0 S ERR="6D" G ERR ; not flagged as a supply station item"
 I '$D(^PRCP(445,PRCPPRIM,1,PRCPITEM)) S ERR="6B" G ERR ; not in the primary"
 I $P($G(^PRCP(445,PRCPSECO,5)),"^",1)']"" S ERR="3F" G ERR ; not a supply station secondary
 I $P($G(^PRC(441,PRCPITEM,0)),"^",6)="S" S ERR="6G" G ERR ; case cart/ik
 ; compare name in 445 with name sent, notify user if mismatch, CONTINUE
 S PRCPSSFL=$P(^PRCP(445.5,$P(^PRCP(445,PRCPSECO,5),"^",1),0),"^",2)
 ; if item name on supply station comes from item master
 I PRCPSSFL="O",$P(^PRC(441,PRCPITEM,0),"^",2)'=PRCPITNM D NAME^PRCPHL70(PRCPSECO,PRCPITEM,PRCPITNM,PRCPSSFL,PRCPHL7)
 ; if item name on supply station is from the secondary
 I PRCPSSFL="S",$G(^PRCP(445,PRCPSECO,1,PRCPITEM,6))'=PRCPITNM D NAME^PRCPHL70(PRCPSECO,PRCPITEM,PRCPITNM,PRCPSSFL,PRCPHL7)
 ;
UPDATE I $P(^PRCP(445.3,ORDERDA,0),"^",6)="P" S ERR="2B" G ERR ; order is posted
 I PRCPPOST'="FU",'$D(^PRCP(445.3,ORDERDA,1,PRCPITEM)) S ERR="6D" G ERR ; item not on order
 I PRCPPOST'="FU" D  G Q ; add amount received to order
 . S DIE="^PRCP(445.3,"_ORDERDA_",1,"
 . S DA=PRCPITEM
 . ; the following lines handle the case on an item in multiple bins
 . ; The user receiving an item in multiple bins will generate one
 . ; transaction per bin.
 . S X=$P($G(^PRCP(445.3,ORDERDA,1,DA,0)),"^",7)+0 ; amt refilled so far
 . S PRCPAMT=PRCPAMT+X
 . S DR="6///^S X=PRCPAMT"
 . D ^DIE K DIE
 . S PRCPDONE=1
 . ;
 . S ^PRCP(445,PRCPSECO,1,PRCPITEM,9)=PRCPLEFT_"^"_PRCPTIME
 ;
 I PRCPPOST="FU" D  G Q
 . S PRCPSS=1
 . L +^PRCP(445,PRCPPRIM,1):3 I $T=0 S PRCPDONE=0 Q
 . S LOCKPRIM=1
 . D ADD^PRCPULOC(445,PRCPPRIM_"-1",0,"HL7 Distribution Order Processing")
 . D PRCPSS^PRCPOPP(ORDERDA,PRCPSECO,PRCPPRIM,PRCPSS)
 . S PRCPDONE=1
 . ; verify each item has refill amount
 . S ITEM=0
 . F  S ITEM=$O(^PRCP(445.3,ORDERDA,1,ITEM)) Q:'ITEM  D
 . . S X=$P($G(^PRCP(445.3,ORDERDA,1,ITEM,0)),"^",7)
 . . I X']"" S PRCPNOIT(ITEM)=1
 . I $D(PRCPNOIT) D  ; send message for items not refilled
 . . N ITEMNM,LN,PRCPXMY,TYPE,XMB,XMDUZ,XMTEXT,XMY
 . . K ^TMP($J,"PRCPHL7")
 . . S ITEM=0,LN=0
 . . F  S ITEM=$O(PRCPNOIT(ITEM)) Q:'ITEM  D
 . . . S LN=LN+1
 . . . S ITEMNM=$P($G(^PRCP(445,PRCPSECO,1,ITEM,6)),"^",1)
 . . . I ITEMNM']"" S TYPE=$P(^PRCP(445.5,$P(^PRCP(445,PRCPSECO,5),"^",1),0),"^",2) D
 . . . . I TYPE="S" S ITEMNM=$P($G(^PRCP(445,PRCPPRIM,1,ITEM,6)),"^",1)
 . . . . I TYPE="O" S ITEMNM=$P($G(^PRC(441,ITEM,0)),"^",2)
 . . . S ^TMP($J,"PRCPHL7",1,LN,0)=$E("       ",$L(ITEM),7)_ITEM_"  "_ITEMNM
 . . S ^TMP($J,"PRCPHL7",1,0)=LN
 . . D GETUSER^PRCPXTRM(PRCPPRIM) Q:'$O(PRCPXMY(""))  ; find primary inventory point users
 . . S ITEM=0
 . . ; restrict message to inventory point managers
 . . F  S ITEM=$O(PRCPXMY(ITEM)) Q:ITEM'>0  I PRCPXMY(ITEM)=1 S XMY(ITEM)=""
 . . S XMTEXT="^TMP($J,""PRCPHL7"",1,"
 . . S XMB(1)=$P(^PRCP(445.3,ORDERDA,0),"^",1)
 . . S XMB(3)=$$INVNAME^PRCPUX1(PRCPSECO)
 . . S XMB(2)=$P(^PRCP(445,$P(^PRCP(445.3,ORDERDA,0),"^",2),0),"^",1)
 . . S XMB="PRCP_NO_REFILL"
 . . S XMDUZ="SUPPLY STATION INTERFACE"
 . . D EN^XMB
 . . K ^TMP($J,"PRCPHL7")
 ;
ERR ;
 N NUMBER,PRCPHLPO
 S NUMBER=ERR
 S PRCPHLPO("ORDER")=$P($G(^PRCP(445.3,ORDERDA,0)),"^",1)
 S PRCPHLPO("SIPNAME")="" I $D(^PRCP(445,PRCPSECO)) S PRCPHLPO("SIPNAME")=$$INVNAME^PRCPUX1(PRCPSECO)
 S PRCPHLPO("ITEM")="" I $D(PRCPITEM) S PRCPHLPO("ITEM")=PRCPITEM
 S PRCPHLPO("NAME")="" I $D(PRCPITNM) S PRCPHLPO("NAME")=PRCPITNM
 S PRCPHLPO("QTY")="" I $D(PRCPAMT) S PRCPHLPO("QTY")=PRCPAMT
 S PRCPHLPO("LEFT")="" I $D(PRCPLEFT) S PRCPHLPO("LEFT")=PRCPLEFT
 S PRCPHLPO("TYPE")="" I $D(PRCPPOST) S PRCPHLPO("TYPE")=PRCPPOST
 D ERR^PRCPHLM0(ERR,"PRCP_BAD_ORDER",PRCPSECO,.PRCPHLPO,PRCPHL7)
 S PRCPDONE=1
 ;
Q I LOCKORD L -^PRCP(445.3,ORDERDA) D CLEAR^PRCPULOC(445.3,ORDERDA_"-1",0)
 I LOCKPRIM L -^PRCP(445,PRCPPRIM,1) D CLEAR^PRCPULOC(445,PRCPPRIM_"-1",0)
 Q
