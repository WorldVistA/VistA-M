ORVOM ; slc/dcm - Generate ONITS- for OE/RR ;1/22/91  15:39
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 I $S('$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !,"PROGRAMMER ACCESS REQUIRED",! Q
R I $D(^%ZOSF("OS"))#2 S DISYS=+$P(^("OS"),"^",2)
 Q:'$D(DISYS)  R !!,"Enter the Name of the Package (2-4 characters): ",X:$S($D(DTIME):DTIME,1:60)
 Q:"^"[X  I X'?1U1.NU!($L(X)>4) D R^ORVOMH G R
 S DIC="^DIC(9.4,",DIC(0)="E",D="C" D IX^DIC,Q^ORVOM0 S DPK=+Y G:Y<1 L
 I $S('$D(^ORD(100.99,1,5,DPK,0)):1,'$L($P(^(0),"^",2))&('$O(^(1,0))):1,1:0) W !,"Nothing setup to export PROTOCOLS in the ORDER PARAMETERS file for this package" G Q
 S DH=$S($D(^ORD(100.99,1,5,DPK,0)):$P(^(0),"^",2),1:"")
DH I $L(DH) W !,"Exporting PROTOCOLS with namespace "_DH S X=DH
R1 W !!,"I am going to create a routine called '",X,"ONIT'."
 S U="^",%=0,%B="",DL=0,DIH="",DTL=X,DN=X_$E("ONI",1,5-$L(X))
 S ^UTILITY($J)=DN,X=X_"ONIT"
 I $D(^%ZOSF("TEST"))#2 X ^("TEST") I  W $C(7),!,"but '"_X_"' is ALREADY ON FILE!" S Q=1
 W !,"Is that OK" D YN^DICN G Q:%<0!(%=2) I '% D R1^ORVOMH G R1
R3 S %=1,Q=DPK,DPK(1)=""
 S F(-1)=0
DD ;
D1 K ^UTILITY(U,$J),DR S DRN=DL,F=0,%=2 G Q:$D(F)+$D(Q)=2,S:Q<1
 W !,"Moving "_$P(^DIC(9.4,DPK,0),U)_" Protocols into Onit's."
 K ^UTILITY(U,$J,"PKG",DPK,"VERSION")
S D VER^ORVOM11 G Q:$D(DIRUT) G ^ORVOM0
 ;
Q G Q^ORVOM0
L W !!,"Package "_X_" not found",!,"Please enter the protocol namespace you wish to export: " R X:300 G Q:'$T!(X="")!(X'?1A.E)
 I $L(X)>4 W !,"Namespace too long" G L
 S DH=X G DH
 Q
DOT ;;
 W "." Q  N DOT,I,J,X
 I '$D(IOBS) D HOME^%ZIS
 I '$L($G(IOBS)) W "." Q
 S DOT="    .|    o|    O|   ( )|  <   >| -     -|"
 F I=1:1:$L(DOT,"|") S X=$P(DOT,"|",I) W X H .2 F J=$L(X):-1:1 W @IOBS
 Q
