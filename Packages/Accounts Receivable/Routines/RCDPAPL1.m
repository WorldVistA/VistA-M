RCDPAPL1 ;WISC/RFJ-account profile listmanager options ;1 Jun 99
 ;;4.5;Accounts Receivable;**114**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ACCOUNT ;  select a new account
 D FULL^VALM1
 S VALMBCK="R"
 ;
 W !!,"This option will allow you to select a new account."
 W ! S %=$$SELACCT^RCDPAPLM
 I %<1 Q
 S RCDEBTDA=%
 ;
 D INIT^RCDPAPLM
 Q
 ;
 ;
BILLTRAN ;  show transactions for a bill
 N RCBILLDA
 S VALMBCK="R"
 ;
 S RCBILLDA=$$SELBILL I 'RCBILLDA Q
 D EN^VALM("RCDP TRANSACTIONS LIST")
 ;
 D INIT^RCDPAPLM
 S VALMBCK="R"
 ;  fast exit
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
 ;
BILLPROF ;  bill profile
 N RCBILLDA
 S VALMBCK="R"
 ;
 S RCBILLDA=$$SELBILL I 'RCBILLDA Q
 D EN^VALM("RCDP BILL PROFILE")
 ;
 D INIT^RCDPAPLM
 S VALMBCK="R"
 ;  fast exit
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
 ;
SELBILL() ;  select bill from list
 N VALMBG,VALMLST,VALMY
 ;  if no bills, quit
 I '$O(^TMP("RCDPAPLM",$J,"IDX",0)) S VALMSG="There are NO bills to profile." Q 0
 ;
 ;  if only one bill, select that one automatically
 I '$O(^TMP("RCDPAPLM",$J,"IDX",1)) Q +$G(^TMP("RCDPAPLM",$J,"IDX",1,1))
 ;
 ;  select the entry from the list
 ;  if not on first screen, make sure selection begins with 1
 S VALMBG=1
 ;  if not on last screen, make sure selection ends with last
 S VALMLST=$O(^TMP("RCDPAPLM",$J,"IDX",999999999),-1)
 D EN^VALM2($G(XQORNOD(0)),"OS")
 Q +$G(^TMP("RCDPAPLM",$J,"IDX",+$O(VALMY(0)),+$O(VALMY(0))))
