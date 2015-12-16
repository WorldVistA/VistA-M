IBDEI049 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1463,1,3,0)
 ;;=3^Abscess of lung without pneumonia
 ;;^UTILITY(U,$J,358.3,1463,1,4,0)
 ;;=4^J85.2
 ;;^UTILITY(U,$J,358.3,1463,2)
 ;;=^5008307
 ;;^UTILITY(U,$J,358.3,1464,0)
 ;;=J85.1^^3^42^1
 ;;^UTILITY(U,$J,358.3,1464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1464,1,3,0)
 ;;=3^Abscess of lung with pneumonia
 ;;^UTILITY(U,$J,358.3,1464,1,4,0)
 ;;=4^J85.1
 ;;^UTILITY(U,$J,358.3,1464,2)
 ;;=^5008306
 ;;^UTILITY(U,$J,358.3,1465,0)
 ;;=D86.9^^3^43^24
 ;;^UTILITY(U,$J,358.3,1465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1465,1,3,0)
 ;;=3^Sarcoidosis, unspecified
 ;;^UTILITY(U,$J,358.3,1465,1,4,0)
 ;;=4^D86.9
 ;;^UTILITY(U,$J,358.3,1465,2)
 ;;=^5002454
 ;;^UTILITY(U,$J,358.3,1466,0)
 ;;=J61.^^3^43^16
 ;;^UTILITY(U,$J,358.3,1466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1466,1,3,0)
 ;;=3^Pneumoconiosis due to asbestos and other mineral fibers
 ;;^UTILITY(U,$J,358.3,1466,1,4,0)
 ;;=4^J61.
 ;;^UTILITY(U,$J,358.3,1466,2)
 ;;=^5008262
 ;;^UTILITY(U,$J,358.3,1467,0)
 ;;=J62.8^^3^43^17
 ;;^UTILITY(U,$J,358.3,1467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1467,1,3,0)
 ;;=3^Pneumoconiosis due to other dust containing silica
 ;;^UTILITY(U,$J,358.3,1467,1,4,0)
 ;;=4^J62.8
 ;;^UTILITY(U,$J,358.3,1467,2)
 ;;=^5008264
 ;;^UTILITY(U,$J,358.3,1468,0)
 ;;=J63.0^^3^43^3
 ;;^UTILITY(U,$J,358.3,1468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1468,1,3,0)
 ;;=3^Aluminosis (of lung)
 ;;^UTILITY(U,$J,358.3,1468,1,4,0)
 ;;=4^J63.0
 ;;^UTILITY(U,$J,358.3,1468,2)
 ;;=^5008265
 ;;^UTILITY(U,$J,358.3,1469,0)
 ;;=J63.1^^3^43^4
 ;;^UTILITY(U,$J,358.3,1469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1469,1,3,0)
 ;;=3^Bauxite fibrosis (of lung)
 ;;^UTILITY(U,$J,358.3,1469,1,4,0)
 ;;=4^J63.1
 ;;^UTILITY(U,$J,358.3,1469,2)
 ;;=^5008266
 ;;^UTILITY(U,$J,358.3,1470,0)
 ;;=J63.2^^3^43^5
 ;;^UTILITY(U,$J,358.3,1470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1470,1,3,0)
 ;;=3^Berylliosis
 ;;^UTILITY(U,$J,358.3,1470,1,4,0)
 ;;=4^J63.2
 ;;^UTILITY(U,$J,358.3,1470,2)
 ;;=^13594
 ;;^UTILITY(U,$J,358.3,1471,0)
 ;;=J63.3^^3^43^9
 ;;^UTILITY(U,$J,358.3,1471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1471,1,3,0)
 ;;=3^Graphite fibrosis (of lung)
 ;;^UTILITY(U,$J,358.3,1471,1,4,0)
 ;;=4^J63.3
 ;;^UTILITY(U,$J,358.3,1471,2)
 ;;=^5008267
 ;;^UTILITY(U,$J,358.3,1472,0)
 ;;=J63.4^^3^43^25
 ;;^UTILITY(U,$J,358.3,1472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1472,1,3,0)
 ;;=3^Siderosis
 ;;^UTILITY(U,$J,358.3,1472,1,4,0)
 ;;=4^J63.4
 ;;^UTILITY(U,$J,358.3,1472,2)
 ;;=^5008268
 ;;^UTILITY(U,$J,358.3,1473,0)
 ;;=J63.5^^3^43^26
 ;;^UTILITY(U,$J,358.3,1473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1473,1,3,0)
 ;;=3^Stannosis
 ;;^UTILITY(U,$J,358.3,1473,1,4,0)
 ;;=4^J63.5
 ;;^UTILITY(U,$J,358.3,1473,2)
 ;;=^5008269
 ;;^UTILITY(U,$J,358.3,1474,0)
 ;;=J63.6^^3^43^18
 ;;^UTILITY(U,$J,358.3,1474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1474,1,3,0)
 ;;=3^Pneumoconiosis due to other specified inorganic dusts
 ;;^UTILITY(U,$J,358.3,1474,1,4,0)
 ;;=4^J63.6
 ;;^UTILITY(U,$J,358.3,1474,2)
 ;;=^5008270
 ;;^UTILITY(U,$J,358.3,1475,0)
 ;;=J70.9^^3^43^22
 ;;^UTILITY(U,$J,358.3,1475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1475,1,3,0)
 ;;=3^Respiratory conditions due to unspecified external agent
 ;;^UTILITY(U,$J,358.3,1475,1,4,0)
 ;;=4^J70.9
 ;;^UTILITY(U,$J,358.3,1475,2)
 ;;=^269985
 ;;^UTILITY(U,$J,358.3,1476,0)
 ;;=J84.10^^3^43^19
 ;;^UTILITY(U,$J,358.3,1476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1476,1,3,0)
 ;;=3^Pulmonary fibrosis, unspecified
 ;;^UTILITY(U,$J,358.3,1476,1,4,0)
 ;;=4^J84.10
