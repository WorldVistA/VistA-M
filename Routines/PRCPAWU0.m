PRCPAWU0 ;WISC/RFJ-adjustment utilities                             ;11 Mar 94
 ;;5.1;IFCAP;**124**;Oct 20, 2000;Build 2
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ITEM() ;  select item from tmp($j,"prcpawap","item",*itemnumber*) global
 N %,COUNT,ITEMDA,PRCPFLAG,X
 F  D  Q:ITEMDA'=""
 .   W !,"  Select ITEM: "
 .   R X:DTIME I '$T!(X["^")!(X="") S ITEMDA="^" Q
 .   I $D(^TMP($J,"PRCPAWAP","ITEM",+X)) S ITEMDA=+X Q
 .   S ITEMDA=""
 .   W !,"Select the ITEM NUMBER from the list below:",!
 .   S COUNT=0,X="" F  S X=$O(^TMP($J,"PRCPAWAP","ITEM",X)) Q:X=""!($G(PRCPFLAG))  D
 .   .   W "  ITEM NUMBER: ",X,?23,$E($$DESCR^PRCPUX1(PRCP("I"),+X),1,30),?58,"NSN: ",$$NSN^PRCPUX1(+X) S COUNT=COUNT+1
 .   .   I COUNT#20=0 D P^PRCPUREP S %="",$P(%," ",80)="" W $C(13),%
 .   .   W !
 Q ITEMDA
 ;
 ;
VOUCHER() ;  enter reference voucher number
 N DIR,X,Y
 S DIR(0)="FA^5:5",DIR("A")="  VOUCHER NUMBER: ",DIR("A",1)="  >> Enter DOCUMENT IDENTIFIER number. <<"
 D ^DIR
 Q Y
 ;
 ;
QTY(LOW,HIGH) ;  adjust quantity from low to high
 ;  return qty, qty=^ for ^ entered
 N DIR,X,Y
 S DIR(0)="NA^"_LOW_":"_HIGH_":0",DIR("A")="  ADJUSTED QUANTITY: ",DIR("B")=0
 S DIR("A",1)="  >> Enter the adjusted quantity in the range "_LOW_" to "_HIGH_". <<"
 D ^DIR
 Q Y
 ;
 ;
VALUE(LOW,HIGH,PROMPT,DEFAULT) ;  adjust value from low to high
 ;  ask in prompt with default value
 N DIR,X,Y
 S DIR(0)="NAO^"_LOW_":"_HIGH_":2",DIR("A")="  ADJUSTED TOTAL"_PROMPT_" VALUE: " S:DEFAULT'="" DIR("B")=DEFAULT
 S DIR("A",1)="  >> Enter the adjusted value in the range "_LOW_" to "_HIGH_". <<"
 D ^DIR
 Q Y
 ;
 ;
REASON(DEFAULT,NODISV) ;  enter reason text
 ;NODISV=1 will stop default reason from ^DISV
 N DIR,REASON,X,Y
 I DEFAULT="",'$G(NODISV) S REASON=$G(^DISV(+$G(DUZ),"PRCPAWU0","REASON"))
 S DIR(0)="F^1:80",DIR("A")="  REASON TEXT",DIR("B")=$S(DEFAULT=""&'$G(NODISV):$G(REASON),1:DEFAULT)
 S DIR("A",1)="  >> Enter the reason text which will appear on the transaction register. <<"
 D ^DIR
 I (DEFAULT=""&'$G(NODISV)),Y'["^" S ^DISV(DUZ,"PRCPAWU0","REASON")=Y
 Q Y
