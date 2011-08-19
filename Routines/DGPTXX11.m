DGPTXX11 ; COMPILED XREF FOR FILE #45.02 ; 04/23/09
 ; 
 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^DGPT(DA(1),"M",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P(DIKZ(0),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,"M",D1,0)):^(0),1:"") S X=$P(Y(1),U,16),X=X S DIU=X K Y X ^DD(45.02,2,1,1,1.1) X ^DD(45.02,2,1,1,1.4)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P(DIKZ(0),U,5)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,5)
 I X'="" X ^DD(45.02,5,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P(DIKZ(0),U,6)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,6)
 I X'="" X ^DD(45.02,6,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P(DIKZ(0),U,7)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,7)
 I X'="" X ^DD(45.02,7,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P(DIKZ(0),U,8)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,8)
 I X'="" X ^DD(45.02,8,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P(DIKZ(0),U,9)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,9)
 I X'="" X ^DD(45.02,9,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P(DIKZ(0),U,10)
 I X'="" S ^DGPT(DA(1),"M","AM",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,11)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,11)
 I X'="" X ^DD(45.02,11,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P(DIKZ(0),U,12)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,12)
 I X'="" X ^DD(45.02,12,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P(DIKZ(0),U,13)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,13)
 I X'="" X ^DD(45.02,13,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P(DIKZ(0),U,14)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,14)
 I X'="" X ^DD(45.02,14,1,992,1)
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X=$P(DIKZ(0),U,15)
 I X'="" S ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,15)
 I X'="" X ^DD(45.02,15,1,992,1)
CR1 S DIXR=447
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,5)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9M^DGPTDDCR(.X,.DA,"M ICD1")
CR2 S DIXR=448
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,6)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9M^DGPTDDCR(.X,.DA,"M ICD2")
CR3 S DIXR=449
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,7)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9M^DGPTDDCR(.X,.DA,"M ICD3")
CR4 S DIXR=450
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,8)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9M^DGPTDDCR(.X,.DA,"M ICD4")
CR5 S DIXR=451
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,9)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9M^DGPTDDCR(.X,.DA,"M ICD5")
CR6 S DIXR=452
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,11)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9M^DGPTDDCR(.X,.DA,"M ICD6")
CR7 S DIXR=453
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,12)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9M^DGPTDDCR(.X,.DA,"M ICD7")
CR8 S DIXR=454
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,13)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9M^DGPTDDCR(.X,.DA,"M ICD8")
CR9 S DIXR=455
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,14)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9M^DGPTDDCR(.X,.DA,"M ICD9")
CR10 S DIXR=456
 K X
 S DIKZ(0)=$G(^DGPT(DA(1),"M",DA,0))
 S X(1)=$P(DIKZ(0),U,10)
 S X(2)=$P(DIKZ(0),U,15)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9M^DGPTDDCR(.X,.DA,"M ICD10")
CR11 K X
 G:'$D(DIKLM) A Q:$D(DISET)
END G ^DGPTXX12
