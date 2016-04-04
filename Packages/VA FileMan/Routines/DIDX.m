DIDX ;SFISC/XAK-BRIEF DD ;25SEP2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**76,1003**
 ;
 S D1=D0,DINM=1,DDRG=1,DDL1=14,DDL2=32 G B
 ;
L S DJ(Z)=0
A I DIDX D  G:D1>0 A:^DD(F(Z),"B",DJ(Z),D1)
 . S DJ(Z)=$O(^DD(F(Z),"B",DJ(Z))) S:DJ(Z)="" D1="" Q:DJ(Z)=""  S D1=$O(^(DJ(Z),0))
 . Q
 E  S (D1,DJ(Z))=$O(^DD(F(Z),DJ(Z)))
 I D1'>0 W ! S Z=Z-1 Q
B I $D(DIGR),D1-.01!'DID X DIGR E  G END
 S N=^DD(F(Z),D1,0) D HD:$Y+9>IOSL Q:M=U  W !!?Z+Z-2,$P(N,U,1),?30,S,F(Z),",",D1,S,S
 S X=$P(N,U,2) I X W ?M,$J(+X,8) I $D(^DD(+X,.01,0)),$P(^(0),U,2)["W" W "  WORD-PROCESSING" S X=""
 W ?M,S,S F W="BOOLEAN","COMPUTED","FREE TEXT","SET","DATE","NUMBER","POINTER","VARIABLE POINTER","K","p","m" I X[$E(W) S:W="K" W="MUMPS" S:W="p" W="POINTER" S:W="m" W="MULTIPLE" D W1 I X["V" D VP0
 I 'X D
 .N Y,NM S:X["P" Y=U_$P(N,U,3),NM=+$P(X,"P",2) I X["C" S NM=+$P(X,"p",2) I NM S Y=$G(^DIC(NM,0,"GL"))
 .Q:'$D(Y)  I Y[U,$D(@(Y_"0)")) S W="TO "_$P(^(0),U)_" FILE (#"_NM_")"
 .E  S W="***** TO A FILE THAT IS UNDEFINED *******"
 .D W1
T ;
 S W=0
H ;
 W ! I $D(^DD(F(Z),D1,.1))#2 W ?(Z*2),^(.1),"   ",?M
 I X["S" S N=$P(N,U,3) F I=1:1 S Y=$P(N,";",I) Q:Y=""  S W="'"_$P(Y,":")_"' FOR "_$P(Y,":",2)_";" W ?M,"  "_W,!
 I $D(^DD(F(Z),D1,3))#2 S W=^(3) W ?M D W1
RD ;
 I X S Z=Z+1,DDL1=DDL1+2,DDL2=DDL2+2,F(Z)=+X,W="   Multiple" D W1,L
END S X="" G:M'=U A:Z>1 Q
 ;
W1 W:$X+$L(W)+3>IOM !,?$S(IOM-$L(W)-5<M:IOM-5-$L(W),1:M),S S %Y=$E(W,IOM-$X,999) W $E(W,1,IOM-$X-1),S I %Y]"" S W=%Y G W1
 D:$Y>IOSL HD Q
 ;
HD S DC=DC+1 D ^DIDH
 Q
VP ;Variable Pointer
 W ?50,W S D1=DJ(Z)
VP0 I '$D(^DD(F(Z),D1,"V",0)) S W="" Q
 S DID1=0,DIMU=0,DID2=0 I '$D(DDRG) D RT
 S W="FILE  ORDER  PREFIX    LAYGO  MESSAGE" W !?(Z+Z+12),W G Q:M=U
VP1 S DID2=$O(^DD(F(Z),D1,"V",DID2)) S:DID2="" DID2=-1 G:DID2'>0 VP2 S DIDV=^(DID2,0) I '$D(^DIC(+DIDV,0)) S DIDV(+DIDV)=""
 S DIVP=$P(DIDV,U),DDLF=(Z+Z+15) I $L(DIVP)>4 W !?(DDLF-$L(DIVP))+1,DIVP
 E  W !?DDLF,DIVP
 W ?(DDLF+5),$P(DIDV,U,3),?(DDLF+10),$P(DIDV,U,4),?(DDLF+23),$P(DIDV,U,6) S DDL3=DDL2,DDL2=DDLF+27,W=$P(DIDV,U,2) D W1^DIDH1 S DDL2=DDL3 S:$P(DIDV,U,5)["y" DIMU=1 D:$Y+4>IOSL HD G ND^DID1:M=U,VP1
VP2 I DIMU S DIDVI=0 F  S DIDVI=$O(^DD(F(Z),D1,"V",DIDVI)) Q:DIDVI'>0  I $D(^(DIDVI,1)) S %=^(0) D VP3 Q:M=U
 S DIDV=0 F  S DIDV=$O(DIDV(DIDV)) Q:DIDV'>0  S W="!! FILE "_DIDV_" DOES NOT EXIST !!" D W^DID1 Q:M=U
Q W ! K DID2,DIMU,DID1,DIDV,DIDVI S W="" Q
VP3 ;
 W !?(Z+Z+12),"SCREEN"_$S('$D(DINM):" ON FILE "_$P(%,U)_":",1:" EXPLANATION ON FILE "_$P(%,U)_":") S W=" "_$S('$D(DINM):^(1),1:$S($D(^(2)):^(2),1:"")) D W^DID1:'$D(DINM),W^DIDH:$D(DINM)
 Q
RT F W="Required","Add New Entry without Asking","Multiply asked","audited" I X[$E(W,1) S W=" ("_W_")" W:($L(W)+$X)'<IOM ! D W^DID1 G ND^DID1:M=U
 I $D(^DD("KEY","F",F(Z),DJ(Z))) S W=" (Key field)" W:($L(W)+$X)'<IOM ! D W^DID1 G ND^DID1:M=U
 W ! I $D(^DD(F(Z),DJ(Z),.1)),^(.1)]"" W !?(Z+Z+12),^(.1),"   ",?M
 Q
AH W !,"ALPHABETICALLY BY LABEL" D YN^DICN Q:%<0  S:%=1 DIDX=1,BY="@.01"
 I '% W !?5,"Enter YES to list the fields ALPHABETICALLY BY LABEL.",!?5,"Enter NO to list the fields by NUMBER." S %=2 G AH
 Q
