LRWU2 ;SLC/RWF - UTILITY # 2 ; 8/5/87  11:12 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
RANGE ;call input in X, return loop in X9 index is T1
 S X9=""
 F I=1:1 Q:$P(X,",",I,99)=""  S Y=$P(X,",",I) D RA2:Y["-" I +Y S X9=X9_","_+Y
 S X9=$S($L(X9)>1:"F T1="_$E(X9,2,999)_" ",1:"") K J,K,Y Q
RA2 Q:Y<1  S J=+Y,K=+$P(Y,"-",2) I K<J S Y=K,K=J,J=Y
 S X9=X9_","_J_":1:"_K,Y=0 Q
GROUP ;return a sub-group in X(I), Name of group in G1, Display group in G2(i), @G4 How to write G2(i), Other test executed in LREXEC
 S:'$D(G4) G4="G2(I)"
GR1 W:$D(G1) !,G1 F I=0:0 S I=$O(G2(I)) Q:I'>0  W !,$J(I,5),?10,@G4
GR2 R !,"Enter Choice(s) :",G:DTIME I G="?" W !,"Enter a string of numbers separated with ',' or ' '.",!,"You may enter more than one line." G GR1
 W ! G GREND:(G=""!(G="^")) S D=$S(G[",":",",1:" ")
 F I=1:1 S X=$P(G,D,I) Q:X=""  I $D(G2(X)) X:$D(LREXEC) LREXEC S:$D(X) X(X)=""
 G GR2
GREND K I,G,D Q
