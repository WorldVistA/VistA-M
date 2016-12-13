IBXX2 ; COMPILED XREF FOR FILE #399.0222 ; 12/13/16
 ; 
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X="" X ^DD(399,232,1,2,2.4)
 S X=$P($G(DIKZ("U2")),U,10)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=$$CLIAREQ^IBCEP8A(DA) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,13),X=X S DIU=X K Y S X=DIV S X=$$CLIA^IBCEP8A(DA) X ^DD(399,232,1,3,2.4)
 S X=$P($G(DIKZ("U2")),U,10)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U3")):^("U3"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"U3")),DIV=X S $P(^("U3"),U,3)=DIV,DIH=399,DIG=244 D ^DICR
 S DIKZ("M1")=$G(^DGCR(399,DA,"M1"))
 S X=$P($G(DIKZ("M1")),U,8)
 I X'="" K ^DGCR(399,"AG",$E(X,1,30),DA)
 S DIKZ("MP")=$G(^DGCR(399,DA,"MP"))
 S X=$P($G(DIKZ("MP")),U,3)
 I X'="" K ^DGCR(399,"E",$E(X,1,30),DA)
 S X=$P($G(DIKZ("MP")),U,5)
 I X'="" K ^DGCR(399,"F",$E(X,1,30),DA)
 S X=$P($G(DIKZ("MP")),U,7)
 I X'="" K ^DGCR(399,"G",$E(X,1,30),DA)
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^DGCR(399,"B",$E(X,1,30),DA)
CR1 S DIXR=139
 K X
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X(1)=$P(DIKZ("M"),U,1)
 S X(2)=$P(DIKZ("M"),U,2)
 S X(3)=$P(DIKZ("M"),U,3)
 S X(4)=$P(DIKZ("M"),U,13)
 S X(5)=$P(DIKZ("M"),U,12)
 S X(6)=$P(DIKZ("M"),U,14)
 S X=$G(X(1))
 D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2),X2(3),X2(4),X2(5),X2(6))=""
 . N DIKXARR M DIKXARR=X S DIKCOND=1
 . S X=$S($O(^DGCR(399,DA,"PRV",0)):1,1:0)
 . S DIKCOND=$G(X) K X M X=DIKXARR
 . Q:'DIKCOND
 . D:X1(1)'=X2(1)!(X1(5)'=X2(5)) DELID^IBCEP3(DA,1) D:X1(2)'=X2(2)!(X1(4)'=X2(4)) DELID^IBCEP3(DA,2) D:X1(3)'=X2(3)!(X1(6)'=X2(6)) DELID^IBCEP3(DA,3)
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
