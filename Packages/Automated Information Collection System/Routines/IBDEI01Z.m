IBDEI01Z ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,374,1,3,0)
 ;;=3^Malignant neoplasm of left renal pelvis
 ;;^UTILITY(U,$J,358.3,374,1,4,0)
 ;;=4^C65.2
 ;;^UTILITY(U,$J,358.3,374,2)
 ;;=^5001252
 ;;^UTILITY(U,$J,358.3,375,0)
 ;;=C66.1^^2^17^14
 ;;^UTILITY(U,$J,358.3,375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,375,1,3,0)
 ;;=3^Malignant neoplasm of right ureter
 ;;^UTILITY(U,$J,358.3,375,1,4,0)
 ;;=4^C66.1
 ;;^UTILITY(U,$J,358.3,375,2)
 ;;=^5001254
 ;;^UTILITY(U,$J,358.3,376,0)
 ;;=C66.2^^2^17^9
 ;;^UTILITY(U,$J,358.3,376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,376,1,3,0)
 ;;=3^Malignant neoplasm of left ureter
 ;;^UTILITY(U,$J,358.3,376,1,4,0)
 ;;=4^C66.2
 ;;^UTILITY(U,$J,358.3,376,2)
 ;;=^5001255
 ;;^UTILITY(U,$J,358.3,377,0)
 ;;=C68.0^^2^17^15
 ;;^UTILITY(U,$J,358.3,377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,377,1,3,0)
 ;;=3^Malignant neoplasm of urethra
 ;;^UTILITY(U,$J,358.3,377,1,4,0)
 ;;=4^C68.0
 ;;^UTILITY(U,$J,358.3,377,2)
 ;;=^267266
 ;;^UTILITY(U,$J,358.3,378,0)
 ;;=D09.0^^2^17^1
 ;;^UTILITY(U,$J,358.3,378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,378,1,3,0)
 ;;=3^Carcinoma in situ of bladder
 ;;^UTILITY(U,$J,358.3,378,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,378,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,379,0)
 ;;=C15.9^^2^18^8
 ;;^UTILITY(U,$J,358.3,379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,379,1,3,0)
 ;;=3^Malignant neoplasm of esophagus, unspecified
 ;;^UTILITY(U,$J,358.3,379,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,379,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,380,0)
 ;;=C16.9^^2^18^15
 ;;^UTILITY(U,$J,358.3,380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,380,1,3,0)
 ;;=3^Malignant neoplasm of stomach, unspecified
 ;;^UTILITY(U,$J,358.3,380,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,380,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,381,0)
 ;;=C17.9^^2^18^14
 ;;^UTILITY(U,$J,358.3,381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,381,1,3,0)
 ;;=3^Malignant neoplasm of small intestine, unspecified
 ;;^UTILITY(U,$J,358.3,381,1,4,0)
 ;;=4^C17.9
 ;;^UTILITY(U,$J,358.3,381,2)
 ;;=^5000926
 ;;^UTILITY(U,$J,358.3,382,0)
 ;;=C18.9^^2^18^7
 ;;^UTILITY(U,$J,358.3,382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,382,1,3,0)
 ;;=3^Malignant neoplasm of colon, unspecified
 ;;^UTILITY(U,$J,358.3,382,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,382,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,383,0)
 ;;=C20.^^2^18^13
 ;;^UTILITY(U,$J,358.3,383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,383,1,3,0)
 ;;=3^Malignant neoplasm of rectum
 ;;^UTILITY(U,$J,358.3,383,1,4,0)
 ;;=4^C20.
 ;;^UTILITY(U,$J,358.3,383,2)
 ;;=^267090
 ;;^UTILITY(U,$J,358.3,384,0)
 ;;=C21.0^^2^18^6
 ;;^UTILITY(U,$J,358.3,384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,384,1,3,0)
 ;;=3^Malignant neoplasm of anus, unspecified
 ;;^UTILITY(U,$J,358.3,384,1,4,0)
 ;;=4^C21.0
 ;;^UTILITY(U,$J,358.3,384,2)
 ;;=^5000930
 ;;^UTILITY(U,$J,358.3,385,0)
 ;;=C22.8^^2^18^11
 ;;^UTILITY(U,$J,358.3,385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,385,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary, unspecified as to type
 ;;^UTILITY(U,$J,358.3,385,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,385,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,386,0)
 ;;=C22.7^^2^18^2
 ;;^UTILITY(U,$J,358.3,386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,386,1,3,0)
 ;;=3^Carcinomas of Liver NEC
 ;;^UTILITY(U,$J,358.3,386,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,386,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,387,0)
 ;;=C22.2^^2^18^3
 ;;^UTILITY(U,$J,358.3,387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,387,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,387,1,4,0)
 ;;=4^C22.2
