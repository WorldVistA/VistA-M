IBDEI03T ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1252,0)
 ;;=C73.^^3^39^79
 ;;^UTILITY(U,$J,358.3,1252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1252,1,3,0)
 ;;=3^Malignant neoplasm of thyroid gland
 ;;^UTILITY(U,$J,358.3,1252,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,1252,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,1253,0)
 ;;=C76.0^^3^39^61
 ;;^UTILITY(U,$J,358.3,1253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1253,1,3,0)
 ;;=3^Malignant neoplasm of head, face and neck
 ;;^UTILITY(U,$J,358.3,1253,1,4,0)
 ;;=4^C76.0
 ;;^UTILITY(U,$J,358.3,1253,2)
 ;;=^5001324
 ;;^UTILITY(U,$J,358.3,1254,0)
 ;;=C77.0^^3^39^115
 ;;^UTILITY(U,$J,358.3,1254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1254,1,3,0)
 ;;=3^Secondary and unsp malig neoplasm of nodes of head, face and neck
 ;;^UTILITY(U,$J,358.3,1254,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,1254,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,1255,0)
 ;;=C77.1^^3^39^117
 ;;^UTILITY(U,$J,358.3,1255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1255,1,3,0)
 ;;=3^Secondary and unsp malignant neoplasm of intrathorac nodes
 ;;^UTILITY(U,$J,358.3,1255,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,1255,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,1256,0)
 ;;=C77.2^^3^39^118
 ;;^UTILITY(U,$J,358.3,1256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1256,1,3,0)
 ;;=3^Secondary and unsp malignant neoplasm of intra-abd nodes
 ;;^UTILITY(U,$J,358.3,1256,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,1256,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,1257,0)
 ;;=C77.3^^3^39^114
 ;;^UTILITY(U,$J,358.3,1257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1257,1,3,0)
 ;;=3^Secondary and unsp malig neoplasm of axilla and upper limb nodes
 ;;^UTILITY(U,$J,358.3,1257,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,1257,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,1258,0)
 ;;=C77.8^^3^39^116
 ;;^UTILITY(U,$J,358.3,1258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1258,1,3,0)
 ;;=3^Secondary and unsp malig neoplasm of nodes of multiple regions
 ;;^UTILITY(U,$J,358.3,1258,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,1258,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,1259,0)
 ;;=C78.01^^3^39^126
 ;;^UTILITY(U,$J,358.3,1259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1259,1,3,0)
 ;;=3^Secondary malignant neoplasm of right lung
 ;;^UTILITY(U,$J,358.3,1259,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,1259,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,1260,0)
 ;;=C78.02^^3^39^123
 ;;^UTILITY(U,$J,358.3,1260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1260,1,3,0)
 ;;=3^Secondary malignant neoplasm of left lung
 ;;^UTILITY(U,$J,358.3,1260,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,1260,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,1261,0)
 ;;=C78.7^^3^39^124
 ;;^UTILITY(U,$J,358.3,1261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1261,1,3,0)
 ;;=3^Secondary malignant neoplasm of liver/intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,1261,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,1261,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,1262,0)
 ;;=C79.31^^3^39^121
 ;;^UTILITY(U,$J,358.3,1262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1262,1,3,0)
 ;;=3^Secondary malignant neoplasm of brain
 ;;^UTILITY(U,$J,358.3,1262,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,1262,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,1263,0)
 ;;=C79.51^^3^39^119
 ;;^UTILITY(U,$J,358.3,1263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1263,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone
 ;;^UTILITY(U,$J,358.3,1263,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,1263,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,1264,0)
 ;;=C79.52^^3^39^120
 ;;^UTILITY(U,$J,358.3,1264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1264,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone marrow
