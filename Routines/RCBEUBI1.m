RCBEUBI1 ;WISC/RFJ-utilties for bills (in file 430)                  ;1 Jun 00
 ;;4.5;Accounts Receivable;**169**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DICW ;  write identifier code for bill lookup
 N DATA,DATA6,RCX
 S DATA=$G(^PRCA(430,Y,0)) I DATA="" Q
 S DATA6=$G(^PRCA(430,Y,6))
 ;  category
 W ?12," ",$E($P($G(^PRCA(430.2,+$P(DATA,"^",2),0)),"^")_"               ",1,15)
 ;  date active
 I '$P(DATA6,"^",21) S $P(DATA6,"^",21)="???????"
 W ?35,"  ",$E($P(DATA6,"^",21),4,5),"/",$E($P(DATA6,"^",21),6,7),"/",$E($P(DATA6,"^",21),2,3)
 ;  debtor
 S RCX=$X
 S %=$P(DATA,"^",9)
 I %,$D(^RCD(340,%,0)) S %=U_$P($P(^RCD(340,%,0),"^"),";",2)_+^(0)_",0)",%=$S($D(@%):$P(@%,"^"),1:"")
 W ?46,"  ",$E($S(%="":"NO DEBTOR NAME",1:%),1,$S(RCX<46:20,1:10)_"                    ")
 ;  status
 W ?68,"  ",$E($P($G(^PRCA(430.3,+$P(DATA,"^",8),0)),"^"),1,9)
 Q
 ;
 ;
LOOKUP ;  special lookup on bills, called from ^dd(430,.01,7.5)
 ;  if rcbeflup flag not set, do not use special lookup
 I '$D(RCBEFLUP) Q
 ;  user entered A.? for lookup on active bills
 I X["A."!(X["a.") S DIC("S")="I $P(^(0),U,8)=16" S X="?" Q
 ;  user entered S.? for lookup on suspended bills
 I X["S."!(X["s.") S DIC("S")="I $P(^(0),U,8)=40" S X="?" Q
 ;  user entered O.? for lookup on open bills
 I X["O."!(X["o.") S DIC("S")="I $P(^(0),U,8)=42" S X="?" Q
 ;  user entered N.? for lookup on new bills
 I X["N."!(X["n.") S DIC("S")="I $P(^(0),U,8)=18" S X="?" Q
 ;  user entered R.? for lookup on refund review bills
 I X["R."!(X["r.") S DIC("S")="I $P(^(0),U,8)=44" S X="?" Q
 K DIC("S")
 Q
