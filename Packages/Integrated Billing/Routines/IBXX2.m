IBXX2 ; COMPILED XREF FOR FILE #399 ; 12/12/16
 ; 
CR2 S DIXR=477
 K X
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X(1)=$P(DIKZ("M"),U,1)
 S X(2)=$P(DIKZ("M"),U,2)
 S X(3)=$P(DIKZ("M"),U,3)
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X(4)=$P(DIKZ(0),U,2)
 S X=$G(X(1))
 D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2),X2(3),X2(4))=""
 . N G I $G(X(4)) F G=1,2,3 I $G(X(G)) K ^DGCR(399,"AE",X(4),X(G),DA)
CR3 S DIXR=820
 K X
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X(1)=$P(DIKZ(0),U,22)
 S DIKZ("U2")=$G(^DGCR(399,DA,"U2"))
 S X(2)=$P(DIKZ("U2"),U,10)
 S DIKZ("MP")=$G(^DGCR(399,DA,"MP"))
 S X(3)=$P(DIKZ("MP"),U,2)
 S X(4)=$P(DIKZ(0),U,19)
 S X=$G(X(1))
 D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2),X2(3),X2(4))=""
 . D TAX^IBCEF79(DA)
CR4 S DIXR=989
 K X
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X(1)=$P(DIKZ(0),U,27)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . D CMAEDALL^IBCU9(DA)
CR5 K X
END G ^IBXX3
