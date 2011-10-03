DGPTXX8 ; COMPILED XREF FOR FILE #45 ; 04/23/09
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^DGPT("B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S L=+^DGPT(DA,0) I L>0 S ^DGPT("AAD",L,X,DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^DGPT("AF",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S L=$S($D(^DGPT(DA,70)):+^(70),1:0) I L'?7N.E S ^DGPT("AADA",X,DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" I $P(^DGPT(DA,0),U,4),$P(^(0),U) S ^DGPT("AFEE",$P(^DGPT(DA,0),U),$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,4)
 I X'="" I $P(^DGPT(DA,0),U),$P(^(0),U,2) S ^DGPT("AFEE",$P(^DGPT(DA,0),U),$P(^DGPT(DA,0),U,2),DA)=""
 S X=$P(DIKZ(0),U,6)
 I X'="" S ^DGPT("AS",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,10)
 I X'="" S ^DGPT("AMT",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,12)
 I X'="" S ^DGPT("ACENSUS",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPT(D0,0)):^(0),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X=DIV S X=2 S DIH=$S($D(^DGPT(DIV(0),0)):^(0),1:""),DIV=X S $P(^(0),U,11)=DIV,DIH=45,DIG=11 D ^DICR
 S DIKZ(101)=$G(^DGPT(DA,101))
 S X=$P(DIKZ(101),U,4)
 I X'="" S %=+^DGPT(DA,0) I %>0 S %C=$S($D(^DPT(%,.3)):^(.3),1:"")_"^^^^^^^^^^",^(.3)=$P(%C,U,1,9)_U_X_U_$P(%C,U,11,99),^DPT("ACB",X,%)="" K ^DPT("ACB",+$P(%C,U,10),%),%,%C
 S DIKZ("401P")=$G(^DGPT(DA,"401P"))
 S X=$P(DIKZ("401P"),U,1)
 I X'="" S ^DGPT(DA,"AP",X)=""
 S X=$P(DIKZ("401P"),U,2)
 I X'="" S ^DGPT(DA,"AP",X)=""
 S X=$P(DIKZ("401P"),U,3)
 I X'="" S ^DGPT(DA,"AP",X)=""
 S X=$P(DIKZ("401P"),U,4)
 I X'="" S ^DGPT(DA,"AP",X)=""
 S X=$P(DIKZ("401P"),U,5)
 I X'="" S ^DGPT(DA,"AP",X)=""
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P(DIKZ(70),U,1)
 I X'="" S ^DGPT("ADS",$E(X,1,30),DA)=""
 S X=$P(DIKZ(70),U,1)
 I X'="" N DGFDA,DGMSG S DGFDA(45.02,"1,"_$$IENS^DILF(DA),10)=X D FILE^DIE("","DGFDA","DGMSG") K DGFDA,DGMSG
 S X=$P(DIKZ(70),U,1)
 I X'="" S L=$P(^DGPT(DA,0),"^",2) I L?7N.E K ^DGPT("AADA",L,DA)
 S X=$P(DIKZ(70),U,2)
 I X'="" I $D(^DGPT(DA,"M",1,0)) N DGFDA,DGMSG S DGFDA(45.02,"1,"_$$IENS^DILF(DA),2)=X D FILE^DIE("","DGFDA","DGMSG") K DGFDA,DGMSG
 S X=$P(DIKZ(70),U,10)
 I X'="" X ^DD(45,79,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P(DIKZ(70),U,16)
 I X'="" X ^DD(45,79.16,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P(DIKZ(70),U,17)
 I X'="" X ^DD(45,79.17,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P(DIKZ(70),U,18)
 I X'="" X ^DD(45,79.18,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P(DIKZ(70),U,19)
 I X'="" X ^DD(45,79.19,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P(DIKZ(70),U,20)
 I X'="" X ^DD(45,79.201,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P(DIKZ(70),U,21)
 I X'="" X ^DD(45,79.21,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P(DIKZ(70),U,22)
 I X'="" X ^DD(45,79.22,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P(DIKZ(70),U,23)
 I X'="" X ^DD(45,79.23,1,992,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P(DIKZ(70),U,24)
 I X'="" X ^DD(45,79.24,1,992,1)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P(DIKZ(71),U,1)
 I X'="" X ^DD(45,79.241,1,1,1)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P(DIKZ(71),U,2)
 I X'="" X ^DD(45,79.242,1,1,1)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P(DIKZ(71),U,3)
 I X'="" X ^DD(45,79.243,1,1,1)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X=$P(DIKZ(71),U,4)
 I X'="" X ^DD(45,79.244,1,1,1)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X=$P(DIKZ(70),U,11)
 I X'="" X ^DD(45,80,1,992,1)
CR1 S DIXR=432
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
 . D SDGPT9D^DGPTDDCR(.X,.DA,"DXLS")
CR2 S DIXR=433
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
 . D SDGPT9D^DGPTDDCR(.X,.DA,"PDX")
CR3 S DIXR=434
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
 . D SDGPT9D^DGPTDDCR(.X,.DA,"D SD1")
CR4 S DIXR=435
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
 . D SDGPT9D^DGPTDDCR(.X,.DA,"D SD2")
CR5 S DIXR=436
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
 . D SDGPT9D^DGPTDDCR(.X,.DA,"D SD3")
CR6 S DIXR=437
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
 . D SDGPT9D^DGPTDDCR(.X,.DA,"D SD4")
CR7 S DIXR=438
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
 . D SDGPT9D^DGPTDDCR(.X,.DA,"D SD5")
CR8 S DIXR=439
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,21)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9D^DGPTDDCR(.X,.DA,"D SD6")
CR9 S DIXR=440
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,22)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9D^DGPTDDCR(.X,.DA,"D SD7")
CR10 S DIXR=441
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,23)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9D^DGPTDDCR(.X,.DA,"D SD8")
CR11 S DIXR=442
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(4)=$P(DIKZ(70),U,24)
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SDGPT9D^DGPTDDCR(.X,.DA,"D SD9")
CR12 S DIXR=443
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
 . D SDGPT9D^DGPTDDCR(.X,.DA,"D SD10")
CR13 S DIXR=444
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
 . D SDGPT9D^DGPTDDCR(.X,.DA,"D SD11")
CR14 S DIXR=445
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
END G ^DGPTXX9
