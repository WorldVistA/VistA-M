PRCPUDUE ;WISC/RFJ-duein,duout utilities                            ;20 Sep 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
GETOUT(INVPT,ITEMDA) ;  return dueout quantity for invpt item
 Q +$P($G(^PRCP(445,INVPT,1,ITEMDA,"DUE")),"^",2)
 ;
 ;
GETIN(INVPT,ITEMDA)  ;  return duein quantity for invpt item
 Q +$P($G(^PRCP(445,INVPT,1,ITEMDA,"DUE")),"^")
 ;
 ;
SETOUT(INVPT,ITEMDA,QTY)     ;  add qty to dueout qty
 I '$D(^PRCP(445,INVPT,1,ITEMDA,0)) Q
 I 'QTY Q
 L +^PRCP(445,INVPT,1,ITEMDA,"DUE")
 S QTY=QTY+$$GETOUT(INVPT,ITEMDA) I QTY<0 S QTY=0
 S $P(^PRCP(445,INVPT,1,ITEMDA,"DUE"),"^",2)=QTY
 L -^PRCP(445,INVPT,1,ITEMDA,"DUE")
 Q
 ;
 ;
SETIN(INVPT,ITEMDA,QTY)      ;  add qty to duein qty
 I '$D(^PRCP(445,INVPT,1,ITEMDA,0)) Q
 I 'QTY Q
 L +^PRCP(445,INVPT,1,ITEMDA,"DUE")
 S QTY=QTY+$$GETIN(INVPT,ITEMDA) I QTY<0 S QTY=0
 S $P(^PRCP(445,INVPT,1,ITEMDA,"DUE"),"^")=QTY
 L -^PRCP(445,INVPT,1,ITEMDA,"DUE")
 Q
