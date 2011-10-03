IBJDF811 ;ALB/RRG - AR PRODUCTIVITY REPORT (COMPILE-cont.) ;28-DEC-00
 ;;2.0;INTEGRATED BILLING;**123,159,192**;21-MAR-94
 ;
1 ; increase adjustment
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="INCREASE ADJUSTMENT"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
2 ; payment (in part)
 S TRXCAT=3,TRXCATN="PAYMENT",TRXTYPN="PAYMENT (IN PART)"
 S IB(3)=($P(IB(3),"^",1)+1)_"^"_($P(IB(3),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
3 ; refer to RC
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="REFER TO RC"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
4 ; refer to DOJ
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="REFER TO DOJ"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
5 ; reestablish to RC
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="REESTABLISH TO RC"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
6 ; returned by RC
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="RETURNED BY RC"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
7 ; cash collection by RC
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="CASH COLLECTION BY RC"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
8 ; terminate by fiscal officer
 S TRXCAT=7,TRXCATN="WRITE-OFF",TRXTYPN="TERMINATE BY FISCAL OFFICER"
 S IB(7)=($P(IB(7),"^",1)+1)_"^"_($P(IB(7),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
9 ; terminate by compromise
 S TRXCAT=10,TRXCATN="COMPROMISED",TRXTYPN="TERMINATE BY COMPROMISE"
 S IB(10)=($P(IB(10),"^",1)+1)_"^"_($P(IB(10),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
10 ; waived in full
 S TRXCAT=8,TRXCATN="WAIVED",TRXTYPN="WAIVED IN FULL"
 S IB(8)=($P(IB(8),"^",1)+1)_"^"_($P(IB(8),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
11 ; waived in part
 S TRXCAT=8,TRXCATN="WAIVED",TRXTYPN="WAIVED IN PART"
 S IB(8)=($P(IB(8),"^",1)+1)_"^"_($P(IB(8),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
12 ; admin cost charge
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="ADMIN COST CHARGE"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
13 ; interest/admin charge
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="INTEREST/ADMIN CHARGE"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
14 ; exempt interest/admin cost
 S TRXCAT=12,TRXCATN="EXEMPTION",TRXTYPN="EXEMPT INTEREST/ADMIN COST"
 S IB(12)=($P(IB(12),"^",1)+1)_"^"_($P(IB(12),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
15 ; incomplete
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="INCOMPLETE"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
16 ; active
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="ACTIVE"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
17 ; in-active
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="IN-ACTIVE"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
18 ; new bill
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="NEW BILL"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
19 ; suspense
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="SUSPENSE"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
20 ; pending approval
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="PENDING APPROVAL"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
21 ; pending calm code
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="PENDING CALM CODE"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
22 ; collected/closed
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="COLLECTED/CLOSED"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
23 ; write-off
 S TRXCAT=7,TRXCATN="WRITE-OFF",TRXTYPN="WRITE-OFF"
 S IB(7)=($P(IB(7),"^",1)+1)_"^"_($P(IB(7),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
24 ; marshal/court cost
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="MARSHAL/COURT COST"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
25 ; repayment plan
 S TRXCAT=11,(TRXCATN,TRXTYPN)="REPAYMENT PLAN"
 S IB(11)=($P(IB(11),"^",1)+1)_"^"_($P(IB(11),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
26 ; cancelled bill
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="CANCELLED BILL"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
27 ; bill incomplete
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="BILL INCOMPLETE"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
28 ; old bill
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="OLD BILL"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
29 ; terminate by RC
 S TRXCAT=10,TRXCATN="COMPROMISED",TRXTYPN="TERMINATE BY RC"
 S IB(10)=($P(IB(10),"^",1)+1)_"^"_($P(IB(10),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
30 ; debit voucher (sf 5515)
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="DEBIT VOUCHER (SF 5515)"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
31 ; returned from ar (new)
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="RETURNED FROM AR (NEW)"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
32 ; returned for amendment
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="RETURNED FOR AMENDMENT"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
33 ; amended bill
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="AMENDED BILL"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
34 ; payment (in full)
 S TRXCAT=3,TRXCATN="PAYMENT",TRXTYPN="PAYMENT (IN FULL)"
 S IB(3)=($P(IB(3),"^",1)+1)_"^"_($P(IB(3),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
35 ; decrease adjustment
 I +IBCONT D
 . S TRXCAT=5,TRXCATN="DEC.ADJ./CONTR",TRXTYPN="DEC.ADJ./CONTR"
 . S IB(5)=($P(IB(5),"^",1)+1)_"^"_($P(IB(5),"^",2)+IBTRAMT)_"^"_TRXCATN
 I '+IBCONT D
 . S TRXCAT=6,TRXCATN="DEC.ADJ./NON-CONTR",TRXTYPN="DEC.ADJ./NON-CONTR"
 . S IB(6)=($P(IB(6),"^",1)+1)_"^"_($P(IB(6),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
36 ; delete (amend)
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="DELETE (AMEND)"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
37 ; add (amend)
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="ADD (AMEND)"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
38 ; amend
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="AMEND"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
39 ; cancellation
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="CANCELLATION"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
40 ; suspended
 S TRXCAT=9,(TRXCATN,TRXTYPN)="SUSPENDED"
 S IB(9)=($P(IB(9),"^",1)+1)_"^"_($P(IB(9),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
41 ; refunded
 S TRXCAT=4,TRXCATN="REFUND",TRXTYPN="REFUNDED"
 S IB(4)=($P(IB(4),"^",1)+1)_"^"_($P(IB(4),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
42 ; open
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="OPEN"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
43 ; re-establish
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="RE-ESTABLISH"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
44 ; refund review
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="REFUND REVIEW"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
45 ; comment
 S TRXCAT=1,(TRXCATN,TRXTYPN)="COMMENT"
 S IB(1)=($P(IB(1),"^",1)+1)_"^"_($P(IB(1),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
46 ; unsuspended
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="UNSUSPENDED"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
47 ; charge suspended
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="CHARGE SUSPENDED"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
48 ; pending archive
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="PENDING ARCHIVE"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
49 ; archived
 S TRXCAT=13,TRXCATN="OTHER",TRXTYPN="ARCHIVED"
 S IB(13)=($P(IB(13),"^",1)+1)_"^"_($P(IB(13),"^",2)+IBTRAMT)_"^"_TRXCATN
 Q
 ;
