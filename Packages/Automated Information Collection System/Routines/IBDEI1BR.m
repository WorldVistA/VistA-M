IBDEI1BR ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23760,2)
 ;;=^272346
 ;;^UTILITY(U,$J,358.3,23761,0)
 ;;=695.89^^141^1467^1
 ;;^UTILITY(U,$J,358.3,23761,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23761,1,3,0)
 ;;=3^695.89
 ;;^UTILITY(U,$J,358.3,23761,1,5,0)
 ;;=5^Keratolysis, acquired only
 ;;^UTILITY(U,$J,358.3,23761,2)
 ;;=^88044
 ;;^UTILITY(U,$J,358.3,23762,0)
 ;;=757.39^^141^1467^2
 ;;^UTILITY(U,$J,358.3,23762,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23762,1,3,0)
 ;;=3^757.39
 ;;^UTILITY(U,$J,358.3,23762,1,5,0)
 ;;=5^Keratolysis, congenital or unknown
 ;;^UTILITY(U,$J,358.3,23762,2)
 ;;=^87938
 ;;^UTILITY(U,$J,358.3,23763,0)
 ;;=891.0^^141^1468^1
 ;;^UTILITY(U,$J,358.3,23763,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23763,1,3,0)
 ;;=3^891.0
 ;;^UTILITY(U,$J,358.3,23763,1,5,0)
 ;;=5^Laceration of knee, leg, & ankle w/o mention of complication
 ;;^UTILITY(U,$J,358.3,23763,2)
 ;;=^275087
 ;;^UTILITY(U,$J,358.3,23764,0)
 ;;=892.0^^141^1468^2
 ;;^UTILITY(U,$J,358.3,23764,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23764,1,3,0)
 ;;=3^892.0
 ;;^UTILITY(U,$J,358.3,23764,1,5,0)
 ;;=5^Laceration of foot except toe(s) alone w/o mention of complication
 ;;^UTILITY(U,$J,358.3,23764,2)
 ;;=^275091
 ;;^UTILITY(U,$J,358.3,23765,0)
 ;;=893.0^^141^1468^3
 ;;^UTILITY(U,$J,358.3,23765,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23765,1,3,0)
 ;;=3^893.0
 ;;^UTILITY(U,$J,358.3,23765,1,5,0)
 ;;=5^Laceration of toe(s) w/o mention of complication
 ;;^UTILITY(U,$J,358.3,23765,2)
 ;;=^275095
 ;;^UTILITY(U,$J,358.3,23766,0)
 ;;=755.30^^141^1468^4
 ;;^UTILITY(U,$J,358.3,23766,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23766,1,3,0)
 ;;=3^755.30
 ;;^UTILITY(U,$J,358.3,23766,1,5,0)
 ;;=5^Leg length discrepancy, congenital
 ;;^UTILITY(U,$J,358.3,23766,2)
 ;;=^273038
 ;;^UTILITY(U,$J,358.3,23767,0)
 ;;=736.81^^141^1468^5
 ;;^UTILITY(U,$J,358.3,23767,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23767,1,3,0)
 ;;=3^736.81
 ;;^UTILITY(U,$J,358.3,23767,1,5,0)
 ;;=5^Leg Length discrepancy, acquired
 ;;^UTILITY(U,$J,358.3,23767,2)
 ;;=^68758
 ;;^UTILITY(U,$J,358.3,23768,0)
 ;;=216.7^^141^1468^6
 ;;^UTILITY(U,$J,358.3,23768,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23768,1,3,0)
 ;;=3^216.7
 ;;^UTILITY(U,$J,358.3,23768,1,5,0)
 ;;=5^Lesion, skin of lower limb, including hip; Benign
 ;;^UTILITY(U,$J,358.3,23768,2)
 ;;=^267636
 ;;^UTILITY(U,$J,358.3,23769,0)
 ;;=709.9^^141^1468^8
 ;;^UTILITY(U,$J,358.3,23769,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23769,1,3,0)
 ;;=3^709.9
 ;;^UTILITY(U,$J,358.3,23769,1,5,0)
 ;;=5^Lesion, skin of lower limb, including hip; Unspecified or unknown
 ;;^UTILITY(U,$J,358.3,23769,2)
 ;;=^111083
 ;;^UTILITY(U,$J,358.3,23770,0)
 ;;=173.70^^141^1468^7
 ;;^UTILITY(U,$J,358.3,23770,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23770,1,3,0)
 ;;=3^173.70
 ;;^UTILITY(U,$J,358.3,23770,1,5,0)
 ;;=5^Lesion, Skin Lower Limb-malignant
 ;;^UTILITY(U,$J,358.3,23770,2)
 ;;=^340603
 ;;^UTILITY(U,$J,358.3,23771,0)
 ;;=735.8^^141^1469^1
 ;;^UTILITY(U,$J,358.3,23771,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23771,1,3,0)
 ;;=3^735.8
 ;;^UTILITY(U,$J,358.3,23771,1,5,0)
 ;;=5^Mallet Toe; Acquired
 ;;^UTILITY(U,$J,358.3,23771,2)
 ;;=^272714
 ;;^UTILITY(U,$J,358.3,23772,0)
 ;;=755.66^^141^1469^2
 ;;^UTILITY(U,$J,358.3,23772,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23772,1,3,0)
 ;;=3^755.66
 ;;^UTILITY(U,$J,358.3,23772,1,5,0)
 ;;=5^Mallet toe; Congenital
 ;;^UTILITY(U,$J,358.3,23772,2)
 ;;=^273059
 ;;^UTILITY(U,$J,358.3,23773,0)
 ;;=736.70^^141^1469^3
 ;;^UTILITY(U,$J,358.3,23773,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23773,1,3,0)
 ;;=3^736.70
