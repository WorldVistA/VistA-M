PRCPCUT1 ;WISC/RFJ-case cart & instrument kit utilities ; 06/23/2009  2:09 PM
 ;;5.1;IFCAP;**136**;Oct 20, 2000;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
FILENUMB(ITEMDA) ;  return file number for item
 I $D(^PRCP(445.7,+ITEMDA,0)) Q 445.7
 I $D(^PRCP(445.8,+ITEMDA)) Q 445.8
 Q 0
 ;
 ;
CHECK(INVPT,NOWRITE) ;  check inventory point keeping perpetual and history
 ;  if $g(nowrite)=1 do not write information on screen
 ;  return 1 if keep perpetual or keep tran reg is no
 N %,PRCPFLAG
 S %=$G(^PRCP(445,+INVPT,0)),PRCPFLAG=0
 I $P(%,"^",2)'="Y" W:'$G(NOWRITE) !,"INVENTORY POINT HAS TO BE 'KEEPING A PERPETUAL INVENTORY'." S PRCPFLAG=1
 I $P(%,"^",6)'="Y" W:'$G(NOWRITE) !,"INVENTORY POINT HAS TO BE 'KEEPING A DETAILED TRANSACTION HISTORY'." S PRCPFLAG=1
 Q PRCPFLAG
 ;
 ;
ADDCCIK(INVPT,CCIKITEM,ITEMDA,QUANTITY) ;  add case cart or instrument kit
 ;  add itemda to ccikitem in invpt with quantity
 N D0,DA,DD,DI,DIC,DIE,DLAYGO,DQ,DR,X,Y
 I '$D(^PRCP(445,+INVPT,1,+CCIKITEM,0)) Q
 I '$D(^PRCP(445,+INVPT,1,+CCIKITEM,8,0)) S ^(0)="^445.121IP^^"
 S DIC="^PRCP(445,"_INVPT_",1,"_CCIKITEM_",8,",DIC(0)="L",DLAYGO=445,DA(2)=INVPT,DA(1)=CCIKITEM,(X,DINUM)=ITEMDA
 S DIC("DR")="1////"_QUANTITY
 D FILE^DICN
 Q
 ;
 ;
GETDEF(FILE,ITEMDA) ;  get definition of items in cc (file=445.7) or ik (file=445.8)
 ;  return:
 ;  ^tmp($j,"prcplist",itemda)=qty      <- both reusable and disposable
 ;  ^tmp($j,"prcplist-disp",itemda)=qty <- disposables only
 N %,QTY
 K ^TMP($J,"PRCPLIST"),^TMP($J,"PRCPLIST-DISP")
 S %=0 F  S %=$O(^PRCP(FILE,ITEMDA,1,%)) Q:'%  S QTY=+$P($G(^PRCP(FILE,ITEMDA,1,%,0)),"^",2),^TMP($J,"PRCPLIST",%)=QTY I '$$REUSABLE^PRCPU441(%) S ^TMP($J,"PRCPLIST-DISP",%)=QTY
 Q
 ;
 ;
QUANTITY(HIGHNUM,TYPE) ;  enter quantity to assemble or disassemble
 ;  highnum=high range
 ;  type='A'ssemble or 'D'isassemble
 N DIR,X,Y
 S DIR(0)="NA^0:"_HIGHNUM_":0",DIR("A")="  QUANTITY TO "_$S(TYPE="A":"ASSEMBLE",1:"DISASSEMBLE")_": ",DIR("B")=1
 S DIR("A",1)="Enter the quantity of case carts to "_$S(TYPE="A":"assemble",1:"disassemble")_" from 0 to "_HIGHNUM_"."
 D ^DIR K DIR
 Q $S(Y<1:0,1:+Y)
 ;
 ;da - ien of file #81
 ;prcdt - fileman date (or date.time)
ICPT(DA,PRCDT) ;  ef - return icpt code and name
 QUIT $P($$CPT^ICPTCOD(DA,$G(PRCDT),"",""),U,2,3)
