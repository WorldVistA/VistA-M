DIDT ;SFISC/GFT-DATE/TIME UTILITY ;2014-12-26  12:32 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**14,35,162,165,1046,1047**
 ;
%DT ;
 I $G(DUZ("LANG"))>1,($G(^DI(.85,DUZ("LANG"),20.2))]"") X ^(20.2) Q
CONT ;
 K % S:$D(%DT)[0 %DT="" S:$G(DIQUIET)!($D(DDS)#2)!($D(ZTQUEUED)) %DT=$P(%DT,"E")_$P(%DT,"E",2) G NA:%DT'["A"
 W !,$S($D(%DT("A")):%DT("A"),1:"DATE: "),$S($D(%DT("B")):%DT("B")_"//",1:"")
 R X:$S($D(DTIME):DTIME,1:300) S:'$T X="^",DTOUT=1 G:$L(X)>39 1
 I $D(%DT("B")),X="" S X=%DT("B")
 I "^"[X S Y=-1 K %I,% Q
NA S %(0)=X G 1:X'?.ANP,1:$P(X,"@")?15.N,1:$P(X,"@",2)?15.N,1:$L(X)>39
 F %=1:1:$L(X) Q:X?.UNP  S Y=$E(X,%) I Y?1L S X=$E(X,1,%-1)_$C($A(Y)-32)_$E(X,%+1,99) ;UPPER CASE
 I %DT["E",X?."?" D HELP^%DTC G B
 I %DT["N",X?.N G NO
 I X?1.A,(X["MID"!(X["NOON")) S X="@"_X
 I X'?1"NOV".E,X?1"N".1"OW".1P.E G N^%DTC:%DT["T"!(%DT["R")&(%DT'["M") S X=$E(X,2,99),X="T"_$P(X,"OW")_$P(X,"OW",2)
 I X?1.N." "1.2A!(X?1.N1":"2N." ".2A)!(X?1.N1":"2N1":"2N." ".2A) S X="T@"_X
 I X?7N1"."1.N G R
 I X'["@",%DT'["R" G R
 I %DT'["T",%DT'["R" G NO
 I %DT["M" G NO
 S Y=$P(X,"@",2,9),X=$P(X,"@")
 F %=2,3 S %I=$P(Y,":",%) I %I?1N.E,%I'?2N.PA G 1
 S:X="" X="T" S Y=$P(Y,":")_$P(Y,":",2)_$P(Y,":",3,9),%I=Y
 I Y?1.A S Y=$S(Y["MID":2400,Y["NOON":1200,1:"")
T G G:Y?4N,G1:Y?6N&(%DT["S"),1:Y'?1.6N." ".1(1"AM",1"A",1"A.M",1"PM",1"P",1"P.M").P I %DT["R",Y="" G NO
 S %I=$P(1_%I,+(1_Y),2) S:%I]"" Y=$P(Y,%I)
 I Y?5.6N G:%DT'["S" 1 S %(3)=$E(Y,$L(Y)-1,$L(Y)),Y=$E(Y,1,$L(Y)-2) G 1:%(3)>59
 I Y?1.2N G:Y'<13 1 S Y=Y_"00" S:$E(Y)=0 %I="A"
 I %I["A" S Y=$S(Y=1200&'$G(%(3)):2400,Y>1159:Y-1200,1:Y)
 E  I Y?1.2"0"2N G:%I["P" 1
 E  I Y<1200,%I["P"!(Y<600) S Y=Y+1200 ;ASSUME PM
G G 1:Y>2400,1:Y#100>59,1:('Y&('$G(%(3)))) S %(1)=$S('Y:".0000",1:Y/10000) G R
G1 G 1:Y>240000!'Y,1:$E(Y,3,4)#100>59,1:$E(Y,5,6)#100>59 S %(1)=Y/1000000
R I %DT["F"!(%DT["P") D TY S %(9)=%
7 G 8:X'?7N1".".E&(X'?7N) S Y=$E(X,8,16),%=$E(Y_"000000",2,7)
 I Y,%DT'["T"!(%DT["M") G NO
 I %DT["E",(%'?.N)!(%>240000)!($E(%,3,4)>59)!($E(%,5,6)>59) G NO
 S:Y %(1)=+Y S X=$E(X,4,7)_($E(X,1,3)+1700),%(7)=1
 I %DT["I",'$D(%("ALPHA")) S X=$E(X,3,4)_$E(X,1,2)_$E(X,5,9)
8 S %I=0,%="" I X'?.N G T^%DTC:"T+-"[$E(X),U:X["^",1:$E(X)?1P,MTH:X?3.A&(%DT["M"),X
 I X?8N,X>17999999,$E(X,5,8)<1300 S X=$E(X,5,8)_$E(X,1,4),%("ALPHA")=1 ;MAY BE '200101231' FOR 2001DEC31
 I %DT'["X",X\300=6!(X?2N) S (%I(1),%I(2))=0,%I(3)=X G 3
 F %I=0:1 S Y=$E(X,1,2),X=$E(X,3,9) G OT:Y="" D  G:%I="" 1
 . I %DT["X",%DT'["M",%I<2,'Y S %I="" Q
 . S:%I=2 Y=Y_X,X=""
 . I %DT["X",%I=2,$L(Y)>2,Y'>1799 S %I="" Q
 . S %I(%I+1)=Y Q
 ;
X S Y=$E(X),X=$E(X,2,99) I Y?1N G A:%?.N,Y ;PEEL OFF CHARACTER-BY-CHARACTER
 I Y?1A G A:%?.A,Y
OT D:%]"" % G 1:%I>3,X:Y?1P,1:Y]"",@%I
Y D % S %=Y G 1:%I>3,X
A S %=%_Y G X
TY S %=$H#1461,%=$H\1461*4+(%\365)+141-(%=1460) Q
0 ;
1 W:%DT["E"&'$D(DIER) $C(7),$S('$D(DDS):" ??",1:"") ;INPUT IS BAD!
B G %DT:%DT["A",NO
U S X="^",%(0)=X
NO S Y=-1 G Q:%DT'["A",Q:X["^" W $C(7)," ??" G %DT
2 I %DT["M" S %I(3)=%I(2),%I(2)=0 G 3
 I %I(2)>31!'%I(2),%DT'["X" S %I(3)=%I(2),%I(2)=0 G 1:'%I(2)&$G(%(1)) G 3
 D TY S %I(3)=% D PF^%DTC:$D(%(9)) G C
3 I %I(1)>1700 S %("YF")=%I(1),%I(1)=%I(2),%I(2)=%I(3),%I(3)=%("YF") ;YEAR FIRST: ALLOW '2010-1-31'
 I %I(3)?2N D  G C
 . I '$D(%(9)) D TY S %(9)=%
 . N A S A=$E(%(9))*100
 . I $E(%(9),2,3)=%I(3) S %I(3)=A+%I(3) Q
 . I %DT["P" S %I(3)=$S(%I(3)<$E(%(9),2,3):A,1:A-100)+%I(3) Q
 . I %DT["F" S %I(3)=$S(%I(3)>$E(%(9),2,3):A,1:A+100)+%I(3) Q
 . S %I(3)=A+%I(3)
 . I %(9)-%I(3)>80 S %I(3)=%I(3)+100 Q
 . I %I(3)-%(9)>20 S %I(3)=%I(3)-100
 . Q
 S %I(3)=%I(3)-1700 G 1:%I(3)'?3N
C I %DT["I",'$D(%("ALPHA")),'$D(%("YF")),%I(2)>0 S %=%I(2),%I(2)=%I(1),%I(1)=% ;INTERNATIONAL: REVERSE MONTH/DAY
 I %I(2)="00",'$G(%(7)) G 1
 I %DT["M",$G(%I(2)) G 1
 I %I(1)>12!(%I(1)="00") G 1
 I %I(2)>28,$E("303232332323",%I(1))+28<%I(2),%I(1)-2!(%I(2)-29)!(%I(3)#4)!('(%I(3)#100)&(%I(3)+1700#400)) G 1
D I %DT["M",$G(%I(2)) S %I(2)=0
 D P
E I $D(%(1)) S:$D(%(3)) %(1)=$E(%(1)_"000",1,5)_%(3) S Y=+(Y_%(1))
 I '$E(Y,6,7),Y["." G 1
 I %DT["E" S %=Y D DD W "  ("_Y_")" S Y=%
 I $D(%DT(0)) S %=%DT(0),%I=$S(%["-":Y,1:-Y) D:'% Z I $S(%DT["S":%,1:%\.0001/10000)+%I>0 G 1
Q S X=%(0) K %,%I,%H Q
 ;
Z I $P("NOW",%(0))="" S %=Y
 E  D NOW^%DTC
 S:%DT(0)["-" %=-% Q
 ;
DD I $G(DUZ("LANG"))>1 S Y=$$OUT^DIALOGU(Y,"DD") Q  ;create writable date from 'Y' to 'Y'
 Q:'Y
 N M,MI,COMMA S M=$S($E(Y,4,5):$E($P($T(M)," ",$E(Y,4,5)+2),1,3)_" ",1:""),MI="",COMMA="," I $G(%DT)["I" S MI=M,M="",COMMA="" ;INTERNATIONAL (UK)
 S Y=M_$S($E(Y,6,7):$E(Y,6,7)_COMMA_" ",1:"")_MI_($E(Y,1,3)+1700)_$S(Y[".":"."_$P(Y,".",2),1:"")
 I Y["." S Y=$P(Y,".")_"@"_$E(Y_0,14,15)_":"_$E(Y_"000",16,17)_$S($E(Y,18,19):":"_$E(Y_0,18,19),1:"")
 I $D(%DT)#2,%DT["S",Y["@",$P(Y,":",3)="" S Y=Y_":00"
 Q
 ;
P S Y=%I(3)_$E(%I(1)+100,2,3)_$E(%I(2)+100,2,3) Q
 ;
MTH S %=X D % G:%I>3 1
 S %I(2)=0
 D TY S %I(3)=% D:$D(%(9)) PF^%DTC
 G D
% ;I %DT["I",%?3.A S %I=9 Q
 I %?3.A S %=$F($T(M)," "_%) I %>0 S %=$L($E($T(M),6,%-1)," ") D:%I=1  S %("ALPHA")=1 ;ONLY MONTH IS ALPHA
 . N T S T=%I(1),%I(1)=%,%=T I $D(%("ALPHA")) S %I=9
 S:%<1&(%'="00")&(%I'=2) %I=9 S %I=%I+1,%I(%I)=%,%=""
M ;; JANUARY FEBRUARY MARCH APRIL MAY JUNE JULY AUGUST SEPTEMBER OCTOBER NOVEMBER DECEMBER
