PRCPOPEE ;WISC/RFJ-edit distribution order items                    ;27 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EDIT ;  edit distribution order
 D FULL^VALM1
 S VALMBCK="R"
 D ITEMS(ORDERDA)
 D INIT^PRCPOPL
 Q
 ;
 ;
ITEMS(ORDERDA)          ;  edit items on distribution order orderda
 I '$D(^PRCP(445.3,ORDERDA,0)) Q
 N AFTERQTY,BEFORQTY,CONV,ITEMDA,PRIMITEM,PRCPORD,SECOITEM,UNITCOST,UNITR,VDATA
 D VARIABLE^PRCPOPU
 ;
 F  S ITEMDA=+$$ITEMSEL^PRCPOPUS(ORDERDA,PRCPPRIM,1) Q:'ITEMDA  D
 .   ;
 .   ;  show inventory data
 .   S PRIMITEM=^PRCP(445,PRCPPRIM,1,ITEMDA,0)
 .   S UNITCOST=+$P(PRIMITEM,"^",22) I $P(PRIMITEM,"^",15)>UNITCOST S UNITCOST=+$P(PRIMITEM,"^",15)
 .   ;
 .   W !!,"Data for PRIMARY inventory point: ",$P(PRCPORD(0),"^",2)
 .   W !?5,"Quantity On-Hand: ",+$P(PRIMITEM,"^",7),?40,"Unit per Issue: ",$$UNIT^PRCPUX1(PRCPPRIM,ITEMDA," per ")
 .   W !?5,"Quantity Due-Out: ",$$GETOUT^PRCPUDUE(PRCPPRIM,ITEMDA),!?5,"Quantity Due-In : ",$$GETIN^PRCPUDUE(PRCPPRIM,ITEMDA),!?12,"Unit Cost: ",UNITCOST
 .   I $P(PRIMITEM,"^",25) W !?2,"Required Issue Mult: ",$P(PRIMITEM,"^",25)
 .   I $P(PRIMITEM,"^",17) W !?4,"Minimum Issue Qty: ",$P(PRIMITEM,"^",17)
 .   ;
 .   S SECOITEM=$G(^PRCP(445,PRCPSECO,1,ITEMDA,0))
 .   W !!,"Data for SECONDARY inventory point: ",$P(PRCPORD(0),"^",3)
 .   I SECOITEM="" S CONV=1 W !?5,"ITEM NOT STORED IN SECONDARY INVENTORY POINT",!
 .   ;
 .   I SECOITEM'="" D
 .   .   W !?5,"Quantity On-Hand: ",+$P(SECOITEM,"^",7),?40,"Unit per Issue: ",$$UNIT^PRCPUX1(PRCPSECO,ITEMDA," per ")
 .   .   S VDATA=$$GETVEN^PRCPUVEN(PRCPSECO,ITEMDA,PRCPPRIM_";PRCP(445,",1),UNITR=$$UNITVAL^PRCPUX1(+$P(VDATA,"^",3),$P(VDATA,"^",2)," per "),CONV=$P(VDATA,"^",4)
 .   .   W !?5,"Quantity Due-In : ",$$GETIN^PRCPUDUE(PRCPSECO,ITEMDA),?40,"Unit per Recpt: ",UNITR,!?37,"Conversion Factor: ",CONV
 .   ;
 .   ;  enter data
 .   I '$P(^PRCP(445.3,ORDERDA,1,ITEMDA,0),"^",3) S $P(^(0),"^",3)=UNITCOST
 .   S BEFORQTY=+$P(^PRCP(445.3,ORDERDA,1,ITEMDA,0),"^",2)
 .   D ITEMEDIT^PRCPOPUS(ORDERDA,ITEMDA,0)
 .   S AFTERQTY=+$P(^PRCP(445.3,ORDERDA,1,ITEMDA,0),"^",2)
 .   ;
 .   ;  if status is released and beginning qty '= current qty
 .   ;  update dueins and dueouts
 .   I $P(PRCPORD(0),"^",6)'="",BEFORQTY'=AFTERQTY D DUEOUTIN^PRCPOPU(PRCPPRIM,PRCPSECO,ITEMDA,$S(AFTERQTY<0:0,1:AFTERQTY)-BEFORQTY,1)
 .   ;
 .   I AFTERQTY=0 D DELITEM^PRCPOPD(ORDERDA,ITEMDA) W !!,"** ITEM HAS BEEN DELETED FROM THE ORDER **" Q
 .   I AFTERQTY>0,AFTERQTY<$P(PRIMITEM,"^",17) W !,"WARNING -- THE QUANTITY IS LESS THAN THE MINIMUM ISSUE QUANTITY"
 .   I $P(PRIMITEM,"^",25)>0 S %=AFTERQTY/$P(PRIMITEM,"^",25) I $P(%,".",2)>0 W !,"WARNING -- THE QUANTITY IS NOT A CORRECT REQUIRED ISSUE MULTIPLE"
 Q
