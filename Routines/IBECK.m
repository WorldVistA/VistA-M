IBECK ;ALB/AAS - INTEGRATED BILLING CHECK IF FILER RUNNING ; 8-MAY-91
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN N X,Y,I S IBFLAG="" G:'$D(^IB("APOST")) END
 S IBCNT=0,IBI="" F  S IBI=$O(^IB("APOST",IBI)) Q:'IBI  S IBCNT=IBCNT+1 I IBCNT>11 S IBFLAG=1
 ;
NOT S IBPARM=$G(^IBE(350.9,1,0))
 I '$P(IBPARM,"^",4)&('$P(IBPARM,"^",10)) S IBFLAG=IBFLAG_"2"
LAST S X=$P(IBPARM,"^",6) D H^%DTC
 I $P(IBPARM,"^",6),+$H'=+%H!(%T+(2200*(+$P(IBPARM,"^",8)))<$P($H,",",2)) S IBFLAG=IBFLAG_"3"
 ;
END K IBCNT,IBI,%T,%H,IBPARM
 Q
 ;
1 W !,"The Integrated Billing filer has more than 10 transactions in the queue." Q
2 W !,"The Integrated Billing filer is not running and has transactions to file." Q
3 W !,"The Integrated Billing filer is late.  It hasn't run since " S Y=$P(^IBE(350.9,1,0),"^",6) D D^DIQ W Y Q
 ;
MENU ;  -menu entry action
 D EN
 I IBFLAG'="" W !,*7 F I=1,2,3 I IBFLAG[I D @I
 K IBFLAG,IBPARM,Y,I G END
