IBXX4 ; COMPILED XREF FOR FILE #399.0304 ; 01/15/20
 ; 
 S DA=0
A1 ;
 I $D(DIKILL) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^DGCR(399,DA(1),"CP",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^DGCR(399,DA(1),"CP",DA,0))
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $D(^DGCR(399,DA(1),"CP",DA,0)),+^(0),$P($P(^(0),"^",1),";",2)="ICPT(" K ^DGCR(399,"ASD",-X,+^(0),DA(1),DA)
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" K ^DGCR(399,DA(1),"CP","D",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" S DGRVRCAL=2
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" K ^DGCR(399,DA(1),"CP","ASC",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,0)):^(0),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" X ^DD(399.0304,6,1,1,2.4)
 S DIKZ(0)=$G(^DGCR(399,DA(1),"CP",DA,0))
 S X=$P($G(DIKZ(0)),U,10)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,0)):^(0),1:"") S X=$P(Y(1),U,16),X=X S DIU=X K Y S X="" X ^DD(399.0304,9,1,1,2.4)
 S DIKZ(1)=$G(^DGCR(399,DA(1),"CP",DA,1))
 S X=$P($G(DIKZ(1)),U,7)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399.0304,53,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,1)):^(1),1:""),Y(1)=$S($D(^DGCR(399,D0,"CP",D1,2)):^(2),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(399.0304,53,1,1,2.4)
 S X=$P($G(DIKZ(1)),U,7)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399.0304,53,1,2,2.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,1)):^(1),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"CP",DIV(1),1)),DIV=X S $P(^(1),U,8)=DIV,DIH=399.0304,DIG=54 D ^DICR
 S DIKZ(0)=$G(^DGCR(399,DA(1),"CP",DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^DGCR(399,DA(1),"CP","B",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I $P(X,";",2)="ICPT(",$D(^DGCR(399,DA(1),"CP",DA,0)),$P(^(0),"^",2) K ^DGCR(399,"ASD",-$P(^(0),"^",2),+X,DA(1),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,0)):^(0),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(399.0304,.01,1,3,2.4)
CR1 S DIXR=991
 K X
 S DIKZ(0)=$G(^DGCR(399,DA(1),"CP",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . D FROMPROC^IBCU9(DA(1),DA,"D")
CR2 K X
 G:'$D(DIKLM) A Q:$D(DIKILL)
END G ^IBXX5
