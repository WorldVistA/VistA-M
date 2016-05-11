IBDEI0IB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8498,2)
 ;;=^267023
 ;;^UTILITY(U,$J,358.3,8499,0)
 ;;=C06.9^^39^460^20
 ;;^UTILITY(U,$J,358.3,8499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8499,1,3,0)
 ;;=3^Malignant neoplasm of mouth, unspecified
 ;;^UTILITY(U,$J,358.3,8499,1,4,0)
 ;;=4^C06.9
 ;;^UTILITY(U,$J,358.3,8499,2)
 ;;=^5000901
 ;;^UTILITY(U,$J,358.3,8500,0)
 ;;=C09.9^^39^460^31
 ;;^UTILITY(U,$J,358.3,8500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8500,1,3,0)
 ;;=3^Malignant neoplasm of tonsil, unspecified
 ;;^UTILITY(U,$J,358.3,8500,1,4,0)
 ;;=4^C09.9
 ;;^UTILITY(U,$J,358.3,8500,2)
 ;;=^5000905
 ;;^UTILITY(U,$J,358.3,8501,0)
 ;;=C10.9^^39^460^23
 ;;^UTILITY(U,$J,358.3,8501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8501,1,3,0)
 ;;=3^Malignant neoplasm of oropharynx, unspecified
 ;;^UTILITY(U,$J,358.3,8501,1,4,0)
 ;;=4^C10.9
 ;;^UTILITY(U,$J,358.3,8501,2)
 ;;=^5000909
 ;;^UTILITY(U,$J,358.3,8502,0)
 ;;=C11.9^^39^460^22
 ;;^UTILITY(U,$J,358.3,8502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8502,1,3,0)
 ;;=3^Malignant neoplasm of nasopharynx, unspecified
 ;;^UTILITY(U,$J,358.3,8502,1,4,0)
 ;;=4^C11.9
 ;;^UTILITY(U,$J,358.3,8502,2)
 ;;=^5000911
 ;;^UTILITY(U,$J,358.3,8503,0)
 ;;=C12.^^39^460^25
 ;;^UTILITY(U,$J,358.3,8503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8503,1,3,0)
 ;;=3^Malignant neoplasm of pyriform sinus
 ;;^UTILITY(U,$J,358.3,8503,1,4,0)
 ;;=4^C12.
 ;;^UTILITY(U,$J,358.3,8503,2)
 ;;=^267046
 ;;^UTILITY(U,$J,358.3,8504,0)
 ;;=C13.9^^39^460^18
 ;;^UTILITY(U,$J,358.3,8504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8504,1,3,0)
 ;;=3^Malignant neoplasm of hypopharynx, unspecified
 ;;^UTILITY(U,$J,358.3,8504,1,4,0)
 ;;=4^C13.9
 ;;^UTILITY(U,$J,358.3,8504,2)
 ;;=^5000915
 ;;^UTILITY(U,$J,358.3,8505,0)
 ;;=C30.0^^39^460^21
 ;;^UTILITY(U,$J,358.3,8505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8505,1,3,0)
 ;;=3^Malignant neoplasm of nasal cavity
 ;;^UTILITY(U,$J,358.3,8505,1,4,0)
 ;;=4^C30.0
 ;;^UTILITY(U,$J,358.3,8505,2)
 ;;=^5000949
 ;;^UTILITY(U,$J,358.3,8506,0)
 ;;=C31.9^^39^460^12
 ;;^UTILITY(U,$J,358.3,8506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8506,1,3,0)
 ;;=3^Malignant neoplasm of accessory sinus, unspecified
 ;;^UTILITY(U,$J,358.3,8506,1,4,0)
 ;;=4^C31.9
 ;;^UTILITY(U,$J,358.3,8506,2)
 ;;=^5000953
 ;;^UTILITY(U,$J,358.3,8507,0)
 ;;=C32.0^^39^460^15
 ;;^UTILITY(U,$J,358.3,8507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8507,1,3,0)
 ;;=3^Malignant neoplasm of glottis
 ;;^UTILITY(U,$J,358.3,8507,1,4,0)
 ;;=4^C32.0
 ;;^UTILITY(U,$J,358.3,8507,2)
 ;;=^267129
 ;;^UTILITY(U,$J,358.3,8508,0)
 ;;=C32.1^^39^460^28
 ;;^UTILITY(U,$J,358.3,8508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8508,1,3,0)
 ;;=3^Malignant neoplasm of supraglottis
 ;;^UTILITY(U,$J,358.3,8508,1,4,0)
 ;;=4^C32.1
 ;;^UTILITY(U,$J,358.3,8508,2)
 ;;=^267130
 ;;^UTILITY(U,$J,358.3,8509,0)
 ;;=C32.2^^39^460^26
 ;;^UTILITY(U,$J,358.3,8509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8509,1,3,0)
 ;;=3^Malignant neoplasm of subglottis
 ;;^UTILITY(U,$J,358.3,8509,1,4,0)
 ;;=4^C32.2
 ;;^UTILITY(U,$J,358.3,8509,2)
 ;;=^267131
 ;;^UTILITY(U,$J,358.3,8510,0)
 ;;=C44.212^^39^460^3
 ;;^UTILITY(U,$J,358.3,8510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8510,1,3,0)
 ;;=3^BC CA Skin RIGHT Ear and EAC
 ;;^UTILITY(U,$J,358.3,8510,1,4,0)
 ;;=4^C44.212
 ;;^UTILITY(U,$J,358.3,8510,2)
 ;;=^5001032
 ;;^UTILITY(U,$J,358.3,8511,0)
 ;;=C44.219^^39^460^2
 ;;^UTILITY(U,$J,358.3,8511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8511,1,3,0)
 ;;=3^BC CA Skin LEFT Ear and EAC
 ;;^UTILITY(U,$J,358.3,8511,1,4,0)
 ;;=4^C44.219
 ;;^UTILITY(U,$J,358.3,8511,2)
 ;;=^5001033
