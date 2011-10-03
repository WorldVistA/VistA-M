LRSPDA ;AVAMC/REG - SURGICAL PATH DATA ENTRY ; 9/11/88  17:13 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
L S X="SURGICAL PATHOLOGY" D ^LRUTL Q
 ;
H ;blocks, stains, procedures
 D END,L G:Y=-1 END K DR,Y W ! F X=1,2,3 S Y(X)=$P(^DD(63.812,X,0),"^") W !?15,X,". ",Y(X)
 S Z="",B=1 F A=0:0 W !,"Selection (",B,"): " R X:DTIME Q:X=""!(X[U)  D:X<1!(X>3)!(X'=+X) HELP I X>0&(X<4)&(X=+X) W " ",Y(X) S:Z'[X Z=Z_X_";" S B=B+1 Q:B=4
 Q:Z=""  S DR=.012,(DR(3,63.8121),DR(3,63.822),DR(3,63.824))=".01;1//^S X=""H & E STAIN""",(DR(4,63.8122),DR(4,63.823),DR(4,63.824))=".01;.02//1;.03;.04"
 S DR(2,63.812)=Z D ^LRAPDA,END Q
HELP W $C(7),!!,"Enter a number from 1 to 3",! Q
 ;
END D V^LRU Q
