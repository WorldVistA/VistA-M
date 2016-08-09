IBDEI0S7 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28351,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Extrnod/Solid Organ Sites NEC
 ;;^UTILITY(U,$J,358.3,28351,1,4,0)
 ;;=4^C84.49
 ;;^UTILITY(U,$J,358.3,28351,2)
 ;;=^5001650
 ;;^UTILITY(U,$J,358.3,28352,0)
 ;;=C77.0^^105^1379^14
 ;;^UTILITY(U,$J,358.3,28352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28352,1,3,0)
 ;;=3^Secondary malignant neoplasm of nodes of head, face and neck
 ;;^UTILITY(U,$J,358.3,28352,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,28352,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,28353,0)
 ;;=C77.1^^105^1379^9
 ;;^UTILITY(U,$J,358.3,28353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28353,1,3,0)
 ;;=3^Secondary malignant neoplasm of intrathorac nodes
 ;;^UTILITY(U,$J,358.3,28353,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,28353,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,28354,0)
 ;;=C77.2^^105^1379^7
 ;;^UTILITY(U,$J,358.3,28354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28354,1,3,0)
 ;;=3^Secondary malignant neoplasm of intra-abd nodes
 ;;^UTILITY(U,$J,358.3,28354,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,28354,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,28355,0)
 ;;=C77.3^^105^1379^1
 ;;^UTILITY(U,$J,358.3,28355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28355,1,3,0)
 ;;=3^Secondary malignant neoplasm of axilla and upper limb nodes
 ;;^UTILITY(U,$J,358.3,28355,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,28355,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,28356,0)
 ;;=C77.4^^105^1379^6
 ;;^UTILITY(U,$J,358.3,28356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28356,1,3,0)
 ;;=3^Secondary malignant neoplasm of inguinal and lower limb nodes
 ;;^UTILITY(U,$J,358.3,28356,1,4,0)
 ;;=4^C77.4
 ;;^UTILITY(U,$J,358.3,28356,2)
 ;;=^5001331
 ;;^UTILITY(U,$J,358.3,28357,0)
 ;;=C77.8^^105^1379^15
 ;;^UTILITY(U,$J,358.3,28357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28357,1,3,0)
 ;;=3^Secondary malignant neoplasm of nodes of multiple regions
 ;;^UTILITY(U,$J,358.3,28357,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,28357,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,28358,0)
 ;;=C77.9^^105^1379^13
 ;;^UTILITY(U,$J,358.3,28358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28358,1,3,0)
 ;;=3^Secondary malignant neoplasm of lymph node, unsp
 ;;^UTILITY(U,$J,358.3,28358,1,4,0)
 ;;=4^C77.9
 ;;^UTILITY(U,$J,358.3,28358,2)
 ;;=^5001333
 ;;^UTILITY(U,$J,358.3,28359,0)
 ;;=C78.01^^105^1379^18
 ;;^UTILITY(U,$J,358.3,28359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28359,1,3,0)
 ;;=3^Secondary malignant neoplasm of right lung
 ;;^UTILITY(U,$J,358.3,28359,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,28359,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,28360,0)
 ;;=C78.02^^105^1379^11
 ;;^UTILITY(U,$J,358.3,28360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28360,1,3,0)
 ;;=3^Secondary malignant neoplasm of left lung
 ;;^UTILITY(U,$J,358.3,28360,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,28360,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,28361,0)
 ;;=C78.7^^105^1379^12
 ;;^UTILITY(U,$J,358.3,28361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28361,1,3,0)
 ;;=3^Secondary malignant neoplasm of liver and intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,28361,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,28361,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,28362,0)
 ;;=C79.2^^105^1379^19
 ;;^UTILITY(U,$J,358.3,28362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28362,1,3,0)
 ;;=3^Secondary malignant neoplasm of skin
 ;;^UTILITY(U,$J,358.3,28362,1,4,0)
 ;;=4^C79.2
 ;;^UTILITY(U,$J,358.3,28362,2)
 ;;=^267333
 ;;^UTILITY(U,$J,358.3,28363,0)
 ;;=C79.31^^105^1379^4
 ;;^UTILITY(U,$J,358.3,28363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28363,1,3,0)
 ;;=3^Secondary malignant neoplasm of brain
 ;;^UTILITY(U,$J,358.3,28363,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,28363,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,28364,0)
 ;;=C79.32^^105^1379^5
 ;;^UTILITY(U,$J,358.3,28364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28364,1,3,0)
 ;;=3^Secondary malignant neoplasm of cerebral meninges
 ;;^UTILITY(U,$J,358.3,28364,1,4,0)
 ;;=4^C79.32
 ;;^UTILITY(U,$J,358.3,28364,2)
 ;;=^5001348
 ;;^UTILITY(U,$J,358.3,28365,0)
 ;;=C79.49^^105^1379^16
 ;;^UTILITY(U,$J,358.3,28365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28365,1,3,0)
 ;;=3^Secondary malignant neoplasm of oth parts of nervous system
 ;;^UTILITY(U,$J,358.3,28365,1,4,0)
 ;;=4^C79.49
 ;;^UTILITY(U,$J,358.3,28365,2)
 ;;=^267335
 ;;^UTILITY(U,$J,358.3,28366,0)
 ;;=C79.51^^105^1379^2
 ;;^UTILITY(U,$J,358.3,28366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28366,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone
 ;;^UTILITY(U,$J,358.3,28366,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,28366,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,28367,0)
 ;;=C79.52^^105^1379^3
 ;;^UTILITY(U,$J,358.3,28367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28367,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone marrow
 ;;^UTILITY(U,$J,358.3,28367,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,28367,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,28368,0)
 ;;=C79.71^^105^1379^17
 ;;^UTILITY(U,$J,358.3,28368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28368,1,3,0)
 ;;=3^Secondary malignant neoplasm of right adrenal gland
 ;;^UTILITY(U,$J,358.3,28368,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,28368,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,28369,0)
 ;;=C79.72^^105^1379^10
 ;;^UTILITY(U,$J,358.3,28369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28369,1,3,0)
 ;;=3^Secondary malignant neoplasm of left adrenal gland
 ;;^UTILITY(U,$J,358.3,28369,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,28369,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,28370,0)
 ;;=C77.5^^105^1379^8
 ;;^UTILITY(U,$J,358.3,28370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28370,1,3,0)
 ;;=3^Secondary malignant neoplasm of intrapelvic nodes
 ;;^UTILITY(U,$J,358.3,28370,1,4,0)
 ;;=4^C77.5
 ;;^UTILITY(U,$J,358.3,28370,2)
 ;;=^267319
 ;;^UTILITY(U,$J,358.3,28371,0)
 ;;=C48.2^^105^1380^24
 ;;^UTILITY(U,$J,358.3,28371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28371,1,3,0)
 ;;=3^Malignant neoplasm of peritoneum, unspecified
 ;;^UTILITY(U,$J,358.3,28371,1,4,0)
 ;;=4^C48.2
 ;;^UTILITY(U,$J,358.3,28371,2)
 ;;=^5001122
 ;;^UTILITY(U,$J,358.3,28372,0)
 ;;=C45.0^^105^1380^30
 ;;^UTILITY(U,$J,358.3,28372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28372,1,3,0)
 ;;=3^Mesothelioma of pleura
 ;;^UTILITY(U,$J,358.3,28372,1,4,0)
 ;;=4^C45.0
 ;;^UTILITY(U,$J,358.3,28372,2)
 ;;=^5001095
 ;;^UTILITY(U,$J,358.3,28373,0)
 ;;=C38.4^^105^1380^25
 ;;^UTILITY(U,$J,358.3,28373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28373,1,3,0)
 ;;=3^Malignant neoplasm of pleura
 ;;^UTILITY(U,$J,358.3,28373,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,28373,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,28374,0)
 ;;=C41.9^^105^1380^16
 ;;^UTILITY(U,$J,358.3,28374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28374,1,3,0)
 ;;=3^Malignant neoplasm of bone and articular cartilage, unsp
 ;;^UTILITY(U,$J,358.3,28374,1,4,0)
 ;;=4^C41.9
 ;;^UTILITY(U,$J,358.3,28374,2)
 ;;=^5000993
 ;;^UTILITY(U,$J,358.3,28375,0)
 ;;=C49.9^^105^1380^19
 ;;^UTILITY(U,$J,358.3,28375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28375,1,3,0)
 ;;=3^Malignant neoplasm of connective and soft tissue, unsp
 ;;^UTILITY(U,$J,358.3,28375,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,28375,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,28376,0)
 ;;=C47.9^^105^1380^14
 ;;^UTILITY(U,$J,358.3,28376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28376,1,3,0)
 ;;=3^Malig neoplasm of prph nerves and autonm nervous sys, unsp
 ;;^UTILITY(U,$J,358.3,28376,1,4,0)
 ;;=4^C47.9
 ;;^UTILITY(U,$J,358.3,28376,2)
 ;;=^5001121
 ;;^UTILITY(U,$J,358.3,28377,0)
 ;;=C43.9^^105^1380^15
 ;;^UTILITY(U,$J,358.3,28377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28377,1,3,0)
 ;;=3^Malignant melanoma of skin, unspecified
 ;;^UTILITY(U,$J,358.3,28377,1,4,0)
 ;;=4^C43.9
