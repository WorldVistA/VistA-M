PRCPHL1 ;WISC/CC-update GIP files from data in 447.1 transaction ;4/01
V ;;5.1;IFCAP;**24**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;
UPDATE(PRCPSEC,PRCPITEM,PRCPLEFT,PRCPHL1,TYPE) ;
 ;
 ; PRCPSEC  = the secondary inventory point ien
 ; PRCPITEM = the item's ien
 ; PRCPLEFT = the amount now remaining in the supply station
 ; PRCPHL1("DATE")     = Date the activity occured
 ;        ("INVVAL")   = the dollar value linked with the transaction
 ;        ("ITEM")     = item information from the zero node
 ;        ("QTY")      = the amount transacted
 ;        ("REASON")   = comments supporting the transaction
 ;        ("RECIPIENT")= patient involved in the transaction
 ;        ("SELVAL")   = the dollar value linked to the transaction
 ;        ("TRAN")     = The transaction file order number, if exists
 ;        ("USER")     = the individual responsible for the activity
 ;     TYPE = the type of activity: A=adjust or disposal, U=usage
 ;            or return, Q=quantity of hand adjusted to supply station
 ;
 N ITEMDATA,PRCPDATE,TRANORDR,%
 S ITEMDATA=PRCPHL1("ITEM")
 I PRCPHL1("QTY")=0 G LEFT ; don't update file 445 if no qty transacted
 S PRCPHL1("INVVAL")=$J(PRCPHL1("QTY")*$P(ITEMDATA,"^",22),0,2)
 ;
 ;  set up monthly start balance, if not yet done (File 445.1)
 D NOW^%DTC S PRCPDATE=%
 I '$D(^PRCP(445.1,PRCPSEC,1,PRCPITEM,1,$E(PRCPDATE,1,5),0)) D BALANCE^PRCPUBAL(PRCPSEC,PRCPITEM,$E(PRCPDATE,1,5))
 ;
 ;  usage (File 445)
 D ADDUSAG^PRCPUSAG(PRCPSEC,PRCPITEM,-PRCPHL1("QTY"),-PRCPHL1("INVVAL"))
 ;
 ;  update inventory point, verify inventory value is set to qty*unitcost
 I '$P(ITEMDATA,"^",27) S $P(ITEMDATA,"^",27)=$J($P(ITEMDATA,"^",7)*$P(ITEMDATA,"^",22),0,2) ; cost of quantity on hand
 S $P(ITEMDATA,"^",7)=$P(ITEMDATA,"^",7)+PRCPHL1("QTY") ; QOH+QTY in txn
 S $P(ITEMDATA,"^",27)=$J($P(ITEMDATA,"^",27),0,2)+PRCPHL1("INVVAL") ; cost of QOH+QTY transacted
 ;
LEFT S ^PRCP(445,PRCPSEC,1,PRCPITEM,0)=ITEMDATA
 S $P(^PRCP(445,PRCPSEC,1,PRCPITEM,9),"^",1)=PRCPLEFT
 S $P(^PRCP(445,PRCPSEC,1,PRCPITEM,9),"^",2)=PRCPHL1("DATE")
 ;
 ;  transaction register
 I PRCPHL1("QTY")=0 G Q ; don't log transactions of 0 qty
 I $D(PRCPHL1("TRAN")) S TRANORDR=PRCPHL1("TRAN")
 I '$D(PRCPHL1("TRAN")) S TRANORDR=$$ORDERNO^PRCPUTRX(PRCPSEC)
 D ADDTRAN^PRCPUTRX(PRCPSEC,PRCPITEM,TYPE,TRANORDR,.PRCPHL1)
 ;
Q Q
