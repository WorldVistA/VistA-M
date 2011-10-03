LRDIED ;SLC/RWF - EDIT ; 8/5/87  10:38 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
RW ;
 S DG=Y I $D(DTIME)[0 S DTIME=99999
L W:$X>50 ! R "  Replace ",X:DTIME G D:X="",Q:X?1"^".E,Q:X?."?",Q:X="@",E:X="END"!(X="end")
 I Y[X S D=X D H G D:'$T S Y=$P(Y,D,1)_X_$P(Y,D,2,999) G L
 S D=$P(X,"...",1),DH=$F(Y,D) I DH S X=$P(X,"...",2,99),X=$S(X="":999,1:$F(Y,X,DH)) I X S DH=DH-$L(D)-1,D=X D H I  S Y=$E(Y,1,DH)_X_$E(Y,D,999) G L
 W $C(7)," ??" G L
H R " With ",X:DTIME Q:X?.ANP  W $C(7),"??" G H
E D H I  S Y=Y_X G L
D W:'$T $C(7) I DG'=Y S X=Y W !?3 W X I X="" S X="@"
Q Q
