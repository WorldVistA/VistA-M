PSOHELP2 ;B'ham ISC/SAB - utility routine #3 ;12/29/94  19:32
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
EN ; validate
 I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>2)!($L(X)>70)!($L(X)<1)!(X["P RN")!(X["PR N") K X Q
 I X?.E1L.E S X=$$ENLU^PSGMI(X) W "  (",X,")"
 ;
ENOS ; order set entry
 S (PSGS0XT,PSGS0Y,XT,Y)="" I X["PRN"!(X="ON CALL") G Q
 S X0=X I X,X'["X" D ENCHK S:$D(X) Y=X G Q
 I X["@" D DW S:$D(X) Y=$P(X,"@",2) G Q
 I $E(X)="?" S Y="?" D DIC K X Q
 I Y'>0,$S(X="NOW":1,X="ONCE":1,X="STAT":1,X="ONE TIME":1,1:X="ONE-TIME") W:'$D(PSGOES) "  (ONCE ONLY)" S Y="",XT="O" G Q
 ;
NS I Y'>0 W:'$D(PSGOES) "  (Nonstandard schedule)" S X=X0,Y=""
 I X="BID"!(X="TID")!(X="QID") S XT=1440/$F("BTQ",$E(X)) G Q
 S:$E(X)="Q" X=$E(X,2,99) S:'X X="1"_X S X1=+X,X=$P(X,+X,2),X2=0 S:X1<0 X1=-X1 S:$E(X)="X" X2=1,X=$E(X,2,99)
 S XT=$S(X["'":1,X["AC"!(X["PC"):480,X["D"!(X["AM")!(X["PM")!(X["HS"):1440,X["H":60,X["W":10080,X["M":40320,1:-1) I XT<0,Y'>0 K X G Q
 S X=X0 I XT S:X2 XT=XT\X1 I 'X2 S:X["O" XT=XT*2 S XT=XT*X1
 ;
Q ;
 S PSGS0XT=$S(XT]"":XT,1:""),PSGS0Y=$S(Y:Y,1:"") K QX,SDW,SWD,X0,XT,Z Q
 ;
ENCHK ;
 I $S($L($P(X,"-"))>4:1,$L(X)>119:1,$L(X)<2:1,X'>0:1,1:X'?.ANP) K X Q
 S X(1)=$P(X,"-") I X(1)'?2N,X(1)'?4N K X Q
 S X(1)=$L(X(1)) I X'["-",X>$E(2400,1,X(1)) K X Q
 F X(2)=2:1:$L(X,"-") S X(3)=$P(X,"-",X(2)) I $S($L(X(3))'=X(1):1,X(3)>$E(2400,1,X(1)):1,1:X(3)'>$P(X,"-",X(2)-1)) K X Q
 K:$D(X) X(1),X(2),X(3) Q
 ;
DW ;
 S SWD="SUNDAYS^MONDAYS^TUESDAYS^WEDNESDAYS^THURSDAYS^FRIDAYS^SATURDAYS",SDW=X,X=$P(X,"@",2) D ENCHK Q:'$D(X)  S X=$P(SDW,"@"),X(1)="-" I X?.E1P.E,X'["-" F QX=1:1:$L(X) I $E(X,QX)?1P S X(1)=$E(X,QX) Q
 F Q=1:1:$L(X,X(1)) K:SWD="" X Q:SWD=""  S Z=$P(X,X(1),Q) D DWC Q:'$D(X)
 K X(1) S:$D(X) X=SDW Q
DWC I $L(Z)<2 K X Q
 F QX=1:1:$L(SWD,"^") S Y=$P(SWD,"^",QX) I $P(Y,Z)="" S SWD=$P(SWD,Y,2) S:$L(SWD) SWD=$E(SWD,2,50) Q
 E  K X
 Q
DIC ;
 K DIC S DIC="^PS(51.1,",DIC(0)="EISZ",D="APPSJ"
 D IX^DIC K DIC S:$D(DIE)#2 DIC=DIE Q:Y'>0  S X=+Y
 S (X,X0)=Y(0,0) S:Y="" Y=$P(Y(0),"^",2)
 Q
ENLU(X) ; convert lower case to upper case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
ENUL(X) ; convert upper case to lower case
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
