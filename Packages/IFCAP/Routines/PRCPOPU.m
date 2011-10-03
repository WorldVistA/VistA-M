PRCPOPU ;WISC/RFJ,DWA-distibution order utilities                      ;27 Sep 93
 ;;5.1;IFCAP;**27**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
VARIABLE ;  set up order variables for orderda
 N DFN,VADM,VAERR
 S PRCPORD(0)=$G(^PRCP(445.3,ORDERDA,0)),PRCPORD(2)=$G(^PRCP(445.3,ORDERDA,2))
 S PRCPPRIM=+$P(PRCPORD(0),"^",2),PRCPSECO=+$P(PRCPORD(0),"^",3),PRCPPAT=+$P(PRCPORD(2),"^")
 S $P(PRCPORD(0),"^",2)=$$INVNAME^PRCPUX1(PRCPPRIM)
 S $P(PRCPORD(0),"^",3)=$$INVNAME^PRCPUX1(PRCPSECO)
 S DFN=PRCPPAT I $$VERSION^XPDUTL("DG") D DEM^VADPT
 S $P(PRCPORD(2),"^")=$G(VADM(1))
 Q
 ;
 ;
DUEOUTIN(PRCPPRIM,PRCPSECO,ITEMDA,QTY,PRINT)          ;
 ;  update the primary prcpprim itemda dueouts by qty (- to subtract);
 ;  update the secondary prcpseco itemda dueins by qty*conv
 ;  print=1 to display message
 N %
 ;
 I PRINT W !!,"<*> Updating DUE-OUTS in primary   ",$$INVNAME^PRCPUX1(PRCPPRIM),?60," by ",QTY
 D SETOUT^PRCPUDUE(PRCPPRIM,ITEMDA,QTY)
 ;
 S QTY=QTY*$P($$GETVEN^PRCPUVEN(PRCPSECO,ITEMDA,PRCPPRIM_";PRCP(445,",1),"^",4)
 I PRINT W !,"<*> Updating DUE-INS  in secondary ",$$INVNAME^PRCPUX1(PRCPSECO),?60," by ",QTY
 D SETIN^PRCPUDUE(PRCPSECO,ITEMDA,QTY)
 Q
 ;
 ;
STATUS(ORDERDA)    ;  return status of order
 N %
 S %=$P($G(^PRCP(445.3,+ORDERDA,0)),"^",6) I %'="" S %=$P($P($P(^DD(445.3,5,0),"^",3),%_":",2),";")
 I %="" S %="<< NOT RELEASED >>"
 Q %
 ;
 ;
TYPE(ORDERDA) ;  return type of order
 N %
 S %=$P($G(^PRCP(445.3,+ORDERDA,0)),"^",8) I %'="" S %=$P($P($P(^DD(445.3,3.5,0),"^",3),%_":",2),";")
 I %="" S %="<< NO TYPE >>"
 Q %
