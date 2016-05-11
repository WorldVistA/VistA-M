ORD28 ; COMPILED XREF FOR FILE #100 ; 03/10/16
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^OR(100,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^OR(100,"AZ",DA,$P(^OR(100,DA,0),U,2))=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D SETALL^ORDD100(DA)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" X ^DD(100,.02,1,5,1)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" X ^DD(100,.02,1,7,1)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D WS^ORDD100
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D OI1^ORDD100A(DA)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" X ^DD(100,.02,1,11,1)
 S DIKZ(0)=$G(^OR(100,DA,0))
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" S ^OR(100,"C",$E(X,1,30),DA)=""
 S DIKZ(3)=$G(^OR(100,DA,3))
 S X=$P($G(DIKZ(3)),U,4)
 I X'="" S ^OR(100,"D",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,8)
 I X'="" D SS^ORDD100
 S X=$P($G(DIKZ(0)),U,8)
 I X'="" D WS^ORDD100
 S X=$P($G(DIKZ(0)),U,8)
 I X'="" D OI1^ORDD100A(DA)
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" D ES^ORDD100A
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" D WS^ORDD100
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" X ^DD(100,23,1,3,1)
CR1 S DIXR=187
 K X
 S DIKZ(0)=$G(^OR(100,DA,0))
 S X(1)=$P(DIKZ(0),U,2)
 S X(2)=$P(DIKZ(0),U,17)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S ^OR(100,"AEVNT",X(1),X(2),DA)=""
CR2 S DIXR=210
 K X
 S DIKZ(0)=$G(^OR(100,DA,0))
 S X(1)=$P(DIKZ(0),U,2)
 S DIKZ(7)=$G(^OR(100,DA,7))
 S X=$P(DIKZ(7),U,1)
 I $G(X)]"" S X=9999999-X
 S:$D(X)#2 X(2)=X
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S ^OR(100,"ARS",X(1),X(2),DA)=""
CR3 K X
END G ^ORD29
