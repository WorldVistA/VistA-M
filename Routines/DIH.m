DIH ;SFISC/GFT-HISTOGRAM ;8:19 AM  28SEP2004
 ;;22.0;VA FileMan;**2,61,144**;Mar 30, 1999;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 I $O(^DOSV(0,IO(0),0))'>0 W !,$C(7),"NO SUB-COUNTS WERE RUN" Q
 K ZTSK S:$D(^%ZTSK) %ZIS="QM" D ^%ZIS G ENDK:POP,QUE:$D(IO("Q"))
DQ S J=$I,DN="=$O(^DOSV(0,J," F X=0:1 Q:'$D(^DOSV(0,J,"BY",X+1))
 G END:'X S A=^(1),DD=$P(A,U,3) I $D(^DD(+A,+$P(A,U,2),0)) S DD=^(0)
 S T=$P(DD,U,2),DP=$P(DD,U,3),DF=$S(T["S":1,T["P":2,T["D"!($P(A,U,7)["D"):3,1:0)
 S DMX=DN_X,DX="",F=X
F S DMX=DMX_",D"_F,DX=DX_"S D"_F_"="""" F X=X:0 S D"_F_DMX_")) Q:D"_F_"=""""  "_$P("S X=X+1,DS(X)=0,DD(X)=0,DV(X)="_$E("-",$P(A,U,4)["-")_"D"_X_" ",U,F=X),F=F-1 G F:F
 S DX=DX_"S:$D(^(D1,F,""N"")) DD(X)=DD(X)+^(""N"") S:$D(^(""S"")) DS(X)=DS(X)+^(""S"")"
 I $E(IOST)="C" S DIFF=1
 S F=-1,C="*",DIHIOM=IOM-23,DIHIOSL=IOSL-8 U IO W:$D(DIFF)&($Y) @IOF S DIFF=1
I S @("F"_DN_"""F"",F))") I 'F G END
 S X=0,T=^(F),DS=1 X DX S DIH=X
 D MAX G I
 ;
MAX S DMX=0 F N=1:1:DIH S:DD(N)>DMX DMX=DD(N) D LBL:DS=1&DF S DV(N)=$E(DV(N),1,14)
 S X=1 F S=1:1 S X=X*2 Q:DMX'>X
 S D1=DMX+X\X*X F S=D1:-X/2 Q:S'>DMX  S D1=S
 S D2=DIHIOM*X/D1
XX S X=X\2,D2=D2\2 I X>4,$L(X)+7<D2 G XX
 I DMX S S=D1/DIHIOM,D1=D2 F X=1:1:DIH D HD:X=1!'(X-1#DIHIOSL),LN,TR:X=N!'(X#DIHIOSL) I Y=U Q
SUM Q:$P(T,U,4)["D"!(Y=U)  I DS=1 S DS=2 F N=1:1 G:N>DIH MAX S S=DD(N),DD(N)=DS(N),DS(N)=S
MEAN I DS=2 S DS=3 F N=1:1 S DD(N)=$S(DS(N):DD(N)/DS(N),1:0) G MAX:N=DIH
 Q
 ;
END W:($E(IOST)'="C")&($Y) @IOF K:$D(ZTSK) ^DOSV(0,IO) D CLOSE^DIO4
ENDK K ZTSK,DIH,S,A,C,DD,DS,D1,D2,DN,T,DP,F,N,J,POP,DF,X,Y,DX,DMX,DV,DIHIOM,DIHIOSL,DIFF Q
 ;
LBL I DF=1 S D1=$F(DP,DV(N)_":") S:D1 DV(N)=$P($E(DP,D1,999),";",1) Q
 I DF=2 S DV(N)=$P(@(U_DP_DV(N)_",0)"),U,1) Q
 S DV(N)=$S($E(DV(N),4,5):+$E(DV(N),4,5)_"-",1:"")_$S($E(DV(N),6,7):+$E(DV(N),6,7)_"-",1:"")_(1700+$E(DV(N),1,3)) Q
 ;
HD U IO W:$Y+N+1>DIHIOSL @IOF W !! D  W !! Q
 .N H
 .S H=$P("COUNT^SUM^MEAN",U,DS)_", "
 .I $D(^DD(+T,0)) S Y=+$P(T,U,2) I Y>.01,$D(^(Y,0)) S H=H_$P(^(0),U)_", "
 .S H=H_"BY "_$P(DD,U) W ?IOM-$L(H)-2,H
LN W ?15-$L(DV(X))-1,DV(X)," |" F Y=1:1:DD(X)/S W C
 W ! Q
TR W ?15 F Y=0:1:DIHIOM W $E("-+",Y#D1=0+1)
 W ! F Y=1:1:DIHIOM I Y#D1=0 S D2=$J(Y*S,0,0) W ?Y+15-($L(D2)\2),D2
 I IOST?1"C".E W $C(7) R Y:DTIME
 Q
QUE ;
 S ZTSAVE("^DOSV(0,$I,")=""
 S ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL,ZTRTN="DQ^DIH"
 D ^%ZTLOAD K ZTSK G END
 ;
