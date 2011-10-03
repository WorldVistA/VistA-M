DICATT6 ;SFISC/XAK-SETS,FREE TEXT ;5:52 AM  20 Dec 2001
 ;;22.0;VA FileMan;**76**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 G @N
 ;
3 S Z="",L=1,P=0,Y="INTERNALLY-STORED CODE: "
P S P=P+1,C=$P($P(O,U,3),S,P) W !,Y W:C]"" $P(C,":",1)_"// " R T:DTIME G T:'$T
 I T_C]"" G P:T="@" S:T="" T=$P(C,":",1) S X=T,L=$S($L(X)>L:$L(X),1:L) D C I $D(X) W "  WILL STAND FOR: " W:C]"" $P(C,":",2),"// " R X:DTIME G:'$T T S:X="" X=$P(C,":",2) D C I $D(X) G TOO:$L(Z)+$L(T)+$L(X)+$L(F)>235 S Z=Z_T_":"_X_S G P:X]"",T
 G T:Z=""!'$D(X) S (DIZ,Z)="S^"_Z I DUZ(0)="@" S DE="^"_F D S^DICATT5 K DE G CHECK^DICATT:$D(DTOUT)!(X=U)
 S C="Q" G H
 ;
C I X["?",P=1 K X W !,"For Example: Internal Code 'M' could stand for 'MALE'",! Q
 I X[":"!(X[U)!(X[S)!(X[Q)!(X["=") K X W $C(7),!,"SORRY, ';' ':' '^' '""' AND '=' AREN'T ALLOWED IN SETS!",! Q
 I X'?.ANP W !,$C(7),"Cannot use CONTROL CHARACTERS!" K X
 Q
 ;
TOO W $C(7),!,"TOO MUCH!! -- SHOULD BE 'POINTER', NOT 'SET'"
T W ! G NO^DICATT2:'$D(X) S DTOUT=1 G CHECK^DICATT
 ;
4 K DG,DE,M S DL=1,L=1,DP=-1,DQ(1)="MINIMUM LENGTH^NR^^1^K:X\1'=X!(X<1) X",DQ(2)="MAXIMUM LENGTH^RN^^2^K:X\1'=X!(X>250)!(DG(1)>X) X"
 S T="",P=" X",DQ(3)="(OPTIONAL) PATTERN MATCH (IN 'X')^^^3^S X=""I ""_X D ^DIM S:$D(X) X=$E(X,3,999) I $D(X) K:X?.NAC X",DQ(3,3)="EXAMPLE: ""X?1A.A"" OR ""X'?.P"""
 G DIED:'O,DG:C'?.E1"K:$L".E1" X"
 S T=$P(C,"K:$L",1),DE(2)=+$P(C,"$L(X)>",2),DE(1)=+$P(C,"$L(X)<",2)
 S Y=0,I=0,Z=$P(C,")!'(",2,99) I Z="" K:'DE(2) DE(2) G DG
L S I=I+1,X=$E(Z,I) G L:X'?.P,DG:X="" I X=Q S Y='Y G L
 G L:Y I X="(" S L=L+1
 G L:X'=")" S L=L-1 G L:L
 S DE(3)=$E(Z,1,I-1),P=$E(Z,I+1,999)
DG S:$D(^DD(A,DA,3)) M=^(3) F L=1,2,3 S:$D(DE(L)) DG(L)=DE(L)
DIED K Y S DM=0 D DQ^DIED K DQ,DM G CHECK^DICATT:$D(DTOUT)!($D(Y))
 S Y=DG(1),L=DG(2),X=$S(L=Y:L,1:Y_"-"_L) I L<Y W $C(7),"??" G 4
 S Z="Answer must be "_X_" character"_$E("s",X'=1)_" in length." I $S($D(M):M'[Z,1:1) S M=Z
 S X=$S('$D(DG(3)):"",DG(3)="":"",1:"!'("_DG(3)_")")
 S C=T_"K:$L(X)>"_L_"!($L(X)<"_Y_")"_X_P
Z S (DIZ,Z)="F^"
H G ^DICATT1
