IBDEI12G ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18129,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,18130,0)
 ;;=99243^^78^873^2
 ;;^UTILITY(U,$J,358.3,18130,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18130,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,18130,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,18131,0)
 ;;=99244^^78^873^3
 ;;^UTILITY(U,$J,358.3,18131,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18131,1,1,0)
 ;;=1^Comprehensive,Mod MDM
 ;;^UTILITY(U,$J,358.3,18131,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,18132,0)
 ;;=99245^^78^873^4
 ;;^UTILITY(U,$J,358.3,18132,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18132,1,1,0)
 ;;=1^Comprehensive,High MDM
 ;;^UTILITY(U,$J,358.3,18132,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,18133,0)
 ;;=I71.3^^79^874^1
 ;;^UTILITY(U,$J,358.3,18133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18133,1,3,0)
 ;;=3^AAA Ruptured
 ;;^UTILITY(U,$J,358.3,18133,1,4,0)
 ;;=4^I71.3
 ;;^UTILITY(U,$J,358.3,18133,2)
 ;;=^5007788
 ;;^UTILITY(U,$J,358.3,18134,0)
 ;;=I71.4^^79^874^2
 ;;^UTILITY(U,$J,358.3,18134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18134,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,18134,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,18134,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,18135,0)
 ;;=I82.A13^^79^874^75
 ;;^UTILITY(U,$J,358.3,18135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18135,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Axillary Vein,Acute
 ;;^UTILITY(U,$J,358.3,18135,1,4,0)
 ;;=4^I82.A13
 ;;^UTILITY(U,$J,358.3,18135,2)
 ;;=^5007944
 ;;^UTILITY(U,$J,358.3,18136,0)
 ;;=I82.413^^79^874^76
 ;;^UTILITY(U,$J,358.3,18136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18136,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Femoral Vein,Acute
 ;;^UTILITY(U,$J,358.3,18136,1,4,0)
 ;;=4^I82.413
 ;;^UTILITY(U,$J,358.3,18136,2)
 ;;=^5007859
 ;;^UTILITY(U,$J,358.3,18137,0)
 ;;=I82.C13^^79^874^77
 ;;^UTILITY(U,$J,358.3,18137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18137,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Int Jugular Vein,Acute
 ;;^UTILITY(U,$J,358.3,18137,1,4,0)
 ;;=4^I82.C13
 ;;^UTILITY(U,$J,358.3,18137,2)
 ;;=^5007960
 ;;^UTILITY(U,$J,358.3,18138,0)
 ;;=I82.433^^79^874^78
 ;;^UTILITY(U,$J,358.3,18138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18138,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Popliteal Vein,Acute
 ;;^UTILITY(U,$J,358.3,18138,1,4,0)
 ;;=4^I82.433
 ;;^UTILITY(U,$J,358.3,18138,2)
 ;;=^5007867
 ;;^UTILITY(U,$J,358.3,18139,0)
 ;;=I82.B13^^79^874^79
 ;;^UTILITY(U,$J,358.3,18139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18139,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Subclavian Vein,Acute
 ;;^UTILITY(U,$J,358.3,18139,1,4,0)
 ;;=4^I82.B13
 ;;^UTILITY(U,$J,358.3,18139,2)
 ;;=^5007952
 ;;^UTILITY(U,$J,358.3,18140,0)
 ;;=I82.623^^79^874^82
 ;;^UTILITY(U,$J,358.3,18140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18140,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Bilateral Upper Extremities
 ;;^UTILITY(U,$J,358.3,18140,1,4,0)
 ;;=4^I82.623
 ;;^UTILITY(U,$J,358.3,18140,2)
 ;;=^5007921
 ;;^UTILITY(U,$J,358.3,18141,0)
 ;;=I82.622^^79^874^84
 ;;^UTILITY(U,$J,358.3,18141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18141,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Left Upper Extremity
 ;;^UTILITY(U,$J,358.3,18141,1,4,0)
 ;;=4^I82.622
 ;;^UTILITY(U,$J,358.3,18141,2)
 ;;=^5007920
 ;;^UTILITY(U,$J,358.3,18142,0)
 ;;=I82.621^^79^874^86
 ;;^UTILITY(U,$J,358.3,18142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18142,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Right Upper Extremity
 ;;^UTILITY(U,$J,358.3,18142,1,4,0)
 ;;=4^I82.621
 ;;^UTILITY(U,$J,358.3,18142,2)
 ;;=^5007919
