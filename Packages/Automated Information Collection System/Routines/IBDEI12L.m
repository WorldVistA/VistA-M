IBDEI12L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17849,1,4,0)
 ;;=4^K85.0
 ;;^UTILITY(U,$J,358.3,17849,2)
 ;;=^5008882
 ;;^UTILITY(U,$J,358.3,17850,0)
 ;;=B25.2^^91^884^8
 ;;^UTILITY(U,$J,358.3,17850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17850,1,3,0)
 ;;=3^Cytomegaloviral pancreatitis
 ;;^UTILITY(U,$J,358.3,17850,1,4,0)
 ;;=4^B25.2
 ;;^UTILITY(U,$J,358.3,17850,2)
 ;;=^5000558
 ;;^UTILITY(U,$J,358.3,17851,0)
 ;;=K86.0^^91^884^4
 ;;^UTILITY(U,$J,358.3,17851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17851,1,3,0)
 ;;=3^Alcohol-induced chronic pancreatitis
 ;;^UTILITY(U,$J,358.3,17851,1,4,0)
 ;;=4^K86.0
 ;;^UTILITY(U,$J,358.3,17851,2)
 ;;=^5008888
 ;;^UTILITY(U,$J,358.3,17852,0)
 ;;=K86.1^^91^884^6
 ;;^UTILITY(U,$J,358.3,17852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17852,1,3,0)
 ;;=3^Chronic pancreatitis NEC
 ;;^UTILITY(U,$J,358.3,17852,1,4,0)
 ;;=4^K86.1
 ;;^UTILITY(U,$J,358.3,17852,2)
 ;;=^5008889
 ;;^UTILITY(U,$J,358.3,17853,0)
 ;;=K86.2^^91^884^7
 ;;^UTILITY(U,$J,358.3,17853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17853,1,3,0)
 ;;=3^Cyst of pancreas
 ;;^UTILITY(U,$J,358.3,17853,1,4,0)
 ;;=4^K86.2
 ;;^UTILITY(U,$J,358.3,17853,2)
 ;;=^5008890
 ;;^UTILITY(U,$J,358.3,17854,0)
 ;;=K86.3^^91^884^19
 ;;^UTILITY(U,$J,358.3,17854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17854,1,3,0)
 ;;=3^Pseudocyst of pancreas
 ;;^UTILITY(U,$J,358.3,17854,1,4,0)
 ;;=4^K86.3
 ;;^UTILITY(U,$J,358.3,17854,2)
 ;;=^5008891
 ;;^UTILITY(U,$J,358.3,17855,0)
 ;;=C25.9^^91^884^16
 ;;^UTILITY(U,$J,358.3,17855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17855,1,3,0)
 ;;=3^Malignant neoplasm of pancreas,unspec
 ;;^UTILITY(U,$J,358.3,17855,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,17855,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,17856,0)
 ;;=C25.0^^91^884^13
 ;;^UTILITY(U,$J,358.3,17856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17856,1,3,0)
 ;;=3^Malignant neoplasm of head of pancreas
 ;;^UTILITY(U,$J,358.3,17856,1,4,0)
 ;;=4^C25.0
 ;;^UTILITY(U,$J,358.3,17856,2)
 ;;=^267104
 ;;^UTILITY(U,$J,358.3,17857,0)
 ;;=C25.1^^91^884^11
 ;;^UTILITY(U,$J,358.3,17857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17857,1,3,0)
 ;;=3^Malignant neoplasm of body of pancreas
 ;;^UTILITY(U,$J,358.3,17857,1,4,0)
 ;;=4^C25.1
 ;;^UTILITY(U,$J,358.3,17857,2)
 ;;=^267105
 ;;^UTILITY(U,$J,358.3,17858,0)
 ;;=C25.2^^91^884^18
 ;;^UTILITY(U,$J,358.3,17858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17858,1,3,0)
 ;;=3^Malignant neoplasm of tail of pancreas
 ;;^UTILITY(U,$J,358.3,17858,1,4,0)
 ;;=4^C25.2
 ;;^UTILITY(U,$J,358.3,17858,2)
 ;;=^267106
 ;;^UTILITY(U,$J,358.3,17859,0)
 ;;=C25.3^^91^884^17
 ;;^UTILITY(U,$J,358.3,17859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17859,1,3,0)
 ;;=3^Malignant neoplasm of pancreatic duct
 ;;^UTILITY(U,$J,358.3,17859,1,4,0)
 ;;=4^C25.3
 ;;^UTILITY(U,$J,358.3,17859,2)
 ;;=^267107
 ;;^UTILITY(U,$J,358.3,17860,0)
 ;;=C25.4^^91^884^12
 ;;^UTILITY(U,$J,358.3,17860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17860,1,3,0)
 ;;=3^Malignant neoplasm of endocrine pancreas
 ;;^UTILITY(U,$J,358.3,17860,1,4,0)
 ;;=4^C25.4
 ;;^UTILITY(U,$J,358.3,17860,2)
 ;;=^5000943
 ;;^UTILITY(U,$J,358.3,17861,0)
 ;;=C25.7^^91^884^14
 ;;^UTILITY(U,$J,358.3,17861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17861,1,3,0)
 ;;=3^Malignant neoplasm of other parts of pancreas
 ;;^UTILITY(U,$J,358.3,17861,1,4,0)
 ;;=4^C25.7
 ;;^UTILITY(U,$J,358.3,17861,2)
 ;;=^5000944
 ;;^UTILITY(U,$J,358.3,17862,0)
 ;;=C25.8^^91^884^15
 ;;^UTILITY(U,$J,358.3,17862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17862,1,3,0)
 ;;=3^Malignant neoplasm of overlapping sites of pancreas
