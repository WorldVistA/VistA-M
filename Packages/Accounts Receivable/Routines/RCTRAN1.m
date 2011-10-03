RCTRAN1 ;WASH-ISC@ALTOONA,PA/LDB-Transaction History Report ;11/14/94  5:25 PM
V ;;4.5;Accounts Receivable;**104**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Subroutines Called by RCTRAN
 ;
TRANS ;Find transactions of selected type for selected date range
 S CAT("X")=CAT D DT^DICRW
 S BDATE(1)=BDATE,BDATE=(BDATE-1)+.999999999
 S EDATE(1)=EDATE,EDATE=$S('EDATE:9999999,1:EDATE+.99999999)
 S RCX=0 F  S RCX=$O(^PRCA(433,RCX)) Q:'RCX  I $D(^PRCA(433,RCX,0)),+$G(^(1)) D
 .S NODE0=^(0),NODE1=^(1),NODE2=$G(^(2)),NODE3=$G(^(3))
 .S TDAT=$S($P(NODE1,"^",9):$P(NODE1,"^",9),1:+NODE1)
 .S BILL=$P(NODE0,"^",2) Q:'BILL
 .S CAT=$P($G(^PRCA(430,+BILL,0)),"^",2) Q:'CAT
 .I ($D(TYP(+$P(NODE1,"^",2)))!'TYP),($D(CAT(+CAT))!'CAT("X")),TDAT>BDATE,TDAT<EDATE D
 ..S APP=$P($G(^PRCA(430,+BILL,11)),"^",17)
 ..I APP="",",5,4,3,18,25,"[(","_CAT_",") S APP="2431"
 ..I APP="",",9,6,7,8,21,22,23,26,"[(","_CAT_",") S APP="5014"
 ..I APP="",",14,12,19,20,1,10,2,"[(","_CAT_",") S APP="0160"
 ..I CAT=26 S APP="5014"
 ..I APP="" S APP="NO FUND W/BILL"
 ..S BILL=$P($G(^PRCA(430,+BILL,0)),"^")
 ..I ",12,13,14,"[(","_TYP_",") D  Q
 ...F I=5:1:8 S AMT=$P(NODE2,"^",I) I AMT S APP=$S(I=8:1435,I=7:3220,1:"0869") D SET
 ..I ",2,34,"[(","_TYP_",") D  Q
 ...F I=1:1:5 I $P(NODE3,"^",I) S AMT=+$P(NODE3,"^",I),APP=$S(I=1:APP,I=2:1435,I=3:3220,1:"0869") D SET
 ..S AMT=+$P(NODE1,"^",5)
 ..D SET
 Q
 ;
SET S ^TMP($J,+$P(NODE1,"^",2),+CAT,APP,TDAT,RCX)=AMT_"^"_BILL_"^"_$P(NODE0,"^",9)
 Q
 ;
SUB ;Sub-total categories
 I RCX'=45 S:AMT(X11)<0 AMT(X11)=-AMT(X11) W !?64,"-----------",!?64,$J(AMT(X11),11,2),!
 Q
 ;
KEY ;Key to category abbreviations
 W !!?30,"CATEGORY ABBREVIATIONS",!!
 W !,"C  - C (MEANS TEST), CE - CURRENT EMPLOYEE, CP - CRIME OF PER. VIO."
 W !,"E  - EX-EMPLOYEE"
 W !,"F1 - FEDERAL AGENGIES-REIMB., F2 - FEDERAL AGENCIES-REFUND"
 W !,"H  - EMERGENCY HUMANITARIAN"
 W !,"I  - INELIGIBLE HOSP., IA - INTERAGENCY, M - MILITARY, MC - MEDICARN"
 W !,"NA - NO-FAULT AUTO ACC."
 W !,"PN - RX CO-PAY NSC, PS - RX CO-PAY SC, PP - PREPAY"
 W !,"RI - REIMBURSIBLE HEALTH INSURANCE"
 W !,"SA - SHARING AGREEMENTS, TF - TORT FEASOR, V - VENDOR, WC - WORKMAN'S COMP."
 Q
HDR ;;Heading
 S PG=PG+1
 W !?30,"HISTORY OF TRANSACTIONS",?70,"PAGE ",?75,PG
 W !,LINE
 W !,"Date",?12,"Trans.",?37,"Cat",?44,"Bill#",?57,"Trans#",?66,"Amount",?75,"BY"
 W !,LINE
 S LN=0
 Q
