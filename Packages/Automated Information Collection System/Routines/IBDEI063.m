IBDEI063 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2322,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,2322,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,2323,0)
 ;;=R13.12^^5^67^2
 ;;^UTILITY(U,$J,358.3,2323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2323,1,3,0)
 ;;=3^Dysphagia, oropharyngeal phase
 ;;^UTILITY(U,$J,358.3,2323,1,4,0)
 ;;=4^R13.12
 ;;^UTILITY(U,$J,358.3,2323,2)
 ;;=^335277
 ;;^UTILITY(U,$J,358.3,2324,0)
 ;;=R13.13^^5^67^3
 ;;^UTILITY(U,$J,358.3,2324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2324,1,3,0)
 ;;=3^Dysphagia, pharyngeal phase
 ;;^UTILITY(U,$J,358.3,2324,1,4,0)
 ;;=4^R13.13
 ;;^UTILITY(U,$J,358.3,2324,2)
 ;;=^335278
 ;;^UTILITY(U,$J,358.3,2325,0)
 ;;=R13.14^^5^67^4
 ;;^UTILITY(U,$J,358.3,2325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2325,1,3,0)
 ;;=3^Dysphagia, pharyngoesophageal phase
 ;;^UTILITY(U,$J,358.3,2325,1,4,0)
 ;;=4^R13.14
 ;;^UTILITY(U,$J,358.3,2325,2)
 ;;=^335279
 ;;^UTILITY(U,$J,358.3,2326,0)
 ;;=S02.2XXA^^5^68^2
 ;;^UTILITY(U,$J,358.3,2326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2326,1,3,0)
 ;;=3^Fracture of nasal bones, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,2326,1,4,0)
 ;;=4^S02.2XXA
 ;;^UTILITY(U,$J,358.3,2326,2)
 ;;=^5020306
 ;;^UTILITY(U,$J,358.3,2327,0)
 ;;=S02.609A^^5^68^1
 ;;^UTILITY(U,$J,358.3,2327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2327,1,3,0)
 ;;=3^Fracture of mandible, unsp, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,2327,1,4,0)
 ;;=4^S02.609A
 ;;^UTILITY(U,$J,358.3,2327,2)
 ;;=^5020372
 ;;^UTILITY(U,$J,358.3,2328,0)
 ;;=S02.92XA^^5^68^5
 ;;^UTILITY(U,$J,358.3,2328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2328,1,3,0)
 ;;=3^Fracture of unsp facial bones, init for clos fx
 ;;^UTILITY(U,$J,358.3,2328,1,4,0)
 ;;=4^S02.92XA
 ;;^UTILITY(U,$J,358.3,2328,2)
 ;;=^5020438
 ;;^UTILITY(U,$J,358.3,2329,0)
 ;;=S02.3XXA^^5^68^3
 ;;^UTILITY(U,$J,358.3,2329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2329,1,3,0)
 ;;=3^Fracture of orbital floor, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,2329,1,4,0)
 ;;=4^S02.3XXA
 ;;^UTILITY(U,$J,358.3,2329,2)
 ;;=^5020312
 ;;^UTILITY(U,$J,358.3,2330,0)
 ;;=S02.92XB^^5^68^4
 ;;^UTILITY(U,$J,358.3,2330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2330,1,3,0)
 ;;=3^Fracture of unsp facial bones, init encntr for open fracture
 ;;^UTILITY(U,$J,358.3,2330,1,4,0)
 ;;=4^S02.92XB
 ;;^UTILITY(U,$J,358.3,2330,2)
 ;;=^5020439
 ;;^UTILITY(U,$J,358.3,2331,0)
 ;;=C00.2^^5^69^13
 ;;^UTILITY(U,$J,358.3,2331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2331,1,3,0)
 ;;=3^Malignant neoplasm of external lip, unspecified
 ;;^UTILITY(U,$J,358.3,2331,1,4,0)
 ;;=4^C00.2
 ;;^UTILITY(U,$J,358.3,2331,2)
 ;;=^5000884
 ;;^UTILITY(U,$J,358.3,2332,0)
 ;;=C02.9^^5^69^30
 ;;^UTILITY(U,$J,358.3,2332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2332,1,3,0)
 ;;=3^Malignant neoplasm of tongue, unspecified
 ;;^UTILITY(U,$J,358.3,2332,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,2332,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,2333,0)
 ;;=C07.^^5^69^24
 ;;^UTILITY(U,$J,358.3,2333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2333,1,3,0)
 ;;=3^Malignant neoplasm of parotid gland
 ;;^UTILITY(U,$J,358.3,2333,1,4,0)
 ;;=4^C07.
 ;;^UTILITY(U,$J,358.3,2333,2)
 ;;=^267005
 ;;^UTILITY(U,$J,358.3,2334,0)
 ;;=C08.0^^5^69^27
 ;;^UTILITY(U,$J,358.3,2334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2334,1,3,0)
 ;;=3^Malignant neoplasm of submandibular gland
 ;;^UTILITY(U,$J,358.3,2334,1,4,0)
 ;;=4^C08.0
 ;;^UTILITY(U,$J,358.3,2334,2)
 ;;=^267006
 ;;^UTILITY(U,$J,358.3,2335,0)
 ;;=C03.9^^5^69^16
 ;;^UTILITY(U,$J,358.3,2335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2335,1,3,0)
 ;;=3^Malignant neoplasm of gum, unspecified
