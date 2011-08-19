RCDPLPSR ;WISC/RFJ-link payments suspense report ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
REPORT ;  report to show payments cleared from suspense in FMS
 D FULL^VALM1
 S VALMBCK="R"
 ;
 W !!,"This option will print a report showing all unlinked payments"
 W !,"received between selected dates that were processed to the station's"
 W !,"suspense account and later cleared by on-line FMS input.",!
 ;
 N DATEEND,DATESTRT
 D DATESEL^RCRJRTRA("PAYMENT")
 I '$G(DATESTRT)!('$G(DATEEND)) Q
 ;
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS I POP S VALMBCK="R" Q
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D ^%ZISC S VALMBCK="R" Q
 .   S ZTDESC="AR Clear Suspense Payment Report",ZTRTN="DQ^RCDPLPSR"
 .   S ZTSAVE("DATE*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 D DQ
 R !,"Press RETURN to continue:",%:DTIME
 S VALMBCK="R"
 Q
 ;
 ;
DQ ;  report (queue) starts here
 N DATA,DATE,DATEDIS1,DATEDIS2,NOW,PAGE,RCDATA,RCRECTDA,RCRJFLAG,RCRJLINE,RCTRANDA,RECDATA,SCREEN
 K ^TMP("RCDPLPSR",$J)
 S RCRECTDA=0 F  S RCRECTDA=$O(^RCY(344,RCRECTDA)) Q:'RCRECTDA  D
 .   S RECDATA=$G(^RCY(344,RCRECTDA,0))
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^RCY(344,RCRECTDA,1,RCTRANDA)) Q:'RCTRANDA  D
 .   .   S RCDATA=$G(^RCY(344,RCRECTDA,1,RCTRANDA,0))
 .   .   I '$P(RCDATA,"^",4) Q  ;no payment amount
 .   .   ;  never sent to suspense
 .   .   I $P($G(^RCY(344,RCRECTDA,1,RCTRANDA,2)),"^",5)="" Q
 .   .   ;  fms doc id not entered (field 26) to clear suspense
 .   .   I $P($G(^RCY(344,RCRECTDA,1,RCTRANDA,2)),"^",6)="" Q
 .   .   ;  get payment date
 .   .   S DATE=$P(RCDATA,"^",6)
 .   .   I 'DATE S DATE=$P(RCDATA,"^",10)
 .   .   I 'DATE S DATE=$P(RECDATA,"^",3)
 .   .   I 'DATE S DATE=0
 .   .   S DATE=$P(DATE,".")
 .   .   I DATE<DATESTRT!(DATE>DATEEND) Q
 .   .   S ^TMP("RCDPLPSR",$J,DATE,RCRECTDA,RCTRANDA)=$P(RECDATA,"^")_"^"_$$GETUNAPP^RCXFMSCR(RCRECTDA,RCTRANDA,0)_"^"_$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,2)),"^",6)_"^"_$P(RCDATA,"^",4)
 ;
 ;  print report
 S Y=$P(DATESTRT,".") D DD^%DT S DATEDIS1=Y
 S Y=$P(DATEEND,".") D DD^%DT S DATEDIS2=Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S PAGE=1,RCRJLINE="",$P(RCRJLINE,"-",81)=""
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO D H
 S DATE=0 F  S DATE=$O(^TMP("RCDPLPSR",$J,DATE)) Q:'DATE!($G(RCRJFLAG))  D
 .   S RCRECTDA=0 F  S RCRECTDA=$O(^TMP("RCDPLPSR",$J,DATE,RCRECTDA)) Q:'RCRECTDA!($G(RCRJFLAG))  D
 .   .   S RCTRANDA=0 F  S RCTRANDA=$O(^TMP("RCDPLPSR",$J,DATE,RCRECTDA,RCTRANDA)) Q:'RCTRANDA!($G(RCRJFLAG))  D
 .   .   .   S DATA=^TMP("RCDPLPSR",$J,DATE,RCRECTDA,RCTRANDA)
 .   .   .   W !,$P(DATA,"^"),?20,$J(RCTRANDA,5),?30,$P(DATA,"^",2),?50,$P(DATA,"^",3),?70,$J($P(DATA,"^",4),10,2)
 .   .   .   I $Y>(IOSL-6) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 K ^TMP("RCDPLPSR",$J)
 D ^%ZISC
 Q
 ;
 ;
H ;  header
 S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"AR CLEARED SUSPENSE REPORT",?(80-$L(%)),%
 W !,"  FOR THE DATE RANGE: ",DATEDIS1,"  TO  ",DATEDIS2
 W !,"RECEIPT",?20,"TRAN#",?30,"UNAPPLIED DEPOSIT#",?50,"CLEAR FMS DOC ID#",?70,$J("AMOUNT",10)
 W !,RCRJLINE
 Q
 ;
 ;
MAILMSG(RCRECTDA,RCTRANDA) ;  generate message to users showing what needs to be moved out
 ;  of suspense to 5287
 N %Z,DATE,DDH,MESSAGE,X9,XCNP,XMDUZ,XMZ,X,Y
 S DATE=$P($P($G(^RCY(344,RCRECTDA,0)),"^",8),".") I DATE S Y=DATE D DD^%DT S DATE=Y
 S MESSAGE(1)="The following payment has been processed to an Account in AR and"
 S MESSAGE(2)="needs to be moved from the station's suspense account 3875 to"
 S MESSAGE(3)="the appropriation/fund identified for this account online in FMS."
 S MESSAGE(4)=" "
 S MESSAGE(5)="              Receipt Number: "_$P(^RCY(344,RCRECTDA,0),"^")
 S MESSAGE(6)="  Payment Transaction Number: "_RCTRANDA
 S MESSAGE(7)="    Unapplied Deposit Number: "_$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,2)),"^",5)
 S MESSAGE(8)="          FMS CR document ID: "_$P($G(^RCY(344,RCRECTDA,2)),"^")
 S MESSAGE(9)="                 Amount Paid: "_$J(+$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,0)),"^",4),0,2)
 S MESSAGE(10)="                Process Date: "_DATE
 ;  if package has been installed for 30 days, do not show hint
 ;  look for first CR document processed for a receipt and the
 ;  date the receipt was processed.
 S X=$P($G(^RCY(344,+$O(^RCY(344,"ADOC",$O(^RCY(344,"ADOC","")),0)),0)),"^",8)
 I X,$$FMDIFF^XLFDT(DT,X)<30 D
 .   S MESSAGE(11)=" "
 .   S MESSAGE(12)="HINT: (Make a note, this hint will soon disappear)"
 .   S MESSAGE(13)="Once the payment has been moved from suspense in FMS, you can use"
 .   S MESSAGE(14)="the Clear Suspense option under the Link Payment ListManager"
 .   S MESSAGE(15)="screen to track the FMS document used to transfer the payment."
 .   S MESSAGE(16)="Since the payment no longer appears on the Link Payment ListManager"
 .   S MESSAGE(17)="screen, at the Select Payment option, press return with out selecting"
 .   S MESSAGE(18)="a payment and you will have the option to enter the receipt and"
 .   S MESSAGE(19)="transaction number (listed above)."
 S XMTEXT="MESSAGE("
 S XMSUB="Transfer Payment From Suspense Rec/# "_$P(^RCY(344,RCRECTDA,0),"^")_"/"_RCTRANDA
 S XMDUZ="AR Package",XMY("G.RCDP PAYMENTS")=""
 D ^XMD
 Q
