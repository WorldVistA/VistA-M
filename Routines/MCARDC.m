MCARDC ;WISC/TJK-MODIFIED DIC ROUTINE FOR MEDICINE SCREENS ;1/14/94  11:07
 ;;2.3;Medicine;;09/13/1996
 S D="B" K DF,DS,DFOUT,DTOUT,DUOUT
EN K DO,DICR S U="^" S:DIC DIC=^DIC(DIC,0,"GL") D PGM I $D(DIPGM) S DIPGM(0)=1 G @DIPGM
ASK I DIC(0)["A" W ! D ^MCARDC1
 I $D(DIADD),X'["""",U'[X,X'?."?" S X=""""_X_""""
X ;
 D DO^MCARDC1:'$D(DO) I U'[X,X'?."?",$D(^DD(+DO(2),.01,7.5)) X ^(7.5) G:'$D(X) BAD^MCARDC1
 D PGM I $D(DIPGM) S DIPGM(0)=2 G @DIPGM
RTN ;
 G O^MCARDC1:X'?.ANP,N:$L(X)>30 I X?.NP G NO:X="",NUM:+X=X,^MCARDCQ:X?1"?"."?" I X=" ",$L(DIC)<29,$D(^DISV(DUZ,DIC)) S Y=+^(DIC) D S G GOT:$T,BAD^MCARDC1
F ;
 S (DD,DS)=0
T S Y=$O(@(DIC_"D,X,0)")),DIX=X S:Y="" Y=-1
 I Y'<0 S YMLH=$O(^(Y)) S:YMLH="" YMLH=-1 G DIY:YMLH'<0!((DIC(0)'["O")&(DIC(0)["E")) D MN I  G K:DS S DS=1 G GOT
 ; Naked refernces in T+1 to T.
DIX I DIC(0)'["X" S:X?.N DIX=DIX_" " S DIX=$O(@(DIC_"D,DIX)")) S:DIX="" DIX=-1 I $P(DIX,X,1)="",DIX'=-1 S Y=$O(^(DIX,0)) S:Y="" Y=-1 G DIY
M I DIC(0)'["M" G B
 S D=$S($D(DID):$P(DID,U,DID(1)),1:$O(@(DIC_"D)")))
 I D="" S D=-1
 I $D(DID) S DID(1)=DID(1)+1
 I D+1 G M:$D(@(DIC_"D)"))-10,T:X'?.NP,T:+X'=X D DO^MCARDC1:'$D(DO) S Y=$O(^DD(+DO(2),0,"IX",D,0)) S:Y="" Y=-1 S YY=$O(^(Y,0)) S:YY="" YY=-1 G T:'$D(^DD(Y,YY,0)),M:$P(^(0),U,2)["P",T
B D D G G:DS=1,Y^MCARDC1:DS
N I X[U S DUOUT=1 G NO
 D DO^MCARDC1:'$D(DO) I X?1"`".NP S Y=$E(X,2,30),DZ=0 G A:Y="" D S S DS=1,DD=Y G GOT:$T I DIC(0)'["L" W:DIC(0)["Q" *7,"  ??" G A
 G ^MCARDCQ:X?."?",^MCARDCM
 ;
NUM D DO^MCARDC1:'$D(DO) G ^MCARDCM:X<0,F:DO(2)<0!$D(DF) S DD=$D(^DD(+DO(2),.001)),DS=$P(^(.01,0),"^",2) I $D(@(DIC_"X)")) G:'DD P:DS["N"!'$O(^("A[")) S Y=X D S G GOT:$T
P I DS["P"!(DS["V"),DIC(0)'["U" S (DD,DS)=0 G M
 G F
 ;
PGM K DIPGM I DIC(0)'["I",'$D(DF),$D(@(DIC_"0)")),$D(^DD(+$P(^(0),U,2),0,"DIC"))#2,"DI"'[$E(^("DIC"),1,2) S DIPGM=U_^("DIC")
 Q
1 ;
 D S G GOT:$T,F
 ;
 ; Naked reference in MN refs. to line Tag: PGM
MN S DZ=$S(DIC(0)["D":1,$D(^(Y))-1:0,1:^(Y)) D:'$D(DO) DO^MCARDC1 I 'DZ,'$D(DO("SCR")),$L(DIX)<30,D="B",'$D(DIC("S")) S DIY="" Q
 D S S:D="B"&'DZ&($P(DIY,DIX,1)="") DIY=$P(DIY,DIX,2,9) Q
 ;
S D:'$D(DO) DO^MCARDC1 I $D(@(DIC_"Y,0)")) S DIY=$P(^(0),"^",1)
 E  S DIY="" Q
 X:$D(DIC("S")) DIC("S") Q:'$T!'$D(DO("SCR"))  I $D(@(DIC_"Y,0)")) X DO("SCR")
 Q
 ;
Y X DJCP S Y=$O(@(DIC_"D,DIX,Y)"))
 I Y="" S Y=-1
DIY I Y<0 G DIX:DIC(0)'["O"&(DIC(0)["E"),G:DS=1&(D="B")&(DIX=X),DIX
 D MN E  G Y
K F DZ=1:1:DS I $D(DS(DZ)),+DS(DZ)=Y,DIC(0)'["C" G Y
 D DS^MCARDC1:'$D(DISMN) I $S<DISMN F DZ=1:1:DS-7 K DS(DZ),DIY(DZ)
 S DS=DS+1,DS(DS)=Y_"^"_$P(DIX,X,2,99),DIY(DS)=DIY G Y:DS#5-1,Y:DS=1,Y:DIC(0)["Y",Y^MCARDC1
 ;
G S DIY=1,DIX=X I DIC(0)["E",DIC(0)'["D",'$D(DICRS) W $P(DS(1),"^",2)
C S Y=+DS(DIY),X=X_$P(DS(DIY),"^",2),DIY=DIY(DIY)
GOT D WO^MCARDC1:DIC(0)["E" S Y=Y_"^"_$S(DIY="":X,1:DIY) I DIC(0)["E",DO(2)["O" G OK^MCARDC1
R I $G(DIC(0))'["F",$D(DUZ)#2 S ^DISV(DUZ,$E(DIC,1,28))=$E(DIC,29,999)_+Y
 I $G(DIC(0))["Z" K D S:$D(C) D=C S Y(0)=@(DIC_"+Y,0)"),DJC=+DO(2),DS=Y,Y=$P(Y(0),U,1) D Y^MCARDCM2 K DJC S Y(0,0)=Y,Y=DS,Y(0)=@(DIC_"+Y,0)") S:$D(D) C=D
 I $D(DO(2)),$D(^DD(+DO(2),0,"ACT"))#2 X ^("ACT")
 S:'$D(Y) Y=-1 I $D(@(DIC_"+Y,0)"))
Q K DID,DISMN,DIC("W"),DINUM,DS,DF,DD,DIX,DIY,DZ,DO,D Q
 ;
D S D=$S($D(DF):DF,1:"B") S:$D(DID(1)) DID(1)=2 Q
 ;
IX S DF=D G EN
 ;
A K DIY,DS I DIC(0)["A" D D G ASK
NO S Y=-1 G Q
