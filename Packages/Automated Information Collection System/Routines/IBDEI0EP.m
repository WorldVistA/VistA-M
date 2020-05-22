IBDEI0EP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6323,1,3,0)
 ;;=3^Postprocedural Heart Failure Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,6323,1,4,0)
 ;;=4^I97.131
 ;;^UTILITY(U,$J,358.3,6323,2)
 ;;=^5008088
 ;;^UTILITY(U,$J,358.3,6324,0)
 ;;=I97.190^^53^406^55
 ;;^UTILITY(U,$J,358.3,6324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6324,1,3,0)
 ;;=3^Postprocedural Cardiac Function Disturbance Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,6324,1,4,0)
 ;;=4^I97.190
 ;;^UTILITY(U,$J,358.3,6324,2)
 ;;=^5008089
 ;;^UTILITY(U,$J,358.3,6325,0)
 ;;=I97.191^^53^406^56
 ;;^UTILITY(U,$J,358.3,6325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6325,1,3,0)
 ;;=3^Postprocedural Cardiac Function Disturbance Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,6325,1,4,0)
 ;;=4^I97.191
 ;;^UTILITY(U,$J,358.3,6325,2)
 ;;=^5008090
 ;;^UTILITY(U,$J,358.3,6326,0)
 ;;=I97.0^^53^406^52
 ;;^UTILITY(U,$J,358.3,6326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6326,1,3,0)
 ;;=3^Postcardiotomy Syndrome
 ;;^UTILITY(U,$J,358.3,6326,1,4,0)
 ;;=4^I97.0
 ;;^UTILITY(U,$J,358.3,6326,2)
 ;;=^5008082
 ;;^UTILITY(U,$J,358.3,6327,0)
 ;;=I97.110^^53^406^58
 ;;^UTILITY(U,$J,358.3,6327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6327,1,3,0)
 ;;=3^Postprocedural Cardiac Insufficiency Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,6327,1,4,0)
 ;;=4^I97.110
 ;;^UTILITY(U,$J,358.3,6327,2)
 ;;=^5008083
 ;;^UTILITY(U,$J,358.3,6328,0)
 ;;=T86.20^^53^406^22
 ;;^UTILITY(U,$J,358.3,6328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6328,1,3,0)
 ;;=3^Complication of Heart Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,6328,1,4,0)
 ;;=4^T86.20
 ;;^UTILITY(U,$J,358.3,6328,2)
 ;;=^5055713
 ;;^UTILITY(U,$J,358.3,6329,0)
 ;;=T86.21^^53^406^38
 ;;^UTILITY(U,$J,358.3,6329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6329,1,3,0)
 ;;=3^Heart Transplant Rejection
 ;;^UTILITY(U,$J,358.3,6329,1,4,0)
 ;;=4^T86.21
 ;;^UTILITY(U,$J,358.3,6329,2)
 ;;=^5055714
 ;;^UTILITY(U,$J,358.3,6330,0)
 ;;=T86.22^^53^406^36
 ;;^UTILITY(U,$J,358.3,6330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6330,1,3,0)
 ;;=3^Heart Transplant Failure
 ;;^UTILITY(U,$J,358.3,6330,1,4,0)
 ;;=4^T86.22
 ;;^UTILITY(U,$J,358.3,6330,2)
 ;;=^5055715
 ;;^UTILITY(U,$J,358.3,6331,0)
 ;;=T86.23^^53^406^37
 ;;^UTILITY(U,$J,358.3,6331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6331,1,3,0)
 ;;=3^Heart Transplant Infection
 ;;^UTILITY(U,$J,358.3,6331,1,4,0)
 ;;=4^T86.23
 ;;^UTILITY(U,$J,358.3,6331,2)
 ;;=^5055716
 ;;^UTILITY(U,$J,358.3,6332,0)
 ;;=T86.290^^53^406^13
 ;;^UTILITY(U,$J,358.3,6332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6332,1,3,0)
 ;;=3^Cardiac Allograft Vasculopathy
 ;;^UTILITY(U,$J,358.3,6332,1,4,0)
 ;;=4^T86.290
 ;;^UTILITY(U,$J,358.3,6332,2)
 ;;=^5055717
 ;;^UTILITY(U,$J,358.3,6333,0)
 ;;=T86.298^^53^406^27
 ;;^UTILITY(U,$J,358.3,6333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6333,1,3,0)
 ;;=3^Complications of Heart Transplant NEC
 ;;^UTILITY(U,$J,358.3,6333,1,4,0)
 ;;=4^T86.298
 ;;^UTILITY(U,$J,358.3,6333,2)
 ;;=^5055718
 ;;^UTILITY(U,$J,358.3,6334,0)
 ;;=T86.30^^53^406^23
 ;;^UTILITY(U,$J,358.3,6334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6334,1,3,0)
 ;;=3^Complication of Heart-Lung Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,6334,1,4,0)
 ;;=4^T86.30
 ;;^UTILITY(U,$J,358.3,6334,2)
 ;;=^5055719
 ;;^UTILITY(U,$J,358.3,6335,0)
 ;;=T86.39^^53^406^28
 ;;^UTILITY(U,$J,358.3,6335,1,0)
 ;;=^358.31IA^4^2
