PRCPUUIP ;WISC/RFJ-utility update item prim to secondary            ;08 Jul 92
 ;;5.1;IFCAP;**126**;Oct 20, 2000;Build 2
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
ITEM(INVPT,ITEMDA,TRANTYPE,ORDERNO,PRCPDATA) ;  update inventory point item
 ;prcpdata =
 ;  qty)       = quantity to add to on-hand
 ;  invval)    = total inventory value
 ;  selval)    = total sales value
 ;  otherpt)   = other inventory point affected (for issues)
 ;  reason)    = reason (for adjustments)
 ;  date)      = date of transaction (optional)
 ;  pkg)       = packaging units on transaction register
 ;  noduein)   = do not decrement dueins if $data (optional)
 ;  nodueout)  = do not decrement dueouts if $data (optional)
 ;
 ;returns
 ;  prcpid = transaction 445.2 da number
 ;
 N %,COSTCNTR,DATE,ITEMDATA,PRCPUUIP,X,Y
 D NOW^%DTC S DATE=%
 I '$D(^PRCP(445.1,INVPT,1,ITEMDA,1,$E(DATE,1,5),0)) D BALANCE^PRCPUBAL(INVPT,ITEMDA,$E(DATE,1,5))
 I $P($G(^PRCP(445,INVPT,0)),"^",6)="Y" D
 .   K PRCPUUIP F %="DATE","QTY","INVVAL","SELVAL","PKG","REF","2237PO","ISSUE","OTHERPT","REASON" I $D(PRCPDATA(%)) S PRCPUUIP(%)=PRCPDATA(%)
 .   K PRCPID D ADDTRAN^PRCPUTRX(INVPT,ITEMDA,TRANTYPE,ORDERNO,.PRCPUUIP) K PRCPUUIP S PRCPID=+$G(Y)
 I '$D(^PRCP(445,INVPT,1,ITEMDA,0))&((TRANTYPE="R")!(TRANTYPE="C")) D  Q
 .   ; update costcenter costs and quit
 .   ; use costcenter for primary since second do not have costcneters
 .   S COSTCNTR=$P($G(^PRCP(445,INVPT,0)),"^",7)
 .   I COSTCNTR D COSTCNTR^PRCPUCC(PRCPDATA("OTHERPT"),INVPT,COSTCNTR,-PRCPDATA("SELVAL"))
 I '$D(^PRCP(445,INVPT,1,ITEMDA,0)) Q
 L +^PRCP(445,INVPT,1,ITEMDA)
 S ITEMDATA=^PRCP(445,INVPT,1,ITEMDA,0)
 ;
 ;  RC=receipts
 I TRANTYPE="RC" D
 .   D RECEIPTS^PRCPUSAG(INVPT,ITEMDA,PRCPDATA("QTY"))
 .   ; do not update dueins if "noduein" defined
 .   I '$D(PRCPDATA("NODUEIN")) D SETIN^PRCPUDUE(INVPT,ITEMDA,-PRCPDATA("QTY"))
 .   S $P(ITEMDATA,"^",15)=$J(PRCPDATA("INVVAL")/PRCPDATA("QTY"),0,3),$P(ITEMDATA,"^",3)=$E(DATE,1,7)
 ;
 ;  R or C=distribution
 I TRANTYPE="R"!(TRANTYPE="C") D
 .   D ADDUSAG^PRCPUSAG(INVPT,ITEMDA,-PRCPDATA("QTY"),-PRCPDATA("INVVAL"))
 .   ;  use costcenter for primary since second do not have costcenters
 .   S COSTCNTR=$P($G(^PRCP(445,INVPT,0)),"^",7)
 .   I COSTCNTR D COSTCNTR^PRCPUCC(PRCPDATA("OTHERPT"),INVPT,COSTCNTR,-PRCPDATA("SELVAL"))
 .   ; do not update dueouts if "nodueout" defined
 .   I '$D(PRCPDATA("NODUEOUT")) D SETOUT^PRCPUDUE(INVPT,ITEMDA,PRCPDATA("QTY"))
 ;
 ;  U=usage
 I TRANTYPE="U" D
 .   D ADDUSAG^PRCPUSAG(INVPT,ITEMDA,-PRCPDATA("QTY"),-PRCPDATA("INVVAL"))
 ;
 ;  update inventory item
 I '$P(ITEMDATA,"^",27) S $P(ITEMDATA,"^",27)=$J($P(ITEMDATA,"^",7)*$P(ITEMDATA,"^",22),0,2)
 S $P(ITEMDATA,"^",7)=$P(ITEMDATA,"^",7)+PRCPDATA("QTY")
 S $P(ITEMDATA,"^",27)=$P(ITEMDATA,"^",27)+PRCPDATA("INVVAL")
 S $P(ITEMDATA,"^",22)=0,%=$P(ITEMDATA,"^",7)+$P(ITEMDATA,"^",19) I %>0 S $P(ITEMDATA,"^",22)=$J($P(ITEMDATA,"^",27)/%,0,3) I $P(ITEMDATA,"^",22)'>0 S $P(ITEMDATA,"^",22)=0
 I TRANTYPE="P",$P(ITEMDATA,"^",22)=0 S $P(ITEMDATA,"^",22)=$P(ITEMDATA,"^",15)
 S ^PRCP(445,INVPT,1,ITEMDA,0)=ITEMDATA
 L -^PRCP(445,INVPT,1,ITEMDA)
 Q
