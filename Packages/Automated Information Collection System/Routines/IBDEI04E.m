IBDEI04E ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1631,0)
 ;;=T86.31^^11^145^30
 ;;^UTILITY(U,$J,358.3,1631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1631,1,3,0)
 ;;=3^Heart-Lung Transplant Rejection
 ;;^UTILITY(U,$J,358.3,1631,1,4,0)
 ;;=4^T86.31
 ;;^UTILITY(U,$J,358.3,1631,2)
 ;;=^5055720
 ;;^UTILITY(U,$J,358.3,1632,0)
 ;;=T86.32^^11^145^28
 ;;^UTILITY(U,$J,358.3,1632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1632,1,3,0)
 ;;=3^Heart-Lung Transplant Failure
 ;;^UTILITY(U,$J,358.3,1632,1,4,0)
 ;;=4^T86.32
 ;;^UTILITY(U,$J,358.3,1632,2)
 ;;=^5055721
 ;;^UTILITY(U,$J,358.3,1633,0)
 ;;=T86.33^^11^145^29
 ;;^UTILITY(U,$J,358.3,1633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1633,1,3,0)
 ;;=3^Heart-Lung Transplant Infection
 ;;^UTILITY(U,$J,358.3,1633,1,4,0)
 ;;=4^T86.33
 ;;^UTILITY(U,$J,358.3,1633,2)
 ;;=^5055722
 ;;^UTILITY(U,$J,358.3,1634,0)
 ;;=T86.810^^11^145^35
 ;;^UTILITY(U,$J,358.3,1634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1634,1,3,0)
 ;;=3^Lung Transplant Rejection
 ;;^UTILITY(U,$J,358.3,1634,1,4,0)
 ;;=4^T86.810
 ;;^UTILITY(U,$J,358.3,1634,2)
 ;;=^5055730
 ;;^UTILITY(U,$J,358.3,1635,0)
 ;;=T86.811^^11^145^34
 ;;^UTILITY(U,$J,358.3,1635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1635,1,3,0)
 ;;=3^Lung Transplant Failure
 ;;^UTILITY(U,$J,358.3,1635,1,4,0)
 ;;=4^T86.811
 ;;^UTILITY(U,$J,358.3,1635,2)
 ;;=^5055731
 ;;^UTILITY(U,$J,358.3,1636,0)
 ;;=T86.819^^11^145^14
 ;;^UTILITY(U,$J,358.3,1636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1636,1,3,0)
 ;;=3^Complication of Lung Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,1636,1,4,0)
 ;;=4^T86.819
 ;;^UTILITY(U,$J,358.3,1636,2)
 ;;=^5137975
 ;;^UTILITY(U,$J,358.3,1637,0)
 ;;=T86.818^^11^145^13
 ;;^UTILITY(U,$J,358.3,1637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1637,1,3,0)
 ;;=3^Complication of Lung Transplant NEC
 ;;^UTILITY(U,$J,358.3,1637,1,4,0)
 ;;=4^T86.818
 ;;^UTILITY(U,$J,358.3,1637,2)
 ;;=^5055733
 ;;^UTILITY(U,$J,358.3,1638,0)
 ;;=Z94.1^^11^145^26
 ;;^UTILITY(U,$J,358.3,1638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1638,1,3,0)
 ;;=3^Heart Transplant Status
 ;;^UTILITY(U,$J,358.3,1638,1,4,0)
 ;;=4^Z94.1
 ;;^UTILITY(U,$J,358.3,1638,2)
 ;;=^5063655
 ;;^UTILITY(U,$J,358.3,1639,0)
 ;;=Z94.3^^11^145^27
 ;;^UTILITY(U,$J,358.3,1639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1639,1,3,0)
 ;;=3^Heart and Lungs Transplant Status
 ;;^UTILITY(U,$J,358.3,1639,1,4,0)
 ;;=4^Z94.3
 ;;^UTILITY(U,$J,358.3,1639,2)
 ;;=^5063657
 ;;^UTILITY(U,$J,358.3,1640,0)
 ;;=Z48.21^^11^145^1
 ;;^UTILITY(U,$J,358.3,1640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1640,1,3,0)
 ;;=3^Aftercare Following Heart Transplant
 ;;^UTILITY(U,$J,358.3,1640,1,4,0)
 ;;=4^Z48.21
 ;;^UTILITY(U,$J,358.3,1640,2)
 ;;=^5063038
 ;;^UTILITY(U,$J,358.3,1641,0)
 ;;=Z48.280^^11^145^2
 ;;^UTILITY(U,$J,358.3,1641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1641,1,3,0)
 ;;=3^Aftercare Following Heart-Lung Transplant
 ;;^UTILITY(U,$J,358.3,1641,1,4,0)
 ;;=4^Z48.280
 ;;^UTILITY(U,$J,358.3,1641,2)
 ;;=^5063042
 ;;^UTILITY(U,$J,358.3,1642,0)
 ;;=I25.10^^11^146^2
 ;;^UTILITY(U,$J,358.3,1642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1642,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1642,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,1642,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,1643,0)
 ;;=I25.110^^11^146^3
 ;;^UTILITY(U,$J,358.3,1643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1643,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1643,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,1643,2)
 ;;=^5007108
