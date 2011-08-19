PRCPCDIR ;WISC/RFJ-disassemble cc or ik (print items)               ;01 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PRINT(ITEMDA,QUANTITY) ;  print items to disassemble
 ;  returns variable notinvpt=1 if items not stored in inventory point
 ;  returns variable prcpflag=1 if user ^ during display
 ;  returns ^tmp($j,"prcpcdir",itemda)=qty needed ^ inventory value
 N %,CCIKITEM,DATA,INVVAL,ITEMDATA,NEWQTY,REUSABLE,SCREEN
 K ^TMP($J,"PRCPCDIR"),NOTINVPT,PRCPFLAG
 W ! D H
 S SCREEN=1,CCIKITEM=0 F  S CCIKITEM=$O(^PRCP(445,PRCP("I"),1,ITEMDA,8,CCIKITEM)) Q:'CCIKITEM!($G(PRCPFLAG))  S DATA=$P(^(CCIKITEM,0),"^",2)*QUANTITY D
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,CCIKITEM,0))
 .   I ITEMDATA'="",$P(ITEMDATA,"^",7)="" S $P(ITEMDATA,"^",7)=0
 .   I ITEMDATA="" S $P(ITEMDATA,"^",7)="Not in InvPt" S NOTINVPT=1
 .   S INVVAL=$J($S('$P(ITEMDATA,"^",7):0,1:$P(ITEMDATA,"^",27)/$P(ITEMDATA,"^",7))*DATA,0,3)
 .   S NEWQTY=$P(ITEMDATA,"^",7)+DATA
 .   W !,CCIKITEM,?7,$E($$DESCR^PRCPUX1(PRCP("I"),CCIKITEM),1,22),?44,$J($P(ITEMDATA,"^",7),13),$J(DATA,10),$J(NEWQTY,13)
 .   S ^TMP($J,"PRCPCDIR",CCIKITEM)=DATA_"^"_INVVAL
 .   S SCREEN=SCREEN+1
 .   I SCREEN'<IOSL D P^PRCPUREP Q:$D(PRCPFLAG)  D H S SCREEN=1
 Q
 ;
 ;
H ;  display header on display
 W !?44,$J("CURRENT",13),$J("QTY",10),$J("** NEW **",13),!,"IM#",?7,"DESCRIPTION",?44,$J("QTY ON-HAND",13),$J("NEEDED",10),$J("QTY ON-HAND",13)
 S %="",$P(%,"-",81)="" W !,%
 Q
