IBDEI12H ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18143,0)
 ;;=I82.A12^^79^874^88
 ;;^UTILITY(U,$J,358.3,18143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18143,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Axillary Vein
 ;;^UTILITY(U,$J,358.3,18143,1,4,0)
 ;;=4^I82.A12
 ;;^UTILITY(U,$J,358.3,18143,2)
 ;;=^5007943
 ;;^UTILITY(U,$J,358.3,18144,0)
 ;;=I82.412^^79^874^89
 ;;^UTILITY(U,$J,358.3,18144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18144,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Femoral Vein
 ;;^UTILITY(U,$J,358.3,18144,1,4,0)
 ;;=4^I82.412
 ;;^UTILITY(U,$J,358.3,18144,2)
 ;;=^5007858
 ;;^UTILITY(U,$J,358.3,18145,0)
 ;;=I82.422^^79^874^90
 ;;^UTILITY(U,$J,358.3,18145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18145,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Iliac Vein
 ;;^UTILITY(U,$J,358.3,18145,1,4,0)
 ;;=4^I82.422
 ;;^UTILITY(U,$J,358.3,18145,2)
 ;;=^5007862
 ;;^UTILITY(U,$J,358.3,18146,0)
 ;;=I82.C12^^79^874^91
 ;;^UTILITY(U,$J,358.3,18146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18146,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Internal Jugular Vein
 ;;^UTILITY(U,$J,358.3,18146,1,4,0)
 ;;=4^I82.C12
 ;;^UTILITY(U,$J,358.3,18146,2)
 ;;=^5007959
 ;;^UTILITY(U,$J,358.3,18147,0)
 ;;=I82.432^^79^874^92
 ;;^UTILITY(U,$J,358.3,18147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18147,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Popliteal Vein
 ;;^UTILITY(U,$J,358.3,18147,1,4,0)
 ;;=4^I82.432
 ;;^UTILITY(U,$J,358.3,18147,2)
 ;;=^5007866
 ;;^UTILITY(U,$J,358.3,18148,0)
 ;;=I82.B12^^79^874^93
 ;;^UTILITY(U,$J,358.3,18148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18148,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Subclavian Vein
 ;;^UTILITY(U,$J,358.3,18148,1,4,0)
 ;;=4^I82.B12
 ;;^UTILITY(U,$J,358.3,18148,2)
 ;;=^5007951
 ;;^UTILITY(U,$J,358.3,18149,0)
 ;;=I82.890^^79^874^97
 ;;^UTILITY(U,$J,358.3,18149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18149,1,3,0)
 ;;=3^Embolism/Thrombosis of Oth Specified Veins
 ;;^UTILITY(U,$J,358.3,18149,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,18149,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,18150,0)
 ;;=I82.A11^^79^874^98
 ;;^UTILITY(U,$J,358.3,18150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18150,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Axillary Vein
 ;;^UTILITY(U,$J,358.3,18150,1,4,0)
 ;;=4^I82.A11
 ;;^UTILITY(U,$J,358.3,18150,2)
 ;;=^5007942
 ;;^UTILITY(U,$J,358.3,18151,0)
 ;;=I82.411^^79^874^99
 ;;^UTILITY(U,$J,358.3,18151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18151,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,18151,1,4,0)
 ;;=4^I82.411
 ;;^UTILITY(U,$J,358.3,18151,2)
 ;;=^5007857
 ;;^UTILITY(U,$J,358.3,18152,0)
 ;;=I82.290^^79^874^107
 ;;^UTILITY(U,$J,358.3,18152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18152,1,3,0)
 ;;=3^Embolism/Thrombosis of Thoracic Veins NEC
 ;;^UTILITY(U,$J,358.3,18152,1,4,0)
 ;;=4^I82.290
 ;;^UTILITY(U,$J,358.3,18152,2)
 ;;=^5007852
 ;;^UTILITY(U,$J,358.3,18153,0)
 ;;=I82.411^^79^874^100
 ;;^UTILITY(U,$J,358.3,18153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18153,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,18153,1,4,0)
 ;;=4^I82.411
 ;;^UTILITY(U,$J,358.3,18153,2)
 ;;=^5007857
 ;;^UTILITY(U,$J,358.3,18154,0)
 ;;=I82.421^^79^874^101
 ;;^UTILITY(U,$J,358.3,18154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18154,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Iliac Vein
 ;;^UTILITY(U,$J,358.3,18154,1,4,0)
 ;;=4^I82.421
 ;;^UTILITY(U,$J,358.3,18154,2)
 ;;=^5007861
 ;;^UTILITY(U,$J,358.3,18155,0)
 ;;=I82.C11^^79^874^102
 ;;^UTILITY(U,$J,358.3,18155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18155,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Internal Jugular Vein
