IBDEI01Y ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,361,0)
 ;;=Z12.39^^2^16^5
 ;;^UTILITY(U,$J,358.3,361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,361,1,3,0)
 ;;=3^Malig Neop of Breast Screening
 ;;^UTILITY(U,$J,358.3,361,1,4,0)
 ;;=4^Z12.39
 ;;^UTILITY(U,$J,358.3,361,2)
 ;;=^5062686
 ;;^UTILITY(U,$J,358.3,362,0)
 ;;=Z12.4^^2^16^6
 ;;^UTILITY(U,$J,358.3,362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,362,1,3,0)
 ;;=3^Malig Neop of Cervix Screening
 ;;^UTILITY(U,$J,358.3,362,1,4,0)
 ;;=4^Z12.4
 ;;^UTILITY(U,$J,358.3,362,2)
 ;;=^5062687
 ;;^UTILITY(U,$J,358.3,363,0)
 ;;=Z12.12^^2^16^7
 ;;^UTILITY(U,$J,358.3,363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,363,1,3,0)
 ;;=3^Malig Neop of Rectum Screening
 ;;^UTILITY(U,$J,358.3,363,1,4,0)
 ;;=4^Z12.12
 ;;^UTILITY(U,$J,358.3,363,2)
 ;;=^5062682
 ;;^UTILITY(U,$J,358.3,364,0)
 ;;=C61.^^2^17^11
 ;;^UTILITY(U,$J,358.3,364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,364,1,3,0)
 ;;=3^Malignant neoplasm of prostate
 ;;^UTILITY(U,$J,358.3,364,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,364,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,365,0)
 ;;=C62.11^^2^17^6
 ;;^UTILITY(U,$J,358.3,365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,365,1,3,0)
 ;;=3^Malignant neoplasm of descended right testis
 ;;^UTILITY(U,$J,358.3,365,1,4,0)
 ;;=4^C62.11
 ;;^UTILITY(U,$J,358.3,365,2)
 ;;=^5001234
 ;;^UTILITY(U,$J,358.3,366,0)
 ;;=C62.12^^2^17^5
 ;;^UTILITY(U,$J,358.3,366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,366,1,3,0)
 ;;=3^Malignant neoplasm of descended left testis
 ;;^UTILITY(U,$J,358.3,366,1,4,0)
 ;;=4^C62.12
 ;;^UTILITY(U,$J,358.3,366,2)
 ;;=^5001235
 ;;^UTILITY(U,$J,358.3,367,0)
 ;;=C62.91^^2^17^3
 ;;^UTILITY(U,$J,358.3,367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,367,1,3,0)
 ;;=3^Malig neoplasm of right testis, unsp descended or undescended
 ;;^UTILITY(U,$J,358.3,367,1,4,0)
 ;;=4^C62.91
 ;;^UTILITY(U,$J,358.3,367,2)
 ;;=^5001237
 ;;^UTILITY(U,$J,358.3,368,0)
 ;;=C62.92^^2^17^2
 ;;^UTILITY(U,$J,358.3,368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,368,1,3,0)
 ;;=3^Malig neoplasm of left testis, unsp descended or undescended
 ;;^UTILITY(U,$J,358.3,368,1,4,0)
 ;;=4^C62.92
 ;;^UTILITY(U,$J,358.3,368,2)
 ;;=^5001238
 ;;^UTILITY(U,$J,358.3,369,0)
 ;;=C60.9^^2^17^10
 ;;^UTILITY(U,$J,358.3,369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,369,1,3,0)
 ;;=3^Malignant neoplasm of penis, unspecified
 ;;^UTILITY(U,$J,358.3,369,1,4,0)
 ;;=4^C60.9
 ;;^UTILITY(U,$J,358.3,369,2)
 ;;=^5001229
 ;;^UTILITY(U,$J,358.3,370,0)
 ;;=C67.9^^2^17^4
 ;;^UTILITY(U,$J,358.3,370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,370,1,3,0)
 ;;=3^Malignant neoplasm of bladder, unspecified
 ;;^UTILITY(U,$J,358.3,370,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,370,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,371,0)
 ;;=C64.2^^2^17^7
 ;;^UTILITY(U,$J,358.3,371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,371,1,3,0)
 ;;=3^Malignant neoplasm of left kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,371,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,371,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,372,0)
 ;;=C64.1^^2^17^12
 ;;^UTILITY(U,$J,358.3,372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,372,1,3,0)
 ;;=3^Malignant neoplasm of right kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,372,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,372,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,373,0)
 ;;=C65.1^^2^17^13
 ;;^UTILITY(U,$J,358.3,373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,373,1,3,0)
 ;;=3^Malignant neoplasm of right renal pelvis
 ;;^UTILITY(U,$J,358.3,373,1,4,0)
 ;;=4^C65.1
 ;;^UTILITY(U,$J,358.3,373,2)
 ;;=^5001251
 ;;^UTILITY(U,$J,358.3,374,0)
 ;;=C65.2^^2^17^8
