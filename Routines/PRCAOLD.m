PRCAOLD ;SF-ISC/YJK-SETUP OLD ACCOUNTS RECEIVABLE ;8/9/96  9:32 AM
 ;;4.5;Accounts Receivable;**40,67,158,153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This sets up an old account for A/R. The account is classified
 ;with category.
 ;
 W !!,*7,"This option can only be used to re-establish MCCR bills.  ALL others",!,"MUST be set up as NEW bills.",!!,"****  THIS IS A REQUIREMENT OF FMS!!  ****",!!
 ;======================= SET UP OLD AR ==============================
SETBIL K PRCA("CKSITE") D CKSITE^PRCAUDT Q:'$D(PRCA("CKSITE"))  D LOOK G:X="" END D ENT G SETBIL
 ;
LOOK S:'$D(^PRCA(430,0)) ^(0)="ACCOUNTS RECEIVABLE^430I^^"
 R !!,"ACCOUNTS RECEIVABLE BILL NO. : ",X:DTIME Q:('$T)!(X="")  I X["^" S X="" Q
 I "Nn"[$E(X) D  I $P(X,"^")=-1 W *7,!!,$P(X,"^",2),! G LOOK
 . S X=$$BNUM^RCMSNUM
 . I $P(X,"^")'=-1 S X=$P(X,"-",2)
 I (X'?1UN1UN4.5UN) W *7,!!,"Please enter 7 character bill number.",!,"It must be in the following format: K400001, K481234 or '(N)ew' to get",!,"the next available number.  (Enter ""^"" to exit)",! G LOOK
 I ($D(^PRCA(430,"D",X)))!($D(^PRCA(430,"B",PRCA("SITE")_"-"_X))) W *7,!!,"SORRY ! THIS NUMBER HAS BEEN ALREADY ASSIGNED TO A BILL. IT MUST BE NEW ENTRY",! G LOOK
 Q
ENT S X=PRCA("SITE")_"-"_X W "   ",X S DIC="^PRCA(430,",DIC(0)="XL",DLAYGO=430 D ^DIC K DLAYGO,DIC
 Q:Y<0  S (X,D0,PRCABN)=+Y,PRCA("MESS1")="THE ACCOUNT WILL REMAIN INCOMPLETE OLD BILL AND SHOULD BE EDITED."
 K PRCADIOK,PRCADEL D EDT^PRCAEOL
DELETE I $D(PRCADEL) S PRCACOMM="USER CANCELED" D DELETE^PRCABIL4 K PRCACOMM W !,*7,"DELETED",!
END I +$G(PRCABN),$P($G(^PRCA(430,PRCABN,0)),U,8)=$O(^PRCA(430.3,"AC",102,"")) D PREPAY^RCBEPAYP(PRCABN)
 L -^PRCA(430,+$G(PRCABN)) K PRCAPO,PRCADINO,PRCA("MESS1"),PRCA("MESS2"),PRCABN,PRCADEL,PRCA("CKSITE"),DIC Q
 ;
PATREF ;enter PAT REF # to the old bill.
 K PRCAPO S PRCAKDA=DA,PRCAREF=1 W !,"PAT REFERENCE NUMBER: " R X:DTIME I X=U W *7,"  (REQUIRED !)" Q
 I (X["?")!(X'?3UN2N1UN) W *7,!,"Please enter a PAT Reference Number assigned to this bill.",!,"Enter 6 number/characters, e.g. 8KA111, K8111A  or  8K111A",! G PATREF
 S X=$$SITE^RCMSITE_"-"_X I $D(^PRC(442,"B",X)) S PRCAPO=$O(^(X,0)) D PATUP Q
 S DIC="^PRC(442,",DIC(0)="QL",DLAYGO=442 D ^DIC I Y<0 K DLAYGO Q
 S PRCAPO=+Y
PATUP S $P(^PRC(442,PRCAPO,0),U,2)=24,^PRC(442,"F",24,PRCAPO)="" S:$D(PRCABN) $P(^PRC(442,PRCAPO,1),U,16)=$P(^PRCA(430,PRCABN,0),U,9)
 S DA=PRCAKDA K PRCAKDA,PRCAREF S Y="@13" Q
HELP W !!,"Please enter a six character bill number.  You may use the PAT number.",!,"It must contain at least one alpha character within the first five spaces."
 W !,"e.g.  8K1234, K81234, 9M234A   (Enter ""^"" to exit)",! Q
