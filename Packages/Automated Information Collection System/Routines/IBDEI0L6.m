IBDEI0L6 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9882,0)
 ;;=H40.11X1^^44^496^110
 ;;^UTILITY(U,$J,358.3,9882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9882,1,3,0)
 ;;=3^Primary Open-Angle Glaucoma,Mild Stage
 ;;^UTILITY(U,$J,358.3,9882,1,4,0)
 ;;=4^H40.11X1
 ;;^UTILITY(U,$J,358.3,9882,2)
 ;;=^5005754
 ;;^UTILITY(U,$J,358.3,9883,0)
 ;;=H40.11X2^^44^496^111
 ;;^UTILITY(U,$J,358.3,9883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9883,1,3,0)
 ;;=3^Primary Open-Angle Glaucoma,Moderate Stage
 ;;^UTILITY(U,$J,358.3,9883,1,4,0)
 ;;=4^H40.11X2
 ;;^UTILITY(U,$J,358.3,9883,2)
 ;;=^5005755
 ;;^UTILITY(U,$J,358.3,9884,0)
 ;;=H40.11X3^^44^496^112
 ;;^UTILITY(U,$J,358.3,9884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9884,1,3,0)
 ;;=3^Primary Open-Angle Glaucoma,Severe Stage
 ;;^UTILITY(U,$J,358.3,9884,1,4,0)
 ;;=4^H40.11X3
 ;;^UTILITY(U,$J,358.3,9884,2)
 ;;=^5005756
 ;;^UTILITY(U,$J,358.3,9885,0)
 ;;=H40.11X4^^44^496^109
 ;;^UTILITY(U,$J,358.3,9885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9885,1,3,0)
 ;;=3^Primary Open-Angle Glaucoma,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,9885,1,4,0)
 ;;=4^H40.11X4
 ;;^UTILITY(U,$J,358.3,9885,2)
 ;;=^5005757
 ;;^UTILITY(U,$J,358.3,9886,0)
 ;;=H40.1211^^44^496^71
 ;;^UTILITY(U,$J,358.3,9886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9886,1,3,0)
 ;;=3^Low-Tension Glaucoma,Right Eye,Mild Stage
 ;;^UTILITY(U,$J,358.3,9886,1,4,0)
 ;;=4^H40.1211
 ;;^UTILITY(U,$J,358.3,9886,2)
 ;;=^5005759
 ;;^UTILITY(U,$J,358.3,9887,0)
 ;;=H40.1212^^44^496^72
 ;;^UTILITY(U,$J,358.3,9887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9887,1,3,0)
 ;;=3^Low-Tension Glaucoma,Right Eye,Moderate Stage
 ;;^UTILITY(U,$J,358.3,9887,1,4,0)
 ;;=4^H40.1212
 ;;^UTILITY(U,$J,358.3,9887,2)
 ;;=^5005760
 ;;^UTILITY(U,$J,358.3,9888,0)
 ;;=H40.1213^^44^496^73
 ;;^UTILITY(U,$J,358.3,9888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9888,1,3,0)
 ;;=3^Low-Tension Glaucoma,Right Eye,Severe Stage
 ;;^UTILITY(U,$J,358.3,9888,1,4,0)
 ;;=4^H40.1213
 ;;^UTILITY(U,$J,358.3,9888,2)
 ;;=^5005761
 ;;^UTILITY(U,$J,358.3,9889,0)
 ;;=H40.1214^^44^496^70
 ;;^UTILITY(U,$J,358.3,9889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9889,1,3,0)
 ;;=3^Low-Tension Glaucoma,Right Eye,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,9889,1,4,0)
 ;;=4^H40.1214
 ;;^UTILITY(U,$J,358.3,9889,2)
 ;;=^5005762
 ;;^UTILITY(U,$J,358.3,9890,0)
 ;;=H40.1221^^44^496^67
 ;;^UTILITY(U,$J,358.3,9890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9890,1,3,0)
 ;;=3^Low-Tension Glaucoma,Left Eye,Mild Stage
 ;;^UTILITY(U,$J,358.3,9890,1,4,0)
 ;;=4^H40.1221
 ;;^UTILITY(U,$J,358.3,9890,2)
 ;;=^5005764
 ;;^UTILITY(U,$J,358.3,9891,0)
 ;;=H40.1222^^44^496^68
 ;;^UTILITY(U,$J,358.3,9891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9891,1,3,0)
 ;;=3^Low-Tension Glaucoma,Left Eye,Moderate Stage
 ;;^UTILITY(U,$J,358.3,9891,1,4,0)
 ;;=4^H40.1222
 ;;^UTILITY(U,$J,358.3,9891,2)
 ;;=^5005765
 ;;^UTILITY(U,$J,358.3,9892,0)
 ;;=H40.1223^^44^496^69
 ;;^UTILITY(U,$J,358.3,9892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9892,1,3,0)
 ;;=3^Low-Tension Glaucoma,Left Eye,Severe Stage
 ;;^UTILITY(U,$J,358.3,9892,1,4,0)
 ;;=4^H40.1223
 ;;^UTILITY(U,$J,358.3,9892,2)
 ;;=^5133492
 ;;^UTILITY(U,$J,358.3,9893,0)
 ;;=H40.1224^^44^496^66
 ;;^UTILITY(U,$J,358.3,9893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9893,1,3,0)
 ;;=3^Low-Tension Glaucoma,Left Eye,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,9893,1,4,0)
 ;;=4^H40.1224
 ;;^UTILITY(U,$J,358.3,9893,2)
 ;;=^5005766
 ;;^UTILITY(U,$J,358.3,9894,0)
 ;;=H40.1231^^44^496^63
 ;;^UTILITY(U,$J,358.3,9894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9894,1,3,0)
 ;;=3^Low-Tension Glaucoma,Bilateral,Mild Stage
