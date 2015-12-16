IBDEI03P ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1199,0)
 ;;=R35.0^^3^38^20
 ;;^UTILITY(U,$J,358.3,1199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1199,1,3,0)
 ;;=3^Frequency of micturition
 ;;^UTILITY(U,$J,358.3,1199,1,4,0)
 ;;=4^R35.0
 ;;^UTILITY(U,$J,358.3,1199,2)
 ;;=^5019334
 ;;^UTILITY(U,$J,358.3,1200,0)
 ;;=R35.1^^3^38^46
 ;;^UTILITY(U,$J,358.3,1200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1200,1,3,0)
 ;;=3^Nocturia
 ;;^UTILITY(U,$J,358.3,1200,1,4,0)
 ;;=4^R35.1
 ;;^UTILITY(U,$J,358.3,1200,2)
 ;;=^5019335
 ;;^UTILITY(U,$J,358.3,1201,0)
 ;;=R39.15^^3^38^67
 ;;^UTILITY(U,$J,358.3,1201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1201,1,3,0)
 ;;=3^Urgency of urination
 ;;^UTILITY(U,$J,358.3,1201,1,4,0)
 ;;=4^R39.15
 ;;^UTILITY(U,$J,358.3,1201,2)
 ;;=^5019345
 ;;^UTILITY(U,$J,358.3,1202,0)
 ;;=R39.11^^3^38^24
 ;;^UTILITY(U,$J,358.3,1202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1202,1,3,0)
 ;;=3^Hesitancy of micturition
 ;;^UTILITY(U,$J,358.3,1202,1,4,0)
 ;;=4^R39.11
 ;;^UTILITY(U,$J,358.3,1202,2)
 ;;=^5019341
 ;;^UTILITY(U,$J,358.3,1203,0)
 ;;=R39.16^^3^38^59
 ;;^UTILITY(U,$J,358.3,1203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1203,1,3,0)
 ;;=3^Straining to void
 ;;^UTILITY(U,$J,358.3,1203,1,4,0)
 ;;=4^R39.16
 ;;^UTILITY(U,$J,358.3,1203,2)
 ;;=^5019346
 ;;^UTILITY(U,$J,358.3,1204,0)
 ;;=R36.0^^3^38^64
 ;;^UTILITY(U,$J,358.3,1204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1204,1,3,0)
 ;;=3^Urethral discharge without blood
 ;;^UTILITY(U,$J,358.3,1204,1,4,0)
 ;;=4^R36.0
 ;;^UTILITY(U,$J,358.3,1204,2)
 ;;=^5019337
 ;;^UTILITY(U,$J,358.3,1205,0)
 ;;=R36.9^^3^38^65
 ;;^UTILITY(U,$J,358.3,1205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1205,1,3,0)
 ;;=3^Urethral discharge, unspecified
 ;;^UTILITY(U,$J,358.3,1205,1,4,0)
 ;;=4^R36.9
 ;;^UTILITY(U,$J,358.3,1205,2)
 ;;=^5019338
 ;;^UTILITY(U,$J,358.3,1206,0)
 ;;=R97.2^^3^38^15
 ;;^UTILITY(U,$J,358.3,1206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1206,1,3,0)
 ;;=3^Elevated prostate specific antigen [PSA]
 ;;^UTILITY(U,$J,358.3,1206,1,4,0)
 ;;=4^R97.2
 ;;^UTILITY(U,$J,358.3,1206,2)
 ;;=^5019748
 ;;^UTILITY(U,$J,358.3,1207,0)
 ;;=R80.9^^3^38^56
 ;;^UTILITY(U,$J,358.3,1207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1207,1,3,0)
 ;;=3^Proteinuria, unspecified
 ;;^UTILITY(U,$J,358.3,1207,1,4,0)
 ;;=4^R80.9
 ;;^UTILITY(U,$J,358.3,1207,2)
 ;;=^5019599
 ;;^UTILITY(U,$J,358.3,1208,0)
 ;;=Z87.442^^3^38^52
 ;;^UTILITY(U,$J,358.3,1208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1208,1,3,0)
 ;;=3^Personal history of urinary calculi
 ;;^UTILITY(U,$J,358.3,1208,1,4,0)
 ;;=4^Z87.442
 ;;^UTILITY(U,$J,358.3,1208,2)
 ;;=^5063497
 ;;^UTILITY(U,$J,358.3,1209,0)
 ;;=C02.9^^3^39^80
 ;;^UTILITY(U,$J,358.3,1209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1209,1,3,0)
 ;;=3^Malignant neoplasm of tongue, unspecified
 ;;^UTILITY(U,$J,358.3,1209,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,1209,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,1210,0)
 ;;=C06.9^^3^39^67
 ;;^UTILITY(U,$J,358.3,1210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1210,1,3,0)
 ;;=3^Malignant neoplasm of mouth, unspecified
 ;;^UTILITY(U,$J,358.3,1210,1,4,0)
 ;;=4^C06.9
 ;;^UTILITY(U,$J,358.3,1210,2)
 ;;=^5000901
 ;;^UTILITY(U,$J,358.3,1211,0)
 ;;=C10.9^^3^39^69
 ;;^UTILITY(U,$J,358.3,1211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1211,1,3,0)
 ;;=3^Malignant neoplasm of oropharynx, unspecified
 ;;^UTILITY(U,$J,358.3,1211,1,4,0)
 ;;=4^C10.9
 ;;^UTILITY(U,$J,358.3,1211,2)
 ;;=^5000909
 ;;^UTILITY(U,$J,358.3,1212,0)
 ;;=C11.9^^3^39^68
 ;;^UTILITY(U,$J,358.3,1212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1212,1,3,0)
 ;;=3^Malignant neoplasm of nasopharynx, unspecified
