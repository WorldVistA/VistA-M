GMRYDIR ;HIRNFO/YH-REPLACE...WITH ;12/14/95
 ;;4.0;Intake/Output;;Apr 25, 1997
RW(STRING,LEN) ; Replace...With...
 N X,Y,%,L S Y=STRING W !,STRING,! S:$D(DTIME)[0 DTIME=999
A W:$X>75 !  W "  Replace " R X:DTIME I '$T!(X["^") S GMROUT=1 G Q
 G Q:X="",Q:X?1."^",Q:$E(X)=U&(Y'[X),C:X?."?",Q:X="@",E2:X="END"!(X="end")
 I Y[X S D=X,L=$L(X) D H G:GMROUT Q S:'%&'GMROUT Y=$P(Y,D,1)_X_$P(Y,D,2,999) G A
 S D=$P(X,"...",1),DH=$F(Y,D) I DH S X=$P(X,"...",2,99),X=$S(X="":$L(Y)+1,1:$F(Y,X,DH)) I X S DH=DH-$L(D)-1,D=X,L=D-DH-1 D H G:GMROUT Q S:'%&'GMROUT Y=$E(Y,1,DH)_X_$E(Y,D,999) G A
 W $C(7)," ??" G A
H W "  With " R X:DTIME I '$T!(X["^") S GMROUT=1,X="",%=0 Q
 S %=$L(Y)-L+$L(X)>LEN I % W $C(7),$S($L(Y)-L'>LEN:"  String too long by "_($L(Y)-L+$L(X)-LEN)_" character(s)",X'=U:"  String too long! '^' to quit",1:" ??") Q:$L(Y)-L>LEN&(X=U)  G H
 Q:X?.ANP  W $C(7)," ??" G H
E2 S L=0 D H G:GMROUT Q S:'%&'GMROUT Y=Y_X G A
C W !,"Entry must be lesser than "_LEN_" characters",! G A
B W:GMROUT *7 I STRING'=Y S X=Y W !?3 W X I X="" S X="@"
Q W:'GMROUT !,Y,! Q Y
 ;
