PSOXZA4 ; COMPILED XREF FOR FILE #52.1 ; 09/24/12
 ; 
 S DA=0
A1 ;
 I $D(DIKILL) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^PSRX(DA(1),1,DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^PSRX(DA(1),1,DA,0))
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I X="W",+$G(^PSRX(DA(1),"IB")) K:$P($G(^PSRX(DA(1),0)),"^",2)&('$P($G(^PSRX(DA(1),1,DA,0)),"^",16))&('$P($G(^(0)),"^",18))&('$G(^("IB"))) ^PSRX("ACP",$P(^PSRX(DA(1),0),"^",2),+$P($G(^PSRX(DA(1),1,DA,0)),"^"),DA,DA(1))
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" D KAS1^PSOSUTL
 S X=$P($G(DIKZ(0)),U,16)
 I X'="" K ^PSRX("AJ",$E(X,1,30),DA(1),DA)
 S X=$P($G(DIKZ(0)),U,18)
 I X'="" K ^PSRX("AL",$E(X,1,30),DA(1),DA)
 S X=$P($G(DIKZ(0)),U,18)
 I X'="" I $P($G(^PSRX(DA(1),0)),"^",2),+$G(^("IB")) S:$P($G(^PSRX(DA(1),1,DA,0)),"^")&($P($G(^(0)),"^",2)="W")&('$P($G(^(0)),"^",16))&('$G(^("IB"))) ^PSRX("ACP",$P(^PSRX(DA(1),0),"^",2),$P(^PSRX(DA(1),1,DA,0),"^"),DA,DA(1))=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^PSRX(DA(1),1,"B",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^PSRX("AD",$E(X,1,30),DA(1),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" X ^DD(52.1,.01,1,3,2)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D K52^PSOUTL
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D KPR^PSOUTL
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$G(^PSRX(DA(1),"IB")) K:$P($G(^PSRX(DA(1),0)),"^",2)&($P($G(^PSRX(DA(1),1,DA,0)),"^",2)="W")&('$P($G(^(0)),"^",16))&('$P($G(^(0)),"^",18))&('$G(^("IB"))) ^PSRX("ACP",$P(^PSRX(DA(1),0),"^",2),X,DA,DA(1))
CR1 S DIXR=462
 K X
 S DIKZ(0)=$G(^PSRX(DA(1),1,DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,18)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . D SKIDX^PSOPXRMU(.X,.DA,"R","K")
CR2 K X
 G:'$D(DIKLM) A Q:$D(DIKILL)
END G ^PSOXZA5
