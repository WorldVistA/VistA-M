RCDPBPL1 ;WISC/RFJ-bill profile options ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,462**;Mar 20, 1995;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified.
 Q
 ;
 ;
BILLTRAN ;  show transactions for a bill
 D EN^VALM("RCDP TRANSACTIONS LIST")
 ;
 D INIT^RCDPBPLM
 S VALMBCK="R"
 ;  fast exit
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
 ;
NEWBILL ;  select a new bill
 D FULL^VALM1
 S VALMBCK="R"
 ;
 W !!,"This option will allow you to select a new bill to display."
 W ! S %=$$SELBILL^RCDPBTLM
 I %<1 Q
 S RCBILLDA=%
 ;
 ;  if called from account profile, pick new account
 I $D(^TMP("RCDPAPLM",$J)) S RCDEBTDA=$P(^PRCA(430,RCBILLDA,0),"^",9)
 ;
 D INIT^RCDPBPLM
 Q
 ;
ELIG ; display patient eligibility  PRCA*4.5*462
 D FULL^VALM1
 S VALMBCK="R"
 D EN^VALM("RCDP ELIGIBILITY")
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
SPAUTH ; display special authority  PRCA*4.5*462
 D FULL^VALM1
 S VALMBCK="R"
 D EN^VALM("RCDP SP AUTHORITY")
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
