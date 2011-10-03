PRCAFN ;WASH-ISC@ALTOONA,PA/RGY-Functions to return AR data ;4/3/95  8:24 AM
V ;;4.5;Accounts Receivable;**2,48,120,144**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Note: These functions are only valid for non-patient and non-
 ;means test patient bills.  The category type of the bill
 ;must not be a PATIENT or MEANS TEST PATIENT type for these
 ;functions to work.  (Except for the PST, PUR, and CATN functions).
 ;
 ;Note: All functions return a -1 if unable to determine
 ;
BN(Y) ;Input: Internal Bill #
 ;Return: Action number or -1
 D CHK I Y>0 S Y=$S('$D(Y)#2:-1,Y="":-1,1:$P($G(^PRCA(430,Y,0)),"^")) S:Y="" Y=-1
 Q Y
 ;
CAT(Y) ;Input: Internal Bill #
 ;Return: Category #^Category name^Category Type or -1
 ;
 D CHK I Y>0 S Y=$S('$D(Y)#2:-1,Y="":-1,1:$G(^PRCA(430.2,+$P($G(^PRCA(430,Y,0)),"^",2),0))) S:Y="" Y=-1 S:Y'=-1 Y=$P(Y,"^",7)_"^"_$P(Y,"^")_"^"_$P(Y,"^",6)
 Q Y
CATN(Y) ;Input: Category Internal Number (430.2)
 ;Return: Category #^Category name^Category Type or -1
 S Y=$S('$D(Y)#2:-1,1:$G(^PRCA(430.2,+Y,0))) S:Y="" Y=-1 S:Y'=-1 Y=$P(Y,"^",7)_"^"_$P(Y,"^")_"^"_$P(Y,"^",6)
 Q Y
 ;
TPR(Y) ;Input: Internal Bill #
 ;Return: Total paid principal or -1
 D CHK I Y>0 S Y=$S('$D(Y)#2:-1,Y="":-1,1:+$P($G(^PRCA(430,Y,7)),"^",7))
 Q Y
 ;
ORI(Y) ;Input: Internal Bill #
 ;Return: Original amount or -1
 D CHK I Y>0 S Y=$S('$D(Y)#2:-1,Y="":-1,$G(^PRCA(430,Y,0))="":-1,1:+$P(^(0),"^",3))
 Q Y
 ;
STA(Y) ;Input: Internal Bill #
 ;Return: Status #^Status name or -1
 D CHK I Y'=-1 S Y=$S('$D(Y)#2:-1,Y="":-1,1:$G(^PRCA(430.3,+$P($G(^PRCA(430,Y,0)),"^",8),0))) S:Y="" Y=-1 S:Y'=-1 Y=$P(Y,"^",3)_"^"_$P(Y,"^")
 Q Y
 ;
 ;
CLO(BILLDA) ;  input: internal bill #
 ;  return: date the bill was closed
 ;          -1 for patient or means test
 ;          -2 if bill not closed
 ;
 N DATE,STAT,TYPE
 ;  if type of bill category is for patient or means test quit -1
 S TYPE=$P($G(^PRCA(430.2,+$P($G(^PRCA(430,BILLDA,0)),"^",2),0)),"^",6)
 I TYPE="P"!(TYPE="C") Q -1
 ;
 ;  do not look at bills never activated
 ;I '$P($P($G(^PRCA(430,BILLDA,6)),"^",21),".") Q -2
 ;
 ;  bill not closed
 S STAT=$P($G(^PRCA(430,BILLDA,0)),"^",8)
 I STAT'=22,STAT'=23,STAT'=26,STAT'=39,STAT'=48,STAT'=49 Q -2
 ;
 S DATE=$P($G(^PRCA(430,BILLDA,0)),"^",14)
 Q DATE
 ;
 ;
PST(Y) ;
 Q $$PST^RCAMFN01($G(Y))
CHK ;
 S Y=$S('$D(Y)#2:-1,",C,P,"[(","_$P($G(^PRCA(430.2,+$P($G(^PRCA(430,+Y,0)),"^",2),0)),"^",6)_","):-1,1:Y)
 Q
PUR(Y) ;Input: Internal Bill #
 ;Return: Date Bill can be purged (FM format) or
 ;Return: -1 Do Not Purge
 ;Return: -2 Purge but no Date, does not exist or Archived
 NEW BN0,X,Z,LST
 I $G(Y)="" S Y=-1 G PURQ
 S BN0=$G(^PRCA(430,Y,0)) I BN0']"" S Y=-2 G PURQ
 I "^220^102^110^104^112^107^113^240^230^205^"[("^"_$P($G(^PRCA(430.3,+$P(BN0,"^",8),0)),"^",3)_"^") S Y=-1 G PURQ
 I $P($G(^PRCA(430.3,+$P(BN0,"^",8),0)),"^",3)=115 S Y=-2 G PURQ
 S Z=0 F X=0:0 S X=$O(^PRCA(433,"C",Y,X)) Q:'X  S Z=$S(+$P($G(^PRCA(433,X,1)),"^",9):$P(^(1),"^",9),1:+$G(^PRCA(433,X,1)))
 I Z S LST(9999999-Z)=""
 S Z=$G(^PRCA(430,Y,6)) F X=3:-1:1 I $P(Z,"^",X) S LST(9999999-$P(Z,"^",X))="" Q
 S LST(9999999-$P(BN0,U,10))=""
 S Z=9999999-$O(LST(0)) S:'Z Z=-2
 S Y=Z
PURQ Q $P(Y,".")
RETN(Y) ;Input: Internal Bill #
 ;Return: 1 if bill was returned to IB, 0 if bill was not returned to IB
 Q ",220,"[(","_$P($G(^PRCA(430.3,+$P($G(^PRCA(430,+Y,0)),"^",8),0)),"^",3)_",")
BAL(DEBT) ;Input: IEN of file 340 or Varable ptr value of debtor
 NEW STAT,X,Y,TOTAL,BILL,BAT,TRAN
 S TOTAL="-"
 I $G(DEBT)'?1N.N,$G(DEBT)'?1N.N1";".A1"(" G Q8
 I DEBT?1N.N1";".E S DEBT=$$DEBT^RCEVUTL(DEBT) ;+$O(^RCD(340,"B",DEBT,0))
 I $G(^RCD(340,DEBT,0))="" G Q8
 S TOTAL=0
 F STAT=$O(^PRCA(430.3,"AC",102,0)),$O(^PRCA(430.3,"AC",107,0)),$O(^PRCA(430.3,"AC",112,0)) F BILL=0:0 S BILL=$O(^PRCA(430,"AS",DEBT,STAT,BILL)) Q:'BILL  D:$G(^PRCA(430,BILL,0))]""
 .S X=$G(^PRCA(430,BILL,7)),Y=$P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5)
 .I $P(^PRCA(430,BILL,0),"^",2)=$O(^PRCA(430.2,"AC",33,0)) S Y=-Y
 .S TOTAL=TOTAL+$S($P(^PRCA(430,BILL,0),"^",2)=$O(^PRCA(430.2,"AC",33,0))&(STAT'=$O(^PRCA(430.3,"AC",112,0))):0,1:Y)
 .Q
 S DEBT=$P(^RCD(340,DEBT,0),"^")
 F BAT=0:0 S BAT=$O(^RCY(344,"AC",DEBT,BAT)) Q:'BAT  F TRAN=0:0 S TRAN=$O(^RCY(344,"AC",DEBT,BAT,TRAN)) Q:'TRAN  I $G(^RCY(344,BAT,1,TRAN,0))]"",$P(^(0),"^",5)="" S TOTAL=TOTAL-$P(^(0),"^",4)
Q8 Q TOTAL
 ;
BN1(Y) ;Input: Internal Bill #
 ;Return: Action number or -1
 S Y=$S('$D(Y)#2:-1,Y="":-1,1:$P($G(^PRCA(430,Y,0)),"^")) S:Y="" Y=-1
 Q Y
