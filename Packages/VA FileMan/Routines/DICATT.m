DICATT ;SFISC/GFT,XAK-MODIFY FILE ATTR ;11NOV2008
 ;;22.0;VA FileMan;**7,82,160**;Mar 30, 1999;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified.
 I $D(DIAX) S %=2
 E  S %=$$SCREEN^DIBT("^D SCREENQ^DICATT") Q:%=U  S %=2-%
 G ^DICATTD:%=1 Q:%<2
 S DLAYGO=1 D D^DICRW Q:Y<0  I $P($G(^DD(+Y,0,"DI")),U)["Y",($P(@(^DIC(+Y,0,"GL")_"0)"),U,4)) W !!,$C(7),"DATA DICTIONARY MODIFICATIONS ON ARCHIVE FILES ARE NOT ALLOWED!" Q
 I '$D(DIC) D DIE^DIB Q:'$D(DG)  S DIC=DG
 S:$D(DIAX) DIAXDIC=+$P(@(DIC_"0)"),U,2)
EN ;
 K I S Q="""",I(0)=DIC,B=+$P(@(DIC_"0)"),U,2),S=";"
B ;
 K DA,J,DIU0,DDA S A=B,DICL=0,J(0)=B I $D(^DD(A,0,"DDA")),^("DDA")["Y" S DDA=""
M ;
 I $G(Z)["W",A-B G B
 W !!! K O,DQ,DIC,DIE,DG,M G Q^DIB:$D(DTOUT)
 S O=1,E=0,DIC(0)="ALEQIZ",DIC="^DD("_A_"," S:$D(DICS) DIC("S")=DICS
 S DIC("W")="S %=$P(^(0),U,2) I % W $P(""  (multiple)^  (word-processing)"",U,$P(^DD(+%,.01,0),U,2)[""W""+1)"
 I $P(^DD(A,.01,0),U,2)["W" S DIC(0)="AEQZ",DIC("B")=.01
 E  I $D(DA),$D(^DD(A,DA,0)),'$P(^(0),U,2),$P(^(0),U,4)'?.P S E=DA
 D ^DIC S:$D(DDA)&$P(Y,U,3) DDA="N" I Y<0 G B:A-B,Q^DICATT2
SV I '$P(Y,U,3) S DIU0=A,O(1)=$P(^DD(A,+Y,0),U,1,2),O(2)=$S($D(^(.1)):$P(^(.1),U),1:"") I $D(DDA) S DDA="E" D SV^DICATTA
 S:$D(DDA) DDA(1)=A
 S DIAC="AUDIT",DIFILE=A D ^DIAC S O=+% K DIAC,DIFILE
SKP S (D0,DA)=+Y,DA(1)=A,DIE=DIC,M=Y(0),T=$P(M,U,2) S:T["C"!(T["W") O=0
 S DR=$P(".01:.1;",U,DUZ(0)="@"!'$F(T,"X"))_$P("1.1;",U,O)_$S(DUZ(0)="@"&(T'["C")&(T'["W"):"1.2;",1:"")_$S(T["C":"8;",1:"8:9;10:")_"11;20:29"
 S O=$S($P(Y,U,3):0,1:1_U_$P(M,U,2,99)),F=$P(M,U) K DIC,DQI
 S X=0 F  S X=$O(^DD(A,DA,1,X)) Q:X'>0  I +^(X,0)=B,$P(^(0),B,2)?1"^"1.A S DQI=$P(^(0),U,2)
 S X=-1 I 'T D DIE:O  Q:$D(DTOUT)  S:'$D(DA)&($D(DDA)) DDA="D" G TYPE^DICATT2:$D(DA),N:$P(O,U,4)?.P,^DICATT4
 S DR=".01;8;9;10:11;20:29" D DIE I '$D(DA) S:$D(DDA) DDA="D" S DQ(+T)=0 G NEW^DICATT4
 S X=$P($P(M,U,4),";"),M=^DD(A,DA,0),E=$P(M,U),A=+T,DICL=DICL+1,J(DICL)=A,Y=$E(Q,+X'=X),I(DICL)=Y_X_Y I E'=F S ^(0)=E_" SUB-FIELD^"_$P(^DD(A,0),U,2,9) K ^(0,"NM") S ^("NM",E)=""
 G 5:$P(M,U,2)["W",N
 ;
 ;
E S DE=^DD(A,E,0) W $P(DE,U) Q
 ;
P S DI=DIU0 D:$D(O(1))
 .I '$D(DA) S DA=D0 D DIPZ^DIU0 Q
 .I $D(^DD(DI,DA,0)),O(1)'=$P(^(0),U,1,2) D DIPZ^DIU0 Q
 .I $D(^(.1)),O(2)'=$P(^(.1),U) D DIPZ^DIU0 Q
 K DIU0 Q
 ;
N I $D(DDA),DDA]"" S:'$D(DA) DA=D0 D AUDT^DICATTA
 D:$D(DIU0) P S DIZZ=$S(('O&$D(DIZ)):DIZ,1:$P(O,U,2,3)) G M
 ;
X W $C(7),"    '",F,"' DELETED!" I $D(DDA) S DDA=$S(DDA="":"D",1:"")
 S DIK="^DD(A,",DA(1)=A D ^DIK G N
 ;
CHECK G:$P(^DD(A,DA,0),U,2)']"" X:$D(DTOUT) G NO^DICATT2
 ;
DIE ;
 N I,J,DICATTED
 S DICATTED=1 D ^DIE
 Q
 ;
0 S C=$P(O,U,5,99) G @N
1 ;
2 G ^DICATT0
3 ;
4 G ^DICATT6
5 S W="0;1",(Z,DIZ)="W^",C="Q",V=1,L=1 G ^DICATT2:O,SUB^DICATT1
6 G ^DICATT3 ;COMPUTED
7 G ^DICATT5
8 G VP^DICATT4
9 S (Z,DIZ)="K^",V=0,C="K:$L(X)>245 X D:$D(X) ^DIM",L=245
 S:$P(^DD(A,DA,0),U,4)]"" W=$P(^(0),U,4) G ^DICATT2:O,SUB^DICATT1
 ;
SCREENQ ;
 W !,"'YES' will invoke the ScreenMan editor.",!,"The same questions are asked in both screen & scrolling mode."
