RCDPRSEA ;WISC/RFJ-extended search ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148,208**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N DATEEND,DATESTRT,RCTRACE,RCCHECK,RCCREDIT,RCSEARCH,RCTYPE,%ZIS,ZTSAVE,ZTDESC,ZTQUEUED,ZTRTN,POP
 ;  search check or credit card
 W !
 S RCSEARCH=$$ASKSEA
 I RCSEARCH<1 Q
 ;
 ;  check to search for
 I RCSEARCH=1 S RCCHECK=$$ASKCHEK^RCDPLPL1 I RCCHECK=-1 Q
 ;  credit card to search for
 I RCSEARCH=2 S RCCREDIT=$$ASKCRED^RCDPLPL1 I RCCREDIT=-1 Q
 ;  ask contains or equals
 S RCTYPE=$$ASKTYPE^RCDPLPL1 I RCTYPE=-1 Q
 S RCTYPE=$E(RCTYPE)
 ;
 ;  trace # to search for
 I RCSEARCH=3 S RCTRACE=$$ASKTRACE^RCDPLPL1 I RCTRACE=-1 Q
 ;
 ;  ask receipt open dates
 W !
 D DATESEL^RCRJRTRA("RECEIPT Opened")
 I '$G(DATESTRT)!('$G(DATEEND)) Q
 ;
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS I POP Q
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Extended Check/Trace#/Credit Card Search",ZTRTN="DQ^RCDPRSEA"
 .   S ZTSAVE("RC*")="",ZTSAVE("DATE*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;  queue starts here
 N %,%I,DATA,DATEDIS1,DATEDIS2,NOW,PAGE,RCRECTDA,RCRJFLAG,RCRJLINE,RCTRANDA,SCREEN,X,Y
 ;  print report
 S Y=$P(DATESTRT,".") D DD^%DT S DATEDIS1=Y
 S Y=$P(DATEEND,".") D DD^%DT S DATEDIS2=Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S PAGE=1,RCRJLINE="",$P(RCRJLINE,"-",81)=""
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO D H
 S RCRECTDA=99999999999999
 F  S RCRECTDA=$O(^RCY(344,RCRECTDA),-1) Q:'RCRECTDA!($G(RCRJFLAG))  D
 .   S DATA=$G(^RCY(344,RCRECTDA,0))
 .   I $P(DATA,"^",3)<DATESTRT Q
 .   I $P($P(DATA,"^",3),".")>DATEEND Q
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^RCY(344,RCRECTDA,1,RCTRANDA)) Q:'RCTRANDA!($G(RCRJFLAG))  D
 .   .   I SCREEN R X:0 I X["^" S RCRJFLAG=1 Q
 .   .   S DATA=$G(^RCY(344,RCRECTDA,1,RCTRANDA,0))
 .   .   ;  check search
 .   .   I RCSEARCH=1 D  Q
 .   .   .   I RCTYPE="E",$P(DATA,"^",7)'=RCCHECK Q    ;equals
 .   .   .   I $P(DATA,"^",7)'[RCCHECK Q               ;contains
 .   .   .   D DISPLAY
 .   .   ;  trace # search
 .   .   I RCSEARCH=3 D  Q
 .   .   .   N RCNUM
 .   .   .   S RCNUM=$$TRACE(RCRECTDA)
 .   .   .   I RCTYPE="E",RCNUM'=RCTRACE Q    ;equals
 .   .   .   I RCNUM'[RCTRACE Q               ;contains
 .   .   .   D DISPLAY
 .   .   ;  credit card search
 .   .   I RCTYPE="E",$P(DATA,"^",11)'=RCCREDIT Q    ;equals
 .   .   I $P(DATA,"^",11)'[RCCREDIT Q               ;contains
 .   .   D DISPLAY
 ;
 I '$G(RCRJFLAG),SCREEN U IO(0) R !,"Press RETURN to continue:",%:DTIME
 D ^%ZISC
 Q
 ;
 ;
DISPLAY ;  display the payment
 I $Y>(IOSL-6) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  W @IOF D H
 ;
 N ACCOUNT,DATA,DATA1
 S DATA=$G(^RCY(344,RCRECTDA,0)),DATA1=DATA
 ;  receipt
 W !,$P(DATA,"^")
 ;  date opened
 W ?13,$E($P(DATA,"^",3),4,5),"/",$E($P(DATA,"^",3),6,7),"/",$E($P(DATA,"^",3),2,3)
 ;  transaction number
 W ?24,RCTRANDA
 S DATA=$G(^RCY(344,RCRECTDA,1,RCTRANDA,0))
 ;  account
 S ACCOUNT=$P(DATA,"^",3)
 I ACCOUNT["PRCA(430," S ACCOUNT=$P($G(^PRCA(430,+$P(DATA,"^",3),0)),"^")
 I ACCOUNT["DPT(" S ACCOUNT=$P($G(^DPT(+$P(DATA,"^",3),0)),"^")
 W ?30,$E(ACCOUNT,1,24)
 ;  amount
 W ?54,$J($P(DATA,"^",4),8,2)
 ;  check/trace/credit card number
 W $J($S(RCSEARCH=1:$P(DATA,"^",7),RCSEARCH=2:$P(DATA,"^",11),1:$$TRACE(RCRECTDA)),18)
 Q
 ;
 ;
H ;  header
 S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"EXTENDED CHECK/TRACE #/CREDIT CARD SEARCH",?(80-$L(%)),%
 W !,"  FOR THE DATE RANGE: ",DATEDIS1,"  TO  ",DATEDIS2
 W !,"       SEARCHING FOR: "
 W $S(RCSEARCH=1:"CHECK ",RCSEARCH=2:"CREDIT CARD ",1:"TRACE # ")
 W $S(RCTYPE="E":"EQUALS ",1:"CONTAINS ")
 W $G(RCCHECK),$G(RCTRACE),$G(RCCREDIT)
 W !,"RECEIPT",?13,"OPENDATE",?24,"TRANS",?30,"ACCOUNT",?54,$J("AMOUNT",8),$J($S(RCSEARCH=1:"CHECK#",RCSEARCH=2:"CREDITCARD#",1:"TRACE#"),18)
 W !,RCRJLINE
 I SCREEN W !!?10,"********** PRESS ^ at anytime to STOP search **********"
 Q
 ;
 ;
TRACE(RCRECTDA) ; Returns the trace # on a receipt
 N DATA
 S DATA=$G(^RCY(344,RCRECTDA,0))
 Q $S($P(DATA,U,18):$P($G(^RCY(344.4,+$P(DATA,"^",18),0)),U,2),$P(DATA,U,17):$P($G(^RCY(344.31,+$P(DATA,U,17),0)),U,4),1:"")
 ;
ASKSEA() ;  ask search field
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SAO^1:Check;2:Credit Card;3:Trace #;"
 S DIR("A")="Search for Check, Trace #, or Credit Card: "
 S DIR("B")="Check"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
