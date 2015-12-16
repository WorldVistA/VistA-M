IBDEI0KR ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9833,1,3,0)
 ;;=3^Punctate Keratitis
 ;;^UTILITY(U,$J,358.3,9833,1,4,0)
 ;;=4^370.21
 ;;^UTILITY(U,$J,358.3,9833,2)
 ;;=Keratitis, Punctate^268920
 ;;^UTILITY(U,$J,358.3,9834,0)
 ;;=054.42^^44^558^63
 ;;^UTILITY(U,$J,358.3,9834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9834,1,3,0)
 ;;=3^Keratitis, Dendritic (HSV)
 ;;^UTILITY(U,$J,358.3,9834,1,4,0)
 ;;=4^054.42
 ;;^UTILITY(U,$J,358.3,9834,2)
 ;;=Dendritic Keratitis^66763
 ;;^UTILITY(U,$J,358.3,9835,0)
 ;;=370.62^^44^558^94
 ;;^UTILITY(U,$J,358.3,9835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9835,1,3,0)
 ;;=3^Pannus
 ;;^UTILITY(U,$J,358.3,9835,1,4,0)
 ;;=4^370.62
 ;;^UTILITY(U,$J,358.3,9835,2)
 ;;=^268949
 ;;^UTILITY(U,$J,358.3,9836,0)
 ;;=053.21^^44^558^69
 ;;^UTILITY(U,$J,358.3,9836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9836,1,3,0)
 ;;=3^Keratoconjunctivits, H Zoster
 ;;^UTILITY(U,$J,358.3,9836,1,4,0)
 ;;=4^053.21
 ;;^UTILITY(U,$J,358.3,9836,2)
 ;;=Herp Zost Keratoconjunctivitis^266553
 ;;^UTILITY(U,$J,358.3,9837,0)
 ;;=V42.5^^44^558^24
 ;;^UTILITY(U,$J,358.3,9837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9837,1,3,0)
 ;;=3^Corneal Transplant
 ;;^UTILITY(U,$J,358.3,9837,1,4,0)
 ;;=4^V42.5
 ;;^UTILITY(U,$J,358.3,9837,2)
 ;;=Corneal Transplant^174117
 ;;^UTILITY(U,$J,358.3,9838,0)
 ;;=996.51^^44^558^109
 ;;^UTILITY(U,$J,358.3,9838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9838,1,3,0)
 ;;=3^Reject/Failure, Corneal Transp
 ;;^UTILITY(U,$J,358.3,9838,1,4,0)
 ;;=4^996.51
 ;;^UTILITY(U,$J,358.3,9838,2)
 ;;=Rejection/Failure, Corneal Transplant^276277^V42.5
 ;;^UTILITY(U,$J,358.3,9839,0)
 ;;=918.1^^44^558^1
 ;;^UTILITY(U,$J,358.3,9839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9839,1,3,0)
 ;;=3^Abrasion, Cornea
 ;;^UTILITY(U,$J,358.3,9839,1,4,0)
 ;;=4^918.1
 ;;^UTILITY(U,$J,358.3,9839,2)
 ;;=Corneal Abrasion^115829
 ;;^UTILITY(U,$J,358.3,9840,0)
 ;;=370.49^^44^558^110
 ;;^UTILITY(U,$J,358.3,9840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9840,1,3,0)
 ;;=3^Rosacea Keratitis
 ;;^UTILITY(U,$J,358.3,9840,1,4,0)
 ;;=4^370.49
 ;;^UTILITY(U,$J,358.3,9840,2)
 ;;=^87674^695.3
 ;;^UTILITY(U,$J,358.3,9841,0)
 ;;=371.41^^44^558^7
 ;;^UTILITY(U,$J,358.3,9841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9841,1,3,0)
 ;;=3^Arcus, Corneal
 ;;^UTILITY(U,$J,358.3,9841,1,4,0)
 ;;=4^371.41
 ;;^UTILITY(U,$J,358.3,9841,2)
 ;;=Corneal Arcus^109206
 ;;^UTILITY(U,$J,358.3,9842,0)
 ;;=371.10^^44^558^17
 ;;^UTILITY(U,$J,358.3,9842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9842,1,3,0)
 ;;=3^Cornea Dep/Amoid
 ;;^UTILITY(U,$J,358.3,9842,1,4,0)
 ;;=4^371.10
 ;;^UTILITY(U,$J,358.3,9842,2)
 ;;=Toxic Keratopathy, Due to med^276846
 ;;^UTILITY(U,$J,358.3,9843,0)
 ;;=370.60^^44^558^87
 ;;^UTILITY(U,$J,358.3,9843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9843,1,3,0)
 ;;=3^Neovascularization, Corneal
 ;;^UTILITY(U,$J,358.3,9843,1,4,0)
 ;;=4^370.60
 ;;^UTILITY(U,$J,358.3,9843,2)
 ;;=Corneal Neovascularization^184274
 ;;^UTILITY(U,$J,358.3,9844,0)
 ;;=371.20^^44^558^37
 ;;^UTILITY(U,$J,358.3,9844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9844,1,3,0)
 ;;=3^Edema, Cornea
 ;;^UTILITY(U,$J,358.3,9844,1,4,0)
 ;;=4^371.20
 ;;^UTILITY(U,$J,358.3,9844,2)
 ;;=Edema, Cornea^28394
 ;;^UTILITY(U,$J,358.3,9845,0)
 ;;=371.00^^44^558^90
 ;;^UTILITY(U,$J,358.3,9845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9845,1,3,0)
 ;;=3^Opacity, Corneal
 ;;^UTILITY(U,$J,358.3,9845,1,4,0)
 ;;=4^371.00
 ;;^UTILITY(U,$J,358.3,9845,2)
 ;;=Corneal Opacity^28398
 ;;^UTILITY(U,$J,358.3,9846,0)
 ;;=371.43^^44^558^9
 ;;^UTILITY(U,$J,358.3,9846,1,0)
 ;;=^358.31IA^4^2
