IBDEI219 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35530,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,35530,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,35531,0)
 ;;=J20.9^^188^2049^1
 ;;^UTILITY(U,$J,358.3,35531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35531,1,3,0)
 ;;=3^Acute bronchitis, unspecified
 ;;^UTILITY(U,$J,358.3,35531,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,35531,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,35532,0)
 ;;=J42.^^188^2049^4
 ;;^UTILITY(U,$J,358.3,35532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35532,1,3,0)
 ;;=3^Chronic bronchitis,Unspec
 ;;^UTILITY(U,$J,358.3,35532,1,4,0)
 ;;=4^J42.
 ;;^UTILITY(U,$J,358.3,35532,2)
 ;;=^5008234
 ;;^UTILITY(U,$J,358.3,35533,0)
 ;;=J45.909^^188^2049^3
 ;;^UTILITY(U,$J,358.3,35533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35533,1,3,0)
 ;;=3^Asthma, uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,35533,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,35533,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,35534,0)
 ;;=J45.902^^188^2049^2
 ;;^UTILITY(U,$J,358.3,35534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35534,1,3,0)
 ;;=3^Asthma with status asthmaticus,Unspec
 ;;^UTILITY(U,$J,358.3,35534,1,4,0)
 ;;=4^J45.902
 ;;^UTILITY(U,$J,358.3,35534,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,35535,0)
 ;;=J44.9^^188^2049^5
 ;;^UTILITY(U,$J,358.3,35535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35535,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease, unspecified
 ;;^UTILITY(U,$J,358.3,35535,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,35535,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,35536,0)
 ;;=J61.^^188^2049^8
 ;;^UTILITY(U,$J,358.3,35536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35536,1,3,0)
 ;;=3^Pneumoconiosis due to asbestos and other mineral fibers
 ;;^UTILITY(U,$J,358.3,35536,1,4,0)
 ;;=4^J61.
 ;;^UTILITY(U,$J,358.3,35536,2)
 ;;=^5008262
 ;;^UTILITY(U,$J,358.3,35537,0)
 ;;=R09.1^^188^2049^7
 ;;^UTILITY(U,$J,358.3,35537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35537,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,35537,1,4,0)
 ;;=4^R09.1
 ;;^UTILITY(U,$J,358.3,35537,2)
 ;;=^95428
 ;;^UTILITY(U,$J,358.3,35538,0)
 ;;=J84.10^^188^2049^10
 ;;^UTILITY(U,$J,358.3,35538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35538,1,3,0)
 ;;=3^Pulmonary fibrosis, unspecified
 ;;^UTILITY(U,$J,358.3,35538,1,4,0)
 ;;=4^J84.10
 ;;^UTILITY(U,$J,358.3,35538,2)
 ;;=^5008300
 ;;^UTILITY(U,$J,358.3,35539,0)
 ;;=R06.02^^188^2049^11
 ;;^UTILITY(U,$J,358.3,35539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35539,1,3,0)
 ;;=3^Shortness of breath
 ;;^UTILITY(U,$J,358.3,35539,1,4,0)
 ;;=4^R06.02
 ;;^UTILITY(U,$J,358.3,35539,2)
 ;;=^5019181
 ;;^UTILITY(U,$J,358.3,35540,0)
 ;;=R06.00^^188^2049^6
 ;;^UTILITY(U,$J,358.3,35540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35540,1,3,0)
 ;;=3^Dyspnea, unspecified
 ;;^UTILITY(U,$J,358.3,35540,1,4,0)
 ;;=4^R06.00
 ;;^UTILITY(U,$J,358.3,35540,2)
 ;;=^5019180
 ;;^UTILITY(U,$J,358.3,35541,0)
 ;;=C49.9^^188^2050^1
 ;;^UTILITY(U,$J,358.3,35541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35541,1,3,0)
 ;;=3^Malignant neoplasm of connective and soft tissue, unsp
 ;;^UTILITY(U,$J,358.3,35541,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,35541,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,35542,0)
 ;;=C34.11^^188^2050^13
 ;;^UTILITY(U,$J,358.3,35542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35542,1,3,0)
 ;;=3^Malignant neoplasm of upper lobe, right bronchus or lung
 ;;^UTILITY(U,$J,358.3,35542,1,4,0)
 ;;=4^C34.11
 ;;^UTILITY(U,$J,358.3,35542,2)
 ;;=^5000961
 ;;^UTILITY(U,$J,358.3,35543,0)
 ;;=C34.12^^188^2050^12
 ;;^UTILITY(U,$J,358.3,35543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35543,1,3,0)
 ;;=3^Malignant neoplasm of upper lobe, left bronchus or lung
