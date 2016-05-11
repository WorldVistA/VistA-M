IBDEI1RU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30109,1,3,0)
 ;;=3^Malignant neoplasm of pancreas, unspecified
 ;;^UTILITY(U,$J,358.3,30109,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,30109,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,30110,0)
 ;;=C19.^^118^1499^15
 ;;^UTILITY(U,$J,358.3,30110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30110,1,3,0)
 ;;=3^Malignant neoplasm of rectosigmoid junction
 ;;^UTILITY(U,$J,358.3,30110,1,4,0)
 ;;=4^C19.
 ;;^UTILITY(U,$J,358.3,30110,2)
 ;;=^267089
 ;;^UTILITY(U,$J,358.3,30111,0)
 ;;=C24.8^^118^1499^13
 ;;^UTILITY(U,$J,358.3,30111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30111,1,3,0)
 ;;=3^Malignant neoplasm of overlapping sites of biliary tract
 ;;^UTILITY(U,$J,358.3,30111,1,4,0)
 ;;=4^C24.8
 ;;^UTILITY(U,$J,358.3,30111,2)
 ;;=^5000941
 ;;^UTILITY(U,$J,358.3,30112,0)
 ;;=C24.9^^118^1499^7
 ;;^UTILITY(U,$J,358.3,30112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30112,1,3,0)
 ;;=3^Malignant neoplasm of biliary tract,unspec
 ;;^UTILITY(U,$J,358.3,30112,1,4,0)
 ;;=4^C24.9
 ;;^UTILITY(U,$J,358.3,30112,2)
 ;;=^5000942
 ;;^UTILITY(U,$J,358.3,30113,0)
 ;;=C01.^^118^1500^2
 ;;^UTILITY(U,$J,358.3,30113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30113,1,3,0)
 ;;=3^Malignant neoplasm of base of tongue
 ;;^UTILITY(U,$J,358.3,30113,1,4,0)
 ;;=4^C01.
 ;;^UTILITY(U,$J,358.3,30113,2)
 ;;=^266996
 ;;^UTILITY(U,$J,358.3,30114,0)
 ;;=C02.9^^118^1500^17
 ;;^UTILITY(U,$J,358.3,30114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30114,1,3,0)
 ;;=3^Malignant neoplasm of tongue, unspecified
 ;;^UTILITY(U,$J,358.3,30114,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,30114,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,30115,0)
 ;;=C04.9^^118^1500^3
 ;;^UTILITY(U,$J,358.3,30115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30115,1,3,0)
 ;;=3^Malignant neoplasm of floor of mouth, unspecified
 ;;^UTILITY(U,$J,358.3,30115,1,4,0)
 ;;=4^C04.9
 ;;^UTILITY(U,$J,358.3,30115,2)
 ;;=^5000896
 ;;^UTILITY(U,$J,358.3,30116,0)
 ;;=C06.9^^118^1500^8
 ;;^UTILITY(U,$J,358.3,30116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30116,1,3,0)
 ;;=3^Malignant neoplasm of mouth, unspecified
 ;;^UTILITY(U,$J,358.3,30116,1,4,0)
 ;;=4^C06.9
 ;;^UTILITY(U,$J,358.3,30116,2)
 ;;=^5000901
 ;;^UTILITY(U,$J,358.3,30117,0)
 ;;=C10.9^^118^1500^10
 ;;^UTILITY(U,$J,358.3,30117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30117,1,3,0)
 ;;=3^Malignant neoplasm of oropharynx, unspecified
 ;;^UTILITY(U,$J,358.3,30117,1,4,0)
 ;;=4^C10.9
 ;;^UTILITY(U,$J,358.3,30117,2)
 ;;=^5000909
 ;;^UTILITY(U,$J,358.3,30118,0)
 ;;=C11.9^^118^1500^9
 ;;^UTILITY(U,$J,358.3,30118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30118,1,3,0)
 ;;=3^Malignant neoplasm of nasopharynx, unspecified
 ;;^UTILITY(U,$J,358.3,30118,1,4,0)
 ;;=4^C11.9
 ;;^UTILITY(U,$J,358.3,30118,2)
 ;;=^5000911
 ;;^UTILITY(U,$J,358.3,30119,0)
 ;;=C31.9^^118^1500^1
 ;;^UTILITY(U,$J,358.3,30119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30119,1,3,0)
 ;;=3^Malignant neoplasm of accessory sinus, unspecified
 ;;^UTILITY(U,$J,358.3,30119,1,4,0)
 ;;=4^C31.9
 ;;^UTILITY(U,$J,358.3,30119,2)
 ;;=^5000953
 ;;^UTILITY(U,$J,358.3,30120,0)
 ;;=C32.9^^118^1500^6
 ;;^UTILITY(U,$J,358.3,30120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30120,1,3,0)
 ;;=3^Malignant neoplasm of larynx, unspecified
 ;;^UTILITY(U,$J,358.3,30120,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,30120,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,30121,0)
 ;;=C33.^^118^1500^19
 ;;^UTILITY(U,$J,358.3,30121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30121,1,3,0)
 ;;=3^Malignant neoplasm of trachea
 ;;^UTILITY(U,$J,358.3,30121,1,4,0)
 ;;=4^C33.
 ;;^UTILITY(U,$J,358.3,30121,2)
 ;;=^267135
