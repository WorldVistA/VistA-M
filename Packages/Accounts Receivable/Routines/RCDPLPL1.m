RCDPLPL1 ;WISC/RFJ-link payments listmanager options ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148,153,208**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CHKTRACE ; Ask to search by chec # or trace #
 N DIR,X,Y
 D FULL^VALM1
 S DIR("A")="SEARCH BY (C)HECK OR (T)RACE #?: ",DIR(0)="SA^C:CHECK;T:TRACE",DIR("B")="CHECK" W ! D ^DIR K DIR
 Q:$D(DTOUT)!$D(DUOUT)
 I Y="C" D  Q
 . D FINDCHEK
 I Y="T" D  Q
 . D FINDTRAC
 Q
 ;
FINDCHEK ;  find a specific check used for payments
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N RCCHECK,RCTYPE
 K RCFCHECK,RCFCREDT,RCFTRACE
 W !
 S RCCHECK=$$ASKCHEK I RCCHECK=-1 D INIT^RCDPLPLM Q
 ;
 S RCTYPE=$$ASKTYPE I RCTYPE=-1 D INIT^RCDPLPLM Q
 S RCFCHECK=RCCHECK_"^"_RCTYPE
 D INIT^RCDPLPLM
 Q
 ;
FINDTRAC ;  find a specific trace # used for EFT/ERA payments
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N RCTRACE,RCTYPE
 K RCFTRACE,RCFCREDT,RCFCHECK
 W !
 S RCTRACE=$$ASKTRACE I RCTRACE=-1 D INIT^RCDPLPLM Q
 ;
 S RCTYPE=$$ASKTYPE I RCTYPE=-1 D INIT^RCDPLPLM Q
 S RCFTRACE=RCTRACE_"^"_RCTYPE
 D INIT^RCDPLPLM
 Q
 ;
 ;
FINDCRED ;  find a specific credit card used for payments
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N RCCREDT,RCTYPE
 K RCFCHECK,RCFCREDT,RCFTRACE
 W !
 S RCCREDT=$$ASKCRED I RCCREDT=-1 D INIT^RCDPLPLM Q
 ;
 S RCTYPE=$$ASKTYPE I RCTYPE=-1 D INIT^RCDPLPLM Q
 S RCFCREDT=RCCREDT_"^"_RCTYPE
 D INIT^RCDPLPLM
 Q
 ;
 ;
ACCOUNT ;  account profile
 D FULL^VALM1
 D ACCTPROF^RCDPAPLM
 D INIT^RCDPLPLM
 S VALMBCK="R"
 ;  fast exit
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
 ;
RECEIPT ;  receipt profile
 D FULL^VALM1
 D RECTPROF^RCDPRPLM
 D INIT^RCDPLPLM
 S VALMBCK="R"
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
 ;
CLEARSUS ;  flag a payment as being cleared from suspense
 D FULL^VALM1
 S VALMBCK="R"
 ;
 W !!,"This option will allow you to enter the FMS Document Number used"
 W !,"to clear the payment from the suspense account in FMS.  Once an"
 W !,"FMS Document Number is entered, the payment will no longer appear"
 W !,"on the list as Unlinked.",!
 N INDEX,RCPAY,RCRECTDA,RCTRANDA
 S INDEX=$$SELPAY
 I INDEX D
 .   S RCPAY=$G(^TMP("RCDPLPLM",$J,"IDX",INDEX,INDEX))
 .   S RCRECTDA=+$P(RCPAY,"^"),RCTRANDA=+$P(RCPAY,"^",2)
 I 'INDEX D
 .   W ! S RCRECTDA=+$$SELRECT^RCDPUREC(0,0) I RCRECTDA<1 Q
 .   S RCTRANDA=+$$SELTRAN^RCDPURET(RCRECTDA) I RCTRANDA<1 S RCTRANDA=0
 I '$G(RCRECTDA)!('$G(RCTRANDA)) S VALMBCK="R" Q
 ;
 W !!,"                   Receipt: ",$P(^RCY(344,RCRECTDA,0),"^")
 W !,"               Transaction: ",RCTRANDA
 W !,"  Unapplied Deposit Number: ",$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,2)),"^",5)
 D EDITFMS^RCDPURET(RCRECTDA,RCTRANDA,"")
 S VALMBCK="R"
 D INIT^RCDPLPLM
 Q
 ;
 ;
 ;
 ;
SELPAY() ;  select a payment from the form list
 N VALMBG,VALMLST
 ;  if no payments, quit
 I '$O(^TMP("RCDPLPLM",$J,"IDX",0)) S VALMSG="There are NO payments on the form to select." Q 0
 ;
 ;  if only one payment, select that one automatically
 I '$O(^TMP("RCDPLPLM",$J,"IDX",1)) Q 1
 ;
 ;  select the entry from the list
 ;  if not on first screen, make sure selection begins with 1
 S VALMBG=1
 ;  if not on last screen, make sure selection ends with last
 S VALMLST=$O(^TMP("RCDPLPLM",$J,"IDX",999999999),-1)
 D EN^VALM2($G(XQORNOD(0)),"OS")
 Q $O(VALMY(0))
 ;
 ;
ASKCHEK() ;  ask the check number
 N DIR,X,Y
 S DIR(0)="FAO^1:15"
 S DIR("A")="Enter the Check Number to Search for: "
 S DIR("?")="Enter the check number from 1 to 15 characters free text."
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q $S(Y'="":Y,1:-1)
 ;
 ;
ASKTRACE() ;  ask the e-payments trace number
 N DIR,X,Y
 S DIR(0)="FAO^1:30"
 S DIR("A")="Enter the e-Payments Trace Number to Search for: "
 S DIR("?")="Enter the trace number from 1 to 30 characters free text."
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q $S(Y'="":Y,1:-1)
 ;
 ;
ASKCRED() ;  ask the credit card number
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="NAO^0:9999999999999999"
 S DIR("A")="Enter the Credit Card Number to Search for: "
 S DIR("?")="Enter the check card number from 1 to 16 numbers."
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q $S(Y'="":Y,1:-1)
 ;
 ;
ASKTYPE() ;  ask the type of match
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SAO^1:Exact Match;2:Contains;"
 S DIR("A")="Type of Match: "
 S DIR("B")="Contains"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q $S(Y=1:"EQUAL TO",Y=2:"CONTAINING",1:-1)
