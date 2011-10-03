RMPRPIY5 ;HINCIO/ODJ - PIP Data fields - Prompts ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;SRC - Prompt for Source - V for VA (used), C for Commercial
SRC(RMPRSRC,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA
 S RMPRSRC=$G(RMPRSRC)
 S RMPRERR=0
 S DIR(0)="661.11,4"
 S DIR("A")="SOURCE"
 S DIR("B")=$S(RMPRSRC="":"C",1:RMPRSRC)
 S DIR("?")="^D SRCH^RMPRPIY5"
RESRC D ^DIR
 I $D(DTOUT) S RMPREXC="T" G SRCX
 I $D(DIROUT) S RMPREXC="P" G SRCX
 I X="" G RESRC
 I (X["^")!($D(DUOUT)) S RMPREXC="^" G SRCX
 S RMPRSRC=Y
 S RMPREXC=""
SRCX Q
SRCH W "If the item is USED, type in 'V' for VA."
 W !,"If the item is NEW, type in 'C' for COMMERCIAL."
 Q
 ;
 ;***** QTY - Prompt for Quantity (Invoice not on hand)
QTY(RMPRQTY,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA
 S RMPRQTY=$G(RMPRQTY)
 S RMPRERR=0
 S DIR(0)="NAO^0:99999:0"
 S DIR("A")="INVOICE QUANTITY: "
 S:RMPRQTY'="" DIR("B")=RMPRQTY
 S DIR("??")="^D QTYHH^RMPRPIY5"
REQTY D ^DIR
 I $D(DTOUT) S RMPREXC="T" G QTYX
 I $D(DIROUT) S RMPREXC="P" G QTYX
 I X="" G REQTY
 I (X["^")!($D(DUOUT)) S RMPREXC="^" G QTYX
 S RMPREXC=""
 S RMPRQTY=+Y
QTYX Q
QTYHH W "Type in the item quantity you are receiving into stock.",!
 W "This quantity should match that on the paper record of the receipt",!
 W "such as an invoice or delivery note, it is not the same as the",!
 W "quantity on hand. To correct on hand quantities you should use the",!
 W "reconciliation option.",!
 W "Please make sure you create separate receipts if you are receiving",!
 W "the same item from different vendors or at different costs."
 Q
 ;
 ;***** UCST - prompt for Unit Cost
UCST(RMPRUCST,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA
 S RMPRUCST=$G(RMPRUCST)
 S RMPRERR=0
 S RMPREXC=""
 S DIR(0)="NOA^0:99999:6"
 S DIR("A")="UNIT COST: "
 S DIR("??")="^D UCSTHH^RMPRPIY5"
 S:RMPRUCST'="" DIR("B")=RMPRUCST
REUCST D ^DIR
 I $D(DTOUT) S RMPREXC="T" G SRCX
 I $D(DIROUT) S RMPREXC="P" G SRCX
 I X="" G REUCST
 I X["^"!($D(DUOUT)) S RMPREXC="^" G SRCX
 S RMPRUCST=+Y
UCSTX Q
UCSTHH W "Type in the dollar cost per item."
 W !,"If you would prefer to enter the total dollar value for the"
 W !,"item quantity you have just typed in, then type in 0 here."
 Q
 ;
 ;***** TVAL - Prompt for total $ value
TVAL(RMPRTVAL,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA
 S RMPRTVAL=$G(RMPRTVAL)
 S RMPRERR=0
 S RMPREXC=""
 S DIR(0)="NOA^0:999999:2"
 S DIR("A")="TOTAL COST OF QUANTITY: "
 S:RMPRTVAL'="" DIR("B")=RMPRTVAL
 S DIR("??")="^D TVALHH^RMPRPIY5"
RETVAL D ^DIR
 I $D(DTOUT) S RMPREXC="T" G TVALX
 I $D(DIROUT) S RMPREXC="P" G TVALX
 I X["^" S RMPREXC="^" G TVALX
 I X="" G RETVAL
 S RMPRTVAL=+Y
TVALX Q
TVALHH W "Type in the total dollar value or cost (excluding freight)"
 W !,"of the item quantity you have entered above."
 Q
 ;
 ;***** REO - Prompt for Re-Order Level
REO(RMPRREO,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA
 S RMPRREO=$G(RMPRREO)
 S RMPRERR=0
 S RMPREXC=""
 S DIR(0)="NOA^0:99999:0"
 S DIR("A")="RE-ORDER LEVEL: "
 S:RMPRREO'="" DIR("B")=RMPRREO
 S DIR("??")="^D REOHH^RMPRPIY5"
REREO D ^DIR
 I $D(DTOUT) S RMPREXC="T" G REOX
 I $D(DIROUT) S RMPREXC="P" G REOX
 I X="" G REREO
 I (X["^")!($D(DUOUT)) S RMPREXC="^" G REOX
 S RMPRREO=+Y
REOX Q
REOHH W "Type in a number that signifies the quantity on hand of an item,"
 W !,"at a particular location, below which the item should be ordered."
 Q
 ;
 ;***** VEND - prompt for Vendor
VEND(RMPRVEND,RMPREXC) ;
 N RMPRERR,DIC,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA
 S RMPRVEND=$G(RMPRVEND("IEN"))
 S RMPRERR=0
 S DIC=440
 S DIC(0)="AEQM"
 S DIC("A")="VENDOR: "
 I RMPRVEND'="" S DIC("B")=RMPRVEND
REVEND D ^DIC
 I $D(DTOUT) S RMPREXC="T" G VENDX
 I $D(DIROUT)!(X["^^") S RMPREXC="P" G VENDX
 I X="" G REVEND
 I (X["^")!($D(DUOUT))!(+Y=-1) S RMPREXC="^" G VENDX
 S RMPREXC=""
 S RMPRVEND("IEN")=$P(Y,"^",1)
 S RMPRVEND("NAME")=$P(Y,"^",2)
VENDX Q
 ;
 ;***** UNIT - prompt for unit of issue
UNIT(RMPRUNI,RMPREXC) ;
 N RMPRERR,DIC,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA
 S RMPRUNI=$G(RMPRUNI("IEN"))
 S RMPRERR=0
 S DIC=420.5
 S DIC(0)="AEQM"
 S DIC("A")="UNIT OF ISSUE: "
 I RMPRUNI'="" S DIC("B")=RMPRUNI
UNITD D ^DIC
 I $D(DTOUT) S RMPREXC="T" G UNITX
 I $D(DIROUT)!(X["^^") S RMPREXC="P" G UNITX
 I X="" G UNITD
 I (X["^")!($D(DUOUT))!(+Y=-1) S RMPREXC="^" G UNITX
 S RMPREXC=""
 S RMPRUNI("IEN")=$P(Y,"^",1)
 S RMPRUNI("NAME")=$P(Y,"^",2)
UNITX Q
