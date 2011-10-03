RCEVUTL ;WASH-ISC@ALTOONA,PA/RGY-Generic Event Utilities ;5/6/96  8:15 AM
V ;;4.5;Accounts Receivable;42;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DEBT(DEB) ;Return or add Debtor to debtor file
 NEW DIC,DLAYGO,X,Y
 S DEB=$G(DEB) I "^DPT(^DIC(36^DIC(4^PRC(440^VA(200^"'[("^"_$P($S(DEB'[";DPT(":$E(DEB,1,$L(DEB)-1),1:DEB),";",2)_"^") S DEB=-1 G Q1
 I '$D(@("^"_$P(DEB,";",2)_(+DEB)_",0)")) S DEB=-1 G Q1
 I '$O(^RCD(340,"B",DEB,0)) K DD,D0 S DIC="^RCD(340,",DLAYGO=340,X=DEB,DIC(0)="L" D FILE^DICN K D0 S DEB=$S(+Y>0:+Y,1:-1) G Q1
 S DEB=$O(^RCD(340,"B",DEB,0)) S:'DEB DEB=-1
Q1 Q DEB
EFF(TRAN) ;Return effect on balance
 S TRAN=$P($G(^RC(341.1,+$P($G(^RC(341,+$G(TRAN),0)),"^",2),0)),"^",3) S:TRAN="" TRAN=-1
Q3 Q TRAN
BAL(DEBT) ;Return amount owed by debtor
 S Y="" G:'$D(DEBT) Q4
 S:DEBT?1N.N1";"1A.A1"(" DEBT=$O(^RCD(340,"B",DEBT,0))
 S Y=$P($G(^RC(341,+$P($G(^RCD(340,DEBT,0)),"^",2),1)),"^",6,10)
Q4 Q Y
OVD(TRAN) ;Return effect on overdue
 S TRAN=$P($G(^RC(341.1,+$P($G(^RC(341,+$G(TRAN),0)),"^",2),0)),"^",5) S:TRAN="" TRAN=-1
 Q TRAN
BILT(BILL) ;Return amount of bill
 I $G(BILL)'?1N.N Q 0
 I $G(^PRCA(430,BILL,0))="" Q 0
 S X=$P($G(^PRCA(430,BILL,7)),"^",1,5)
 S $P(X,"^",6)=$P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5)
 Q X
BALO(DEBT) ;Return overdue amount for a debtor
 S Y="" G:'$D(DEBT) Q5
 S:DEBT?1N.N1";"1A.A1"(" DEBT=$O(^RCD(340,"B",DEBT,0))
 S Y=$P($G(^RC(341,+$P($G(^RCD(340,DEBT,0)),"^",2),1)),"^",11,15)
Q5 Q Y
