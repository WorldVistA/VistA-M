RCDPBTL1 ;WISC/RFJ-bill transaction options ;1 Jun 99
 ;;4.5;Accounts Receivable;**114**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
BILLPROF ;  bill profile
 D EN^VALM("RCDP BILL PROFILE")
 ;
 D INIT^RCDPBTLM
 S VALMBCK="R"
 ;  fast exit
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
 ;
TRANPROF ;  transaction profile
 N INDEX,RCTRANDA,VALMBG,VALMLST,VALMY
 S VALMBCK="R"
 ;
 ;  if no transactions, quit
 I '$O(^TMP("RCDPBTLM",$J,"IDX",0)) S VALMSG="There are NO transactions to profile." Q
 ;
 ;  if only one transaction, select that one automatically
 I '$O(^TMP("RCDPBTLM",$J,"IDX",1)) S INDEX=1
 ;
 ;  select the entry from the list
 I '$G(INDEX) D   I 'INDEX Q
 .   ;  if not on first screen, make sure selection begins with 1
 .   S VALMBG=1
 .   ;  if not on last screen, make sure selection ends with last
 .   S VALMLST=$O(^TMP("RCDPBTLM",$J,"IDX",999999999),-1)
 .   D EN^VALM2($G(XQORNOD(0)),"OS")
 .   S INDEX=$O(VALMY(0))
 ;
 S RCTRANDA=+$G(^TMP("RCDPBTLM",$J,"IDX",INDEX,INDEX))
 D EN^VALM("RCDP TRANS PROFILE")
 ;
 D INIT^RCDPBTLM
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
 D INIT^RCDPBTLM
 Q
