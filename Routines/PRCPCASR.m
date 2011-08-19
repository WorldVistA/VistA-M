PRCPCASR ;WISC/RFJ-assemble cc or ik (print list of items)          ;01 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PRINT(QUANTITY) ;  print list of items in cc or ik
 ;  quantity=qty to assemble
 ;  returns variable notinvpt=1 if items not stored in inventory point
 ;  returns variable negative=1 if new item qty drops below zero
 ;  returns variable prcpflag=1 if user ^ during display
 ;  returns ^tmp($j,"prcpcasr",itemda)=qty needed ^ inventory value
 N %,DATA,INVVAL,ITEMDA,ITEMDATA,NEWQTY,REUSABLE,SCREEN
 K ^TMP($J,"PRCPCASR"),NEGATIVE,NOTINVPT,PRCPFLAG
 W ! D H
 S SCREEN=1,ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPLIST",ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S DATA=^(ITEMDA)*QUANTITY D
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   I ITEMDATA'="",$P(ITEMDATA,"^",7)="" S $P(ITEMDATA,"^",7)=0
 .   I ITEMDATA="" S $P(ITEMDATA,"^",7)="Not in InvPt" S NOTINVPT=1
 .   S INVVAL=$J($S('$P(ITEMDATA,"^",7):0,1:$P(ITEMDATA,"^",27)/$P(ITEMDATA,"^",7))*DATA,0,3)
 .   S NEWQTY=$P(ITEMDATA,"^",7)-DATA
 .   S REUSABLE=$$REUSABLE^PRCPU441(ITEMDA)
 .   I REUSABLE S NEWQTY=$P(ITEMDATA,"^",7)
 .   I 'REUSABLE,NEWQTY<0 S NEGATIVE=1
 .   W !,ITEMDA,?7,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,22),?30,$S(REUSABLE=1:"Reusable",1:"Disposable"),?44,$J($P(ITEMDATA,"^",7),13),$J(DATA,10),$J(NEWQTY,13)
 .   I 'REUSABLE,DATA S ^TMP($J,"PRCPCASR",ITEMDA)=DATA_"^"_INVVAL
 .   S SCREEN=SCREEN+1
 .   I SCREEN'<IOSL D P^PRCPUREP Q:$D(PRCPFLAG)  D H S SCREEN=1
 Q
 ;
 ;
H ;  display header on display
 W !?44,$J("CURRENT",13),$J("QTY",10),$J("** NEW **",13),!,"IM#",?7,"DESCRIPTION",?30,"ITEM TYPE",?44,$J("QTY ON-HAND",13),$J("NEEDED",10),$J("QTY ON-HAND",13)
 S %="",$P(%,"-",81)="" W !,%
 Q
 ;
 ;
CHECK(TYPE) ;  called from prcpcasc,prcpcask to check the ik or cc definition
 ;  before assembly
 ;  type=c for case cart or =i for instrument kit
 S TYPE=$S(TYPE="C":"case cart",1:"instrument kit")
 N CCIKITEM,PRCPITEM,X
 S CCIKITEM=0,PRCPITEM=0
 F  S CCIKITEM=$O(^TMP($J,"PRCPLIST-DISP",CCIKITEM)),PRCPITEM=$O(^PRCP(445,PRCP("I"),1,ITEMDA,8,PRCPITEM)) Q:'CCIKITEM&('PRCPITEM)  D  Q:$G(PRCPFLAG)
 .   I CCIKITEM'=PRCPITEM S PRCPFLAG=1 Q
 .   I $G(^TMP($J,"PRCPLIST-DISP",CCIKITEM))'=+$P($G(^PRCP(445,PRCP("I"),1,ITEMDA,8,PRCPITEM,0)),"^",2) S PRCPFLAG=1 Q
 I '$G(PRCPFLAG) Q
 K X S X(1)="WARNING -- This "_TYPE_" is assembled in the inventory point (quantity on-hand equals "_$P($G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),"^",7)_").  Since being assembled, the "_TYPE_" definition has been changed."
 S X(2)="Assembling another "_TYPE_" under the new definition will cause quantity differences with items stored under the "_TYPE_"."
 S X(3)="Please disassemble the "_TYPE_" item, leaving 0 quantity on-hand, before assembling additional "_TYPE_"s for this item."
 D DISPLAY^PRCPUX2(20,60,.X)
 Q
