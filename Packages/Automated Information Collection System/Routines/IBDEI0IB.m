IBDEI0IB ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18451,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,18451,1,4,0)
 ;;=4^I82.411
 ;;^UTILITY(U,$J,358.3,18451,2)
 ;;=^5007857
 ;;^UTILITY(U,$J,358.3,18452,0)
 ;;=I82.421^^84^962^101
 ;;^UTILITY(U,$J,358.3,18452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18452,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Iliac Vein
 ;;^UTILITY(U,$J,358.3,18452,1,4,0)
 ;;=4^I82.421
 ;;^UTILITY(U,$J,358.3,18452,2)
 ;;=^5007861
 ;;^UTILITY(U,$J,358.3,18453,0)
 ;;=I82.C11^^84^962^102
 ;;^UTILITY(U,$J,358.3,18453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18453,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Internal Jugular Vein
 ;;^UTILITY(U,$J,358.3,18453,1,4,0)
 ;;=4^I82.C11
 ;;^UTILITY(U,$J,358.3,18453,2)
 ;;=^5007958
 ;;^UTILITY(U,$J,358.3,18454,0)
 ;;=I82.431^^84^962^103
 ;;^UTILITY(U,$J,358.3,18454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18454,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Popliteal Vein
 ;;^UTILITY(U,$J,358.3,18454,1,4,0)
 ;;=4^I82.431
 ;;^UTILITY(U,$J,358.3,18454,2)
 ;;=^5007865
 ;;^UTILITY(U,$J,358.3,18455,0)
 ;;=I82.B11^^84^962^104
 ;;^UTILITY(U,$J,358.3,18455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18455,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Subclavian Vein
 ;;^UTILITY(U,$J,358.3,18455,1,4,0)
 ;;=4^I82.B11
 ;;^UTILITY(U,$J,358.3,18455,2)
 ;;=^5007950
 ;;^UTILITY(U,$J,358.3,18456,0)
 ;;=I82.613^^84^962^80
 ;;^UTILITY(U,$J,358.3,18456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18456,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,18456,1,4,0)
 ;;=4^I82.613
 ;;^UTILITY(U,$J,358.3,18456,2)
 ;;=^5007917
 ;;^UTILITY(U,$J,358.3,18457,0)
 ;;=I82.612^^84^962^94
 ;;^UTILITY(U,$J,358.3,18457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18457,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,18457,1,4,0)
 ;;=4^I82.612
 ;;^UTILITY(U,$J,358.3,18457,2)
 ;;=^5007916
 ;;^UTILITY(U,$J,358.3,18458,0)
 ;;=I82.611^^84^962^105
 ;;^UTILITY(U,$J,358.3,18458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18458,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Upper Extrem Superficial Veins
 ;;^UTILITY(U,$J,358.3,18458,1,4,0)
 ;;=4^I82.611
 ;;^UTILITY(U,$J,358.3,18458,2)
 ;;=^5007915
 ;;^UTILITY(U,$J,358.3,18459,0)
 ;;=I82.4Y3^^84^962^83
 ;;^UTILITY(U,$J,358.3,18459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18459,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Bilateral Proximal Lower Extrem
 ;;^UTILITY(U,$J,358.3,18459,1,4,0)
 ;;=4^I82.4Y3
 ;;^UTILITY(U,$J,358.3,18459,2)
 ;;=^5007879
 ;;^UTILITY(U,$J,358.3,18460,0)
 ;;=I82.4Y2^^84^962^85
 ;;^UTILITY(U,$J,358.3,18460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18460,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Left Proximal Lower Extrem
 ;;^UTILITY(U,$J,358.3,18460,1,4,0)
 ;;=4^I82.4Y2
 ;;^UTILITY(U,$J,358.3,18460,2)
 ;;=^5007878
 ;;^UTILITY(U,$J,358.3,18461,0)
 ;;=I82.4Y1^^84^962^87
 ;;^UTILITY(U,$J,358.3,18461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18461,1,3,0)
 ;;=3^Embolism/Thrombosis of Deep Veins of Right Proximal Lower Extrem
 ;;^UTILITY(U,$J,358.3,18461,1,4,0)
 ;;=4^I82.4Y1
 ;;^UTILITY(U,$J,358.3,18461,2)
 ;;=^5007877
 ;;^UTILITY(U,$J,358.3,18462,0)
 ;;=I82.603^^84^962^81
 ;;^UTILITY(U,$J,358.3,18462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18462,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Upper Extremity Veins,Unspec
 ;;^UTILITY(U,$J,358.3,18462,1,4,0)
 ;;=4^I82.603
 ;;^UTILITY(U,$J,358.3,18462,2)
 ;;=^5007914
 ;;^UTILITY(U,$J,358.3,18463,0)
 ;;=I82.602^^84^962^95
 ;;^UTILITY(U,$J,358.3,18463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18463,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Upper Extremity Veins,Unspec
 ;;^UTILITY(U,$J,358.3,18463,1,4,0)
 ;;=4^I82.602
 ;;^UTILITY(U,$J,358.3,18463,2)
 ;;=^5007913
 ;;^UTILITY(U,$J,358.3,18464,0)
 ;;=I82.601^^84^962^106
 ;;^UTILITY(U,$J,358.3,18464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18464,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Upper Extremity Veins,Unspec
 ;;^UTILITY(U,$J,358.3,18464,1,4,0)
 ;;=4^I82.601
 ;;^UTILITY(U,$J,358.3,18464,2)
 ;;=^5007912
 ;;^UTILITY(U,$J,358.3,18465,0)
 ;;=K55.0^^84^962^162
 ;;^UTILITY(U,$J,358.3,18465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18465,1,3,0)
 ;;=3^Vascular Intestinal Disorders,Acute
 ;;^UTILITY(U,$J,358.3,18465,1,4,0)
 ;;=4^K55.0
 ;;^UTILITY(U,$J,358.3,18465,2)
 ;;=^5008705
 ;;^UTILITY(U,$J,358.3,18466,0)
 ;;=I72.4^^84^962^6
 ;;^UTILITY(U,$J,358.3,18466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18466,1,3,0)
 ;;=3^Aneurysm of Lower Extremity Artery
 ;;^UTILITY(U,$J,358.3,18466,1,4,0)
 ;;=4^I72.4
 ;;^UTILITY(U,$J,358.3,18466,2)
 ;;=^269777
 ;;^UTILITY(U,$J,358.3,18467,0)
 ;;=I72.0^^84^962^4
 ;;^UTILITY(U,$J,358.3,18467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18467,1,3,0)
 ;;=3^Aneurysm of Carotid Artery
 ;;^UTILITY(U,$J,358.3,18467,1,4,0)
 ;;=4^I72.0
 ;;^UTILITY(U,$J,358.3,18467,2)
 ;;=^5007793
 ;;^UTILITY(U,$J,358.3,18468,0)
 ;;=I72.3^^84^962^5
 ;;^UTILITY(U,$J,358.3,18468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18468,1,3,0)
 ;;=3^Aneurysm of Iliac Artery
 ;;^UTILITY(U,$J,358.3,18468,1,4,0)
 ;;=4^I72.3
 ;;^UTILITY(U,$J,358.3,18468,2)
 ;;=^269775
 ;;^UTILITY(U,$J,358.3,18469,0)
 ;;=I72.8^^84^962^3
 ;;^UTILITY(U,$J,358.3,18469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18469,1,3,0)
 ;;=3^Aneurysm of Arteries NEC
 ;;^UTILITY(U,$J,358.3,18469,1,4,0)
 ;;=4^I72.8
 ;;^UTILITY(U,$J,358.3,18469,2)
 ;;=^5007794
 ;;^UTILITY(U,$J,358.3,18470,0)
 ;;=I72.2^^84^962^7
 ;;^UTILITY(U,$J,358.3,18470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18470,1,3,0)
 ;;=3^Aneurysm of Renal Artery
 ;;^UTILITY(U,$J,358.3,18470,1,4,0)
 ;;=4^I72.2
 ;;^UTILITY(U,$J,358.3,18470,2)
 ;;=^269773
 ;;^UTILITY(U,$J,358.3,18471,0)
 ;;=I83.93^^84^962^8
 ;;^UTILITY(U,$J,358.3,18471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18471,1,3,0)
 ;;=3^Asymptomatic Varicose Veins of Bilateral Lower Extremities
 ;;^UTILITY(U,$J,358.3,18471,1,4,0)
 ;;=4^I83.93
 ;;^UTILITY(U,$J,358.3,18471,2)
 ;;=^5008022
 ;;^UTILITY(U,$J,358.3,18472,0)
 ;;=I83.92^^84^962^9
 ;;^UTILITY(U,$J,358.3,18472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18472,1,3,0)
 ;;=3^Asymptomatic Varicose Veins of Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,18472,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,18472,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,18473,0)
 ;;=I83.91^^84^962^10
 ;;^UTILITY(U,$J,358.3,18473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18473,1,3,0)
 ;;=3^Asymptomatic Varicose Veins of Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,18473,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,18473,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,18474,0)
 ;;=I70.263^^84^962^12
 ;;^UTILITY(U,$J,358.3,18474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18474,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Gangrene
 ;;^UTILITY(U,$J,358.3,18474,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,18474,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,18475,0)
 ;;=I70.262^^84^962^18
 ;;^UTILITY(U,$J,358.3,18475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18475,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,18475,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,18475,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,18476,0)
 ;;=I70.261^^84^962^24
 ;;^UTILITY(U,$J,358.3,18476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18476,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,18476,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,18476,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,18477,0)
 ;;=I70.213^^84^962^11
 ;;^UTILITY(U,$J,358.3,18477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18477,1,3,0)
 ;;=3^Athscl Native Arteries of Bilater Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,18477,1,4,0)
 ;;=4^I70.213
