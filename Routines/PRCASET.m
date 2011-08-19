PRCASET ;SF-ISC/YJK-SETUP A NEW ACCOUNTS RECEIVABLE ;4/1/96  2:24 PM
 ;;4.5;Accounts Receivable;**16,25,40,51,67,158,153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This sets up a new account for A/R. The account is classified
 ;with category.
 ;
 ;======================= SET UP NEW AR ==============================
SETBIL K PRCABT D CKSITE^PRCAUDT Q:('$D(PRCA("CKSITE")))  D LOOK G:X="" END D ENT G SETBIL
 ;
LOOK S:'$D(^PRCA(430,0)) ^(0)="ACCOUNTS RECEIVABLE^430I^^"
 R !!,"ACCOUNTS RECEIVABLE BILL NO. : ",X:DTIME Q:('$T)!(X="")  I X["^" S X="" Q
 I "Nn"[$E(X) D  I $P(X,"^")=-1 W *7,!!,$P(X,"^",2),! G LOOK
 . S X=$$BNUM^RCMSNUM
 . I $P(X,"^")'=-1 S X=$P(X,"-",2)
 I (X'?1UN1UN4.5UN) W *7,!!,"Please enter 7 character bill number.",!,"It must be in the following format: K400001, K481234 or '(N)ew' to get",!,"the next available number.  (Enter ""^"" to exit)",! G LOOK
 I ($D(^PRCA(430,"D",X)))!($D(^PRCA(430,"B",PRCA("SITE")_"-"_X))) W *7,!!,"SORRY ! THIS NUMBER HAS BEEN ALREADY ASSIGNED TO A BILL. IT MUST BE NEW ENTRY",! G LOOK
 Q
ENT S X=PRCA("SITE")_"-"_X W "   ",X S DIC="^PRCA(430,",DIC(0)="XL",DLAYGO=430,DIC("DR")="97////^S X=DUZ" D ^DIC K DLAYGO,DIC
 Q:Y<0  S (X,D0,PRCABN)=+Y,PRCA("MESS1")="THE ACCOUNT WILL BE INCOMPLETE.",PRCA("MESS2")="*** APPROVED AND RELEASED TO ACCOUNTING ***"
 W " ...Bill Number '",$P(^PRCA(430,PRCABN,0),"^"),"' assigned!"
 K PRCADEL,PRCADINO D EDT^PRCAEIN
DELETE I $D(PRCADEL) S PRCACOMM="USER CANCELED" D DELETE^PRCABIL4 K PRCACOMM W !,*7,"DELETED",!
END I $G(PRCABN),$P($G(^PRCA(430,PRCABN,0)),U,8)=$O(^PRCA(430.3,"AC",102,"")) D PREPAY^RCBEPAYP(PRCABN)
 L -^PRCA(430,+$G(PRCABN)) K PRCADINO,PRCA("MESS1"),PRCA("MESS2"),PRCABN,PRCADEL,PRCA("CKSITE"),DIC
 Q
