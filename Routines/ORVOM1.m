ORVOM1 ; slc/dcm - Creates rtns for Protocol export ;1/23/91  07:13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
L S DH=" F I=1:2 S X=$T(Q+I) Q:X=""""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y",F=$O(F(F))
 I 'F D FILE^ORVOM3:DL S:DSEC DH=" I DSEC"_DH,%X="^UTILITY(""DI"",$J,",%Y="^UTILITY($J," D:DSEC %XY^%RCR,FILE^ORVOM3:$O(^UTILITY($J,0)) K ^UTILITY("DI",$J) S:DSEC DH=$E(DH,8,999) G ^ORVOM11
 S ^UTILITY($J,DL+1,0)="^DIC("_F_",0,""GL"")",^UTILITY($J,DL+2,0)="="_F(F,0),^UTILITY($J,DL+3,0)="^DIC(""B"","""_F(F)_""","_F_")",^UTILITY($J,DL+4,0)="=",DL=DL+4
 F E="%","%D" S %X="^DIC("_F_","""_E_""",",E=0 D %XY
 I DSEC S E="" F DSEC=DSEC:1 S E=$O(^DIC(F,0,E)) Q:E=""  I E'="GL" S ^UTILITY("DI",$J,DSEC,0)="^DIC("_F_",0,"""_E_""")" S DSEC=DSEC+1 S ^UTILITY("DI",$J,DSEC,0)="="_^DIC(F,0,E)
 S D=0 F  S D=$O(F(F,D)),E=0,%X="^DD("_D_",0" Q:'D  S DL=DL+1,^UTILITY($J,DL,0)=%X_")",DL=DL+1,^UTILITY($J,DL,0)="="_^DD(D,0),%X=%X_"," D %XY S X=0 F  S X=$O(^DD(D,X)) Q:'X  S %X="^DD("_D_","_X_",",E="%Z#2" D SAVE:$D(F(F,D))<9!$D(F(F,D,X))
 I $D(DTL(F)) D FILE^ORVOM3
 I $D(DTL(F)) S DL=DL+1 S E="%Z#2=0",%X=F(F,0),@("D="_%X_"0)")
 I  S ^UTILITY($J,DL+1,0)="^UTILITY(U,$J,"_F_")",^UTILITY($J,DL+2,0)="="_%X,^UTILITY($J,DL+3,0)="^UTILITY(U,$J,"_F_",0)",^UTILITY($J,DL+4,0)="="_D,%Y="^UTILITY(U,$J,"_F_",",%Z=0,%C(-1)=0,%B=0,%A="",DL=DL+5
 I  D N D FILE^ORVOM3
 G L
 ;
SAVE K DSV I $D(^DD(D,X,8)) S DSV(8)=^(8) K ^(8)
 I $D(^DD(D,X,8.5)) S DSV(8.5)=^(8.5) K ^(8.5)
 I $D(^DD(D,X,9)),^(9)'=U S DSV(9)=^(9) K ^(9)
 D %XY
 F %Z=8,8.5,9 I $D(DSV(%Z)),DSV(%Z)]"" S ^DD(D,X,%Z)=DSV(%Z) I DSEC S ^UTILITY("DI",$J,DSEC,0)="^DD("_D_","_X_","_%Z_")",DSEC=DSEC+1,^UTILITY("DI",$J,DSEC,0)="="_DSV(%Z),DSEC=DSEC+1
 Q
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
