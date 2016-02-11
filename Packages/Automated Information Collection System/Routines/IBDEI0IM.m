IBDEI0IM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8364,1,4,0)
 ;;=4^C65.2
 ;;^UTILITY(U,$J,358.3,8364,2)
 ;;=^5001252
 ;;^UTILITY(U,$J,358.3,8365,0)
 ;;=C71.9^^55^538^53
 ;;^UTILITY(U,$J,358.3,8365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8365,1,3,0)
 ;;=3^Malignant neoplasm of brain, unspecified
 ;;^UTILITY(U,$J,358.3,8365,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,8365,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,8366,0)
 ;;=C73.^^55^538^79
 ;;^UTILITY(U,$J,358.3,8366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8366,1,3,0)
 ;;=3^Malignant neoplasm of thyroid gland
 ;;^UTILITY(U,$J,358.3,8366,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,8366,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,8367,0)
 ;;=C76.0^^55^538^61
 ;;^UTILITY(U,$J,358.3,8367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8367,1,3,0)
 ;;=3^Malignant neoplasm of head, face and neck
 ;;^UTILITY(U,$J,358.3,8367,1,4,0)
 ;;=4^C76.0
 ;;^UTILITY(U,$J,358.3,8367,2)
 ;;=^5001324
 ;;^UTILITY(U,$J,358.3,8368,0)
 ;;=C77.0^^55^538^115
 ;;^UTILITY(U,$J,358.3,8368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8368,1,3,0)
 ;;=3^Secondary and unsp malig neoplasm of nodes of head, face and neck
 ;;^UTILITY(U,$J,358.3,8368,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,8368,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,8369,0)
 ;;=C77.1^^55^538^117
 ;;^UTILITY(U,$J,358.3,8369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8369,1,3,0)
 ;;=3^Secondary and unsp malignant neoplasm of intrathorac nodes
 ;;^UTILITY(U,$J,358.3,8369,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,8369,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,8370,0)
 ;;=C77.2^^55^538^118
 ;;^UTILITY(U,$J,358.3,8370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8370,1,3,0)
 ;;=3^Secondary and unsp malignant neoplasm of intra-abd nodes
 ;;^UTILITY(U,$J,358.3,8370,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,8370,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,8371,0)
 ;;=C77.3^^55^538^114
 ;;^UTILITY(U,$J,358.3,8371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8371,1,3,0)
 ;;=3^Secondary and unsp malig neoplasm of axilla and upper limb nodes
 ;;^UTILITY(U,$J,358.3,8371,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,8371,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,8372,0)
 ;;=C77.8^^55^538^116
 ;;^UTILITY(U,$J,358.3,8372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8372,1,3,0)
 ;;=3^Secondary and unsp malig neoplasm of nodes of multiple regions
 ;;^UTILITY(U,$J,358.3,8372,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,8372,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,8373,0)
 ;;=C78.01^^55^538^126
 ;;^UTILITY(U,$J,358.3,8373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8373,1,3,0)
 ;;=3^Secondary malignant neoplasm of right lung
 ;;^UTILITY(U,$J,358.3,8373,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,8373,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,8374,0)
 ;;=C78.02^^55^538^123
 ;;^UTILITY(U,$J,358.3,8374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8374,1,3,0)
 ;;=3^Secondary malignant neoplasm of left lung
 ;;^UTILITY(U,$J,358.3,8374,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,8374,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,8375,0)
 ;;=C78.7^^55^538^124
 ;;^UTILITY(U,$J,358.3,8375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8375,1,3,0)
 ;;=3^Secondary malignant neoplasm of liver/intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,8375,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,8375,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,8376,0)
 ;;=C79.31^^55^538^121
 ;;^UTILITY(U,$J,358.3,8376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8376,1,3,0)
 ;;=3^Secondary malignant neoplasm of brain
 ;;^UTILITY(U,$J,358.3,8376,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,8376,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,8377,0)
 ;;=C79.51^^55^538^119
