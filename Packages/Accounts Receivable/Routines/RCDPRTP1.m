RCDPRTP1 ;ALB/LDB - CLAIMS MATCHING REPORT (PRINT) ;1/26/01  2:56 PM
 ;;4.5;Accounts Receivable;**151,169**;Mar 20, 1995
 ;
 ;
EN ; Entry point to print the Claims Matching Report.
 N %,DATEDIS1,DATEDIS2,NOW,PG,RCBILL,RCAMT,RCAMT1,RCIBDAT,RCIBFN,RCNAM,RCNAM1,RCNO,RCNOW,RCDLINE,RCLINE,RCPHIT,RCQ,RCSSN,RCSTAT,RCTP,X,Y
 ;
 ; - initialize report header variables
 S PG=0
 I RCSORT'=2,(RCSORT'=4) D
 .S Y=$P(DATESTRT,".") D DD^%DT S DATEDIS1=Y
 .S Y=$P(DATEEND,".") D DD^%DT S DATEDIS2=Y
 D NOW^%DTC S Y=% D DD^%DT S RCNOW=$E(Y,1,18)
 S RCDLINE=$TR($J("",80)," ","-")
 S RCLINE=$TR($J("",80)," ","*")
 ;
 ; - main report loop
 K ^TMP($J)
 ;
 ;
 D HDR ; initial header
 S RCNO=0 ; flag to indicate at least one matching claim
 ;
 S RCNAM="" F  S RCNAM=$O(^TMP("RCDPRTPB",$J,RCNAM)) Q:RCNAM=""!$G(RCQ)  D
 .S RCBILL=0 F  S RCBILL=$O(^TMP("RCDPRTPB",$J,RCNAM,RCBILL)) Q:'RCBILL!$G(RCQ)  D
 ..;
 ..S RCPHIT=0 ; flag that requires patient info to print
 ..D PROC ;     process a single third party bill
 ..K ^TMP("IBRBT",$J),^TMP("IBRBF",$J)
 ;
 I $G(RCQ) G ENQ
 ;
 I $O(^TMP("RCDPRTPB",$J,0))="" W !!,?18,"No matching debts." Q
 I 'RCNO W !!,?18,"No matching debts."
ENQ ;
 Q
 ;
 ;
PROC ; Process each third party bill for a patient.
 D RELBILL^IBRFN(RCBILL)
 ;
 ; - quit if there are no associated first party bills
 I '$O(^TMP("IBRBF",$J,0)) K ^TMP("RCDPRTPB",$J,RCNAM,RCBILL) G PROCQ
 ;
 S (RCAMT(0),RCAMT(1))=0
 ;
 S RCTP(0)=0 F  S RCTP(0)=$O(^TMP("IBRBF",$J,RCTP(0))) Q:'RCTP(0)  S RCTP(1)=0 F  S RCTP(1)=$O(^TMP("IBRBF",$J,RCTP(0),RCTP(1))) Q:'RCTP(1)  S ^TMP($J,"IBRBF",RCTP(1),RCTP(0))=""
 S RCPT(0)=0 F  S RCTP(0)=$O(^TMP($J,"IBRBF",RCTP(0))) Q:'RCTP(0)  S RCTP(1)=0 F  S RCTP(1)=$O(^TMP($J,"IBRBF",RCTP(0),RCTP(1))) Q:'RCTP(1)  D
 .I RCTP(1)=RCBILL Q
 .I $D(^TMP($J,"IBRBF",RCTP(0),RCBILL))!(RCTP(1)'=$O(^TMP($J,"IBRBF",RCTP(0),0))) K ^TMP("IBRBF",$J,RCTP(1),RCTP(0)),^TMP($J,"IBRBF",RCTP(0),RCTP(1)) I '$O(^TMP("IBRBF",$J,RCTP(1),0)) K ^TMP("IBRBF",$J,RCTP(1))
 S RCTP(0)="" F  S RCTP(0)=$O(^TMP("IBRBT",$J,RCBILL,RCTP(0))) Q:RCTP(0)=""  D
 .;if associated third party has had payment also do not list twice
 .I $D(^TMP("RCDPRTPB",$J,RCNAM,RCTP(0))),(RCBILL'=RCTP(0)) S RCTP(RCTP(0))=^TMP("RCDPRTPB",$J,RCNAM,RCTP(0)) K ^(RCTP(0))
 .;if no prescription coverage exclude associated rx co-pay charges
 .I '$P(^TMP("IBRBT",$J,RCBILL),"^") D
 ..S RCTP(1)=0 F  S RCTP(1)=$O(^TMP("IBRBF",$J,RCTP(0),RCTP(1))) Q:RCTP(1)=""  I $G(^TMP("IBRBF",$J,RCTP(0),RCTP(1)))["RX" K ^TMP("IBRBF",$J,RCTP(0),RCTP(1)) I '$O(^TMP("IBRBF",$J,RCTP(0),"")) K ^TMP("IBRBF",$J,RCTP(0))
 .;if duplicate charges exclude them from report
 S RCTP(0)=0 F  S RCTP(0)=$O(^TMP("IBRBF",$J,RCTP(0))) Q:RCTP(0)=""  S RCTP(1)=0 F  S RCTP(1)=$O(^TMP("IBRBF",$J,RCTP(0),RCTP(1))) Q:'RCTP(1)  D
 .I RCTP(0)'=RCBILL,($D(^TMP("IBRBF",$J,RCBILL,RCTP(1)))) K ^TMP("IBRBF",$J,RCTP(0),RCTP(1)) K:'$O(^TMP("IBRBF",$J,RCTP(0),0)) ^TMP("IBRBF",$J,RCTP(0))
 ;exclude cancelled charges if not selected to be on report
 I 'RCAN D
 .S RCTP(0)=0 F  S RCTP(0)=$O(^TMP("IBRBF",$J,RCTP(0))) Q:RCTP(0)=""  S RCTP(1)=0 F  S RCTP(1)=$O(^TMP("IBRBF",$J,RCTP(0),RCTP(1))) Q:'RCTP(1)  D
 ..I $P(^TMP("IBRBF",$J,RCTP(0),RCTP(1)),"^",3) K ^TMP("IBRBF",$J,RCTP(0),RCTP(1)) Q
 ..S RCPT(2)=$O(^PRCA(430,"B",+$P(^TMP("IBRBF",$J,RCTP(0),RCTP(1)),"^",4),0)) I $P($G(^PRCA(430,+RCPT(2),0)),"^",8)=39 K ^TMP("IBRBF",$J,RCTP(0),RCTP(1))
 ..I '$O(^TMP("IBRBF",$J,RCTP(0),"")) K ^TMP("IBRBF",$J,RCTP(0))
 I '$O(^TMP("IBRBF",$J,RCBILL,0)) K ^TMP("RCDPRTPB",$J,RCNAM,RCBILL) G PROCQ
 ;
 ; - print patient detail line
 I 'RCPHIT S RCPHIT=1 D PRINT3^RCDPRTP2 G:$G(RCQ) PROCQ
 ;
 ; - print third party bills
 ;    o  print the header first; need room for the header and
 ;       the bill that was paid.
 ;    o  print the bill that was paid.
 S RCTP=RCBILL,RCIBDAT=$G(^TMP("IBRBT",$J,RCBILL,RCBILL))
 I $Y>(IOSL-7) D PAUSE^RCDPRTP2 G:$G(RCQ) PROCQ D HDR
 D HDR1^RCDPRTP2,PRINT1^RCDPRTP2 G:$G(RCQ) PROCQ
 ;
 ; - print the other assoicated third party bills
 S RCTP=0 F  S RCTP=$O(^TMP("IBRBT",$J,RCBILL,RCTP)) Q:'RCTP!$G(RCQ)  D
 .I RCBILL=RCTP Q  ; don't reprint the bill that was paid.
 .S RCIBDAT=$G(^TMP("IBRBT",$J,RCBILL,RCTP))
 .I 'RCAN,($P(RCIBDAT,"^",3)) Q  ; exclude cancelled claims
 .D PRINT1^RCDPRTP2
 G:$G(RCQ) PROCQ
 ;
 ; - print the third party totals
 I $Y>(IOSL-2) D PAUSE^RCDPRTP2 G:$G(RCQ) PROCQ D HDR W !
 W !,?57,"---------",?68,"---------"
 W !,?57,$J(RCAMT(0),9,2),?68,$J(RCAMT(1),9,2)
 ;
 ; - print the associated first party charges
 S RCTP(0)=0 F  S RCTP(0)=$O(^TMP("IBRBF",$J,RCTP(0))) Q:'RCTP(0)!$G(RCQ)  D
 .I RCTP(0)=$O(^TMP("IBRBF",$J,0)) D
 ..I $Y>(IOSL-5) D PAUSE^RCDPRTP2 Q:$G(RCQ)  D HDR
 ..D HDR2^RCDPRTP2
 .S RCTP=0 F  S RCTP=$O(^TMP("IBRBF",$J,RCTP(0),RCTP)) Q:'RCTP!$G(RCQ)  D
 ..S RCNO=1 ; set flag for at least one match
 ..;
 ..S RCIBDAT=$G(^TMP("IBRBF",$J,RCTP(0),RCTP))
 ..;
 ..; - print the header for the first charge
 ..;
 ..; - print the patient detail line
 ..D PRINT2^RCDPRTP2
 ;.
PROCQ K ^TMP($J) Q
 ;
 ;
HDR ; Print the main report header.
 S PG=PG+1 I PG'=1!($E(IOST,1,2)="C-") W @IOF
 W !,?5,"THIRD PARTY CLAIMS W/MATCHING FIRST PARTY DEBTS  ",RCNOW," PAGE ",PG
 I RCSORT'=2,(RCSORT'=4) W !,?18,"FOR THE PAYMENT DATES: ",DATEDIS1,"  TO  ",DATEDIS2
 I RCSORT=4 W !,?18,"RECEIPT NUMBER ",RCPT
 W !,RCDLINE
 I PG=1 D
 .W !!,"Remember that any actions taken to decrease the first party receivables must"
 .W !,"consider any applicable deductibles or coinsurance amounts specified on the EOB."
 Q
 ;
