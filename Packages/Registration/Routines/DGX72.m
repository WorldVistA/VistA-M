DGX72 ; ;07/10/20
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,7)=DIV,DIH=45,DIG=82.07 D ^DICR
 S X=DG(DQ),DIC=DIE
 X "N DG1 S DG1=$P(^DGPT(DA,0),""^"",1) N X S X=""DGRUDD01"" X ^%ZOSF(""TEST"") Q:'$T  D:(+DG1>0) ADGRU^DGRUDD01(DG1)"
