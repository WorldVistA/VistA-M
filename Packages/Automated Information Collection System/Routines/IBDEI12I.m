IBDEI12I ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18155,1,4,0)
 ;;=4^I82.C11
 ;;^UTILITY(U,$J,358.3,18155,2)
 ;;=^5007958
 ;;^UTILITY(U,$J,358.3,18156,0)
 ;;=I82.431^^79^874^103
 ;;^UTILITY(U,$J,358.3,18156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18156,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Popliteal Vein
 ;;^UTILITY(U,$J,358.3,18156,1,4,0)
 ;;=4^I82.431
 ;;^UTILITY(U,$J,358.3,18156,2)
 ;;=^5007865
 ;;^UTILITY(U,$J,358.3,18157,0)
 ;;=I82.B11^^79^874^104
 ;;^UTILITY(U,$J,358.3,18157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18157,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Subclavian Vein
 ;;^UTILITY(U,$J,358.3,18157,1,4,0)
 ;;=4^I82.B11
 ;;^UTILITY(U,$J,358.3,18157,2)
 ;;=^5007950
 ;;^UTILITY(U,$J,358.3,18158,0)
 ;;=I82.613^^79^874^80
 ;;^UTILITY(U,$J,358.3,18158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18158,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,18158,1,4,0)
 ;;=4^I82.613
 ;;^UTILITY(U,$J,358.3,18158,2)
 ;;=^5007917
 ;;^UTILITY(U,$J,358.3,18159,0)
 ;;=I82.612^^79^874^94
 ;;^UTILITY(U,$J,358.3,18159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18159,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,18159,1,4,0)
 ;;=4^I82.612
 ;;^UTILITY(U,$J,358.3,18159,2)
 ;;=^5007916
 ;;^UTILITY(U,$J,358.3,18160,0)
 ;;=I82.611^^79^874^105
 ;;^UTILITY(U,$J,358.3,18160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18160,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,18160,1,4,0)
 ;;=4^I82.611
 ;;^UTILITY(U,$J,358.3,18160,2)
 ;;=^5007915
 ;;^UTILITY(U,$J,358.3,18161,0)
 ;;=I82.4Y3^^79^874^83
 ;;^UTILITY(U,$J,358.3,18161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18161,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Bilateral Proximal Lower Extrem
 ;;^UTILITY(U,$J,358.3,18161,1,4,0)
 ;;=4^I82.4Y3
 ;;^UTILITY(U,$J,358.3,18161,2)
 ;;=^5007879
 ;;^UTILITY(U,$J,358.3,18162,0)
 ;;=I82.4Y2^^79^874^85
 ;;^UTILITY(U,$J,358.3,18162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18162,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Left Proximal Lower Extrem
 ;;^UTILITY(U,$J,358.3,18162,1,4,0)
 ;;=4^I82.4Y2
 ;;^UTILITY(U,$J,358.3,18162,2)
 ;;=^5007878
 ;;^UTILITY(U,$J,358.3,18163,0)
 ;;=I82.4Y1^^79^874^87
 ;;^UTILITY(U,$J,358.3,18163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18163,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Right Proximal Lower Extrem
 ;;^UTILITY(U,$J,358.3,18163,1,4,0)
 ;;=4^I82.4Y1
 ;;^UTILITY(U,$J,358.3,18163,2)
 ;;=^5007877
 ;;^UTILITY(U,$J,358.3,18164,0)
 ;;=I82.603^^79^874^81
 ;;^UTILITY(U,$J,358.3,18164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18164,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Upper Extremity Veins,Unspec
 ;;^UTILITY(U,$J,358.3,18164,1,4,0)
 ;;=4^I82.603
 ;;^UTILITY(U,$J,358.3,18164,2)
 ;;=^5007914
 ;;^UTILITY(U,$J,358.3,18165,0)
 ;;=I82.602^^79^874^95
 ;;^UTILITY(U,$J,358.3,18165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18165,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Upper Extremity Veins,Unspec
 ;;^UTILITY(U,$J,358.3,18165,1,4,0)
 ;;=4^I82.602
 ;;^UTILITY(U,$J,358.3,18165,2)
 ;;=^5007913
 ;;^UTILITY(U,$J,358.3,18166,0)
 ;;=I82.601^^79^874^106
 ;;^UTILITY(U,$J,358.3,18166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18166,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Upper Extremity Veins,Unspec
 ;;^UTILITY(U,$J,358.3,18166,1,4,0)
 ;;=4^I82.601
 ;;^UTILITY(U,$J,358.3,18166,2)
 ;;=^5007912
 ;;^UTILITY(U,$J,358.3,18167,0)
 ;;=K55.0^^79^874^162
 ;;^UTILITY(U,$J,358.3,18167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18167,1,3,0)
 ;;=3^Vascular Intestinal Disorders,Acute
