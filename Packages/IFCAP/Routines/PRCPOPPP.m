PRCPOPPP ;WISC/RFJ/DWA-move item from prim to seco to patient ;27 Sep 93
 ;;5.1;IFCAP;**4,33**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SALE(PRCPPRIM,ITEMDA,TRANORDR,PRCPOPPP) ;  post item for primary sale
 ;  tranordr=transaction register #
 ;  prcpoppp("qty") = qty to sale (include minus for sale)
 ;  prcpoppp("invval") = inv value sold (include minus for sale)
 ;  prcpoppp("orderda")= ien of ordernumber in 445.3 (used for type)
 ;  prcpoppp("otherpt") = inv pt sold to
 ;  prcpoppp("dueout") = dueout qty to add (- to subtract)
 ;  prcpoppp("reason") = 0:reason for transaction register
 ;  prcpoppp("noinvpt") = set to 1 to prevent from updating invpt
 ;  locks to inventory pt prcpprim need to be applied before entry
 ;
 ;  distribution costs
 N COSTCNTR,TYPE
 ;  use costcenter for primary since secondaries do not have costcenters
 S COSTCNTR=$P($G(^PRCP(445,PRCPPRIM,0)),"^",7)
 I COSTCNTR,$G(PRCPOPPP("OTHERPT")) D COSTCNTR^PRCPUCC(PRCPOPPP("OTHERPT"),PRCPPRIM,COSTCNTR,-PRCPOPPP("INVVAL"))
 ;
 ;  usage
 D ADDUSAG^PRCPUSAG(PRCPPRIM,ITEMDA,-PRCPOPPP("QTY"),-PRCPOPPP("INVVAL"))
 ;
 ;  if prcpoppp("noinvpt"), do not update inventory point
 I $G(PRCPOPPP("NOINVPT")) Q
 ;
 ;  update begin balance, inventory point, transaction register
 S TYPE=$P($G(^PRCP(445.3,+$G(PRCPOPPP("ORDERDA")),0)),"^",8) I TYPE="" S TYPE="R"
 D INVPT(PRCPPRIM,ITEMDA,TYPE,TRANORDR,.PRCPOPPP)
 Q
 ;
 ;
RECEIPT(PRCPSECO,ITEMDA,TRANORDR,PRCPOPPP)       ;  receive items
 ;  tranordr=transaction register #
 ;  prcpoppp("qty") = qty to receive
 ;  prcpoppp("invval") = inv value received
 ;  prcpoppp("otherpt") = inv pt received from
 ;  prcpoppp("duein") = duein qty to add (- to subtract)
 ;  prcpoppp("reason") = 0:reason for transaction register
 ;    for patient distributions:
 ;  prcpoppp("prcpptda") = ptr to file 446.1 (patient distribution)
 ;  locks to inventory pt prcpseco need to be applied before entry
 ;
 ;  receipt history
 D RECEIPTS^PRCPUSAG(PRCPSECO,ITEMDA,PRCPOPPP("QTY"))
 ;
 ;  update inventory point
 D INVPT(PRCPSECO,ITEMDA,"RC",TRANORDR,.PRCPOPPP)
 ;
 ;  if no patient quit
 I '$G(PRCPOPPP("PRCPPTDA")) Q
 ;
 ;  sale to patient
 ;
 ;  usage
 D ADDUSAG^PRCPUSAG(PRCPSECO,ITEMDA,PRCPOPPP("QTY"),PRCPOPPP("INVVAL"))
 ;
 ;  take out of inventory point
 N COST,QTY,Y
 S QTY=PRCPOPPP("QTY"),COST=PRCPOPPP("INVVAL")
 S PRCPOPPP("QTY")=-QTY,(PRCPOPPP("INVVAL"),PRCPOPPP("SELVAL"))=-COST
 K PRCPOPPP("OTHERPT"),PRCPOPPP("DUEIN")
 S Y=PRCPPTDA D DD^%DT
 S PRCPOPPP("REASON")="0:Distribution to patient ("_Y_")"
 D INVPT(PRCPSECO,ITEMDA,"R",TRANORDR,.PRCPOPPP)
 ;
 ;  distribute to patient
 D DISTITEM^PRCPUPAT(PRCPPTDA,ITEMDA,QTY,COST)
 Q
 ;
 ;
INVPT(PRCPINPT,ITEMDA,TRANTYPE,TRANORDR,PRCPOPPP) ;  update inventory point data
 ;  trantype=type of transaction; tranordr=transaction register #
 ;  prcpoppp("qty") = qty to add to inventory point
 ;  prcpoppp("invval") = value to add to inventory point
 ;  prcpoppp("otherpt") = inv pt sold to (for transaction register)
 ;  prcpoppp("dueout") = qty to add to dueout
 ;  prcpoppp("duein")  = qty to add to duein
 ;  prcpoppp("reason") = 0:reason for transaction register
 ;  locks to inventory pt prcpinpt need to be applied before entry
 ;
 N ITEMDATA,QUANTITY
 S ITEMDATA=$G(^PRCP(445,PRCPINPT,1,ITEMDA,0)) I ITEMDATA="" Q
 ;
 ;  update beginning balance
 I '$D(^PRCP(445.1,PRCPINPT,1,ITEMDA,1,$E(DT,1,5),0)) D BALANCE^PRCPUBAL(PRCPINPT,ITEMDA,$E(DT,1,5))
 ;
 ;  make sure inventory value has been set to qty*unitcost
 I '$P(ITEMDATA,"^",27) S $P(ITEMDATA,"^",27)=$J($P(ITEMDATA,"^",7)*$P(ITEMDATA,"^",22),0,2)
 S $P(ITEMDATA,"^",7)=$P(ITEMDATA,"^",7)+PRCPOPPP("QTY")
 S $P(ITEMDATA,"^",27)=$P(ITEMDATA,"^",27)+PRCPOPPP("INVVAL")
 ;
 ;  update average cost
 S $P(ITEMDATA,"^",22)=0,QUANTITY=$P(ITEMDATA,"^",7)+$P(ITEMDATA,"^",19)
 I QUANTITY>0 S $P(ITEMDATA,"^",22)=$J($P(ITEMDATA,"^",27)/QUANTITY,0,3) I $P(ITEMDATA,"^",22)'>0 S $P(ITEMDATA,"^",22)=0
 S:TRANTYPE="RC" $P(ITEMDATA,"^",3)=DT
 S ^PRCP(445,PRCPINPT,1,ITEMDA,0)=ITEMDATA
 ;
 ;  update dueout and duein
 I $G(PRCPOPPP("DUEOUT"))<0 D SETOUT^PRCPUDUE(PRCPINPT,ITEMDA,PRCPOPPP("DUEOUT"))
 I $G(PRCPOPPP("DUEIN"))<0 D SETIN^PRCPUDUE(PRCPINPT,ITEMDA,PRCPOPPP("DUEIN"))
 ;
 ;
 ;  transaction register
 S PRCPOPPP("SELVAL")=PRCPOPPP("INVVAL")
 I TRANORDR D ADDTRAN^PRCPUTRX(PRCPINPT,ITEMDA,TRANTYPE,TRANORDR,.PRCPOPPP)
 Q
