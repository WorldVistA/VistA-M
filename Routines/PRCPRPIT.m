PRCPRPIT ;WISC/RFJ-reprint picking ticket from tr ;9.9.97
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N DA,DATA,PRCPFREP,PRCPNAME,PRCPORD,PRCPPOST,PRCPTRID,PRCPTRNO,PRCPUSER,Y
 S DA=$$SELECT^PRCPUTRS(PRCP("I")) I 'DA Q
 S DATA=^PRCP(445.2,DA,0),PRCPTRID=$P(DATA,"^",2),PRCPNAME=$P($$INVNAME^PRCPUX1($P(DATA,"^",18)),"-",2,99),Y=$P(DATA,"^",17) D DD^%DT S PRCPPOST=Y,PRCPUSER=$$USER^PRCPUREP($P(DATA,"^",16)),PRCPORD=$P(DATA,"^",15),PRCPTRNO=$P(DATA,"^",19)
 W !!,"TRANSACTION NUMBER: ",PRCPTRNO,?40,"DATE DISTRIBUTED: ",Y,!?40,"INVENTORY POINT : ",$E(PRCPNAME,1,23)
 S PRCPFREP=1
 ;
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Reprint Picking Ticket (Whse to Primary)",ZTRTN="DQ^PRCPRPIT"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ZTREQ")="@"
 ;
DQ ;  queue comes here
 ;  prcptrno = transaction number (file 410)
 ;  prcptrid = transaction register id
 ;  prcpname = inventory point to post to
 ;  prcpord  = voucher number
 ;  prcpuser = user posting issue book
 ;  prcpfrep = 1 for reprint
 N %,COSTCNTR,DA,DATA,DATEREQ,DELPT,ITEMDA,NSN,INVCOST,INVDATA,STORLOC,QTY,SUBACCT,TOTCOST,TRANDA,WHSESRCE,X,Y
 K ^TMP($J,"PRCPRPIR")
 S TRANDA=+$O(^PRCS(410,"B",PRCPTRNO,0))
 S DELPT=$P($G(^PRCS(410,TRANDA,9)),"^"),Y=+$P($G(^PRCS(410,TRANDA,1)),"^",4) D DD^%DT S DATEREQ=$S(Y=0:"",1:Y)
 S COSTCNTR=+$P($G(^PRCS(410,TRANDA,3)),"^",3),COSTCNTR=+$S($D(^PRCD(420.1,COSTCNTR,0)):$P(^(0),"^"),1:COSTCNTR)
 S WHSESRCE=+$O(^PRC(440,"AC","S",0))
 S DA=0 F  S DA=$O(^PRCP(445.2,"C",PRCPTRNO,DA)) Q:'DA  S DATA=$G(^PRCP(445.2,DA,0)),ITEMDA=+$P(DATA,"^",5) I ITEMDA,$P(DATA,"^",2)=PRCPTRID D
 .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" "
 .   S INVDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),STORLOC=$$STORELOC^PRCPESTO($P(INVDATA,"^",6))
 .   S QTY=$P(DATA,"^",7) S:QTY<0 QTY=QTY*-1
 .   S TOTCOST=-$P(DATA,"^",23),INVCOST=-$P(DATA,"^",22)
 .   I '+$P(INVDATA,"^",25) S $P(INVDATA,"^",25)=1 I WHSESRCE S %=+$P($G(^PRC(441,ITEMDA,2,WHSESRCE,0)),"^",11) I % S $P(INVDATA,"^",25)=%
 .   I $D(^TMP($J,"PRCPRPIR",STORLOC,NSN,ITEMDA)) S %=^(ITEMDA),$P(%,"^",9)=$P(%,"^",9)+QTY,$P(%,"^",10)=$P(%,"^",10)+INVCOST,$P(%,"^",11)=$J($P(%,"^",11)+TOTCOST,0,2),^(ITEMDA)=% Q
 .   S %=ITEMDA_"^"_NSN_"^"_STORLOC_"^"_$$DESCR^PRCPUX1(PRCP("I"),ITEMDA)_"^"_$P(INVDATA,"^",7)_"^"_$J($$UNITVAL^PRCPUX1($P(INVDATA,"^",14),$P(INVDATA,"^",5)," per "),13)
 .   S SUBACCT=$P($G(^PRCS(410,TRANDA,"IT",+$P(DATA,"^",24),0)),"^",4) I SUBACCT="" S SUBACCT=$$SUBACCT^PRCPU441(ITEMDA)
 .   ;  xx=qty ordered
 .   S ^TMP($J,"PRCPRPIR",STORLOC,NSN,ITEMDA)=%_"^"_$P(INVDATA,"^",25)_"^XX^"_QTY_"^"_INVCOST_"^"_$J(TOTCOST,0,2)_"^"_COSTCNTR_"/"_SUBACCT_"^"_$$ACCT1^PRCPUX1($P(NSN,"-"))
 D PICK^PRCPRPIR Q
