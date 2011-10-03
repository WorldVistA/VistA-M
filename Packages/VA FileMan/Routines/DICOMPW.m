DICOMPW ;SFISC/GFT-EVALUATE COMPUTED FLD EXPR ;5:56 AM  20 Dec 2001
 ;;22.0;VA FileMan;**6,76**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
COLON N DICOMPW K DP,Y S DICOMPW=DICOMP
 I $D(DIC)#2,$P(X,":",2)="" S X=$P(X,":"),DIC(0)="FIZO",DIC("S")="N A S A=$P(^(0),U,2) I A[""P""!(A[""p""),'A" D ^DIC K DIC S X=X_":" D:Y>0 ARC I Y>0 S X="INTERNAL(#"_+Y_")",DP=+$P($P(Y(0),U,2),"P",2)_U_$P(Y(0),U,3)
 I  I $P(Y(0),U,2)["p" S X=$P(Y(0),U,5,99),DP=+$P($P(Y(0),U,2),"p",2),DP=DP_$G(^DIC(DP,0,"GL")),Y=0 G JUMP ;computed pointer
 I $G(Y)'>0 S X=$E(X,1,$L(X)-1),DICOMPX="",DICOMPX(0)="D("
 S DICOMP=DICOMP_"S"
 D EN^DICOMP G Q:'$D(X)
 I '$D(DP) S DP=+DICOMPX K:Y'>DICOMPW X S %=I(+Y),DP=DP_$S(%[U:%,1:U_$P(%,"""",1)_$P(%,"""",2)) G Q
JUMP S:$D(DIFG) DIFG=2 S DICOMP=DICOMPW D DRW^DICOMPX G Q:'$D(^DIC(+DP,0)) S D=Y,Y=+DP X DIC("S") S Y=D I '$T K X,DIC("S") G Q
 F D=DICOMPW\100*100:1 S X="S I("_D_",0)=D"_(D#100)_" "_X I +DICOMPW=D S X=X_" S D(0)=+X",D=Y\100+1*100,I(D)=U_$P(DP,U,2),J(D)=+DP,Y=D_U_Y Q
Q S:$D(DIFG)&$D(X) DIFG("DICOMP")=DICOMPX K DICOMP,DICOMPX,DICOMPW Q
 ;
 ;
M ;
 S (D,DS)=0,DZ="""",Y=J(DLV) I DICOMP["W" D ASKE,ASK:'D I D<0 K X Q
 S:DS DZ="E"""
 I D S DZ=$E("W",$D(DICO(3)))_"L"_DZ_$S(DLV=DLV0:"",1:",DIC(""P"")="""_$P(^DD(J(DLV-1),$O(^DD(J(DLV-1),"SB",J(DLV),0)),0),U,2)_"""") I D=2 S DZ=DZ_",X=""""""""_X_"""""""""
 S (%,%Y)=DLV#100,DZ=" K DIC S "_$P("Y=-1,",U,%>0)_"DIC="""_X_""",DIC(0)=""MF"_DZ,X=" D ^DIC"_$P(":D"_(%-1)_">0",U,%>0)_" S (D,D"_%_$S($D(DICOMPX(0)):","_DICOMPX(0)_%_")",1:"")_")=+Y"
 I D F %=%:-1:1 S X=X_",DA("_%_")=DIU("_%_")",DZ=DZ_",DIU("_%_")=$S($D(DA("_%_")):DA("_%_"),1:0),DA("_%_")=D"_(%Y-%)
 S X=DZ_X
 I W=":" S M=M+1 Q
 S I="#.01"_$E(I,M,999),M=0 Q
 ;
ASKE ;
 S (D,DS)=0,%=1 I DICOMP["?",DICOMP["E" W !,"WILL TERMINAL USER BE ALLOWED TO SELECT PROPER ENTRY IN '"_$O(^DD(Y,0,"NM",0))_"' FILE" D YN^DICN S:%=1 DS=1
 S:%<0 D=% Q:%  D DICOMPW^DIQQQ G ASKE
 ;
ASK ;
 G NO:DICOMP'["?",ASK1:DUZ(0)="@"
 S DIFILE=Y,DIAC="LAYGO" D ^DIAC K DIAC,DIFILE G:'% NO
ASK1 W !,"DO YOU WANT TO PERMIT ADDING A NEW '"_$O(^DD(Y,0,"NM",0))_"' ENTRY"
 S %=2-(DICOMP["L"),D=0 D YN^DICN W ! I %<1 S D=-1 Q
 Q:%=2  S D=1 Q:DZ  W "WELL THEN, DO YOU WANT TO **FORCE** ADDING A NEW ENTRY EVERY TIME"
 S %=2-(DICOMP["L2") D YN^DICN I %<1 S D=-1 Q
 S D=3-%,DICO(2)=1 Q:%=1!'DS
 W !,"DO YOU WANT AN 'ADDING A NEW "_$O(^DD(Y,0,"NM",0))_"' MESSAGE" D YN^DICN I %<1 S D=-1 Q
 Q:%=1  S DICO(3)=% Q
NO S D=0 Q
 ;
DPS ;
 S X=DPS(DPS),%=$O(DPS(DPS,"$")) S:$D(DPS(DPS,"BOOL")) DBOOL=DPS(DPS,"BOOL") I %["$" S X=X_"X)"_DPS(DPS,%)
 I $D(DPS(DPS,"DATE")) S DATE(K+1)=1
 S %=$D(DATE(K)) I $D(DPS(DPS,U)) S K=K+2,K(K-1)=X,K(K)=$E(DPS(DPS,U)),X=$E(DPS(DPS,U),2,99)
 I %&$D(DPS(DPS,"O"))!$D(DPS(DPS,"D"))!$D(DPS(DPS,"DATE")) S DATE(K+1)=1
 E  I '$D(DPS(DPS,"ST")) S K(K+1,9)=0
 K DPS(DPS) S DPS=DPS-1
 Q
ARC ;
 Q:DICOMP'["W"
 I $P($G(^DD(+$P($P(Y(0),U,2),"P",2),0,"DI")),U,2)["Y" W !,$C(7),"SORRY, CAN'T EDIT A RESTRICTED"_$S($P($G(^("DI")),U)["Y":" (ARCHIVE)",1:"")_" FILE!" S Y=-1
 Q
