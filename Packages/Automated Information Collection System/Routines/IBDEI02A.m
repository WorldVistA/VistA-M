IBDEI02A ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,518,1,4,0)
 ;;=4^C44.211
 ;;^UTILITY(U,$J,358.3,518,2)
 ;;=^5001031
 ;;^UTILITY(U,$J,358.3,519,0)
 ;;=C44.221^^2^23^37
 ;;^UTILITY(U,$J,358.3,519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,519,1,3,0)
 ;;=3^Squamous cell carcinoma skin/ unsp ear and extrn auric canal
 ;;^UTILITY(U,$J,358.3,519,1,4,0)
 ;;=4^C44.221
 ;;^UTILITY(U,$J,358.3,519,2)
 ;;=^5001034
 ;;^UTILITY(U,$J,358.3,520,0)
 ;;=C44.310^^2^23^8
 ;;^UTILITY(U,$J,358.3,520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,520,1,3,0)
 ;;=3^Basal cell carcinoma of skin of unspecified parts of face
 ;;^UTILITY(U,$J,358.3,520,1,4,0)
 ;;=4^C44.310
 ;;^UTILITY(U,$J,358.3,520,2)
 ;;=^5001043
 ;;^UTILITY(U,$J,358.3,521,0)
 ;;=C44.311^^2^23^4
 ;;^UTILITY(U,$J,358.3,521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,521,1,3,0)
 ;;=3^Basal cell carcinoma of skin of nose
 ;;^UTILITY(U,$J,358.3,521,1,4,0)
 ;;=4^C44.311
 ;;^UTILITY(U,$J,358.3,521,2)
 ;;=^5001044
 ;;^UTILITY(U,$J,358.3,522,0)
 ;;=C44.319^^2^23^5
 ;;^UTILITY(U,$J,358.3,522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,522,1,3,0)
 ;;=3^Basal cell carcinoma of skin of other parts of face
 ;;^UTILITY(U,$J,358.3,522,1,4,0)
 ;;=4^C44.319
 ;;^UTILITY(U,$J,358.3,522,2)
 ;;=^5001045
 ;;^UTILITY(U,$J,358.3,523,0)
 ;;=C44.320^^2^23^36
 ;;^UTILITY(U,$J,358.3,523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,523,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of unspecified parts of face
 ;;^UTILITY(U,$J,358.3,523,1,4,0)
 ;;=4^C44.320
 ;;^UTILITY(U,$J,358.3,523,2)
 ;;=^5001046
 ;;^UTILITY(U,$J,358.3,524,0)
 ;;=C44.321^^2^23^32
 ;;^UTILITY(U,$J,358.3,524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,524,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of nose
 ;;^UTILITY(U,$J,358.3,524,1,4,0)
 ;;=4^C44.321
 ;;^UTILITY(U,$J,358.3,524,2)
 ;;=^5001047
 ;;^UTILITY(U,$J,358.3,525,0)
 ;;=C44.329^^2^23^33
 ;;^UTILITY(U,$J,358.3,525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,525,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of other parts of face
 ;;^UTILITY(U,$J,358.3,525,1,4,0)
 ;;=4^C44.329
 ;;^UTILITY(U,$J,358.3,525,2)
 ;;=^5001048
 ;;^UTILITY(U,$J,358.3,526,0)
 ;;=C44.41^^2^23^7
 ;;^UTILITY(U,$J,358.3,526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,526,1,3,0)
 ;;=3^Basal cell carcinoma of skin of scalp and neck
 ;;^UTILITY(U,$J,358.3,526,1,4,0)
 ;;=4^C44.41
 ;;^UTILITY(U,$J,358.3,526,2)
 ;;=^340476
 ;;^UTILITY(U,$J,358.3,527,0)
 ;;=C44.42^^2^23^35
 ;;^UTILITY(U,$J,358.3,527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,527,1,3,0)
 ;;=3^Squamous cell carcinoma of skin of scalp and neck
 ;;^UTILITY(U,$J,358.3,527,1,4,0)
 ;;=4^C44.42
 ;;^UTILITY(U,$J,358.3,527,2)
 ;;=^340477
 ;;^UTILITY(U,$J,358.3,528,0)
 ;;=C44.510^^2^23^1
 ;;^UTILITY(U,$J,358.3,528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,528,1,3,0)
 ;;=3^Basal cell carcinoma of anal skin
 ;;^UTILITY(U,$J,358.3,528,1,4,0)
 ;;=4^C44.510
 ;;^UTILITY(U,$J,358.3,528,2)
 ;;=^5001054
 ;;^UTILITY(U,$J,358.3,529,0)
 ;;=C44.511^^2^23^2
 ;;^UTILITY(U,$J,358.3,529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,529,1,3,0)
 ;;=3^Basal cell carcinoma of skin of breast
 ;;^UTILITY(U,$J,358.3,529,1,4,0)
 ;;=4^C44.511
 ;;^UTILITY(U,$J,358.3,529,2)
 ;;=^5001055
 ;;^UTILITY(U,$J,358.3,530,0)
 ;;=C44.519^^2^23^6
 ;;^UTILITY(U,$J,358.3,530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,530,1,3,0)
 ;;=3^Basal cell carcinoma of skin of other part of trunk
 ;;^UTILITY(U,$J,358.3,530,1,4,0)
 ;;=4^C44.519
 ;;^UTILITY(U,$J,358.3,530,2)
 ;;=^5001056
 ;;^UTILITY(U,$J,358.3,531,0)
 ;;=C44.520^^2^23^29
 ;;^UTILITY(U,$J,358.3,531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,531,1,3,0)
 ;;=3^Squamous cell carcinoma of anal skin
