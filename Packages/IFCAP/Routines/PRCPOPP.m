PRCPOPP ;WISC/RFJ-post distribution order;  ; 8/4/99 1:05pm
V ;;5.1;IFCAP;**1,41**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
PRCPSS(ORDERDA,PRCPSECO,PRCPPRIM,PRCPSS) ; entry point for supply station
 ; ORDERDA  order to be posted
 ; PRCPSECO secondary inventory point
 ; PRCPPRIM primary inventory point
 ; PRCPSS   flag to designate supply station posting (value = 1)
 G PRCPSS0
 ;
POST ;  post order
 ;  orderda=order number
 S VALMBCK="R"
 N PRCPSS S PRCPSS=0 ; posting is done at GIP
 ;
PRCPSS0 N %,CONVFACT,DATA,ITEMDA,ITEMDATA,ORDRDATA,PRCPFLAG,PRCPID,PRCPOH,PRCPOPP,PRCPPORD,PRCPPTDA,PRCPSORD,QTYDUE,QUANTITY,TOTCOST,UNITCOST,XORDERDA,XDT
 ;
 ;  Check for old orders
 S XORDERDA=0 F  S XORDERDA=$O(^PRCP(445.3,XORDERDA)) Q:'XORDERDA  Q:XORDERDA]"A"  D
 .  S XDT=$P($G(^PRCP(445.3,XORDERDA,0)),"^",9)
 .  Q:'XDT
 .  I XDT+2<DT D DELORDER^PRCPOPD(XORDERDA)
 .  Q
 ;
 I PRCPSS G PRCPSS1 ; checks not valid for supply station posting
 ;
 W !!,"CHECKING ITEMS ON ORDER..."
 S (ITEMDA,PRCPFLAG)=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERDA,1,ITEMDA)) Q:'ITEMDA  S QUANTITY=$P($G(^(ITEMDA,0)),"^",2) I QUANTITY D  I PRCPFLAG Q
 .   I $$ITEMCHK^PRCPOPER(PRCPPRIM,PRCPSECO,ITEMDA)'="" S PRCPFLAG=1 Q
 I PRCPFLAG S VALMSG="ORDER CANNOT BE POSTED - FIX ALL ERRORS FIRST" D CHECKORD^PRCPOPER Q
 W " NO ERRORS FOUND !",!
 ;
 I $P($G(^PRCP(445.3,ORDERDA,0)),"^",7)="" D  Q:$G(PRCPFLAG)
 .   S XP="Do you want to print the picking ticket before posting",XH="Enter YES to print the picking ticket, NO to skip printing it, or ^ to exit."
 .   S %=$$YN^PRCPUYN(1) I %<1 S PRCPFLAG=1 Q
 .   I %'=1 Q
 .   D PICKLM^PRCPOPT
 ;
 S XP="Are you sure you want to POST this order to "_$$INVNAME^PRCPUX1(+$P($G(^PRCP(445.3,+ORDERDA,0)),"^",3)),XH="Enter 'YES' to start posting the order to the secondary inventory point",XH(1)="Enter 'NO' or '^' to exit."
 W ! I $$YN^PRCPUYN(1)'=1 Q
 ;
 L +^PRCP(445,PRCPPRIM,1):5
 I '$T D SHOWWHO^PRCPULOC(445,PRCPPRIM_"-1",0) Q
 L +^PRCP(445,PRCPSECO,1):5 I '$T D  Q
 . L -^PRCP(445,PRCPPRIM,1)
 . D SHOWWHO^PRCPULOC(445,PRCPSECO_"-1",0)
 D ADD^PRCPULOC(445,PRCPPRIM_"-1",0,"Distribution Order Processing")
 D ADD^PRCPULOC(445,PRCPSECO_"-1",0,"Distribution Order Processing")
 ;
 W !,"POSTING DISTRIBUTION ORDER ..."
 ;
 ;  if patient is on order, add entry
PRCPSS1 ;  use the same transaction register numbers fr the entire order
 S PRCPPORD=$$ORDERNO^PRCPUTRX(PRCPPRIM)
 S PRCPSORD=$$ORDERNO^PRCPUTRX(PRCPSECO)
 ;
 I $P($G(^PRCP(445.3,ORDERDA,2)),"^") S DATA=^(2) D
 .   S PRCPPTDA=+$P(DATA,"^",3) I $D(^PRCP(446.1,PRCPPTDA,0)) Q
 .   S PRCPPTDA=$$PATIENT^PRCPUPAT(+$P(DATA,"^"),+$P(DATA,"^",2))
 .   I 'PRCPPTDA Q
 .   S $P(^PRCP(445.3,ORDERDA,2),"^",3)=PRCPPTDA
 .   S $P(^PRCP(446.1,PRCPPTDA,0),"^",6)=PRCPSECO
 ;
 ;  store case carts and instrument kits in
 ;  ^tmp($j,"prcpopccik",itemda)=qty for cc/ik item posting
 K ^TMP($J,"PRCPOPCCIK")
 ;
 ;  post order
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERDA,1,ITEMDA)) Q:'ITEMDA  S ORDRDATA=$G(^(ITEMDA,0)) D
 .   S (QTYDUE,QUANTITY)=$P(ORDRDATA,"^",2)
 .   S PRCPOH=$P($G(^PRCP(445,PRCPPRIM,1,ITEMDA,0)),"^",7)
 .   I PRCPOH+0=0 S PRCPOH=0
 .   I QUANTITY>PRCPOH S QUANTITY=PRCPOH
 .   I PRCPOH<0 S QUANTITY=0
 .   I PRCPSS S QUANTITY=$P(ORDRDATA,"^",7) ; use qty that was stocked
 .   ; 
 .   ;  if case cart or instrument kit, set tmp global
 .   I $D(^PRCP(445.7,ITEMDA,0))!($D(^PRCP(445.8,ITEMDA,0))) S:QUANTITY>0 ^TMP($J,"PRCPOPCCIK",ITEMDA)=QUANTITY Q
 .   ;
 .   S ITEMDATA=^PRCP(445,PRCPPRIM,1,ITEMDA,0)
 .   S UNITCOST=+$P(ITEMDATA,"^",22) I 'UNITCOST S UNITCOST=+$P(ITEMDATA,"^",15)
 .   I 'UNITCOST S UNITCOST=+$P(ORDRDATA,"^",3)
 .   S TOTCOST=$J(QUANTITY*UNITCOST,0,2)
 .   ;
 .   ;
 .   I QTYDUE'=0 D
 .   .   I 'PRCPSS!(PRCPSS&$D(^PRCP(445,PRCPPRIM,1,ITEMDA))) D 
 .   .   .   ;  sell from primary
 .   .   .   K PRCPOPP
 .   .   .   S PRCPOPP("QTY")=-QUANTITY,PRCPOPP("DUEOUT")=-QTYDUE,PRCPOPP("INVVAL")=-TOTCOST,PRCPOPP("OTHERPT")=PRCPSECO,PRCPOPP("ORDERDA")=ORDERDA
 .   .   .   D SALE^PRCPOPPP(PRCPPRIM,ITEMDA,PRCPPORD,.PRCPOPP)
 .   .   ;
 .   .   I 'PRCPSS!(PRCPSS&$D(^PRCP(445,PRCPSECO,1,ITEMDA))) D
 .   .   .   ;  receipt in secondary
 .   .   .   S CONVFACT=$P($$GETVEN^PRCPUVEN(PRCPSECO,ITEMDA,PRCPPRIM_";PRCP(445,",1),"^",4)
 .   .   .   K PRCPOPP
 .   .   .   S PRCPOPP("QTY")=QUANTITY*CONVFACT,PRCPOPP("DUEIN")=-QTYDUE*CONVFACT,PRCPOPP("INVVAL")=TOTCOST,PRCPOPP("OTHERPT")=PRCPPRIM
 .   .   .   ;  if patient, distribute from secondary to patient
 .   .   .   I $G(PRCPPTDA) S PRCPOPP("PRCPPTDA")=PRCPPTDA
 .   .   .   D RECEIPT^PRCPOPPP(PRCPSECO,ITEMDA,PRCPSORD,.PRCPOPP)
 .   .   .   Q
 .   ;
 .   ;  Set quantity posted into item multiple
 .   I 'PRCPSS S $P(^PRCP(445.3,ORDERDA,1,ITEMDA,0),"^",7)=QUANTITY
 ;
 ;  Set up posted status
 S $P(^PRCP(445.3,ORDERDA,0),"^",6)="P",$P(^(0),"^",9)=DT
 ;
 ;  if an item is a cc or ik
 I $O(^TMP($J,"PRCPOPCCIK",0)) D
 .   ; if interactive, display screen to post items in cc and iks
 .   I 'PRCPSS D EN^VALM("PRCP DIST ORDER CC/IK POSTING")
 .   I PRCPSS D  ; mark amount rec'd as 0, so user gets message
 .   .  N PRCPAMT
 .   .  S DIE="^PRCP(445.3,"_ORDERDA_",1,"
 .   .  S DA=PRCPITEM
 .   .  S PRCPAMT="@" ; delete entry to invoke bulletin to user
 .   .  S DR="6///^S X=PRCPAMT"
 .   .  D ^DIE K DIE
 .   .  Q
 .   Q
 ;
 I 'PRCPSS D
 . D CLEAR^PRCPULOC(445,PRCPPRIM_"-1",0),CLEAR^PRCPULOC(445,PRCPSECO_"-1",0)
 . L -^PRCP(445,PRCPPRIM,1),-^PRCP(445,PRCPSECO,1)
 ;
 Q
