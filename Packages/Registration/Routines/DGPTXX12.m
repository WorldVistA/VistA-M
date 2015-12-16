DGPTXX12 ; COMPILED XREF FOR FILE #45.02 ; 09/16/15
 ; 
 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^DGPT(DA(1),"M",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,0)):^(0),1:"") S X=$P(Y(1),U,16),X=X S DIU=X K Y X ^DD(45.02,2,1,1,1.1) X ^DD(45.02,2,1,1,1.4)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),"M",DIV(1),82)),DIV=X S $P(^(82),U,1)=DIV,DIH=45.02,DIG=82.01 D ^DICR
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" X ^DD(45.02,5,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),"M",DIV(1),82)),DIV=X S $P(^(82),U,2)=DIV,DIH=45.02,DIG=82.02 D ^DICR
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" X ^DD(45.02,6,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),"M",DIV(1),82)),DIV=X S $P(^(82),U,3)=DIV,DIH=45.02,DIG=82.03 D ^DICR
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" X ^DD(45.02,7,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P($G(DIKZ(0)),U,8)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,8)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),"M",DIV(1),82)),DIV=X S $P(^(82),U,4)=DIV,DIH=45.02,DIG=82.04 D ^DICR
 S X=$P($G(DIKZ(0)),U,8)
 I X'="" X ^DD(45.02,8,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),"M",DIV(1),82)),DIV=X S $P(^(82),U,5)=DIV,DIH=45.02,DIG=82.05 D ^DICR
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" X ^DD(45.02,9,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P($G(DIKZ(0)),U,10)
 I X'="" S ^DGPT(DA(1),"M","AM",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),"M",DIV(1),82)),DIV=X S $P(^(82),U,6)=DIV,DIH=45.02,DIG=82.06 D ^DICR
 S X=$P($G(DIKZ(0)),U,11)
 I X'="" X ^DD(45.02,11,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),"M",DIV(1),82)),DIV=X S $P(^(82),U,7)=DIV,DIH=45.02,DIG=82.07 D ^DICR
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" X ^DD(45.02,12,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),"M",DIV(1),82)),DIV=X S $P(^(82),U,8)=DIV,DIH=45.02,DIG=82.08 D ^DICR
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" X ^DD(45.02,13,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P($G(DIKZ(0)),U,14)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,9),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),"M",DIV(1),82)),DIV=X S $P(^(82),U,9)=DIV,DIH=45.02,DIG=82.09 D ^DICR
 S X=$P($G(DIKZ(0)),U,14)
 I X'="" X ^DD(45.02,14,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P($G(DIKZ(0)),U,15)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,15)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,10),X=X S DIU=X K Y S X="" X ^DD(45.02,15,1,2,1.4)
 S X=$P($G(DIKZ(0)),U,15)
 I X'="" X ^DD(45.02,15,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,1)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X="" X ^DD(45.02,81.01,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,1)
 I X'="" X ^DD(45.02,81.01,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,2)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" X ^DD(45.02,81.02,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,2)
 I X'="" X ^DD(45.02,81.02,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,3)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,3)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,13),X=X S DIU=X K Y S X="" X ^DD(45.02,81.03,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,3)
 I X'="" X ^DD(45.02,81.03,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,4)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,4)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,14),X=X S DIU=X K Y S X="" X ^DD(45.02,81.04,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,4)
 I X'="" X ^DD(45.02,81.04,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,5)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,15),X=X S DIU=X K Y S X="" X ^DD(45.02,81.05,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,5)
 I X'="" X ^DD(45.02,81.05,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,6)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,6)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,16),X=X S DIU=X K Y S X="" X ^DD(45.02,81.06,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,6)
 I X'="" X ^DD(45.02,81.06,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,7)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,7)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,17),X=X S DIU=X K Y S X="" X ^DD(45.02,81.07,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,7)
 I X'="" X ^DD(45.02,81.07,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,8)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,8)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,18),X=X S DIU=X K Y S X="" X ^DD(45.02,81.08,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,8)
 I X'="" X ^DD(45.02,81.08,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,9)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,9)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,19),X=X S DIU=X K Y S X="" X ^DD(45.02,81.09,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,9)
 I X'="" X ^DD(45.02,81.09,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,10)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,10)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(45.02,81.1,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,10)
 I X'="" X ^DD(45.02,81.1,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,11)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,11)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,21),X=X S DIU=X K Y S X="" X ^DD(45.02,81.11,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,11)
 I X'="" X ^DD(45.02,81.11,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,12)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,12)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,22),X=X S DIU=X K Y S X="" X ^DD(45.02,81.12,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,12)
 I X'="" X ^DD(45.02,81.12,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,13)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,23),X=X S DIU=X K Y S X="" X ^DD(45.02,81.13,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,13)
 I X'="" X ^DD(45.02,81.13,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,14)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,24),X=X S DIU=X K Y S X="" X ^DD(45.02,81.14,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,14)
 I X'="" X ^DD(45.02,81.14,1,992,1)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X=$P($G(DIKZ(81)),U,15)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(81)),U,15)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,82)):^(82),1:"") S X=$P(Y(1),U,25),X=X S DIU=X K Y S X="" X ^DD(45.02,81.15,1,2,1.4)
 S X=$P($G(DIKZ(81)),U,15)
 I X'="" X ^DD(45.02,81.15,1,992,1)
CR1 S DIXR=1177
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,5)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD1")
CR2 S DIXR=1178
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,15)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD10")
CR3 S DIXR=1179
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,6)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD2")
CR4 S DIXR=1180
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,7)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD3")
CR5 S DIXR=1181
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,8)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD4")
CR6 S DIXR=1182
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,9)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD5")
CR7 S DIXR=1183
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,11)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD6")
CR8 S DIXR=1184
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,12)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD7")
CR9 S DIXR=1185
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,13)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD8")
CR10 S DIXR=1186
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,14)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD9")
CR11 S DIXR=1224
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X(2)=$P(DIKZ(81),U,1)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD11")
CR12 S DIXR=1225
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X(2)=$P(DIKZ(81),U,2)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD12")
CR13 S DIXR=1226
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X(2)=$P(DIKZ(81),U,3)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD13")
CR14 S DIXR=1227
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X(2)=$P(DIKZ(81),U,4)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD14")
CR15 S DIXR=1228
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X(2)=$P(DIKZ(81),U,5)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD15")
CR16 S DIXR=1229
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S DIKZ(81)=$G(^DGPT(DA(1),"M",DA,81))
 S X(2)=$P(DIKZ(81),U,6)
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD16")
CR17 S DIXR=1230
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 G ^DGPTXX13
END G END^DGPTXX13
