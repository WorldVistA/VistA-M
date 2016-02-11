IBDEI270 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36814,1,4,0)
 ;;=4^C83.99
 ;;^UTILITY(U,$J,358.3,36814,2)
 ;;=^5001620
 ;;^UTILITY(U,$J,358.3,36815,0)
 ;;=C84.10^^169^1859^73
 ;;^UTILITY(U,$J,358.3,36815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36815,1,3,0)
 ;;=3^Sezary Disease,Unspec Site
 ;;^UTILITY(U,$J,358.3,36815,1,4,0)
 ;;=4^C84.10
 ;;^UTILITY(U,$J,358.3,36815,2)
 ;;=^5001631
 ;;^UTILITY(U,$J,358.3,36816,0)
 ;;=C84.19^^169^1859^72
 ;;^UTILITY(U,$J,358.3,36816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36816,1,3,0)
 ;;=3^Sezary Disease,Extrnod/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,36816,1,4,0)
 ;;=4^C84.19
 ;;^UTILITY(U,$J,358.3,36816,2)
 ;;=^5001640
 ;;^UTILITY(U,$J,358.3,36817,0)
 ;;=C84.40^^169^1859^70
 ;;^UTILITY(U,$J,358.3,36817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36817,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,36817,1,4,0)
 ;;=4^C84.40
 ;;^UTILITY(U,$J,358.3,36817,2)
 ;;=^5001641
 ;;^UTILITY(U,$J,358.3,36818,0)
 ;;=C84.49^^169^1859^69
 ;;^UTILITY(U,$J,358.3,36818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36818,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Extrnod/Solid Organ Sites NEC
 ;;^UTILITY(U,$J,358.3,36818,1,4,0)
 ;;=4^C84.49
 ;;^UTILITY(U,$J,358.3,36818,2)
 ;;=^5001650
 ;;^UTILITY(U,$J,358.3,36819,0)
 ;;=C77.0^^169^1860^14
 ;;^UTILITY(U,$J,358.3,36819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36819,1,3,0)
 ;;=3^Secondary malignant neoplasm of nodes of head, face and neck
 ;;^UTILITY(U,$J,358.3,36819,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,36819,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,36820,0)
 ;;=C77.1^^169^1860^9
 ;;^UTILITY(U,$J,358.3,36820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36820,1,3,0)
 ;;=3^Secondary malignant neoplasm of intrathorac nodes
 ;;^UTILITY(U,$J,358.3,36820,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,36820,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,36821,0)
 ;;=C77.2^^169^1860^7
 ;;^UTILITY(U,$J,358.3,36821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36821,1,3,0)
 ;;=3^Secondary malignant neoplasm of intra-abd nodes
 ;;^UTILITY(U,$J,358.3,36821,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,36821,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,36822,0)
 ;;=C77.3^^169^1860^1
 ;;^UTILITY(U,$J,358.3,36822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36822,1,3,0)
 ;;=3^Secondary malignant neoplasm of axilla and upper limb nodes
 ;;^UTILITY(U,$J,358.3,36822,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,36822,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,36823,0)
 ;;=C77.4^^169^1860^6
 ;;^UTILITY(U,$J,358.3,36823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36823,1,3,0)
 ;;=3^Secondary malignant neoplasm of inguinal and lower limb nodes
 ;;^UTILITY(U,$J,358.3,36823,1,4,0)
 ;;=4^C77.4
 ;;^UTILITY(U,$J,358.3,36823,2)
 ;;=^5001331
 ;;^UTILITY(U,$J,358.3,36824,0)
 ;;=C77.8^^169^1860^15
 ;;^UTILITY(U,$J,358.3,36824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36824,1,3,0)
 ;;=3^Secondary malignant neoplasm of nodes of multiple regions
 ;;^UTILITY(U,$J,358.3,36824,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,36824,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,36825,0)
 ;;=C77.9^^169^1860^13
 ;;^UTILITY(U,$J,358.3,36825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36825,1,3,0)
 ;;=3^Secondary malignant neoplasm of lymph node, unsp
 ;;^UTILITY(U,$J,358.3,36825,1,4,0)
 ;;=4^C77.9
 ;;^UTILITY(U,$J,358.3,36825,2)
 ;;=^5001333
 ;;^UTILITY(U,$J,358.3,36826,0)
 ;;=C78.01^^169^1860^18
 ;;^UTILITY(U,$J,358.3,36826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36826,1,3,0)
 ;;=3^Secondary malignant neoplasm of right lung
 ;;^UTILITY(U,$J,358.3,36826,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,36826,2)
 ;;=^5001335
