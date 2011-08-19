DIDH ;SFISC/XAK-HDR FOR DD LISTS ;05:35 PM  24 Apr 2002
 ;;22.0;VA FileMan;**76**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^DIDH1 I $G(M)=U S DN=0
Q K DDV,%F,M1 Q
 ;
XR S X=2,J=0,DG=F(Z) W:$Y !
XL S J=$O(^DD(DA,0,"IX",J)) I J="" S F(Z)=DG Q
 F K=0:0 S K=$O(^DD(DA,0,"IX",J,K)) G XL:K'>0 F N=0:0 S N=$O(^DD(DA,0,"IX",J,K,N)) Q:N'>0  I 1 S F(Z)=K,DJ(Z)=N X:$D(DIGR) DIGR D:$T XL1
XL1 F %=0:0 S %=$O(^DD(K,N,1,%)) Q:'%!(M=U)  I $D(^(%,0)),+^(0)=DA,$P(^(0),U,2)=J W:X=2 !,"CROSS",! W $P(", ^REFERENCED BY: ",U,X) S X=$P(^DD(K,N,0),U)_"("_J_")" W:($L(X)+$X+4)'<IOM !?15 W X S X=1 Q:$Y+4'>IOSL  I '$D(DIU) D H S X=2
 Q
POINT ; CALLED BY ^DD(1,.01,"DEL",.5,0)
 S W1="W:$Y ! W !,""POINTED TO BY: "",?15" I $O(^DD(DA,0,"PT",""))'="" S DDPT=1
 S X="" F  S X=$O(^DD(DA,0,"PT",X)) Q:X=""  S DG=0 F  S DG=$O(^DD(DA,0,"PT",X,DG)) Q:DG=""  D PD W:$D(^DD(DA,0,"PT",X,DG)) !?15 I '$D(DIU) D H G Q:M=U
 S (DG,X)=-1 K W1,DDPT Q
PD I $S('$D(^DD(X,DG,0)):1,$P(^(0),U,2)["V":0,1:$P($P(^(0),U,2),"P",2)-DA) K ^DD(DA,0,"PT",X,DG) Q
 S %=X,%F=DG
WR I '$D(IOM) S IOP="HOME" N %X D ^%ZIS Q:POP
 I $D(DDPT) X W1 K DDPT
 S X1=$P(^DD(%,%F,0),U)_" field (#"_%F_")"
UP I $L(X1)+$L(%)+$L($O(^DD(%,0,"NM",0)))>225 S X1=X1_" etc... ^" G L1
 S X1=X1_" of the "_$O(^(0))
 I $D(^DD(%,0,"UP")) S X1=X1_" sub-field (#"_%_")",%=^("UP") G UP
 S X1=X1_" File (#"_%_") ^"
L1 F DDC=1:1 S DDV=$P(X1," ",DDC)_" " Q:DDV["^"  W:$L(DDV)+$X>IOM !,?19 W DDV
 K DDC,DDV,X1 Q
 ;
TRIG ;CALLED BY ^DD(1,.01,"DEL","TRB",0)
 S W1="W:$Y ! W !,""A FIELD IS"",!,""TRIGGERED BY :"",?15",DDPT=1
 K X S X="" F  S X=$O(^DD(DA,"TRB",X)) Q:X=""  I X-DA,'$D(^DD(DA,"SB",X)) S %=0 F  S %=$O(^DD(DA,"TRB",X,%)) Q:%=""  S %X=0 F  S %X=$O(^DD(DA,"TRB",X,%,%X)) Q:%X=""  S %Y=0 F  S %Y=$O(^DD(DA,"TRB",X,%,%X,%Y)) Q:%Y'>0  D TT
 S %Y=-1 I $D(X)>9 S %X=0 F  S %X=$O(X(%X)) Q:%X=""  S X=0 F  S X=$O(X(%X,X)) Q:X=""  S %F=X,%=%X D WR:$D(^DD(%,X,0)) W !?15 D:'$D(DIU) H I 1
 K X,%X,%Y,W1,DDPT Q
 ;
TT S X(X,%)=0 I $D(^DD(X,%,0)) Q:$P(^(0),U,2)  I $D(^(1,%X,0)),^(0)["TRIGGER" Q
 K X(X,%),^DD(DA,"TRB",X,%,%X,%Y)
 Q
H I $D(IOSL),$Y+4>IOSL S DC=DC+1 D ^DIDH1 G Q:M=U
 Q
W F K=0:1 W:$D(DDF) !?25 S %Y=$E(W,IOM-$X,999) W $E(W,1,IOM-$X-1) Q:%Y=""  S W=%Y,DDF=1
 K DDF Q
PTR(X) ;finds pointers to file being deleted
 N Y,Z S (Y,Z)=0
 I $O(^DD(X,0,"PT",Y))="" Q Z
 D  Q Z
 . F  S Y=$O(^DD(X,0,"PT",Y)) Q:Y=""  I $$FNO^DILIBF(Y)'=X S Z=1 Q
 . Q
