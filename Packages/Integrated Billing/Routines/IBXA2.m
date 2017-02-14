IBXA2 ; COMPILED XREF FOR FILE #350 ; 12/20/16
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^IB(DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^IB("B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" S ^IB("C",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^IB(DA,0)),$P(^(0),"^",17) S ^IB("AFDT",X,-$P(^(0),"^",17),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^IB(DA,1)),$P(^(1),"^",2) S ^IB("APTDT",X,$P(^(1),"^",2),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^IB(DA,0)),$P(^(0),U,5)=8 S ^IB("AH",X,DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^IB(DA,0)),$P(^(0),U,5)=99 S ^IB("AI",X,DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I X,$D(^IB(DA,1)),$P(^(1),"^",5) S ^IB("ACVA",X,$P(^(1),"^",5),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^IB(DA,0)),$P(^(0),U,5)=21 S ^IB("AJ",X,DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^IB(DA,1)),$P(^IB(DA,1),U,6) S ^IB("AHDT",X,+$P(^IB(DA,0),U,5),$P(^IB(DA,1),U,6),DA)=""
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" S ^IB("AE",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" S ^IB("AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^IB(D0,1)):^(1),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X=$S($D(IBDUZ):IBDUZ,$D(DUZ):DUZ,1:.5) S DIH=$G(^IB(DIV(0),1)),DIV=X S $P(^(1),U,3)=DIV,DIH=350,DIG=13 D ^DICR
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^IB(D0,1)):^(1),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X=DIV N %I,%H,% D NOW^%DTC S X=% X ^DD(350,.05,1,3,1.4)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I X=1,$D(^IB(DA,0)),$P($G(^IBE(350.1,+$P(^(0),"^",3),0)),"^")'["ADMISSION",$P(^IB(DA,0),"^",16) S ^IB("ACT",$P(^(0),"^",16),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I X=8,$P(^IB(DA,0),U,2) S ^IB("AH",$P(^IB(DA,0),U,2),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I X=99,$P(^IB(DA,0),U,2) S ^IB("AI",$P(^IB(DA,0),U,2),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I X=21,$P(^IB(DA,0),U,2) S ^IB("AJ",$P(^IB(DA,0),U,2),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I X=8 I X S X=DIV S Y(1)=$S($D(^IB(D0,1)):^(1),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X=DIV N %I,%H,% D NOW^%DTC X ^DD(350,.05,1,8,1.4)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I $D(^IB(DA,1)),$P(^IB(DA,1),U,6) S ^IB("AHDT",+$P(^IB(DA,0),U,2),X,$P(^IB(DA,1),U,6),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=$P($G(^IBE(350.21,+Y(0),0)),U)="HOLD - REVIEW" I X S X=DIV S Y(1)=$S($D(^IB(D0,1)):^(1),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X=DIV N %I,%H,% D NOW^%DTC X ^DD(350,.05,1,10,1.4)
 S DIKZ(0)=$G(^IB(DA,0))
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" S ^IB("AD",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" I $D(^IB(DA,1)),$P(^(1),"^",2) S ^IB("APDT",$E(X,1,30),-$P(^(1),"^",2),DA)=""
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" S ^IB("ABIL",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" S ^IB("AT",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,16)
 I X'="" S ^IB("AF",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,16)
 I X'="" I $D(^IB(DA,0)),$P(^(0),"^",5)=1,$P($G(^IBE(350.1,+$P(^(0),"^",3),0)),"^")'["ADMISSION" S ^IB("ACT",X,DA)=""
 S X=$P($G(DIKZ(0)),U,17)
 I X'="" I $D(^IB(DA,0)),$P(^(0),"^",2) S ^IB("AFDT",$P(^(0),"^",2),-X,DA)=""
 S DIKZ(1)=$G(^IB(DA,1))
 S X=$P($G(DIKZ(1)),U,2)
 I X'="" S ^IB("D",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(1)),U,2)
 I X'="" I $P(^IB(DA,0),"^",9) S ^IB("APDT",$P(^(0),"^",9),-X,DA)=""
 S X=$P($G(DIKZ(1)),U,2)
 I X'="" I $D(^IB(DA,0)),$P(^(0),"^",2) S ^IB("APTDT",$P(^(0),"^",2),X,DA)=""
 S X=$P($G(DIKZ(1)),U,5)
 I X'="" I X,$D(^IB(DA,0)),$P(^(0),"^",2) S ^IB("ACVA",$P(^(0),"^",2),X,DA)=""
 S X=$P($G(DIKZ(1)),U,6)
 I X'="" I $D(^IB(DA,1)),$P(^IB(DA,1),U,6) S ^IB("AHDT",+$P(^IB(DA,0),U,2),+$P(^IB(DA,0),U,5),X,DA)=""
END Q
