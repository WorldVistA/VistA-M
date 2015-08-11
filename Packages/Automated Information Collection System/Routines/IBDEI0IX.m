IBDEI0IX ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9186,0)
 ;;=153.3^^55^613^28
 ;;^UTILITY(U,$J,358.3,9186,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9186,1,4,0)
 ;;=4^CA of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,9186,1,5,0)
 ;;=5^153.3
 ;;^UTILITY(U,$J,358.3,9186,2)
 ;;=Ca of Sigmoid Colon^267082
 ;;^UTILITY(U,$J,358.3,9187,0)
 ;;=153.1^^55^613^37
 ;;^UTILITY(U,$J,358.3,9187,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9187,1,4,0)
 ;;=4^CA of Transverse Colon
 ;;^UTILITY(U,$J,358.3,9187,1,5,0)
 ;;=5^153.1
 ;;^UTILITY(U,$J,358.3,9187,2)
 ;;=CA of Transverse Colon^267080
 ;;^UTILITY(U,$J,358.3,9188,0)
 ;;=153.0^^55^613^11
 ;;^UTILITY(U,$J,358.3,9188,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9188,1,4,0)
 ;;=4^CA of Colon, Hepatic Flexure.
 ;;^UTILITY(U,$J,358.3,9188,1,5,0)
 ;;=5^153.0
 ;;^UTILITY(U,$J,358.3,9188,2)
 ;;=CA of Colon at Hepatic Flexure^267079
 ;;^UTILITY(U,$J,358.3,9189,0)
 ;;=153.7^^55^613^10
 ;;^UTILITY(U,$J,358.3,9189,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9189,1,4,0)
 ;;=4^CA of Colon at Splenic Flexure
 ;;^UTILITY(U,$J,358.3,9189,1,5,0)
 ;;=5^153.7
 ;;^UTILITY(U,$J,358.3,9189,2)
 ;;=CA of Colon at Splenic Flexure^267086
 ;;^UTILITY(U,$J,358.3,9190,0)
 ;;=151.9^^55^613^29
 ;;^UTILITY(U,$J,358.3,9190,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9190,1,4,0)
 ;;=4^CA of Stomach
 ;;^UTILITY(U,$J,358.3,9190,1,5,0)
 ;;=5^151.9
 ;;^UTILITY(U,$J,358.3,9190,2)
 ;;=CA of Stomach^73532
 ;;^UTILITY(U,$J,358.3,9191,0)
 ;;=151.2^^55^613^4
 ;;^UTILITY(U,$J,358.3,9191,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9191,1,4,0)
 ;;=4^CA of Antrum of Stomach
 ;;^UTILITY(U,$J,358.3,9191,1,5,0)
 ;;=5^151.2
 ;;^UTILITY(U,$J,358.3,9191,2)
 ;;=CA of Antrum of Stomach^267065
 ;;^UTILITY(U,$J,358.3,9192,0)
 ;;=151.4^^55^613^30
 ;;^UTILITY(U,$J,358.3,9192,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9192,1,4,0)
 ;;=4^CA of Stomach Body
 ;;^UTILITY(U,$J,358.3,9192,1,5,0)
 ;;=5^151.4
 ;;^UTILITY(U,$J,358.3,9192,2)
 ;;=CA of Stomach Body^267067
 ;;^UTILITY(U,$J,358.3,9193,0)
 ;;=151.0^^55^613^31
 ;;^UTILITY(U,$J,358.3,9193,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9193,1,4,0)
 ;;=4^CA of Stomach Cardia
 ;;^UTILITY(U,$J,358.3,9193,1,5,0)
 ;;=5^151.0
 ;;^UTILITY(U,$J,358.3,9193,2)
 ;;=CA of Stomach Cardia^267063
 ;;^UTILITY(U,$J,358.3,9194,0)
 ;;=151.3^^55^613^32
 ;;^UTILITY(U,$J,358.3,9194,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9194,1,4,0)
 ;;=4^CA of Stomach Fundus
 ;;^UTILITY(U,$J,358.3,9194,1,5,0)
 ;;=5^151.3
 ;;^UTILITY(U,$J,358.3,9194,2)
 ;;=CA of Fundus of Stomach^267066
 ;;^UTILITY(U,$J,358.3,9195,0)
 ;;=151.6^^55^613^33
 ;;^UTILITY(U,$J,358.3,9195,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9195,1,4,0)
 ;;=4^CA of Stomach Great Curve
 ;;^UTILITY(U,$J,358.3,9195,1,5,0)
 ;;=5^151.6
 ;;^UTILITY(U,$J,358.3,9195,2)
 ;;=^267069
 ;;^UTILITY(U,$J,358.3,9196,0)
 ;;=151.5^^55^613^34
 ;;^UTILITY(U,$J,358.3,9196,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9196,1,4,0)
 ;;=4^CA of Stomach Less Curv
 ;;^UTILITY(U,$J,358.3,9196,1,5,0)
 ;;=5^151.5
 ;;^UTILITY(U,$J,358.3,9196,2)
 ;;=CA of Lesser Curve of Stomach^267068
 ;;^UTILITY(U,$J,358.3,9197,0)
 ;;=151.1^^55^613^26
 ;;^UTILITY(U,$J,358.3,9197,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9197,1,4,0)
 ;;=4^CA of Pylorus
 ;;^UTILITY(U,$J,358.3,9197,1,5,0)
 ;;=5^151.1
 ;;^UTILITY(U,$J,358.3,9197,2)
 ;;=Cancer of Pylorus^267064
 ;;^UTILITY(U,$J,358.3,9198,0)
 ;;=151.8^^55^613^35
 ;;^UTILITY(U,$J,358.3,9198,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9198,1,4,0)
 ;;=4^CA of Stomach,Other
 ;;^UTILITY(U,$J,358.3,9198,1,5,0)
 ;;=5^151.8
 ;;^UTILITY(U,$J,358.3,9198,2)
 ;;=CA, Stomach, Other^267070
