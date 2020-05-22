IBDEI0EQ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6335,1,3,0)
 ;;=3^Complications of Heart-Lung Transplant NEC
 ;;^UTILITY(U,$J,358.3,6335,1,4,0)
 ;;=4^T86.39
 ;;^UTILITY(U,$J,358.3,6335,2)
 ;;=^5055723
 ;;^UTILITY(U,$J,358.3,6336,0)
 ;;=T86.31^^53^406^43
 ;;^UTILITY(U,$J,358.3,6336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6336,1,3,0)
 ;;=3^Heart-Lung Transplant Rejection
 ;;^UTILITY(U,$J,358.3,6336,1,4,0)
 ;;=4^T86.31
 ;;^UTILITY(U,$J,358.3,6336,2)
 ;;=^5055720
 ;;^UTILITY(U,$J,358.3,6337,0)
 ;;=T86.32^^53^406^41
 ;;^UTILITY(U,$J,358.3,6337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6337,1,3,0)
 ;;=3^Heart-Lung Transplant Failure
 ;;^UTILITY(U,$J,358.3,6337,1,4,0)
 ;;=4^T86.32
 ;;^UTILITY(U,$J,358.3,6337,2)
 ;;=^5055721
 ;;^UTILITY(U,$J,358.3,6338,0)
 ;;=T86.33^^53^406^42
 ;;^UTILITY(U,$J,358.3,6338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6338,1,3,0)
 ;;=3^Heart-Lung Transplant Infection
 ;;^UTILITY(U,$J,358.3,6338,1,4,0)
 ;;=4^T86.33
 ;;^UTILITY(U,$J,358.3,6338,2)
 ;;=^5055722
 ;;^UTILITY(U,$J,358.3,6339,0)
 ;;=T86.810^^53^406^50
 ;;^UTILITY(U,$J,358.3,6339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6339,1,3,0)
 ;;=3^Lung Transplant Rejection
 ;;^UTILITY(U,$J,358.3,6339,1,4,0)
 ;;=4^T86.810
 ;;^UTILITY(U,$J,358.3,6339,2)
 ;;=^5055730
 ;;^UTILITY(U,$J,358.3,6340,0)
 ;;=T86.811^^53^406^49
 ;;^UTILITY(U,$J,358.3,6340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6340,1,3,0)
 ;;=3^Lung Transplant Failure
 ;;^UTILITY(U,$J,358.3,6340,1,4,0)
 ;;=4^T86.811
 ;;^UTILITY(U,$J,358.3,6340,2)
 ;;=^5055731
 ;;^UTILITY(U,$J,358.3,6341,0)
 ;;=T86.819^^53^406^25
 ;;^UTILITY(U,$J,358.3,6341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6341,1,3,0)
 ;;=3^Complication of Lung Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,6341,1,4,0)
 ;;=4^T86.819
 ;;^UTILITY(U,$J,358.3,6341,2)
 ;;=^5137975
 ;;^UTILITY(U,$J,358.3,6342,0)
 ;;=T86.818^^53^406^24
 ;;^UTILITY(U,$J,358.3,6342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6342,1,3,0)
 ;;=3^Complication of Lung Transplant NEC
 ;;^UTILITY(U,$J,358.3,6342,1,4,0)
 ;;=4^T86.818
 ;;^UTILITY(U,$J,358.3,6342,2)
 ;;=^5055733
 ;;^UTILITY(U,$J,358.3,6343,0)
 ;;=Z94.1^^53^406^39
 ;;^UTILITY(U,$J,358.3,6343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6343,1,3,0)
 ;;=3^Heart Transplant Status
 ;;^UTILITY(U,$J,358.3,6343,1,4,0)
 ;;=4^Z94.1
 ;;^UTILITY(U,$J,358.3,6343,2)
 ;;=^5063655
 ;;^UTILITY(U,$J,358.3,6344,0)
 ;;=Z94.3^^53^406^40
 ;;^UTILITY(U,$J,358.3,6344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6344,1,3,0)
 ;;=3^Heart and Lungs Transplant Status
 ;;^UTILITY(U,$J,358.3,6344,1,4,0)
 ;;=4^Z94.3
 ;;^UTILITY(U,$J,358.3,6344,2)
 ;;=^5063657
 ;;^UTILITY(U,$J,358.3,6345,0)
 ;;=Z48.21^^53^406^8
 ;;^UTILITY(U,$J,358.3,6345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6345,1,3,0)
 ;;=3^Aftercare Following Heart Transplant
 ;;^UTILITY(U,$J,358.3,6345,1,4,0)
 ;;=4^Z48.21
 ;;^UTILITY(U,$J,358.3,6345,2)
 ;;=^5063038
 ;;^UTILITY(U,$J,358.3,6346,0)
 ;;=Z48.280^^53^406^9
 ;;^UTILITY(U,$J,358.3,6346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6346,1,3,0)
 ;;=3^Aftercare Following Heart-Lung Transplant
 ;;^UTILITY(U,$J,358.3,6346,1,4,0)
 ;;=4^Z48.280
 ;;^UTILITY(U,$J,358.3,6346,2)
 ;;=^5063042
 ;;^UTILITY(U,$J,358.3,6347,0)
 ;;=I50.41^^53^406^1
 ;;^UTILITY(U,$J,358.3,6347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6347,1,3,0)
 ;;=3^Acute Combined Systolic & Diastolic Hrt Failure
 ;;^UTILITY(U,$J,358.3,6347,1,4,0)
 ;;=4^I50.41
