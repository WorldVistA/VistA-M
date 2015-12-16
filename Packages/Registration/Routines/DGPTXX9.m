DGPTXX9 ; COMPILED XREF FOR FILE #45 ; 09/16/15
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^DGPT("B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" S L=+^DGPT(DA,0) I L>0 S ^DGPT("AAD",L,X,DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" S ^DGPT("AF",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" S L=$S($D(^DGPT(DA,70)):+^(70),1:0) I L'?7N.E S ^DGPT("AADA",X,DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $P(^DGPT(DA,0),U,4),$P(^(0),U) S ^DGPT("AFEE",$P(^DGPT(DA,0),U),$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" I $P(^DGPT(DA,0),U),$P(^(0),U,2) S ^DGPT("AFEE",$P(^DGPT(DA,0),U),$P(^DGPT(DA,0),U,2),DA)=""
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" S ^DGPT("AS",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,10)
 I X'="" S ^DGPT("AMT",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" S ^DGPT("ACENSUS",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,0)):^(0),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X=DIV S X=2 S DIH=$S($D(^DGPT(DIV(0),0)):^(0),1:""),DIV=X S $P(^(0),U,11)=DIV,DIH=45,DIG=11 D ^DICR
 S DIKZ(101)=$G(^DGPT(DA,101))
 S X=$P($G(DIKZ(101)),U,4)
 I X'="" S %=+^DGPT(DA,0) I %>0 S %C=$S($D(^DPT(%,.3)):^(.3),1:"")_"^^^^^^^^^^",^(.3)=$P(%C,U,1,9)_U_X_U_$P(%C,U,11,99),^DPT("ACB",X,%)="" K ^DPT("ACB",+$P(%C,U,10),%),%,%C
 S DIKZ("401P")=$G(^DGPT(DA,"401P"))
 S X=$P($G(DIKZ("401P")),U,1)
 I X'="" S ^DGPT(DA,"AP",X)=""
 S X=$P($G(DIKZ("401P")),U,2)
 I X'="" S ^DGPT(DA,"AP",X)=""
 S X=$P($G(DIKZ("401P")),U,3)
 I X'="" S ^DGPT(DA,"AP",X)=""
 S X=$P($G(DIKZ("401P")),U,4)
 I X'="" S ^DGPT(DA,"AP",X)=""
 S X=$P($G(DIKZ("401P")),U,5)
 I X'="" S ^DGPT(DA,"AP",X)=""
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P($G(DIKZ(70)),U,1)
 I X'="" S ^DGPT("ADS",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(70)),U,1)
 I X'="" N DGFDA,DGMSG S DGFDA(45.02,"1,"_$$IENS^DILF(DA),10)=X D FILE^DIE("","DGFDA","DGMSG") K DGFDA,DGMSG
 S X=$P($G(DIKZ(70)),U,1)
 I X'="" S L=$P(^DGPT(DA,0),"^",2) I L?7N.E K ^DGPT("AADA",L,DA)
 S X=$P($G(DIKZ(70)),U,2)
 I X'="" I $D(^DGPT(DA,"M",1,0)) N DGFDA,DGMSG S DGFDA(45.02,"1,"_$$IENS^DILF(DA),2)=X D FILE^DIE("","DGFDA","DGMSG") K DGFDA,DGMSG
 S X=$P($G(DIKZ(70)),U,10)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,1)=DIV,DIH=45,DIG=82.01 D ^DICR
 S X=$P($G(DIKZ(70)),U,10)
 I X'="" X ^DD(45,79,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P($G(DIKZ(70)),U,16)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,2)=DIV,DIH=45,DIG=82.02 D ^DICR
 S X=$P($G(DIKZ(70)),U,16)
 I X'="" X ^DD(45,79.16,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P($G(DIKZ(70)),U,17)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,3)=DIV,DIH=45,DIG=82.03 D ^DICR
 S X=$P($G(DIKZ(70)),U,17)
 I X'="" X ^DD(45,79.17,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P($G(DIKZ(70)),U,18)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,4)=DIV,DIH=45,DIG=82.04 D ^DICR
 S X=$P($G(DIKZ(70)),U,18)
 I X'="" X ^DD(45,79.18,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P($G(DIKZ(70)),U,19)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,5)=DIV,DIH=45,DIG=82.05 D ^DICR
 S X=$P($G(DIKZ(70)),U,19)
 I X'="" X ^DD(45,79.19,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P($G(DIKZ(70)),U,20)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,6)=DIV,DIH=45,DIG=82.06 D ^DICR
 S X=$P($G(DIKZ(70)),U,20)
 I X'="" X ^DD(45,79.201,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P($G(DIKZ(70)),U,21)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,7)=DIV,DIH=45,DIG=82.07 D ^DICR
 S X=$P($G(DIKZ(70)),U,21)
 I X'="" X ^DD(45,79.21,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P($G(DIKZ(70)),U,22)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,8)=DIV,DIH=45,DIG=82.08 D ^DICR
 S X=$P($G(DIKZ(70)),U,22)
 I X'="" X ^DD(45,79.22,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P($G(DIKZ(70)),U,23)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,9),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,9)=DIV,DIH=45,DIG=82.09 D ^DICR
 S X=$P($G(DIKZ(70)),U,23)
 I X'="" X ^DD(45,79.23,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P($G(DIKZ(70)),U,24)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,10),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,10)=DIV,DIH=45,DIG=82.1 D ^DICR
 S X=$P($G(DIKZ(70)),U,24)
 I X'="" X ^DD(45,79.24,1,992,1)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,1)
 I X'="" X ^DD(45,79.241,1,1,1)
 S X=$P($G(DIKZ(71)),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,11)=DIV,DIH=45,DIG=82.11 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,2)
 I X'="" X ^DD(45,79.242,1,1,1)
 S X=$P($G(DIKZ(71)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,12)=DIV,DIH=45,DIG=82.12 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,3)
 I X'="" X ^DD(45,79.243,1,1,1)
 S X=$P($G(DIKZ(71)),U,3)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,13),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,13)=DIV,DIH=45,DIG=82.13 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,4)
 I X'="" X ^DD(45,79.244,1,1,1)
 S X=$P($G(DIKZ(71)),U,4)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,14),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,14)=DIV,DIH=45,DIG=82.14 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,5)
 I X'="" X ^DD(45,79.245,1,1,1)
 S X=$P($G(DIKZ(71)),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,15),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,15)=DIV,DIH=45,DIG=82.15 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,6)
 I X'="" X ^DD(45,79.246,1,1,1)
 S X=$P($G(DIKZ(71)),U,6)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,16),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,16)=DIV,DIH=45,DIG=82.16 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,7)
 I X'="" X ^DD(45,79.247,1,1,1)
 S X=$P($G(DIKZ(71)),U,7)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,17),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,17)=DIV,DIH=45,DIG=82.17 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,8)
 I X'="" X ^DD(45,79.248,1,1,1)
 S X=$P($G(DIKZ(71)),U,8)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,18),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,18)=DIV,DIH=45,DIG=82.18 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,9)
 I X'="" X ^DD(45,79.249,1,1,1)
 S X=$P($G(DIKZ(71)),U,9)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,19),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,19)=DIV,DIH=45,DIG=82.19 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,10)
 I X'="" X ^DD(45,79.2491,1,1,1)
 S X=$P($G(DIKZ(71)),U,10)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,20)=DIV,DIH=45,DIG=82.2 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,11)
 I X'="" X ^DD(45,79.24911,1,1,1)
 S X=$P($G(DIKZ(71)),U,11)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,21),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,21)=DIV,DIH=45,DIG=82.21 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,12)
 I X'="" X ^DD(45,79.24912,1,1,1)
 S X=$P($G(DIKZ(71)),U,12)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,22),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,22)=DIV,DIH=45,DIG=82.22 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,13)
 I X'="" X ^DD(45,79.24913,1,1,1)
 S X=$P($G(DIKZ(71)),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,23),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,23)=DIV,DIH=45,DIG=82.23 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,14)
 I X'="" X ^DD(45,79.24914,1,1,1)
 S X=$P($G(DIKZ(71)),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,24),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,24)=DIV,DIH=45,DIG=82.24 D ^DICR
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P($G(DIKZ(71)),U,15)
 I X'="" X ^DD(45,79.24915,1,1,1)
 S X=$P($G(DIKZ(71)),U,15)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,82)):^(82),1:"") S X=$P(Y(1),U,25),X=X S DIU=X K Y S X="" S DIH=$G(^DGPT(DIV(0),82)),DIV=X S $P(^(82),U,25)=DIV,DIH=45,DIG=82.25 D ^DICR
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P($G(DIKZ(70)),U,11)
 I X'="" X ^DD(45,80,1,992,1)
CR1 S DIXR=401
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,11)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"PDX")
CR2 S DIXR=1176
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,10)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"DXLS")
CR3 S DIXR=1187
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,16)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD1")
CR4 S DIXR=1188
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X(4)=$P(DIKZ(71),U,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD10")
CR5 S DIXR=1189
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X(4)=$P(DIKZ(71),U,2)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD11")
CR6 S DIXR=1190
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X(4)=$P(DIKZ(71),U,3)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD12")
CR7 S DIXR=1191
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X(4)=$P(DIKZ(71),U,4)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD13")
CR8 S DIXR=1192
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,17)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD2")
CR9 S DIXR=1193
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,18)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD3")
CR10 S DIXR=1194
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,19)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD4")
CR11 S DIXR=1195
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,20)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD5")
CR12 S DIXR=1196
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,21)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
END G ^DGPTXX10
