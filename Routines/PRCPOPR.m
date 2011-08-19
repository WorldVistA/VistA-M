PRCPOPR ;WISC/RFJ-release distribution order ;27 Sep 93
V ;;5.1;IFCAP;**1,24**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
RELEASEL ;  release order - called from list manager
 S VALMBCK="R"
 N %,ITEMDA,PRCPFLAG
 ;
 W !!,"CHECKING ITEMS ON ORDER..."
 S (ITEMDA,PRCPFLAG)=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERDA,1,ITEMDA)) Q:'ITEMDA  I $P($G(^(ITEMDA,0)),"^",2),$$ITEMCHK^PRCPOPER(PRCPPRIM,PRCPSECO,ITEMDA)'="" S PRCPFLAG=1 Q
 I PRCPFLAG S VALMSG="ORDER CANNOT BE RELEASED - FIX ALL ERRORS FIRST" D CHECKORD^PRCPOPER Q
 W " NO ERRORS FOUND !",!
 ;
 I $$ASKREL(ORDERDA,1)'=1 Q
 ;
 D RELEASE(ORDERDA)
 S VALMSG="ORDER HAS BEEN RELEASED (TO PRIMARY) FOR FILLING"
 D HDR^PRCPOPL,VARIABLE^PRCPOPU
 Q
 ;
 ;
RELEASE(ORDERDA) ;  release order - update dueouts and dueins, set order status released
 N %,ITEMDA,ORDRDATA,PRCPPRIM,PRCPSECO,QUANTITY
 S ORDRDATA=$G(^PRCP(445.3,ORDERDA,0)),PRCPPRIM=$P(ORDRDATA,"^",2),PRCPSECO=$P(ORDRDATA,"^",3)
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERDA,1,ITEMDA)) Q:'ITEMDA  S QUANTITY=$P(^(ITEMDA,0),"^",2) I QUANTITY D DUEOUTIN^PRCPOPU(PRCPPRIM,PRCPSECO,ITEMDA,QUANTITY,0)
 ;
 S $P(^PRCP(445.3,ORDERDA,0),"^",6)="R"
 ;
 ; if this is a regular order for a supply station secondary, send the
 ; order to the supply station and set up field 10.
 I $P(^PRCP(445.3,ORDERDA,0),"^",8)="R",$P($G(^PRCP(445,PRCPSECO,5)),"^",1)]"" D
 . N FLAG,ITEM
 . I $P($G(^PRCP(445.3,ORDERDA,2)),"^",1)]"" D EN^DDIOL("Case Cart or IK Orders are not handled by the supply station.") Q  ; CC/IK don't go
 . S ITEM=0,FLAG=0
 . F  S ITEM=$O(^PRCP(445.3,ORDERDA,1,ITEM)) Q:+ITEM=0  D  I FLAG Q
 . . I $P(^PRC(441,ITEM,0),"^",6)'="S" S FLAG=1
 . I 'FLAG D EN^DDIOL("Case Cart or IK Orders are not handled by the supply station.") Q
 . D BLDSEG^PRCPHLSO(ORDERDA)
 . D NOW^%DTC
 . S $P(^PRCP(445.3,ORDERDA,0),"^",10)=%
 ;
 Q
 ;
ASKREL(ORDERDA,%)         ;  ask to release order, %=defualt
 ;  returns 1 for yes, 2 for no, 0 for ^
 S XP="Is this order READY to be RELEASED to "_$$INVNAME^PRCPUX1(+$P($G(^PRCP(445.3,+ORDERDA,0)),"^",2))_" for FILLING",XH="Enter 'YES' to RELEASE this order for filling, 'NO' or '^' to exit."
 W !
 Q $$YN^PRCPUYN(%)
 ;
 ;
 ; remove piece 10 from file 445.3 for order sent to supply station
REMFLAG I '$D(PRCP("DPTYPE")) S PRCP("DPTYPE")="P"
 D ^PRCPUSEL I '$G(PRCP("I")) Q
 N DA,DIE,DIR,DR,ORDERDA,PRCPPRIM,PRCPSEC,PRCPSTOP,REFILL,Y
 S PRCPPRIM=PRCP("I")
 ; ask order number
 S ORDERDA=$$ORDERSEL^PRCPOPUS(PRCPPRIM,0,"R","")
 Q:'ORDERDA
 S PRCPSEC=$P(^PRCP(445.3,ORDERDA,0),"^",10)
 I PRCPSEC']"" D EN^DDIOL("This order is not a supply station order and has no flag to remove.") QUIT
 S DIR(0)="Y"
 S DIR("A")="Restrict all processing of this order to GIP"
 S DIR("A",1)=" "
 S DIR("A",2)="WARNING: RESTRICTIONS MAY COMPROMISE THE INTEGRITY OF INVENTORY DATA !!!"
 S DIR("A",3)=" "
 S DIR("A",4)="Restrict processing ONLY when a supply station or its interface is"
 S DIR("A",5)="down for extended periods of time."
 S DIR("B")="NO"
 D ^DIR
 K DIR
 I Y'=1 QUIT
 S PRCPSTOP=0
 S REFILL=$$REFILL^PRCPOPD(+ORDERDA)
 I REFILL D  I PRCPSTOP QUIT
 . N DA,DIR,DR
 . S DIR(0)="Y"
 . S DIR("A",1)=" "
 . S DIR("A",2)="WARNING: The supply station stocked items in this order!!!"
 . S DIR("A",3)="         THE STOCKED QUANTITIES WILL BE LOST IF YOU PROCEED."
 . S DIR("A",4)=" "
 . S DIR("A")="Are you sure you want to process the order in GIP instead"
 . S DIR("?")="Enter 'Y' or 'YES' to process the order in GIP."
 . S DIR("?",1)="Enter 'N' or 'NO' to process the order in the supply station."
 . D ^DIR
 . I $D(DUOUT)!$D(DTOUT) S PRCPSTOP=1 Q
 . I Y=0 S PRCPSTOP=1 Q
 ;
 ; DELETE FLAG FROM ORDER
 I REFILL D MESSAGE^PRCPOPD(+ORDERDA,2)
 S DIE="^PRCP(445.3,"
 S DA=ORDERDA
 S DR="10///@"
 D ^DIE
 Q
