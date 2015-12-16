IBDEI028 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,492,1,4,0)
 ;;=4^C77.4
 ;;^UTILITY(U,$J,358.3,492,2)
 ;;=^5001331
 ;;^UTILITY(U,$J,358.3,493,0)
 ;;=C77.8^^2^22^14
 ;;^UTILITY(U,$J,358.3,493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,493,1,3,0)
 ;;=3^Secondary malignant neoplasm of nodes of multiple regions
 ;;^UTILITY(U,$J,358.3,493,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,493,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,494,0)
 ;;=C77.9^^2^22^12
 ;;^UTILITY(U,$J,358.3,494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,494,1,3,0)
 ;;=3^Secondary malignant neoplasm of lymph node, unsp
 ;;^UTILITY(U,$J,358.3,494,1,4,0)
 ;;=4^C77.9
 ;;^UTILITY(U,$J,358.3,494,2)
 ;;=^5001333
 ;;^UTILITY(U,$J,358.3,495,0)
 ;;=C78.01^^2^22^17
 ;;^UTILITY(U,$J,358.3,495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,495,1,3,0)
 ;;=3^Secondary malignant neoplasm of right lung
 ;;^UTILITY(U,$J,358.3,495,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,495,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,496,0)
 ;;=C78.02^^2^22^10
 ;;^UTILITY(U,$J,358.3,496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,496,1,3,0)
 ;;=3^Secondary malignant neoplasm of left lung
 ;;^UTILITY(U,$J,358.3,496,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,496,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,497,0)
 ;;=C78.7^^2^22^11
 ;;^UTILITY(U,$J,358.3,497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,497,1,3,0)
 ;;=3^Secondary malignant neoplasm of liver and intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,497,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,497,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,498,0)
 ;;=C79.2^^2^22^18
 ;;^UTILITY(U,$J,358.3,498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,498,1,3,0)
 ;;=3^Secondary malignant neoplasm of skin
 ;;^UTILITY(U,$J,358.3,498,1,4,0)
 ;;=4^C79.2
 ;;^UTILITY(U,$J,358.3,498,2)
 ;;=^267333
 ;;^UTILITY(U,$J,358.3,499,0)
 ;;=C79.31^^2^22^4
 ;;^UTILITY(U,$J,358.3,499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,499,1,3,0)
 ;;=3^Secondary malignant neoplasm of brain
 ;;^UTILITY(U,$J,358.3,499,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,499,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,500,0)
 ;;=C79.32^^2^22^5
 ;;^UTILITY(U,$J,358.3,500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,500,1,3,0)
 ;;=3^Secondary malignant neoplasm of cerebral meninges
 ;;^UTILITY(U,$J,358.3,500,1,4,0)
 ;;=4^C79.32
 ;;^UTILITY(U,$J,358.3,500,2)
 ;;=^5001348
 ;;^UTILITY(U,$J,358.3,501,0)
 ;;=C79.49^^2^22^15
 ;;^UTILITY(U,$J,358.3,501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,501,1,3,0)
 ;;=3^Secondary malignant neoplasm of oth parts of nervous system
 ;;^UTILITY(U,$J,358.3,501,1,4,0)
 ;;=4^C79.49
 ;;^UTILITY(U,$J,358.3,501,2)
 ;;=^267335
 ;;^UTILITY(U,$J,358.3,502,0)
 ;;=C79.51^^2^22^2
 ;;^UTILITY(U,$J,358.3,502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,502,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone
 ;;^UTILITY(U,$J,358.3,502,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,502,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,503,0)
 ;;=C79.52^^2^22^3
 ;;^UTILITY(U,$J,358.3,503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,503,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone marrow
 ;;^UTILITY(U,$J,358.3,503,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,503,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,504,0)
 ;;=C79.71^^2^22^16
 ;;^UTILITY(U,$J,358.3,504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,504,1,3,0)
 ;;=3^Secondary malignant neoplasm of right adrenal gland
 ;;^UTILITY(U,$J,358.3,504,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,504,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,505,0)
 ;;=C79.72^^2^22^9
 ;;^UTILITY(U,$J,358.3,505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,505,1,3,0)
 ;;=3^Secondary malignant neoplasm of left adrenal gland
