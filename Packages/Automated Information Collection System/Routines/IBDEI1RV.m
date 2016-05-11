IBDEI1RV ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30122,0)
 ;;=C34.91^^118^1500^21
 ;;^UTILITY(U,$J,358.3,30122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30122,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of right bronchus or lung
 ;;^UTILITY(U,$J,358.3,30122,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,30122,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,30123,0)
 ;;=C34.92^^118^1500^20
 ;;^UTILITY(U,$J,358.3,30123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30123,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of left bronchus or lung
 ;;^UTILITY(U,$J,358.3,30123,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,30123,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,30124,0)
 ;;=C38.4^^118^1500^14
 ;;^UTILITY(U,$J,358.3,30124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30124,1,3,0)
 ;;=3^Malignant neoplasm of pleura
 ;;^UTILITY(U,$J,358.3,30124,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,30124,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,30125,0)
 ;;=C45.0^^118^1500^22
 ;;^UTILITY(U,$J,358.3,30125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30125,1,3,0)
 ;;=3^Mesothelioma of pleura
 ;;^UTILITY(U,$J,358.3,30125,1,4,0)
 ;;=4^C45.0
 ;;^UTILITY(U,$J,358.3,30125,2)
 ;;=^5001095
 ;;^UTILITY(U,$J,358.3,30126,0)
 ;;=C73.^^118^1500^16
 ;;^UTILITY(U,$J,358.3,30126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30126,1,3,0)
 ;;=3^Malignant neoplasm of thyroid gland
 ;;^UTILITY(U,$J,358.3,30126,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,30126,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,30127,0)
 ;;=C76.0^^118^1500^4
 ;;^UTILITY(U,$J,358.3,30127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30127,1,3,0)
 ;;=3^Malignant neoplasm of head, face and neck
 ;;^UTILITY(U,$J,358.3,30127,1,4,0)
 ;;=4^C76.0
 ;;^UTILITY(U,$J,358.3,30127,2)
 ;;=^5001324
 ;;^UTILITY(U,$J,358.3,30128,0)
 ;;=C05.9^^118^1500^11
 ;;^UTILITY(U,$J,358.3,30128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30128,1,3,0)
 ;;=3^Malignant neoplasm of palate,unspec
 ;;^UTILITY(U,$J,358.3,30128,1,4,0)
 ;;=4^C05.9
 ;;^UTILITY(U,$J,358.3,30128,2)
 ;;=^5000898
 ;;^UTILITY(U,$J,358.3,30129,0)
 ;;=C07.^^118^1500^12
 ;;^UTILITY(U,$J,358.3,30129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30129,1,3,0)
 ;;=3^Malignant neoplasm of parotid gland
 ;;^UTILITY(U,$J,358.3,30129,1,4,0)
 ;;=4^C07.
 ;;^UTILITY(U,$J,358.3,30129,2)
 ;;=^267005
 ;;^UTILITY(U,$J,358.3,30130,0)
 ;;=C08.9^^118^1500^7
 ;;^UTILITY(U,$J,358.3,30130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30130,1,3,0)
 ;;=3^Malignant neoplasm of major salivary gland,unspec
 ;;^UTILITY(U,$J,358.3,30130,1,4,0)
 ;;=4^C08.9
 ;;^UTILITY(U,$J,358.3,30130,2)
 ;;=^5000902
 ;;^UTILITY(U,$J,358.3,30131,0)
 ;;=C09.9^^118^1500^18
 ;;^UTILITY(U,$J,358.3,30131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30131,1,3,0)
 ;;=3^Malignant neoplasm of tonsil,unspec
 ;;^UTILITY(U,$J,358.3,30131,1,4,0)
 ;;=4^C09.9
 ;;^UTILITY(U,$J,358.3,30131,2)
 ;;=^5000905
 ;;^UTILITY(U,$J,358.3,30132,0)
 ;;=C12.^^118^1500^15
 ;;^UTILITY(U,$J,358.3,30132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30132,1,3,0)
 ;;=3^Malignant neoplasm of pyriform sinus
 ;;^UTILITY(U,$J,358.3,30132,1,4,0)
 ;;=4^C12.
 ;;^UTILITY(U,$J,358.3,30132,2)
 ;;=^267046
 ;;^UTILITY(U,$J,358.3,30133,0)
 ;;=C13.9^^118^1500^5
 ;;^UTILITY(U,$J,358.3,30133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30133,1,3,0)
 ;;=3^Malignant neoplasm of hypopharynx,unspec
 ;;^UTILITY(U,$J,358.3,30133,1,4,0)
 ;;=4^C13.9
 ;;^UTILITY(U,$J,358.3,30133,2)
 ;;=^5000915
 ;;^UTILITY(U,$J,358.3,30134,0)
 ;;=C14.0^^118^1500^13
 ;;^UTILITY(U,$J,358.3,30134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30134,1,3,0)
 ;;=3^Malignant neoplasm of pharynx,unspec
 ;;^UTILITY(U,$J,358.3,30134,1,4,0)
 ;;=4^C14.0
