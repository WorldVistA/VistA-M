IBDEI04A ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1476,2)
 ;;=^5008300
 ;;^UTILITY(U,$J,358.3,1477,0)
 ;;=J84.111^^3^43^11
 ;;^UTILITY(U,$J,358.3,1477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1477,1,3,0)
 ;;=3^Idiopathic interstitial pneumonia, not otherwise specified
 ;;^UTILITY(U,$J,358.3,1477,1,4,0)
 ;;=4^J84.111
 ;;^UTILITY(U,$J,358.3,1477,2)
 ;;=^340610
 ;;^UTILITY(U,$J,358.3,1478,0)
 ;;=J84.112^^3^43^13
 ;;^UTILITY(U,$J,358.3,1478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1478,1,3,0)
 ;;=3^Idiopathic pulmonary fibrosis
 ;;^UTILITY(U,$J,358.3,1478,1,4,0)
 ;;=4^J84.112
 ;;^UTILITY(U,$J,358.3,1478,2)
 ;;=^340534
 ;;^UTILITY(U,$J,358.3,1479,0)
 ;;=J84.113^^3^43^12
 ;;^UTILITY(U,$J,358.3,1479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1479,1,3,0)
 ;;=3^Idiopathic non-specific interstitial pneumonitis
 ;;^UTILITY(U,$J,358.3,1479,1,4,0)
 ;;=4^J84.113
 ;;^UTILITY(U,$J,358.3,1479,2)
 ;;=^340535
 ;;^UTILITY(U,$J,358.3,1480,0)
 ;;=J84.114^^3^43^1
 ;;^UTILITY(U,$J,358.3,1480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1480,1,3,0)
 ;;=3^Acute interstitial pneumonitis
 ;;^UTILITY(U,$J,358.3,1480,1,4,0)
 ;;=4^J84.114
 ;;^UTILITY(U,$J,358.3,1480,2)
 ;;=^340536
 ;;^UTILITY(U,$J,358.3,1481,0)
 ;;=J84.115^^3^43^21
 ;;^UTILITY(U,$J,358.3,1481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1481,1,3,0)
 ;;=3^Respiratory bronchiolitis interstitial lung disease
 ;;^UTILITY(U,$J,358.3,1481,1,4,0)
 ;;=4^J84.115
 ;;^UTILITY(U,$J,358.3,1481,2)
 ;;=^340537
 ;;^UTILITY(U,$J,358.3,1482,0)
 ;;=J84.2^^3^43^15
 ;;^UTILITY(U,$J,358.3,1482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1482,1,3,0)
 ;;=3^Lymphoid interstitial pneumonia
 ;;^UTILITY(U,$J,358.3,1482,1,4,0)
 ;;=4^J84.2
 ;;^UTILITY(U,$J,358.3,1482,2)
 ;;=^5008302
 ;;^UTILITY(U,$J,358.3,1483,0)
 ;;=J84.116^^3^43^7
 ;;^UTILITY(U,$J,358.3,1483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1483,1,3,0)
 ;;=3^Cryptogenic organizing pneumonia
 ;;^UTILITY(U,$J,358.3,1483,1,4,0)
 ;;=4^J84.116
 ;;^UTILITY(U,$J,358.3,1483,2)
 ;;=^340539
 ;;^UTILITY(U,$J,358.3,1484,0)
 ;;=J84.117^^3^43^8
 ;;^UTILITY(U,$J,358.3,1484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1484,1,3,0)
 ;;=3^Desquamative interstitial pneumonia
 ;;^UTILITY(U,$J,358.3,1484,1,4,0)
 ;;=4^J84.117
 ;;^UTILITY(U,$J,358.3,1484,2)
 ;;=^340540
 ;;^UTILITY(U,$J,358.3,1485,0)
 ;;=J84.81^^3^43^14
 ;;^UTILITY(U,$J,358.3,1485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1485,1,3,0)
 ;;=3^Lymphangioleiomyomatosis
 ;;^UTILITY(U,$J,358.3,1485,1,4,0)
 ;;=4^J84.81
 ;;^UTILITY(U,$J,358.3,1485,2)
 ;;=^340541
 ;;^UTILITY(U,$J,358.3,1486,0)
 ;;=J84.82^^3^43^2
 ;;^UTILITY(U,$J,358.3,1486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1486,1,3,0)
 ;;=3^Adult pulmonary Langerhans cell histiocytosis
 ;;^UTILITY(U,$J,358.3,1486,1,4,0)
 ;;=4^J84.82
 ;;^UTILITY(U,$J,358.3,1486,2)
 ;;=^340542
 ;;^UTILITY(U,$J,358.3,1487,0)
 ;;=J84.842^^3^43^20
 ;;^UTILITY(U,$J,358.3,1487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1487,1,3,0)
 ;;=3^Pulmonary interstitial glycogenosis
 ;;^UTILITY(U,$J,358.3,1487,1,4,0)
 ;;=4^J84.842
 ;;^UTILITY(U,$J,358.3,1487,2)
 ;;=^340544
 ;;^UTILITY(U,$J,358.3,1488,0)
 ;;=J84.83^^3^43^27
 ;;^UTILITY(U,$J,358.3,1488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1488,1,3,0)
 ;;=3^Surfactant mutations of the lung
 ;;^UTILITY(U,$J,358.3,1488,1,4,0)
 ;;=4^J84.83
 ;;^UTILITY(U,$J,358.3,1488,2)
 ;;=^340545
 ;;^UTILITY(U,$J,358.3,1489,0)
 ;;=J99.^^3^43^23
 ;;^UTILITY(U,$J,358.3,1489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1489,1,3,0)
 ;;=3^Respiratory disorders in diseases classified elsewhere
 ;;^UTILITY(U,$J,358.3,1489,1,4,0)
 ;;=4^J99.
