IBXA1 ; COMPILED XREF FOR FILE #350 ; 02/28/23
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^IB(DA,0))
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" K ^IB("C",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^IB(DA,0)),$P(^(0),"^",17) K ^IB("AFDT",X,-$P(^(0),"^",17),DA)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^IB(DA,1)),$P(^(1),"^",2) K ^IB("APTDT",X,$P(^(1),"^",2),DA)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^IB(DA,0)),$P(^(0),U,5)=8 K ^IB("AH",X,DA)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^IB(DA,0)),$P(^(0),U,5)=99 K ^IB("AI",X,DA)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I X,$D(^IB(DA,1)),$P(^(1),"^",5) K ^IB("ACVA",X,$P(^(1),"^",5),DA)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" K ^IB("AJ",X,DA)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^IB(DA,1)),$P(^IB(DA,1),U,6) K ^IB("AHDT",X,+$P(^IB(DA,0),U,5),$P(^IB(DA,1),U,6),DA)
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" K ^IB("AE",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" K ^IB("AC",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^IB(D0,1)):^(1),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X=$S($D(IBDUZ):IBDUZ,$D(DUZ):DUZ,1:.5) S DIH=$G(^IB(DIV(0),1)),DIV=X S $P(^(1),U,3)=DIV,DIH=350,DIG=13 D ^DICR
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^IB(D0,1)):^(1),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X=DIV N %I,%H,% D NOW^%DTC S X=% X ^DD(350,.05,1,3,2.4)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I $D(^IB(DA,0)),$P(^(0),"^",16) K ^IB("ACT",$P(^(0),"^",16),DA)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I $P(^IB(DA,0),U,2) K ^IB("AH",$P(^IB(DA,0),U,2),DA)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I $P(^IB(DA,0),U,2) K ^IB("AI",$P(^IB(DA,0),U,2),DA)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I $P(^IB(DA,0),U,2) K ^IB("AJ",$P(^IB(DA,0),U,2),DA)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I $D(^IB(DA,1)),$P(^IB(DA,1),U,6) K ^IB("AHDT",+$P(^IB(DA,0),U,2),X,$P(^IB(DA,1),U,6),DA)
 S DIKZ(0)=$G(^IB(DA,0))
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" K ^IB("AD",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" I $D(^IB(DA,1)),$P(^(1),"^",2) K ^IB("APDT",$E(X,1,30),-$P(^(1),"^",2),DA)
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" K ^IB("ABIL",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" K ^IB("AT",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,16)
 I X'="" K ^IB("AF",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,16)
 I X'="" K ^IB("ACT",X,DA)
 S X=$P($G(DIKZ(0)),U,17)
 I X'="" I $D(^IB(DA,0)),$P(^(0),"^",2) K ^IB("AFDT",$P(^(0),"^",2),-X,DA)
 S DIKZ(1)=$G(^IB(DA,1))
 S X=$P($G(DIKZ(1)),U,2)
 I X'="" K ^IB("D",$E(X,1,30),DA)
 S X=$P($G(DIKZ(1)),U,2)
 I X'="" I $P(^IB(DA,0),"^",9) K ^IB("APDT",$P(^(0),"^",9),-X,DA)
 S X=$P($G(DIKZ(1)),U,2)
 I X'="" I $D(^IB(DA,0)),$P(^(0),"^",2) K ^IB("APTDT",$P(^(0),"^",2),X,DA)
 S X=$P($G(DIKZ(1)),U,5)
 I X'="" I X,$D(^IB(DA,0)),$P(^(0),"^",2) K ^IB("ACVA",$P(^(0),"^",2),X,DA)
 S X=$P($G(DIKZ(1)),U,6)
 I X'="" I $D(^IB(DA,1)),$P(^IB(DA,1),U,6) K ^IB("AHDT",+$P(^IB(DA,0),U,2),+$P(^IB(DA,0),U,5),X,DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^IB("B",$E(X,1,30),DA)
CR1 S DIXR=1717
 K X
 S X(1)=$P(DIKZ(0),U,2)
 S X(2)=$P(DIKZ(0),U,17)
 S X(3)=$P(DIKZ(0),U,14)
 S X=$G(X(1))
 D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2),X2(3))=""
 . D KACHDT^IBAUTL10
CR2 K X
END Q
