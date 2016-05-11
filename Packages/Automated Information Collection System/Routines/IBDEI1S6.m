IBDEI1S6 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30258,1,4,0)
 ;;=4^C44.02
 ;;^UTILITY(U,$J,358.3,30258,2)
 ;;=^340465
 ;;^UTILITY(U,$J,358.3,30259,0)
 ;;=C44.310^^118^1504^11
 ;;^UTILITY(U,$J,358.3,30259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30259,1,3,0)
 ;;=3^Basal cell carcinoma of skin of unspecified parts of face
 ;;^UTILITY(U,$J,358.3,30259,1,4,0)
 ;;=4^C44.310
 ;;^UTILITY(U,$J,358.3,30259,2)
 ;;=^5001043
 ;;^UTILITY(U,$J,358.3,30260,0)
 ;;=C44.311^^118^1504^6
 ;;^UTILITY(U,$J,358.3,30260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30260,1,3,0)
 ;;=3^Basal cell carcinoma of skin of nose
 ;;^UTILITY(U,$J,358.3,30260,1,4,0)
 ;;=4^C44.311
 ;;^UTILITY(U,$J,358.3,30260,2)
 ;;=^5001044
 ;;^UTILITY(U,$J,358.3,30261,0)
 ;;=C44.319^^118^1504^7
 ;;^UTILITY(U,$J,358.3,30261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30261,1,3,0)
 ;;=3^Basal cell carcinoma of skin of other parts of face
 ;;^UTILITY(U,$J,358.3,30261,1,4,0)
 ;;=4^C44.319
 ;;^UTILITY(U,$J,358.3,30261,2)
 ;;=^5001045
 ;;^UTILITY(U,$J,358.3,30262,0)
 ;;=C44.320^^118^1504^42
 ;;^UTILITY(U,$J,358.3,30262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30262,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of unspecified parts of face
 ;;^UTILITY(U,$J,358.3,30262,1,4,0)
 ;;=4^C44.320
 ;;^UTILITY(U,$J,358.3,30262,2)
 ;;=^5001046
 ;;^UTILITY(U,$J,358.3,30263,0)
 ;;=C44.321^^118^1504^36
 ;;^UTILITY(U,$J,358.3,30263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30263,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of nose
 ;;^UTILITY(U,$J,358.3,30263,1,4,0)
 ;;=4^C44.321
 ;;^UTILITY(U,$J,358.3,30263,2)
 ;;=^5001047
 ;;^UTILITY(U,$J,358.3,30264,0)
 ;;=C44.329^^118^1504^37
 ;;^UTILITY(U,$J,358.3,30264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30264,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of other parts of face
 ;;^UTILITY(U,$J,358.3,30264,1,4,0)
 ;;=4^C44.329
 ;;^UTILITY(U,$J,358.3,30264,2)
 ;;=^5001048
 ;;^UTILITY(U,$J,358.3,30265,0)
 ;;=C44.41^^118^1504^10
 ;;^UTILITY(U,$J,358.3,30265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30265,1,3,0)
 ;;=3^Basal cell carcinoma of skin of scalp and neck
 ;;^UTILITY(U,$J,358.3,30265,1,4,0)
 ;;=4^C44.41
 ;;^UTILITY(U,$J,358.3,30265,2)
 ;;=^340476
 ;;^UTILITY(U,$J,358.3,30266,0)
 ;;=C44.42^^118^1504^41
 ;;^UTILITY(U,$J,358.3,30266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30266,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of scalp and neck
 ;;^UTILITY(U,$J,358.3,30266,1,4,0)
 ;;=4^C44.42
 ;;^UTILITY(U,$J,358.3,30266,2)
 ;;=^340477
 ;;^UTILITY(U,$J,358.3,30267,0)
 ;;=C44.510^^118^1504^1
 ;;^UTILITY(U,$J,358.3,30267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30267,1,3,0)
 ;;=3^Basal cell carcinoma of anal skin
 ;;^UTILITY(U,$J,358.3,30267,1,4,0)
 ;;=4^C44.510
 ;;^UTILITY(U,$J,358.3,30267,2)
 ;;=^5001054
 ;;^UTILITY(U,$J,358.3,30268,0)
 ;;=C44.511^^118^1504^2
 ;;^UTILITY(U,$J,358.3,30268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30268,1,3,0)
 ;;=3^Basal cell carcinoma of skin of breast
 ;;^UTILITY(U,$J,358.3,30268,1,4,0)
 ;;=4^C44.511
 ;;^UTILITY(U,$J,358.3,30268,2)
 ;;=^5001055
 ;;^UTILITY(U,$J,358.3,30269,0)
 ;;=C44.519^^118^1504^8
 ;;^UTILITY(U,$J,358.3,30269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30269,1,3,0)
 ;;=3^Basal cell carcinoma of skin of other part of trunk
 ;;^UTILITY(U,$J,358.3,30269,1,4,0)
 ;;=4^C44.519
 ;;^UTILITY(U,$J,358.3,30269,2)
 ;;=^5001056
 ;;^UTILITY(U,$J,358.3,30270,0)
 ;;=C44.520^^118^1504^31
 ;;^UTILITY(U,$J,358.3,30270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30270,1,3,0)
 ;;=3^Squamous cell carcinoma of anal skin
 ;;^UTILITY(U,$J,358.3,30270,1,4,0)
 ;;=4^C44.520
 ;;^UTILITY(U,$J,358.3,30270,2)
 ;;=^5001057
