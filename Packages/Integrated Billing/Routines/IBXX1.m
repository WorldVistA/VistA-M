IBXX1 ; COMPILED XREF FOR FILE #399 ; 01/15/20
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" K ^DGCR(399,"C",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" K ^DGCR(399,"D",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" S IBN=$P(^DGCR(399,DA,0),"^",2) I $D(IBN) K ^DGCR(399,"APDT",IBN,DA,9999999-X),IBN
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" K ^DGCR(399,"ABNDT",DA,9999999-X)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" K ^DGCR(399,"ABT",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,.07,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U")):^("U"),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X=DIV S X=0 X ^DD(399,.07,1,1,2.4)
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" K ^DGCR(399,"AD",$E(X,1,30),DA)
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X=$P($G(DIKZ(0)),U,8)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U")):^("U"),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" X ^DD(399,.08,1,4,2.4)
 S X=$P($G(DIKZ(0)),U,8)
 I X'="" K ^DGCR(399,"APTF",$E(X,1,30),DA)
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" D DEL^IBCU5
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" S DGRVRCAL=2
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=$S($P(^DGCR(399,DA,0),U,11)'="i":1,"PST"'[$P(^DGCR(399,DA,0),U,21):1,1:0) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,0)):^(0),1:"") S X=$P(Y(1),U,21),X=X S DIU=X K Y S X="" X ^DD(399,.11,1,4,2.4)
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" I $P(^DGCR(399,DA,0),U,2) K ^DGCR(399,"AOP",$P(^(0),U,2),DA)
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" K ^DGCR(399,"AST",+X,DA)
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,.13,1,4,2.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"TX")):^("TX"),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X=DIV S X="0" S DIH=$G(^DGCR(399,DIV(0),"TX")),DIV=X S $P(^("TX"),U,5)=DIV,DIH=399,DIG=24 D ^DICR
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X=$P($G(DIKZ(0)),U,17)
 I X'="" K ^DGCR(399,"AC",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,19)
 I X'="" S DGRVRCAL=2
 S X=$P($G(DIKZ(0)),U,19)
 I X'="" D ALLID^IBCEP3(DA,.19,2)
 S X=$P($G(DIKZ(0)),U,19)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,1)=DIV,DIH=399,DIG=140 D ^DICR
 S X=$P($G(DIKZ(0)),U,19)
 I X'="" D ATTREND^IBCU1(DA,"","")
 S X=$P($G(DIKZ(0)),U,19)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,2)=DIV,DIH=399,DIG=141 D ^DICR
 S X=$P($G(DIKZ(0)),U,19)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,3)=DIV,DIH=399,DIG=142 D ^DICR
 S X=$P($G(DIKZ(0)),U,19)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,4)=DIV,DIH=399,DIG=143 D ^DICR
 S X=$P($G(DIKZ(0)),U,19)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,5)=DIV,DIH=399,DIG=144 D ^DICR
 S X=$P($G(DIKZ(0)),U,19)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,6)=DIV,DIH=399,DIG=145 D ^DICR
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X=$P($G(DIKZ(0)),U,21)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(399,.21,1,1,2.4)
 S X=$P($G(DIKZ(0)),U,21)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=('$$REQMRA^IBEFUNC(DA)&$$NEEDMRA^IBEFUNC(DA)) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"TX")):^("TX"),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" X ^DD(399,.21,1,2,2.4)
 S X=$P($G(DIKZ(0)),U,21)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=$$DELETE^IBCEF84(DA) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"TX")):^("TX"),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" X ^DD(399,.21,1,4,2.4)
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X=$P($G(DIKZ(0)),U,25)
 I X'="" D ALLID^IBCEP3(DA,.25,2)
 S DIKZ("S")=$G(^DGCR(399,DA,"S"))
 S X=$P($G(DIKZ("S")),U,1)
 I X'="" K ^DGCR(399,"APD",$E(X,1,30),DA)
 S X=$P($G(DIKZ("S")),U,7)
 I X'="" K ^DGCR(399,"APM",$E(X,1,30),DA)
 S X=$P($G(DIKZ("S")),U,10)
 I X'="" K ^DGCR(399,"APD3",$E(X,1,30),DA)
 S X=$P($G(DIKZ("S")),U,12)
 I X'="" K ^DGCR(399,"AP",$E(X,1,30),DA)
 S DIKZ("TX")=$G(^DGCR(399,DA,"TX"))
 S X=$P($G(DIKZ("TX")),U,2)
 I X'="" K ^DGCR(399,"ALEX",$E(X,1,30),DA)
 S DIKZ("S1")=$G(^DGCR(399,DA,"S1"))
 S X=$P($G(DIKZ("S1")),U,7)
 I X'="" K ^DGCR(399,"CAP",$E(X,1,30),DA)
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X=$P($G(DIKZ("M")),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I $$COBN^IBCEF(DA)=1 I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"TX")):^("TX"),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" X ^DD(399,101,1,2,2.4)
 S X=$P($G(DIKZ("M")),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=$$DELETE^IBCEF84(DA) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"TX")):^("TX"),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" X ^DD(399,101,1,5,2.4)
 S X=$P($G(DIKZ("M")),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,1)=DIV,DIH=399,DIG=140 D ^DICR
 S X=$P($G(DIKZ("M")),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,2)=DIV,DIH=399,DIG=141 D ^DICR
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X=$P($G(DIKZ("M")),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I $$COBN^IBCEF(DA)=2 I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"TX")):^("TX"),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" X ^DD(399,102,1,3,2.4)
 S X=$P($G(DIKZ("M")),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,3)=DIV,DIH=399,DIG=142 D ^DICR
 S X=$P($G(DIKZ("M")),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,4)=DIV,DIH=399,DIG=143 D ^DICR
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X=$P($G(DIKZ("M")),U,3)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,6)=DIV,DIH=399,DIG=145 D ^DICR
 S X=$P($G(DIKZ("M")),U,3)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,5)=DIV,DIH=399,DIG=144 D ^DICR
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X=$P($G(DIKZ("M")),U,11)
 I X'="" D DEL^IBCU5
 S X=$P($G(DIKZ("M")),U,11)
 I X'="" S DGRVRCAL=2
 S X=$P($G(DIKZ("M")),U,12)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M")):^("M"),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(399,112,1,1,2.4)
 S X=$P($G(DIKZ("M")),U,12)
 I X'="" D KIX^IBCNS2(DA,"I1")
 S X=$P($G(DIKZ("M")),U,12)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,112,1,3,2.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(399,112,1,3,2.4)
 S X=$P($G(DIKZ("M")),U,12)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U")):^("U"),1:"") S X=$P(Y(1),U,13),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"U")),DIV=X S $P(^("U"),U,13)=DIV,DIH=399,DIG=163 D ^DICR
 S X=$P($G(DIKZ("M")),U,12)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"UF32")):^("UF32"),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"UF32")),DIV=X S $P(^("UF32"),U,1)=DIV,DIH=399,DIG=253 D ^DICR
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X=$P($G(DIKZ("M")),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M")):^("M"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(399,113,1,1,2.4)
 S X=$P($G(DIKZ("M")),U,13)
 I X'="" D KIX^IBCNS2(DA,"I2")
 S X=$P($G(DIKZ("M")),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,113,1,3,2.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(399,113,1,3,2.4)
 S X=$P($G(DIKZ("M")),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"U2")),DIV=X S $P(^("U2"),U,8)=DIV,DIH=399,DIG=230 D ^DICR
 S X=$P($G(DIKZ("M")),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"UF32")):^("UF32"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"UF32")),DIV=X S $P(^("UF32"),U,2)=DIV,DIH=399,DIG=254 D ^DICR
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X=$P($G(DIKZ("M")),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M")):^("M"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(399,114,1,1,2.4)
 S X=$P($G(DIKZ("M")),U,14)
 I X'="" D KIX^IBCNS2(DA,"I3")
 S X=$P($G(DIKZ("M")),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,114,1,3,2.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(399,114,1,3,2.4)
 S X=$P($G(DIKZ("M")),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,9),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"U2")),DIV=X S $P(^("U2"),U,9)=DIV,DIH=399,DIG=231 D ^DICR
 S X=$P($G(DIKZ("M")),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"UF32")):^("UF32"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"UF32")),DIV=X S $P(^("UF32"),U,3)=DIV,DIH=399,DIG=255 D ^DICR
 S DIKZ("M1")=$G(^DGCR(399,DA,"M1"))
 S X=$P($G(DIKZ("M1")),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,2)="" I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,10),X=X S DIU=X K Y S X="" X ^DD(399,122,1,1,2.4)
 S DIKZ("M1")=$G(^DGCR(399,DA,"M1"))
 S X=$P($G(DIKZ("M1")),U,3)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,3)="" I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X="" X ^DD(399,123,1,1,2.4)
 S DIKZ("M1")=$G(^DGCR(399,DA,"M1"))
 S X=$P($G(DIKZ("M1")),U,4)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,4)="" I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" X ^DD(399,124,1,1,2.4)
 S DIKZ("MP")=$G(^DGCR(399,DA,"MP"))
 S X=$P($G(DIKZ("MP")),U,1)
 I X'="" D DEL^IBCU5
 S X=$P($G(DIKZ("MP")),U,1)
 I X'="" S DGRVRCAL=2
 S X=$P($G(DIKZ("MP")),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(399,136,1,1,2.4)
 S DIKZ("M2")=$G(^DGCR(399,DA,"M2"))
 S X=$P($G(DIKZ("M2")),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,2)=DIV,DIH=399,DIG=141 D ^DICR
 S DIKZ("M2")=$G(^DGCR(399,DA,"M2"))
 S X=$P($G(DIKZ("M2")),U,3)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,4)=DIV,DIH=399,DIG=143 D ^DICR
 S DIKZ("M2")=$G(^DGCR(399,DA,"M2"))
 S X=$P($G(DIKZ("M2")),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"M2")),DIV=X S $P(^("M2"),U,6)=DIV,DIH=399,DIG=145 D ^DICR
 S DIKZ("U")=$G(^DGCR(399,DA,"U"))
 S X=$P($G(DIKZ("U")),U,1)
 I X'="" S DGRVRCAL=2
 S X=$P($G(DIKZ("U")),U,1)
 I X'="" K:$P(^DGCR(399,DA,0),"^",2) ^DGCR(399,"APDS",$P(^(0),U,2),-X,DA)
 S X=$P($G(DIKZ("U")),U,2)
 I X'="" S DGRVRCAL=2
 S DIKZ("U1")=$G(^DGCR(399,DA,"U1"))
 S X=$P($G(DIKZ("U1")),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,202,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"U1")),DIV=X S $P(^("U1"),U,3)=DIV,DIH=399,DIG=203 D ^DICR
 S DIKZ("U2")=$G(^DGCR(399,DA,"U2"))
 S X=$P($G(DIKZ("U2")),U,4)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU-X X ^DD(399,218,1,1,2.4)
 S DIKZ("U2")=$G(^DGCR(399,DA,"U2"))
 S X=$P($G(DIKZ("U2")),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU-X X ^DD(399,219,1,1,2.4)
 S DIKZ("U2")=$G(^DGCR(399,DA,"U2"))
 S X=$P($G(DIKZ("U2")),U,6)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU-X X ^DD(399,220,1,1,2.4)
 S DIKZ("U2")=$G(^DGCR(399,DA,"U2"))
 S X=$P($G(DIKZ("U2")),U,10)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" X ^DD(399,232,1,1,2.4)
 S X=$P($G(DIKZ("U2")),U,10)
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
END G ^IBXX2
