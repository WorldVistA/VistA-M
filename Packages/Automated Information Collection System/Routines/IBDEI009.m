IBDEI009 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3)
 ;;=^IBE(358.3,
 ;;^UTILITY(U,$J,358.3,0)
 ;;=IMP/EXP SELECTION^358.3I^5456^5456
 ;;^UTILITY(U,$J,358.3,1,0)
 ;;=I71.3^^1^1^1
 ;;^UTILITY(U,$J,358.3,1,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1,1,3,0)
 ;;=3^AAA Ruptured
 ;;^UTILITY(U,$J,358.3,1,1,4,0)
 ;;=4^I71.3
 ;;^UTILITY(U,$J,358.3,1,2)
 ;;=^5007788
 ;;^UTILITY(U,$J,358.3,2,0)
 ;;=I71.4^^1^1^2
 ;;^UTILITY(U,$J,358.3,2,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,2,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,2,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,3,0)
 ;;=I82.A13^^1^1^78
 ;;^UTILITY(U,$J,358.3,3,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Axillary Vein,Acute
 ;;^UTILITY(U,$J,358.3,3,1,4,0)
 ;;=4^I82.A13
 ;;^UTILITY(U,$J,358.3,3,2)
 ;;=^5007944
 ;;^UTILITY(U,$J,358.3,4,0)
 ;;=I82.413^^1^1^79
 ;;^UTILITY(U,$J,358.3,4,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Femoral Vein,Acute
 ;;^UTILITY(U,$J,358.3,4,1,4,0)
 ;;=4^I82.413
 ;;^UTILITY(U,$J,358.3,4,2)
 ;;=^5007859
 ;;^UTILITY(U,$J,358.3,5,0)
 ;;=I82.C13^^1^1^80
 ;;^UTILITY(U,$J,358.3,5,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Int Jugular Vein,Acute
 ;;^UTILITY(U,$J,358.3,5,1,4,0)
 ;;=4^I82.C13
 ;;^UTILITY(U,$J,358.3,5,2)
 ;;=^5007960
 ;;^UTILITY(U,$J,358.3,6,0)
 ;;=I82.433^^1^1^81
 ;;^UTILITY(U,$J,358.3,6,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Popliteal Vein,Acute
 ;;^UTILITY(U,$J,358.3,6,1,4,0)
 ;;=4^I82.433
 ;;^UTILITY(U,$J,358.3,6,2)
 ;;=^5007867
 ;;^UTILITY(U,$J,358.3,7,0)
 ;;=I82.B13^^1^1^82
 ;;^UTILITY(U,$J,358.3,7,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Subclavian Vein,Acute
 ;;^UTILITY(U,$J,358.3,7,1,4,0)
 ;;=4^I82.B13
 ;;^UTILITY(U,$J,358.3,7,2)
 ;;=^5007952
 ;;^UTILITY(U,$J,358.3,8,0)
 ;;=I82.623^^1^1^85
 ;;^UTILITY(U,$J,358.3,8,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Bilateral Upper Extremities
 ;;^UTILITY(U,$J,358.3,8,1,4,0)
 ;;=4^I82.623
 ;;^UTILITY(U,$J,358.3,8,2)
 ;;=^5007921
 ;;^UTILITY(U,$J,358.3,9,0)
 ;;=I82.622^^1^1^87
 ;;^UTILITY(U,$J,358.3,9,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Left Upper Extremity
 ;;^UTILITY(U,$J,358.3,9,1,4,0)
 ;;=4^I82.622
 ;;^UTILITY(U,$J,358.3,9,2)
 ;;=^5007920
 ;;^UTILITY(U,$J,358.3,10,0)
 ;;=I82.621^^1^1^89
 ;;^UTILITY(U,$J,358.3,10,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Right Upper Extremity
 ;;^UTILITY(U,$J,358.3,10,1,4,0)
 ;;=4^I82.621
 ;;^UTILITY(U,$J,358.3,10,2)
 ;;=^5007919
 ;;^UTILITY(U,$J,358.3,11,0)
 ;;=I82.A12^^1^1^91
 ;;^UTILITY(U,$J,358.3,11,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Axillary Vein
 ;;^UTILITY(U,$J,358.3,11,1,4,0)
 ;;=4^I82.A12
 ;;^UTILITY(U,$J,358.3,11,2)
 ;;=^5007943
 ;;^UTILITY(U,$J,358.3,12,0)
 ;;=I82.412^^1^1^92
 ;;^UTILITY(U,$J,358.3,12,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Femoral Vein
 ;;^UTILITY(U,$J,358.3,12,1,4,0)
 ;;=4^I82.412
 ;;^UTILITY(U,$J,358.3,12,2)
 ;;=^5007858
 ;;^UTILITY(U,$J,358.3,13,0)
 ;;=I82.422^^1^1^93
 ;;^UTILITY(U,$J,358.3,13,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Iliac Vein
 ;;^UTILITY(U,$J,358.3,13,1,4,0)
 ;;=4^I82.422
 ;;^UTILITY(U,$J,358.3,13,2)
 ;;=^5007862
 ;;^UTILITY(U,$J,358.3,14,0)
 ;;=I82.C12^^1^1^94
 ;;^UTILITY(U,$J,358.3,14,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Internal Jugular Vein
 ;;^UTILITY(U,$J,358.3,14,1,4,0)
 ;;=4^I82.C12
 ;;^UTILITY(U,$J,358.3,14,2)
 ;;=^5007959
 ;;^UTILITY(U,$J,358.3,15,0)
 ;;=I82.432^^1^1^95
 ;;^UTILITY(U,$J,358.3,15,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Popliteal Vein
 ;;^UTILITY(U,$J,358.3,15,1,4,0)
 ;;=4^I82.432
 ;;^UTILITY(U,$J,358.3,15,2)
 ;;=^5007866
 ;;^UTILITY(U,$J,358.3,16,0)
 ;;=I82.B12^^1^1^96
 ;;^UTILITY(U,$J,358.3,16,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Subclavian Vein
 ;;^UTILITY(U,$J,358.3,16,1,4,0)
 ;;=4^I82.B12
 ;;^UTILITY(U,$J,358.3,16,2)
 ;;=^5007951
 ;;^UTILITY(U,$J,358.3,17,0)
 ;;=I82.890^^1^1^100
 ;;^UTILITY(U,$J,358.3,17,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17,1,3,0)
 ;;=3^Embolism/Thrombosis of Oth Specified Veins
 ;;^UTILITY(U,$J,358.3,17,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,17,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,18,0)
 ;;=I82.A11^^1^1^101
 ;;^UTILITY(U,$J,358.3,18,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Axillary Vein
 ;;^UTILITY(U,$J,358.3,18,1,4,0)
 ;;=4^I82.A11
 ;;^UTILITY(U,$J,358.3,18,2)
 ;;=^5007942
 ;;^UTILITY(U,$J,358.3,19,0)
 ;;=I82.411^^1^1^102
 ;;^UTILITY(U,$J,358.3,19,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,19,1,4,0)
 ;;=4^I82.411
 ;;^UTILITY(U,$J,358.3,19,2)
 ;;=^5007857
 ;;^UTILITY(U,$J,358.3,20,0)
 ;;=I82.290^^1^1^110
 ;;^UTILITY(U,$J,358.3,20,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20,1,3,0)
 ;;=3^Embolism/Thrombosis of Thoracic Veins NEC
 ;;^UTILITY(U,$J,358.3,20,1,4,0)
 ;;=4^I82.290
 ;;^UTILITY(U,$J,358.3,20,2)
 ;;=^5007852
 ;;^UTILITY(U,$J,358.3,21,0)
 ;;=I82.411^^1^1^103
 ;;^UTILITY(U,$J,358.3,21,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,21,1,4,0)
 ;;=4^I82.411
 ;;^UTILITY(U,$J,358.3,21,2)
 ;;=^5007857
 ;;^UTILITY(U,$J,358.3,22,0)
 ;;=I82.421^^1^1^104
 ;;^UTILITY(U,$J,358.3,22,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Iliac Vein
 ;;^UTILITY(U,$J,358.3,22,1,4,0)
 ;;=4^I82.421
 ;;^UTILITY(U,$J,358.3,22,2)
 ;;=^5007861
 ;;^UTILITY(U,$J,358.3,23,0)
 ;;=I82.C11^^1^1^105
 ;;^UTILITY(U,$J,358.3,23,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Internal Jugular Vein
 ;;^UTILITY(U,$J,358.3,23,1,4,0)
 ;;=4^I82.C11
 ;;^UTILITY(U,$J,358.3,23,2)
 ;;=^5007958
 ;;^UTILITY(U,$J,358.3,24,0)
 ;;=I82.431^^1^1^106
 ;;^UTILITY(U,$J,358.3,24,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Popliteal Vein
 ;;^UTILITY(U,$J,358.3,24,1,4,0)
 ;;=4^I82.431
 ;;^UTILITY(U,$J,358.3,24,2)
 ;;=^5007865
 ;;^UTILITY(U,$J,358.3,25,0)
 ;;=I82.B11^^1^1^107
 ;;^UTILITY(U,$J,358.3,25,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Subclavian Vein
 ;;^UTILITY(U,$J,358.3,25,1,4,0)
 ;;=4^I82.B11
 ;;^UTILITY(U,$J,358.3,25,2)
 ;;=^5007950
 ;;^UTILITY(U,$J,358.3,26,0)
 ;;=I82.613^^1^1^83
 ;;^UTILITY(U,$J,358.3,26,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,26,1,4,0)
 ;;=4^I82.613
 ;;^UTILITY(U,$J,358.3,26,2)
 ;;=^5007917
 ;;^UTILITY(U,$J,358.3,27,0)
 ;;=I82.612^^1^1^97
 ;;^UTILITY(U,$J,358.3,27,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,27,1,4,0)
 ;;=4^I82.612
 ;;^UTILITY(U,$J,358.3,27,2)
 ;;=^5007916
 ;;^UTILITY(U,$J,358.3,28,0)
 ;;=I82.611^^1^1^108
 ;;^UTILITY(U,$J,358.3,28,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,28,1,4,0)
 ;;=4^I82.611
 ;;^UTILITY(U,$J,358.3,28,2)
 ;;=^5007915
 ;;^UTILITY(U,$J,358.3,29,0)
 ;;=I82.4Y3^^1^1^86
 ;;^UTILITY(U,$J,358.3,29,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Bilateral Proximal Lower Extrem
 ;;^UTILITY(U,$J,358.3,29,1,4,0)
 ;;=4^I82.4Y3
 ;;^UTILITY(U,$J,358.3,29,2)
 ;;=^5007879
 ;;^UTILITY(U,$J,358.3,30,0)
 ;;=I82.4Y2^^1^1^88
 ;;^UTILITY(U,$J,358.3,30,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Left Proximal Lower Extrem
 ;;^UTILITY(U,$J,358.3,30,1,4,0)
 ;;=4^I82.4Y2
 ;;^UTILITY(U,$J,358.3,30,2)
 ;;=^5007878
 ;;^UTILITY(U,$J,358.3,31,0)
 ;;=I82.4Y1^^1^1^90
 ;;^UTILITY(U,$J,358.3,31,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Right Proximal Lower Extrem
 ;;^UTILITY(U,$J,358.3,31,1,4,0)
 ;;=4^I82.4Y1
 ;;^UTILITY(U,$J,358.3,31,2)
 ;;=^5007877
 ;;^UTILITY(U,$J,358.3,32,0)
 ;;=I82.603^^1^1^84
 ;;^UTILITY(U,$J,358.3,32,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Upper Extremity Veins,Unspec
 ;;^UTILITY(U,$J,358.3,32,1,4,0)
 ;;=4^I82.603
 ;;^UTILITY(U,$J,358.3,32,2)
 ;;=^5007914
 ;;^UTILITY(U,$J,358.3,33,0)
 ;;=I82.602^^1^1^98
 ;;^UTILITY(U,$J,358.3,33,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Upper Extremity Veins,Unspec
 ;;^UTILITY(U,$J,358.3,33,1,4,0)
 ;;=4^I82.602
 ;;^UTILITY(U,$J,358.3,33,2)
 ;;=^5007913
 ;;^UTILITY(U,$J,358.3,34,0)
 ;;=I82.601^^1^1^109
 ;;^UTILITY(U,$J,358.3,34,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Upper Extremity Veins,Unspec
 ;;^UTILITY(U,$J,358.3,34,1,4,0)
 ;;=4^I82.601
 ;;^UTILITY(U,$J,358.3,34,2)
 ;;=^5007912
 ;;^UTILITY(U,$J,358.3,35,0)
 ;;=K55.0^^1^1^164
 ;;^UTILITY(U,$J,358.3,35,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35,1,3,0)
 ;;=3^Vascular Intestinal Disorders,Acute
 ;;^UTILITY(U,$J,358.3,35,1,4,0)
 ;;=4^K55.0
 ;;^UTILITY(U,$J,358.3,35,2)
 ;;=^5008705
 ;;^UTILITY(U,$J,358.3,36,0)
 ;;=I72.4^^1^1^6
 ;;^UTILITY(U,$J,358.3,36,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36,1,3,0)
 ;;=3^Aneurysm of Lower Extremity Artery
