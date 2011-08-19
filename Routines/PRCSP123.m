PRCSP123 ;WISC/SAW-CONTROL POINT ACTIVITY 2237 PRINTOUT CON'T ;3-9-88/5:05 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ADMIN AND RECEIPT ACTION BLOCKS
 W !,?12,"ADMINISTRATIVE ACTION",?45,"|",?60,"RECEIPT ACTION",!,$E(L,1,45)
 W "|",$E(L,1,44)
 W !,"(Circle Applicable Item)",?45,"|I CERTIFY that the quantities in  ""ACTION"""
 W !," Unposted    Posted    Service    Bulk Sale",?45,"|column have been received.",!,$E(L,1,45)
 W "|",$E(L,1,44)
 W !,"Availability of Items Requested Above, or",?45,"|Signature of Responsible Official",?79,"|Date"
 W !,"Suitable Substitutes",?45,"|or Designee",?79,"|"
 W !," VA     GSA            NOT AVAILABLE FROM",?45,"|",?79,"|"
 W !," STOCK  STOCK  EXCESS  ANY OF THESE SOURCES",?45,"|",?79,"|",!,$E(L,1,45)
 W "|",$E(L,1,33),"|",$E(L,1,10),!,"Signature of Accountable",?25,"|Date",?45,"|(Check Applicable Statement)"
 W !,"Officer or Designee",?25,"|",?45,"|TURN-IN USE ONLY"
 N AO S AO=$P($G(^PRCS(410,DA,7)),"^",11) I AO'="" W !,$P($G(^VA(200,AO,0)),"^"),?25,"|"
 I AO="" W !,?25,"|"
 N AODATE S AODATE=$P($G(^PRCS(410,DA,7)),"^",12) I AODATE'="" S Y=AODATE D DD^%DT W $P(Y,"@")
 W ?45,"|   I CERTIFY that the quantities shown in",!,$E(L,1,25)
 W ?25,"|",$E(L,1,19),"|   ""ACTION"" column have been received and"
 W !,"Authority for and/or Method of Purchase",?45,"|   the turn-in circumstances cited appear"
 W !,?45,"|   reasonable. Disposition codes indicate",!,$E(L,1,45)
 W ?45,"|   action taken."
 W !,"I certify that the resultant contract is",?45,"|RECEIVING REPORT USE ONLY"
 W !,"authorized by law and is within the limits",?45,"|   The articles or services listed hereon"
 W !,"of my authority.",?45,"|   have been received or rendered and are"
 W !,?45,"|   accepted, except as noted.",!,$E(L,1,45)
 W "|",$E(L,1,44)
 I $Y>57 D NEWP^PRCSP121
 W !,"Signature of Contracting Officer",?45,"|Signature of Storekeeper",?78,"|Date",!,?45,"|",?78,"|",!,$E(L,1,45)
 W ?45,"|",$E(L,1,32)
 W ?78,"|",$E(L,1,11)
 W !,"Purchase Order or Req. No|Date of P.O. or Req|Signature of Accountable Officer",?78,"|Date",!,?25,"|",?45,"|",?78,"|",!,$E(L,1,25)
 W ?25,"|",$E(L,1,19),"|",$E(L,1,32),?78,"|",$E(L,1,11) I $Y>53 D NEWP^PRCSP121
 W !,"FUND CERTIFICATION: The Supplies/Services",?45,"|Date of Voucher",?58,"|Voucher No."
 W !,"listed on this request are properly charge-",?45,"|",?61,"|"
 W !,"able to the following allotments, the avail-",?45,"|",?61,"|"
 W !,"able balances of which are sufficient to",?45,"|",$E(L,1,15)
 W ?61,"|",$E(L,1,28)
 W !,"cover the cost thereof, and funds have",?45,"|Obligated By",?78,"|Date"
 W !,"been obligated.",?45,"|",?78,"|",!,$E(L,1,45)
 W ?45,"|",?78,"|",!,"Appropriation and Accounting Symbols",?45,"|",?78,"|",!
 S P=$P(^PRCS(410,DA,0),U,5) I $D(^(3)) S X=^(3) S:$P(X,U,2)'="" P=P_"-"_$P(X,U,2) S:$P(X,U)'="" P=P_"-"_$P($P(X,U)," ") S:$P(X,U,3)'="" P=P_"-"_$P($P(X,U,3)," ")
 S:$D(PRCS("SUB")) P=P_"-"_PRCS("SUB")
 I $D(^PRCS(410,DA,4)),$P(^(4),U,5)'="" S P=P_"-"_$P(^(4),U,5)
 S FPROJ=$P($G(^PRCS(410,DA,3)),"^",12) S P=P_" "_FPROJ
 W P,?45,"|",?78,"|",!,$E(L,1,45)
 W ?45,"|",$E(L,1,32)
 W ?78,"|",$E(L,1,11),!,"VA FORM 90-2237-ADP MAR 1985",!
 Q
