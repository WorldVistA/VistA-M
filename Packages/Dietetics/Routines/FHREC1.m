FHREC1 ; HISC/REL - Units Conversion ;2/24/92  13:33 
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Units Input - UNT=Recipe Unit, X=Input - Error if X undefined
 K A1 D TYP I TYP="E" S X=+X G:X'?1N.N!(X<1) F5 G KIL
 I X["#" F K=0:0 S A1=$F(X,"#") Q:'A1  S X=$E(X,0,A1-2)_"LBS"_$E(X,A1,99)
 I X["," F K=0:0 S A1=$F(X,",") Q:'A1  S X=$E(X,0,A1-2)_$E(X,A1,99)
 I X["-" F K=0:0 S A1=$F(X,"-") Q:'A1  S X=$E(X,0,A1-2)_" "_$E(X,A1,99)
F1 S A1=$P(X," ",1),X=$P(X," ",2,99) I A1="" G F4:X="",F1
 G:A1'?.E1U.E D1 F K=1:1:$L(A1) Q:$E(A1,K)?1U
 S A3=$E(A1,K,99),A1=$E(A1,0,K-1),A2="" G D3
D1 G:X="" F5 S A2=$P(X," ",1),X=$P(X," ",2,99) G:A2'?.E1U.E D2
 F K=1:1:$L(A2) Q:$E(A2,K)?1U
 S A3=$E(A2,K,99),A2=$E(A2,0,K-1) G D3
D2 G:X="" F5 S A3=$P(X," ",1),X=$P(X," ",2,99) G:A3'?1U.E F5
D3 S:A1?1N1"/"1N&(A2="") A2=A1,A1=0 I A1'?1N.N,A1'?.N1".".N G F5
 I A2'="" G:A2'?1N1"/"1N F5 S Y1=+A2,Y2=$E(A2,3) G:Y1=0!(Y1'<Y2) F5 S A1=A1+(Y1/Y2)
 S:A3["." A3=$P(A3,".",1) S A2=A3
 I TYP="W" S S1=$F("LBS OZ TBSP TSP",A2) G:'S1 F5 S S1=$S(S1<5:1,S1<8:2,S1<13:3,1:4) G F3
 S S1=$F("GALS QTS QUARTS PINTS PTS CUPS FLOZ TBSP TSP",A2) G:'S1 F5 S S1=$S(S1<6:1,S1<17:2,S1<27:3,S1<32:4,S1<37:5,S1<42:6,1:7)
F3 S:'$D(A1(S1)) A1(S1)=0 S A1(S1)=A1(S1)+A1 G F1
F4 D DIV S X=0 F K=1:1 S P1=$P(P0,",",K) Q:P1=""  S:$D(A1(K)) X=X+(A1(K)/P1)
 S X=$J(X,0,5),X=+X G KIL
F5 K X G KIL
TYP S TYP=$S(UNT="EACH":"E",UNT="LB":"W",1:"V") Q
DIV I TYP="W" S P0="1,16,32,96"
 E  S P0="1,4,8,16,128,256,768"
 Q
EN2 ; Units Output - UNT=Recipe Unit, Y=Amount - return Y
 D TYP I TYP="E" S Y=$J(Y,0,0)_" "_UNT G KIL
 S A2=$S(TYP="W":"LB OZ TBSP TSP",1:"GAL QTS PTS CUPS FLOZ TBSP TSP")
 D DIV F K=1:1 S P1=$P(P0,",",K) Q:P1=""!((Y*P1)'<1)
 S (Y1,Y2)="" S:P1="" K=K-1,P1=$P(P0,",",K) S P2=$P(P0,",",K+1)
 S U1=$P(A2," ",K),U2=$P(A2," ",K+1) I P2="" S P2=P1,P1="",U2=U1,U1="" G N1
 S A1=Y*P1 I A1\1 S Y1=A1\1,Y=Y-(A1\1/P1)
N1 S A1=Y*P2 S:A1#1>.875 A1=(A1+1)\1 I A1\1 S Y2=(A1\1),A1=A1#1
 I P1,Y2'<(P2/P1) S Y1=Y1+1,Y2=Y2-(P2/P1) S:'Y2 Y2=""
N2 S S1=$S(A1<.125:"",A1<.375:"1/4",A1<.625:"1/2",1:"3/4") I Y2'=""!(S1="") G N3
 G:'$P(P0,",",K+2) N3 S A1=A1*$P(P0,",",K+2)/P2+.5\1 G:'A1 N3
 I A1'<($P(P0,",",K+2)/P2) S Y2=Y2+1,S1="" G N3
 S Y2=A1,U2=$P(A2," ",K+2),S1=""
N3 I S1'="" S:Y2'="" Y2=Y2_"-" S Y2=Y2_S1
 I Y1'="" S Y1=Y1_" "_U1 S:Y2'="" Y1=Y1_", "
 S:Y2'="" Y2=Y2_" "_U2 S Y=Y1_Y2 S:Y="" Y="1/8 TSP" G KIL
EN3 ; Portion size input
 F K=1:1 S A1=$E(X,K) I A1'?1N,A1'?1"." Q
 S A1=+$E(X,1,K-1),A2=$E(X,K,99) I 'A1 K X G KIL
 S:$E(A2,1)'?1U A2=$E(A2,2,99) S A3=$P(A2," ",2,99),A2=$P(A2," ",1) I A2="" K X G KIL
 I $P("OZ",A2,1)'="",$P("EACH",A2,1)'="",$P("FLOZ",A2,1)'="" K X G KIL
 S X=A1_"-"_$S(A2?1"O".E:"OZ",A2?1"E".E:"EACH",1:"FLOZ") S:A3'="" X=X_" "_A3 G KIL
KIL K A1,A2,A3,P1,P2,P0,K,S1,TYP,U1,U2,Y1,Y2 Q
