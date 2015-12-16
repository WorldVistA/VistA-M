IBDEI021 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,401,1,3,0)
 ;;=3^Malignant neoplasm of accessory sinus, unspecified
 ;;^UTILITY(U,$J,358.3,401,1,4,0)
 ;;=4^C31.9
 ;;^UTILITY(U,$J,358.3,401,2)
 ;;=^5000953
 ;;^UTILITY(U,$J,358.3,402,0)
 ;;=C32.9^^2^19^5
 ;;^UTILITY(U,$J,358.3,402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,402,1,3,0)
 ;;=3^Malignant neoplasm of larynx, unspecified
 ;;^UTILITY(U,$J,358.3,402,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,402,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,403,0)
 ;;=C33.^^2^19^12
 ;;^UTILITY(U,$J,358.3,403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,403,1,3,0)
 ;;=3^Malignant neoplasm of trachea
 ;;^UTILITY(U,$J,358.3,403,1,4,0)
 ;;=4^C33.
 ;;^UTILITY(U,$J,358.3,403,2)
 ;;=^267135
 ;;^UTILITY(U,$J,358.3,404,0)
 ;;=C34.91^^2^19^14
 ;;^UTILITY(U,$J,358.3,404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,404,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of right bronchus or lung
 ;;^UTILITY(U,$J,358.3,404,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,404,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,405,0)
 ;;=C34.92^^2^19^13
 ;;^UTILITY(U,$J,358.3,405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,405,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of left bronchus or lung
 ;;^UTILITY(U,$J,358.3,405,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,405,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,406,0)
 ;;=C38.4^^2^19^9
 ;;^UTILITY(U,$J,358.3,406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,406,1,3,0)
 ;;=3^Malignant neoplasm of pleura
 ;;^UTILITY(U,$J,358.3,406,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,406,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,407,0)
 ;;=C45.0^^2^19^15
 ;;^UTILITY(U,$J,358.3,407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,407,1,3,0)
 ;;=3^Mesothelioma of pleura
 ;;^UTILITY(U,$J,358.3,407,1,4,0)
 ;;=4^C45.0
 ;;^UTILITY(U,$J,358.3,407,2)
 ;;=^5001095
 ;;^UTILITY(U,$J,358.3,408,0)
 ;;=C73.^^2^19^10
 ;;^UTILITY(U,$J,358.3,408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,408,1,3,0)
 ;;=3^Malignant neoplasm of thyroid gland
 ;;^UTILITY(U,$J,358.3,408,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,408,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,409,0)
 ;;=C76.0^^2^19^4
 ;;^UTILITY(U,$J,358.3,409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,409,1,3,0)
 ;;=3^Malignant neoplasm of head, face and neck
 ;;^UTILITY(U,$J,358.3,409,1,4,0)
 ;;=4^C76.0
 ;;^UTILITY(U,$J,358.3,409,2)
 ;;=^5001324
 ;;^UTILITY(U,$J,358.3,410,0)
 ;;=D57.40^^2^20^15
 ;;^UTILITY(U,$J,358.3,410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,410,1,3,0)
 ;;=3^Sickle-cell thalassemia without crisis
 ;;^UTILITY(U,$J,358.3,410,1,4,0)
 ;;=4^D57.40
 ;;^UTILITY(U,$J,358.3,410,2)
 ;;=^329908
 ;;^UTILITY(U,$J,358.3,411,0)
 ;;=D57.419^^2^20^14
 ;;^UTILITY(U,$J,358.3,411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,411,1,3,0)
 ;;=3^Sickle-cell thalassemia with crisis, unspecified
 ;;^UTILITY(U,$J,358.3,411,1,4,0)
 ;;=4^D57.419
 ;;^UTILITY(U,$J,358.3,411,2)
 ;;=^5002316
 ;;^UTILITY(U,$J,358.3,412,0)
 ;;=D56.0^^2^20^1
 ;;^UTILITY(U,$J,358.3,412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,412,1,3,0)
 ;;=3^Alpha thalassemia
 ;;^UTILITY(U,$J,358.3,412,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,412,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,413,0)
 ;;=D56.1^^2^20^2
 ;;^UTILITY(U,$J,358.3,413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,413,1,3,0)
 ;;=3^Beta thalassemia
 ;;^UTILITY(U,$J,358.3,413,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,413,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,414,0)
 ;;=D56.2^^2^20^3
 ;;^UTILITY(U,$J,358.3,414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,414,1,3,0)
 ;;=3^Delta-beta thalassemia
 ;;^UTILITY(U,$J,358.3,414,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,414,2)
 ;;=^340496
