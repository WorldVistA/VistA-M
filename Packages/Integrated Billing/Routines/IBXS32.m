IBXS32 ; ;03/14/19
 S X=DE(33),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M")):^("M"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(399,114,1,1,2.4)
 S X=DE(33),DIC=DIE
 D KIX^IBCNS2(DA,"I3")
 S X=DE(33),DIC=DIE
 X ^DD(399,114,1,3,2.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(399,114,1,3,2.4)
 S X=DE(33),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,9),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"U2")),DIV=X S $P(^("U2"),U,9)=DIV,DIH=399,DIG=231 D ^DICR
 S X=DE(33),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"UF32")):^("UF32"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"UF32")),DIV=X S $P(^("UF32"),U,3)=DIV,DIH=399,DIG=255 D ^DICR
