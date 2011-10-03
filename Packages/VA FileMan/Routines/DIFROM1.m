DIFROM1 ;SFISC/XAK-CREATES RTNS WITH DD'S ;02:23 PM  28 Nov 1994
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
L S DH=" F I=1:2 S X=$T(Q+I) Q:X=""""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y",F=$O(F(F))
 I F'>0 D:DSEC SEC K ^UTILITY("DI",$J) G ^DIFROM11
 S ^UTILITY($J,DL+1,0)="^DIC("_F_",0,""GL"")",^UTILITY($J,DL+2,0)="="_F(F,0),^UTILITY($J,DL+3,0)="^DIC(""B"","""_F(F)_""","_F_")",^UTILITY($J,DL+4,0)="=",DL=DL+4
 S DH=" Q:'DIFQ("_F_") "_DH
 F E="%","%D" S %X="^DIC("_F_","""_E_""",",E=0 D %XY
 I DSEC S E="" F DSEC=DSEC:1 S E=$O(^DIC(F,0,E)) Q:E=""  I E'="GL" S ^UTILITY("DI",$J,DSEC,0)="^DIC("_F_",0,"""_E_""")" S DSEC=DSEC+1 S ^UTILITY("DI",$J,DSEC,0)="="_^DIC(F,0,E)
 F D=0:0 S D=$O(F(F,D)),E=0,%X="^DD("_D_",0" Q:D'>0  S ^UTILITY($J,DL+1,0)=%X_")",DL=DL+2,^UTILITY($J,DL,0)="="_^DD(D,0),%X=%X_"," D V F X=0:0 S X=$O(^DD(D,X)) Q:X'>0  S %X="^DD("_D_","_X_",",E="%Z#2" D SAVE:$D(F(F,D))<9!$D(F(F,D,X))
 D FILE^DIFROM3 G:'$D(DRN) EQ^DIFROM11 I $P(F(F,-222),U,7)'="y" G L
 S DL=DL+1,E="%Z#2=0",%X=F(F,0),@("D="_%X_"0)")
 S ^UTILITY($J,DL+1,0)="^UTILITY(U,$J,"_F_")",^UTILITY($J,DL+2,0)="="_%X,^UTILITY($J,DL+3,0)="^UTILITY(U,$J,"_F_",0)",^UTILITY($J,DL+4,0)="="_D,%Y="^UTILITY(U,$J,"_F_",",%Z=0,%C(-1)=0,%B=0,%A="",DL=DL+5
 D N S DH=$P(DH,"DIFQ")_"DIFQR"_$P(DH,"DIFQ",2,99)
 D FILE^DIFROM3 G:'$D(DRN) EQ^DIFROM11 G L
 ;
SAVE K DSV I $D(^(X,8)) S DSV(8)=^(8) K ^(8)
 F %Z=8.5,9 I $D(^(%Z)),^(%Z)'=U,'($P(^(0),U,2)["K"&(^(%Z)="@")) S DSV(%Z)=^(%Z) K ^(%Z)
 D %XY
 F %Z=8,8.5,9 I $D(DSV(%Z)),DSV(%Z)]"" S ^DD(D,X,%Z)=DSV(%Z) I DSEC S ^UTILITY("DI",$J,DSEC,0)="^DD("_D_","_X_","_%Z_")",DSEC=DSEC+1,^UTILITY("DI",$J,DSEC,0)="="_DSV(%Z),DSEC=DSEC+1
 Q
 ;
SEC S DH=" I DSEC"_DH,%X="^UTILITY(""DI"",$J,",%Y="^UTILITY($J," D %XY^%RCR
 D FILE^DIFROM3:$O(^UTILITY($J,0))>0 G:'$D(DRN) EQ^DIFROM11 S DH=$E(DH,8,999) Q
 ;
%XY ;
 W "." S %Z=0,%A="",%C(-1)=0,%Y=%X
S S %B=""
N S @("%B=$O("_%X_%A_"%B))"),%C(%Z)=%C(%Z-1) I '%B,%B'?1"0".E,@E S %B=""
 I %B["," F %C=0:0 S %C=$F(%B,",",%C) Q:'%C  S %C(%Z)=%C(%Z)+1
 I %B="" G Q:'%Z S @("%B="_$P(%A,",",%Z+%C(%Z-2),%Z+%C(%Z-1))),%Z=%Z-1,%A=$P(%A,",",1,%Z+%C(%Z-1))_$E(",",%Z>0) G N
 I @("$D("_%X_%A_"%B))#2=1") S %V=^(%B) D W:%V'?.ANP S %=$P("""",U,+%B'=%B),%=%Y_%A_%_%B_%_")" D B:$L(%V)>240 S DL=DL+1,^UTILITY($J,DL,0)=%,DL=DL+1,^UTILITY($J,DL,0)="="_%V
 I @("$D("_%X_%A_"%B))<9") G N
 G D:+%B=%B F %C=0:0 S %C=$F(%B,"""",%C) Q:'%C  S %B=$E(%B,1,%C-1)_""""_$E(%B,%C,999),%C=%C+1
 S %B=""""_%B_""""
D S %A=%A_%B_",",%Z=%Z+1 G S
 ;
B I $L(%V)>255 W !,"WARNING--DATA TOO LONG:  " D X
 S DL=DL+1,^UTILITY($J,DL,0)=%,%=$C(126)_$E(%V,1,160),%V=$E(%V,161,999) Q
 ;
W W !,"WARNING--CONTROL CHARACTER IN DATA:  "
X W $C(7),%X,%A,%B,")--",!?3,%V
Q Q
V K DSV I $D(^DD(D,0,"VR"))#2 S DSV=^("VR") K ^("VR")
 D %XY
 I $D(DSV)#2 S ^DD(D,0,"VR")=DSV K DSV
 Q
