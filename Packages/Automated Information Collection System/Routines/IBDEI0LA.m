IBDEI0LA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9931,2)
 ;;=^5005835
 ;;^UTILITY(U,$J,358.3,9932,0)
 ;;=H40.241^^44^496^115
 ;;^UTILITY(U,$J,358.3,9932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9932,1,3,0)
 ;;=3^Residual Stage Angle-Closure Glaucoma,Right Eye
 ;;^UTILITY(U,$J,358.3,9932,1,4,0)
 ;;=4^H40.241
 ;;^UTILITY(U,$J,358.3,9932,2)
 ;;=^5005843
 ;;^UTILITY(U,$J,358.3,9933,0)
 ;;=H40.242^^44^496^114
 ;;^UTILITY(U,$J,358.3,9933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9933,1,3,0)
 ;;=3^Residual Stage Angle-Closure Glaucoma,Left Eye
 ;;^UTILITY(U,$J,358.3,9933,1,4,0)
 ;;=4^H40.242
 ;;^UTILITY(U,$J,358.3,9933,2)
 ;;=^5005844
 ;;^UTILITY(U,$J,358.3,9934,0)
 ;;=H40.61X0^^44^496^43
 ;;^UTILITY(U,$J,358.3,9934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9934,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Right Eye,Unspec Stage
 ;;^UTILITY(U,$J,358.3,9934,1,4,0)
 ;;=4^H40.61X0
 ;;^UTILITY(U,$J,358.3,9934,2)
 ;;=^5005906
 ;;^UTILITY(U,$J,358.3,9935,0)
 ;;=H40.61X2^^44^496^41
 ;;^UTILITY(U,$J,358.3,9935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9935,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Right Eye,Moderate Stage
 ;;^UTILITY(U,$J,358.3,9935,1,4,0)
 ;;=4^H40.61X2
 ;;^UTILITY(U,$J,358.3,9935,2)
 ;;=^5005908
 ;;^UTILITY(U,$J,358.3,9936,0)
 ;;=H40.61X3^^44^496^42
 ;;^UTILITY(U,$J,358.3,9936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9936,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Right Eye,Severe Stage
 ;;^UTILITY(U,$J,358.3,9936,1,4,0)
 ;;=4^H40.61X3
 ;;^UTILITY(U,$J,358.3,9936,2)
 ;;=^5133509
 ;;^UTILITY(U,$J,358.3,9937,0)
 ;;=H40.61X4^^44^496^39
 ;;^UTILITY(U,$J,358.3,9937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9937,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Right Eye,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,9937,1,4,0)
 ;;=4^H40.61X4
 ;;^UTILITY(U,$J,358.3,9937,2)
 ;;=^5005909
 ;;^UTILITY(U,$J,358.3,9938,0)
 ;;=H40.62X1^^44^496^35
 ;;^UTILITY(U,$J,358.3,9938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9938,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Left Eye,Mild Stage
 ;;^UTILITY(U,$J,358.3,9938,1,4,0)
 ;;=4^H40.62X1
 ;;^UTILITY(U,$J,358.3,9938,2)
 ;;=^5005911
 ;;^UTILITY(U,$J,358.3,9939,0)
 ;;=H40.62X0^^44^496^38
 ;;^UTILITY(U,$J,358.3,9939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9939,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Left Eye,Unspec Stage
 ;;^UTILITY(U,$J,358.3,9939,1,4,0)
 ;;=4^H40.62X0
 ;;^UTILITY(U,$J,358.3,9939,2)
 ;;=^5005910
 ;;^UTILITY(U,$J,358.3,9940,0)
 ;;=H40.62X2^^44^496^36
 ;;^UTILITY(U,$J,358.3,9940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9940,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Left Eye,Moderate Stage
 ;;^UTILITY(U,$J,358.3,9940,1,4,0)
 ;;=4^H40.62X2
 ;;^UTILITY(U,$J,358.3,9940,2)
 ;;=^5005912
 ;;^UTILITY(U,$J,358.3,9941,0)
 ;;=H40.62X3^^44^496^37
 ;;^UTILITY(U,$J,358.3,9941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9941,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Left Eye,Severe Stage
 ;;^UTILITY(U,$J,358.3,9941,1,4,0)
 ;;=4^H40.62X3
 ;;^UTILITY(U,$J,358.3,9941,2)
 ;;=^5133510
 ;;^UTILITY(U,$J,358.3,9942,0)
 ;;=H40.62X4^^44^496^34
 ;;^UTILITY(U,$J,358.3,9942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9942,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Left Eye,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,9942,1,4,0)
 ;;=4^H40.62X4
 ;;^UTILITY(U,$J,358.3,9942,2)
 ;;=^5005913
 ;;^UTILITY(U,$J,358.3,9943,0)
 ;;=H40.63X0^^44^496^33
 ;;^UTILITY(U,$J,358.3,9943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9943,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Bilateral,Unspec Stage
 ;;^UTILITY(U,$J,358.3,9943,1,4,0)
 ;;=4^H40.63X0
 ;;^UTILITY(U,$J,358.3,9943,2)
 ;;=^5005914
 ;;^UTILITY(U,$J,358.3,9944,0)
 ;;=H40.63X1^^44^496^30
 ;;^UTILITY(U,$J,358.3,9944,1,0)
 ;;=^358.31IA^4^2
