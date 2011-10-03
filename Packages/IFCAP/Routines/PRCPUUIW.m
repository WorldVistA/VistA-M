PRCPUUIW ;WISC/RFJ-utility update item whse to prim                 ;08 Jul 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ITEM(INVPT,ITEMDA,TRANTYPE,ORDERNO,PRCPDATA) ;  update inventory point item
 ;prcpdata =
 ;  qty)       = quantity to add to on-hand
 ;  invval)    = total inventory value
 ;  selval)    = total sales value
 ;  2237po)    = 2237 or purchase order number
 ;  ref)       = reference number
 ;  otherpt)   = other inventory point affected (for issues)
 ;  reason)    = reason (for adjustments)
 ;  reasoncode)= reason code for other adjustments
 ;  date)      = date of transaction (optional)
 ;  tranda)    = transaction number for removing due-ins
 ;  pkg)       = packaging units on transaction register
 ;  drugacct)  = update drug accountability
 ;
 ;returns
 ;  prcpid = transaction 445.2 da number
 ;
 N %,COSTCNTR,DATE,INVTYPE,ITEMDATA,PRCPUUIW,X,Y
 D NOW^%DTC S DATE=%
 I '$D(^PRCP(445.1,INVPT,1,ITEMDA,1,$E(DATE,1,5),0)) D BALANCE^PRCPUBAL(INVPT,ITEMDA,$E(DATE,1,5))
 I $P($G(^PRCP(445,INVPT,0)),"^",6)="Y" D
 .   K PRCPUUIW F %="DATE","QTY","INVVAL","SELVAL","PKG","REF","2237PO","ISSUE","OTHERPT","REASON","REASONCODE" I $D(PRCPDATA(%)) S PRCPUUIW(%)=PRCPDATA(%)
 .   K PRCPID D ADDTRAN^PRCPUTRX(INVPT,ITEMDA,TRANTYPE,ORDERNO,.PRCPUUIW) K PRCPUUIW S PRCPID=+$G(Y)
 S INVTYPE=$P(^PRCP(445,INVPT,0),"^",3)
 I '$D(^PRCP(445,INVPT,1,ITEMDA,0)) Q
 L +^PRCP(445,INVPT,1,ITEMDA)
 S ITEMDATA=^PRCP(445,INVPT,1,ITEMDA,0)
 ;  purchase order
 I PRCPDATA("2237PO")'="",$P(PRCPDATA("2237PO"),"-",3)="" D
 .   I PRCPDATA("QTY") D RECEIPTS^PRCPUSAG(INVPT,ITEMDA,PRCPDATA("QTY"))
 ;
 ;  2237 issue
 I $P(PRCPDATA("2237PO"),"-",3)'="" D
 .   I INVTYPE="W" D
 .   .   D ADDUSAG^PRCPUSAG(INVPT,ITEMDA,-PRCPDATA("QTY"),-PRCPDATA("INVVAL"))
 .   .   I TRANTYPE="R" D SETOUT^PRCPUDUE(INVPT,ITEMDA,PRCPDATA("QTY"))
 .   I INVTYPE="P" D
 .   .   D RECEIPTS^PRCPUSAG(INVPT,ITEMDA,PRCPDATA("QTY"))
 .   .   S COSTCNTR=$P($G(^PRCP(445,INVPT,0)),"^",7) I COSTCNTR D COSTCNTR^PRCPUCC(INVPT,PRCPDATA("OTHERPT"),COSTCNTR,PRCPDATA("SELVAL"))
 ;  update drug accountability
 I INVTYPE="P",$G(PRCPDATA("DRUGACCT")) S %=+$P(ITEMDATA,"^",29) S:'% %=1 D EN^PSAGIP(INVPT,ITEMDA,PRCPDATA("QTY")*%,$G(PRCPDATA("TRANDA")),PRCPDATA("2237PO"),TRANTYPE_ORDERNO,PRCPDATA("INVVAL"))
 ;  update inventory item
 I '$P(ITEMDATA,"^",27) S $P(ITEMDATA,"^",27)=$J($P(ITEMDATA,"^",7)*$P(ITEMDATA,"^",22),0,2)
 S $P(ITEMDATA,"^",7)=$P(ITEMDATA,"^",7)+PRCPDATA("QTY")
 I $D(PRCPDATA("ISSUE")) S $P(ITEMDATA,"^",19)=$P(ITEMDATA,"^",19)-PRCPDATA("QTY")
 S $P(ITEMDATA,"^",27)=$P(ITEMDATA,"^",27)+PRCPDATA("INVVAL")
 S $P(ITEMDATA,"^",22)=0,%=$P(ITEMDATA,"^",7)+$P(ITEMDATA,"^",19) I %>0 S $P(ITEMDATA,"^",22)=$J($P(ITEMDATA,"^",27)/%,0,3)
 I TRANTYPE="RC",$G(PRCPDATA("TRANDA")) D OUTST^PRCPUTRA(INVPT,ITEMDA,PRCPDATA("TRANDA"),-PRCPDATA("QTY"))
 I TRANTYPE="RC",PRCPDATA("QTY") S $P(ITEMDATA,"^",15)=$J(PRCPDATA("INVVAL")/PRCPDATA("QTY"),0,3),$P(ITEMDATA,"^",3)=$E(DATE,1,7)
 I PRCPDATA("2237PO")'="",$P(PRCPDATA("2237PO"),"-",3)="",INVTYPE="W",$D(^PRC(441,ITEMDA,2,+$O(^PRC(440,"AC","S",0)),0)) S $P(^(0),"^",2)=$S($P(ITEMDATA,"^",15)>$P(ITEMDATA,"^",22):$P(ITEMDATA,"^",15),1:$P(ITEMDATA,"^",22))
 S ^PRCP(445,INVPT,1,ITEMDA,0)=ITEMDATA
 L -^PRCP(445,INVPT,1,ITEMDA)
 Q
