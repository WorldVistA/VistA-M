PRCPUITM ;WISC/RFJ-select items utility                             ;10 Dec 91
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ITEM(INVPT,ADDNEW,SCREEN,DEFAULT) ;  select item in inventory point
 ;  addnew=1 to add new items
 ;  screen=additional screen
 ;  default=default item master number
 ;  return itemda; 0 no item selected; ^ for ^ entered or timeout
 ;
 I '$D(^PRCP(445,+INVPT,0)) Q 0
 N %,C,DA,DG,DISYS,DIC,DTOUT,DUOUT,I,PRCPSET,PRCPX,TYPE,X,Y
 S DIC="^PRCP(445,"_INVPT_",1,"
 S DIC(0)="QEAM"_$S(ADDNEW:"L",1:"")
 S DIC("A")="Select "_$P($$INVNAME^PRCPUX1(INVPT),"-",2,99)_" ITEM: "
 S TYPE=$P($G(^PRCP(445,INVPT,0)),"^",3)
 S PRCPSET="I 0"
 ;
 ;  whse screen
 I TYPE="W" S PRCPSET="I $$PURCHASE^PRCPU441(+Y),'$$INACTIVE^PRCPU441(+Y),$$MANDSRCE^PRCPU441(+Y)=$O(^PRC(440,""AC"",""S"",0))"_$G(SCREEN)
 ;
 ;  primary screen
 I TYPE="P" S PRCPSET="I '$$INACTIVE^PRCPU441(+Y)"_$G(SCREEN)
 ;
 ;  secondary screen
 I TYPE="S" S PRCPSET="I '$$INACTIVE^PRCPU441(+Y),$O(^PRCP(445,""AB"","_INVPT_",0))"_$G(SCREEN)_" F PRCPX=0:0 S PRCPX=$O(^PRCP(445,""AB"","_INVPT_",PRCPX)) Q:'PRCPX  I $D(^PRCP(445,PRCPX,1,+Y,0)) Q"
 ;
 S:'$D(^PRCP(445,INVPT,1,0)) ^(0)="^445.01IP^^"
 S DIC("S")=PRCPSET
 S DIC("W")="W ?10,$E($$DESCR^PRCPUX1("_INVPT_",+Y),1,20),?35,""NSN: "",$$NSN^PRCPUX1(+Y)"
 S DA(1)=INVPT
 I DEFAULT S DIC("B")=$$DESCR^PRCPUX1(INVPT,DEFAULT) I DIC("B")="" K DIC("B")
 D ^DIC
 Q $S($G(DUOUT):"^",$G(DTOUT):"^",Y<1:0,1:+Y)
 ;
 ;
MASTITEM(SCREEN) ;  select item from master item file
 ;  screen=optional screen
 ;  return itemda; 0 no item selected; ^ for ^ entered or timeout
 ;
 N %,DDH,DIC,DTOUT,DUOUT,PRCPSET,X,Y
 I $G(SCREEN)'="" S DIC("S")=SCREEN,PRCPSET=SCREEN
 S DIC="^PRC(441,",DIC(0)="QEAM" D ^DIC
 Q $S($G(DUOUT):"^",$G(DTOUT):"^",Y<1:0,1:+Y)
 ;
 ;
GETITEM(INVPT,ITEMDA)          ;  get data for item in invpt
 ;  return data in prcpdata array
 K PRCPDATA
 I '$D(^PRCP(445,+INVPT,1,+ITEMDA,0)) Q
 N %,D0,DA,DIC,DIQ,DIQ2,DR
 S DIC="^PRCP(445,"
 S DR=1,DR(445.01)=".01:99"
 S DA=INVPT,DA(445.01)=ITEMDA
 S DIQ="PRCPDATA",DIQ(0)="E"
 D EN^DIQ1
 Q
 ;
 ;
DELETE(PRCPINPT,ITEMDA) ;  check for deleting item from inventory point
 I $G(^PRCP(445,+PRCPINPT,1,+ITEMDA,0))="" Q
 N %,%H,%I,DATA,DIC,DISTR,DISYS,DUEIN,DUEOUT,INACTIVE,OUTORD,SITE,STRING,TYPE,X,Y
 S DATA=^PRCP(445,PRCPINPT,1,ITEMDA,0)
 I $P(DATA,"^",7) W !!,"QUANTITY ON HAND (",$P(DATA,"^",7),") NEEDS TO BE ADJUSTED TO ZERO." Q
 I $P(DATA,"^",19) W !!,"QUANTITY NON-ISSUABLE (",$P(DATA,"^",19),") NEEDS TO BE ADJUSTED TO ZERO." Q
 S INACTIVE=$P(^PRCP(445,PRCPINPT,0),"^",13)
 I INACTIVE D NOW^%DTC S X1=X,X2=-(INACTIVE*30+1) D C^%DTC I $O(^PRCP(445,PRCPINPT,1,ITEMDA,2,$E(X,1,5)-.1))!($O(^PRCP(445,PRCPINPT,1,ITEMDA,3,X))) D  Q
 . W !!,"ITEM HAS HAD ACTIVITY DURING THE LAST ",INACTIVE," MONTHS."
 S DUEIN=$$GETIN^PRCPUDUE(PRCPINPT,ITEMDA)
 I DUEIN W !,"ITEM HAS DUE-INS: ",DUEIN
 S DUEOUT=$$GETOUT^PRCPUDUE(PRCPINPT,ITEMDA)
 I DUEOUT W !,"ITEM HAS DUE-OUTS: ",DUEOUT
 W !,"Checking to see if this item is on an outstanding order...."
 S OUTORD=$$ORDCHK(ITEMDA,PRCPINPT,"RCE","") I OUTORD D  Q
 . W !,"This item cannot be deleted.  You must first post, delete, or"
 . W !,"remove the item from the following order(s):"
 . D LISTOO(ITEMDA,PRCPINPT)
 S %=$$INVNAME^PRCPUX1(PRCPINPT),SITE=$P(%,"-")
 S XP="ARE YOU SURE YOU WANT TO DELETE THIS ITEM"
 S XP(1)="     FROM THE "_%_" INVENTORY POINT"
 S XH="Enter 'YES' to DELETE this item from the inventory point."
 I $$YN^PRCPUYN(2)'=1 Q
 W !!?5,"--Deleting Item from Inventory Point ..."
 D DELITEM(PRCPINPT,ITEMDA)
 I $P($G(^PRCP(445,PRCPINPT,0)),"^",3)="W" D
 .   D DELETE^PRCPSMS0(ITEMDA)
 .   I STRING("ID")="" W !,"  WARNING--UNABLE TO CREATE ISMS CODE SHEET!" Q
 .   K ^TMP($J,"STRING") S ^TMP($J,"STRING",1)=STRING("ID") D CODESHT^PRCPSMGO(SITE,"IVD","")
 W !!,"Checking Distribution Points (you will have the option to delete the item",!,"from the distribution points if the distribution point is NOT keeping a",!,"perpetual inventory) ..."
 S DISTR="" F  S DISTR=$O(^PRCP(445,PRCPINPT,2,DISTR)) Q:'DISTR  I $P($G(^PRCP(445,DISTR,0)),"^",6)="Y",$D(^PRCP(445,DISTR,1,ITEMDA,0)) W !!,"DISTRIBUTION POINT: ",$P($$INVNAME^PRCPUX1(DISTR),"-",2,99) D
 .   S XP="     OK TO DELETE ITEM FROM THIS DISTRIBUTION POINT",XH="     Enter 'YES' to DELETE the item from the distribution point, '^' to exit."
 .   S %=$$YN^PRCPUYN(2) I '% S DISTR=999999 Q
 .   I %=2 Q
 .   W !!?5,"--Deleting Item from Distribution Point ..." D DELITEM(DISTR,ITEMDA) Q
 Q
 ;
 ;
DELITEM(PRCPINPT,DA) ;  delete item da from inventory point
 N %,DIC,DIK,ITEM,X,Y
 S ITEM=DA
 I $P($G(^PRCP(445,PRCPINPT,5)),"^",1)]"",$P($G(^PRCP(445,PRCPINPT,1,ITEM,0)),"^",9)>0 D BLDSEG^PRCPHLFM(2,ITEM,PRCPINPT) ; send to supply station
 S DA(1)=PRCPINPT,DIK="^PRCP(445,"_DA(1)_",1," D ^DIK
 Q
 ;
ORDCHK(ITEMDA,PRCPINPT,ORDTYP,ORDSTA) ; is the item on any outstanding orders
 ; ITEMDA = DA of item to be deleted, 0 if search is for any order
 ;        for that inventory point.
 ; PRCPINT = DA of inventory point in the search
 ; ORDTYP = search for regular, emergency and/or call-in
 ; ORDSTA = Status of the outstanding order, if search is limited
 ; returns 0 if no outstanding order is found, 1 it it is
 ;
 N ORD,OUTORD,TYPE,XREF
 I '$D(ORDSTA) S ORDSTA=""
 S TYPE=$P($G(^PRCP(445,PRCPINPT,0)),"^",3)
 S XREF=""
 I TYPE="S" S XREF="AD"
 I TYPE="P" S XREF="AC"
 S OUTORD=0
 I XREF]"" D
 . S ORD=0
 . F  S ORD=$O(^PRCP(445.3,XREF,PRCPINPT,ORD)) Q:+ORD'>0!OUTORD  D
 . . I 'ITEMDA,$P(^PRCP(445.3,ORD,0),"^",6)'="P",ORDTYP[($P(^PRCP(445.3,ORD,0),"^",8)) D
 . . . I ORDSTA="" S OUTORD=1
 . . . I ORDSTA]"",$P(^PRCP(445.3,ORD,0),"^",6)[ORDSTA S OUTORD=1
 . . I ITEMDA,$P(^PRCP(445.3,ORD,0),"^",6)'="P",$D(^PRCP(445.3,ORD,1,ITEMDA)),ORDTYP[($P(^PRCP(445.3,ORD,0),"^",8)) D
 . . . I ORDSTA="" S OUTORD=1
 . . . I ORDSTA]"",$P(^PRCP(445.3,ORD,0),"^",6)[ORDSTA S OUTORD=1
 Q (OUTORD)
 ;
LISTOO(ITEM,PRCPINPT,ORDSTA) ; list outstanding orders for this item
 ; ITEM = DA of item to be deleted
 ; PRCPINT = DA of inventory point housing the item
 ; ORDSTA = Status of the outstanding order, if search is limited
 ;
 N ORD,OUTORD,TYPE,XREF
 I '$D(ORDSTA) S ORDSTA=""
 S TYPE=$P($G(^PRCP(445,PRCPINPT,0)),"^",3)
 S XREF=""
 I TYPE="S" S XREF="AD"
 I TYPE="P" S XREF="AC"
 S OUTORD=0
 I XREF]"" D
 . S ORD=0
 . F  S ORD=$O(^PRCP(445.3,XREF,PRCPINPT,ORD)) Q:+ORD'>0  D
 . . I $P(^PRCP(445.3,ORD,0),"^",6)'="P",$D(^PRCP(445.3,ORD,1,ITEM)) D
 . . . S OUTORD=$P(^PRCP(445.3,ORD,0),"^",1)
 . . . I ORDSTA]"",$P(^PRCP(445.3,ORD,0),"^",6)[ORDSTA W !?5,OUTORD
 . . . I ORDSTA="" W !?5,OUTORD
 Q  ; (OUTORD)
