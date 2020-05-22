IBDEI0F6 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6532,1,3,0)
 ;;=3^Raynaud's Syndrome w/o Gangrene
 ;;^UTILITY(U,$J,358.3,6532,1,4,0)
 ;;=4^I73.00
 ;;^UTILITY(U,$J,358.3,6532,2)
 ;;=^5007796
 ;;^UTILITY(U,$J,358.3,6533,0)
 ;;=I73.1^^53^417^103
 ;;^UTILITY(U,$J,358.3,6533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6533,1,3,0)
 ;;=3^Thromboangiitis Obliterans
 ;;^UTILITY(U,$J,358.3,6533,1,4,0)
 ;;=4^I73.1
 ;;^UTILITY(U,$J,358.3,6533,2)
 ;;=^5007798
 ;;^UTILITY(U,$J,358.3,6534,0)
 ;;=I73.9^^53^417^93
 ;;^UTILITY(U,$J,358.3,6534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6534,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6534,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,6534,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,6535,0)
 ;;=I74.01^^53^417^95
 ;;^UTILITY(U,$J,358.3,6535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6535,1,3,0)
 ;;=3^Saddle Embolus of Abdominal Aorta
 ;;^UTILITY(U,$J,358.3,6535,1,4,0)
 ;;=4^I74.01
 ;;^UTILITY(U,$J,358.3,6535,2)
 ;;=^340522
 ;;^UTILITY(U,$J,358.3,6536,0)
 ;;=I74.09^^53^417^12
 ;;^UTILITY(U,$J,358.3,6536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6536,1,3,0)
 ;;=3^Arterial Embolism/Thrombosis of Abdominal Aorta NEC
 ;;^UTILITY(U,$J,358.3,6536,1,4,0)
 ;;=4^I74.09
 ;;^UTILITY(U,$J,358.3,6536,2)
 ;;=^340523
 ;;^UTILITY(U,$J,358.3,6537,0)
 ;;=I74.11^^53^417^80
 ;;^UTILITY(U,$J,358.3,6537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6537,1,3,0)
 ;;=3^Embolism/Thrombosis of Thoracic Aorta
 ;;^UTILITY(U,$J,358.3,6537,1,4,0)
 ;;=4^I74.11
 ;;^UTILITY(U,$J,358.3,6537,2)
 ;;=^269787
 ;;^UTILITY(U,$J,358.3,6538,0)
 ;;=I74.2^^53^417^83
 ;;^UTILITY(U,$J,358.3,6538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6538,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,6538,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,6538,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,6539,0)
 ;;=I74.3^^53^417^78
 ;;^UTILITY(U,$J,358.3,6539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6539,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,6539,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,6539,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,6540,0)
 ;;=I74.5^^53^417^77
 ;;^UTILITY(U,$J,358.3,6540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6540,1,3,0)
 ;;=3^Embolism/Thrombosis of Iliac Artery
 ;;^UTILITY(U,$J,358.3,6540,1,4,0)
 ;;=4^I74.5
 ;;^UTILITY(U,$J,358.3,6540,2)
 ;;=^269792
 ;;^UTILITY(U,$J,358.3,6541,0)
 ;;=I74.8^^53^417^76
 ;;^UTILITY(U,$J,358.3,6541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6541,1,3,0)
 ;;=3^Embolism/Thrombosis of Arteries NEC
 ;;^UTILITY(U,$J,358.3,6541,1,4,0)
 ;;=4^I74.8
 ;;^UTILITY(U,$J,358.3,6541,2)
 ;;=^5007804
 ;;^UTILITY(U,$J,358.3,6542,0)
 ;;=I77.0^^53^417^14
 ;;^UTILITY(U,$J,358.3,6542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6542,1,3,0)
 ;;=3^Arteriovenous Fistula,Acquired
 ;;^UTILITY(U,$J,358.3,6542,1,4,0)
 ;;=4^I77.0
 ;;^UTILITY(U,$J,358.3,6542,2)
 ;;=^46674
 ;;^UTILITY(U,$J,358.3,6543,0)
 ;;=I77.1^^53^417^98
 ;;^UTILITY(U,$J,358.3,6543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6543,1,3,0)
 ;;=3^Stricture of Artery
 ;;^UTILITY(U,$J,358.3,6543,1,4,0)
 ;;=4^I77.1
 ;;^UTILITY(U,$J,358.3,6543,2)
 ;;=^114763
 ;;^UTILITY(U,$J,358.3,6544,0)
 ;;=I77.3^^53^417^13
 ;;^UTILITY(U,$J,358.3,6544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6544,1,3,0)
 ;;=3^Arterial Fibromuscular Dysplasia
