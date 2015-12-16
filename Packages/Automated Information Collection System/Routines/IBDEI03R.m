IBDEI03R ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1226,1,3,0)
 ;;=3^Malignant neoplasm of extrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,1226,1,4,0)
 ;;=4^C24.0
 ;;^UTILITY(U,$J,358.3,1226,2)
 ;;=^5000940
 ;;^UTILITY(U,$J,358.3,1227,0)
 ;;=C24.1^^3^39^50
 ;;^UTILITY(U,$J,358.3,1227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1227,1,3,0)
 ;;=3^Malignant neoplasm of ampulla of Vater
 ;;^UTILITY(U,$J,358.3,1227,1,4,0)
 ;;=4^C24.1
 ;;^UTILITY(U,$J,358.3,1227,2)
 ;;=^267100
 ;;^UTILITY(U,$J,358.3,1228,0)
 ;;=C25.9^^3^39^70
 ;;^UTILITY(U,$J,358.3,1228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1228,1,3,0)
 ;;=3^Malignant neoplasm of pancreas, unspecified
 ;;^UTILITY(U,$J,358.3,1228,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,1228,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,1229,0)
 ;;=C31.9^^3^39^49
 ;;^UTILITY(U,$J,358.3,1229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1229,1,3,0)
 ;;=3^Malignant neoplasm of accessory sinus, unspecified
 ;;^UTILITY(U,$J,358.3,1229,1,4,0)
 ;;=4^C31.9
 ;;^UTILITY(U,$J,358.3,1229,2)
 ;;=^5000953
 ;;^UTILITY(U,$J,358.3,1230,0)
 ;;=C32.9^^3^39^62
 ;;^UTILITY(U,$J,358.3,1230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1230,1,3,0)
 ;;=3^Malignant neoplasm of larynx, unspecified
 ;;^UTILITY(U,$J,358.3,1230,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,1230,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,1231,0)
 ;;=C34.91^^3^39^82
 ;;^UTILITY(U,$J,358.3,1231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1231,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of right bronchus or lung
 ;;^UTILITY(U,$J,358.3,1231,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,1231,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,1232,0)
 ;;=C34.92^^3^39^81
 ;;^UTILITY(U,$J,358.3,1232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1232,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of left bronchus or lung
 ;;^UTILITY(U,$J,358.3,1232,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,1232,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,1233,0)
 ;;=C38.4^^3^39^71
 ;;^UTILITY(U,$J,358.3,1233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1233,1,3,0)
 ;;=3^Malignant neoplasm of pleura
 ;;^UTILITY(U,$J,358.3,1233,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,1233,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,1234,0)
 ;;=C45.0^^3^39^86
 ;;^UTILITY(U,$J,358.3,1234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1234,1,3,0)
 ;;=3^Mesothelioma of pleura
 ;;^UTILITY(U,$J,358.3,1234,1,4,0)
 ;;=4^C45.0
 ;;^UTILITY(U,$J,358.3,1234,2)
 ;;=^5001095
 ;;^UTILITY(U,$J,358.3,1235,0)
 ;;=C49.9^^3^39^55
 ;;^UTILITY(U,$J,358.3,1235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1235,1,3,0)
 ;;=3^Malignant neoplasm of connective and soft tissue, unsp
 ;;^UTILITY(U,$J,358.3,1235,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,1235,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,1236,0)
 ;;=C43.9^^3^39^48
 ;;^UTILITY(U,$J,358.3,1236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1236,1,3,0)
 ;;=3^Malignant melanoma of skin, unspecified
 ;;^UTILITY(U,$J,358.3,1236,1,4,0)
 ;;=4^C43.9
 ;;^UTILITY(U,$J,358.3,1236,2)
 ;;=^5001015
 ;;^UTILITY(U,$J,358.3,1237,0)
 ;;=D03.9^^3^39^85
 ;;^UTILITY(U,$J,358.3,1237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1237,1,3,0)
 ;;=3^Melanoma in situ, unspecified
 ;;^UTILITY(U,$J,358.3,1237,1,4,0)
 ;;=4^D03.9
 ;;^UTILITY(U,$J,358.3,1237,2)
 ;;=^5001908
 ;;^UTILITY(U,$J,358.3,1238,0)
 ;;=C50.911^^3^39^84
 ;;^UTILITY(U,$J,358.3,1238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1238,1,3,0)
 ;;=3^Malignant neoplasm of unsp site of right female breast
 ;;^UTILITY(U,$J,358.3,1238,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,1238,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,1239,0)
 ;;=C50.912^^3^39^83
