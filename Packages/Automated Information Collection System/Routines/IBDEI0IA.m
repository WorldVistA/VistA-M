IBDEI0IA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8486,1,3,0)
 ;;=3^Dysphagia, pharyngoesophageal phase
 ;;^UTILITY(U,$J,358.3,8486,1,4,0)
 ;;=4^R13.14
 ;;^UTILITY(U,$J,358.3,8486,2)
 ;;=^335279
 ;;^UTILITY(U,$J,358.3,8487,0)
 ;;=S02.2XXA^^39^459^2
 ;;^UTILITY(U,$J,358.3,8487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8487,1,3,0)
 ;;=3^Fracture of nasal bones, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,8487,1,4,0)
 ;;=4^S02.2XXA
 ;;^UTILITY(U,$J,358.3,8487,2)
 ;;=^5020306
 ;;^UTILITY(U,$J,358.3,8488,0)
 ;;=S02.609A^^39^459^1
 ;;^UTILITY(U,$J,358.3,8488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8488,1,3,0)
 ;;=3^Fracture of mandible, unsp, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,8488,1,4,0)
 ;;=4^S02.609A
 ;;^UTILITY(U,$J,358.3,8488,2)
 ;;=^5020372
 ;;^UTILITY(U,$J,358.3,8489,0)
 ;;=S02.92XA^^39^459^4
 ;;^UTILITY(U,$J,358.3,8489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8489,1,3,0)
 ;;=3^Fracture of unsp facial bones, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,8489,1,4,0)
 ;;=4^S02.92XA
 ;;^UTILITY(U,$J,358.3,8489,2)
 ;;=^5020438
 ;;^UTILITY(U,$J,358.3,8490,0)
 ;;=S02.3XXA^^39^459^3
 ;;^UTILITY(U,$J,358.3,8490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8490,1,3,0)
 ;;=3^Fracture of orbital floor, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,8490,1,4,0)
 ;;=4^S02.3XXA
 ;;^UTILITY(U,$J,358.3,8490,2)
 ;;=^5020312
 ;;^UTILITY(U,$J,358.3,8491,0)
 ;;=S02.92XB^^39^459^5
 ;;^UTILITY(U,$J,358.3,8491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8491,1,3,0)
 ;;=3^Fracture of unsp facial bones, init encntr for open fracture
 ;;^UTILITY(U,$J,358.3,8491,1,4,0)
 ;;=4^S02.92XB
 ;;^UTILITY(U,$J,358.3,8491,2)
 ;;=^5020439
 ;;^UTILITY(U,$J,358.3,8492,0)
 ;;=C00.2^^39^460^13
 ;;^UTILITY(U,$J,358.3,8492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8492,1,3,0)
 ;;=3^Malignant neoplasm of external lip, unspecified
 ;;^UTILITY(U,$J,358.3,8492,1,4,0)
 ;;=4^C00.2
 ;;^UTILITY(U,$J,358.3,8492,2)
 ;;=^5000884
 ;;^UTILITY(U,$J,358.3,8493,0)
 ;;=C02.9^^39^460^30
 ;;^UTILITY(U,$J,358.3,8493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8493,1,3,0)
 ;;=3^Malignant neoplasm of tongue, unspecified
 ;;^UTILITY(U,$J,358.3,8493,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,8493,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,8494,0)
 ;;=C07.^^39^460^24
 ;;^UTILITY(U,$J,358.3,8494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8494,1,3,0)
 ;;=3^Malignant neoplasm of parotid gland
 ;;^UTILITY(U,$J,358.3,8494,1,4,0)
 ;;=4^C07.
 ;;^UTILITY(U,$J,358.3,8494,2)
 ;;=^267005
 ;;^UTILITY(U,$J,358.3,8495,0)
 ;;=C08.0^^39^460^27
 ;;^UTILITY(U,$J,358.3,8495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8495,1,3,0)
 ;;=3^Malignant neoplasm of submandibular gland
 ;;^UTILITY(U,$J,358.3,8495,1,4,0)
 ;;=4^C08.0
 ;;^UTILITY(U,$J,358.3,8495,2)
 ;;=^267006
 ;;^UTILITY(U,$J,358.3,8496,0)
 ;;=C03.9^^39^460^16
 ;;^UTILITY(U,$J,358.3,8496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8496,1,3,0)
 ;;=3^Malignant neoplasm of gum, unspecified
 ;;^UTILITY(U,$J,358.3,8496,1,4,0)
 ;;=4^C03.9
 ;;^UTILITY(U,$J,358.3,8496,2)
 ;;=^5000892
 ;;^UTILITY(U,$J,358.3,8497,0)
 ;;=C04.9^^39^460^14
 ;;^UTILITY(U,$J,358.3,8497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8497,1,3,0)
 ;;=3^Malignant neoplasm of floor of mouth, unspecified
 ;;^UTILITY(U,$J,358.3,8497,1,4,0)
 ;;=4^C04.9
 ;;^UTILITY(U,$J,358.3,8497,2)
 ;;=^5000896
 ;;^UTILITY(U,$J,358.3,8498,0)
 ;;=C05.2^^39^460^32
 ;;^UTILITY(U,$J,358.3,8498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8498,1,3,0)
 ;;=3^Malignant neoplasm of uvula
 ;;^UTILITY(U,$J,358.3,8498,1,4,0)
 ;;=4^C05.2
