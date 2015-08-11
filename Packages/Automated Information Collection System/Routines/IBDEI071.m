IBDEI071 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3102,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3102,1,4,0)
 ;;=4^CA of Descending Colon
 ;;^UTILITY(U,$J,358.3,3102,1,5,0)
 ;;=5^153.2
 ;;^UTILITY(U,$J,358.3,3102,2)
 ;;=CA of Descending Colon^267081
 ;;^UTILITY(U,$J,358.3,3103,0)
 ;;=153.3^^26^250^28
 ;;^UTILITY(U,$J,358.3,3103,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3103,1,4,0)
 ;;=4^CA of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,3103,1,5,0)
 ;;=5^153.3
 ;;^UTILITY(U,$J,358.3,3103,2)
 ;;=Ca of Sigmoid Colon^267082
 ;;^UTILITY(U,$J,358.3,3104,0)
 ;;=153.1^^26^250^37
 ;;^UTILITY(U,$J,358.3,3104,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3104,1,4,0)
 ;;=4^CA of Transverse Colon
 ;;^UTILITY(U,$J,358.3,3104,1,5,0)
 ;;=5^153.1
 ;;^UTILITY(U,$J,358.3,3104,2)
 ;;=CA of Transverse Colon^267080
 ;;^UTILITY(U,$J,358.3,3105,0)
 ;;=153.0^^26^250^11
 ;;^UTILITY(U,$J,358.3,3105,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3105,1,4,0)
 ;;=4^CA of Colon, Hepatic Flexure.
 ;;^UTILITY(U,$J,358.3,3105,1,5,0)
 ;;=5^153.0
 ;;^UTILITY(U,$J,358.3,3105,2)
 ;;=CA of Colon at Hepatic Flexure^267079
 ;;^UTILITY(U,$J,358.3,3106,0)
 ;;=153.7^^26^250^10
 ;;^UTILITY(U,$J,358.3,3106,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3106,1,4,0)
 ;;=4^CA of Colon at Splenic Flexure
 ;;^UTILITY(U,$J,358.3,3106,1,5,0)
 ;;=5^153.7
 ;;^UTILITY(U,$J,358.3,3106,2)
 ;;=CA of Colon at Splenic Flexure^267086
 ;;^UTILITY(U,$J,358.3,3107,0)
 ;;=151.9^^26^250^29
 ;;^UTILITY(U,$J,358.3,3107,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3107,1,4,0)
 ;;=4^CA of Stomach
 ;;^UTILITY(U,$J,358.3,3107,1,5,0)
 ;;=5^151.9
 ;;^UTILITY(U,$J,358.3,3107,2)
 ;;=CA of Stomach^73532
 ;;^UTILITY(U,$J,358.3,3108,0)
 ;;=151.2^^26^250^4
 ;;^UTILITY(U,$J,358.3,3108,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3108,1,4,0)
 ;;=4^CA of Antrum of Stomach
 ;;^UTILITY(U,$J,358.3,3108,1,5,0)
 ;;=5^151.2
 ;;^UTILITY(U,$J,358.3,3108,2)
 ;;=CA of Antrum of Stomach^267065
 ;;^UTILITY(U,$J,358.3,3109,0)
 ;;=151.4^^26^250^30
 ;;^UTILITY(U,$J,358.3,3109,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3109,1,4,0)
 ;;=4^CA of Stomach Body
 ;;^UTILITY(U,$J,358.3,3109,1,5,0)
 ;;=5^151.4
 ;;^UTILITY(U,$J,358.3,3109,2)
 ;;=CA of Stomach Body^267067
 ;;^UTILITY(U,$J,358.3,3110,0)
 ;;=151.0^^26^250^31
 ;;^UTILITY(U,$J,358.3,3110,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3110,1,4,0)
 ;;=4^CA of Stomach Cardia
 ;;^UTILITY(U,$J,358.3,3110,1,5,0)
 ;;=5^151.0
 ;;^UTILITY(U,$J,358.3,3110,2)
 ;;=CA of Stomach Cardia^267063
 ;;^UTILITY(U,$J,358.3,3111,0)
 ;;=151.3^^26^250^32
 ;;^UTILITY(U,$J,358.3,3111,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3111,1,4,0)
 ;;=4^CA of Stomach Fundus
 ;;^UTILITY(U,$J,358.3,3111,1,5,0)
 ;;=5^151.3
 ;;^UTILITY(U,$J,358.3,3111,2)
 ;;=CA of Fundus of Stomach^267066
 ;;^UTILITY(U,$J,358.3,3112,0)
 ;;=151.6^^26^250^33
 ;;^UTILITY(U,$J,358.3,3112,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3112,1,4,0)
 ;;=4^CA of Stomach Great Curve
 ;;^UTILITY(U,$J,358.3,3112,1,5,0)
 ;;=5^151.6
 ;;^UTILITY(U,$J,358.3,3112,2)
 ;;=^267069
 ;;^UTILITY(U,$J,358.3,3113,0)
 ;;=151.5^^26^250^34
 ;;^UTILITY(U,$J,358.3,3113,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3113,1,4,0)
 ;;=4^CA of Stomach Less Curv
 ;;^UTILITY(U,$J,358.3,3113,1,5,0)
 ;;=5^151.5
 ;;^UTILITY(U,$J,358.3,3113,2)
 ;;=CA of Lesser Curve of Stomach^267068
 ;;^UTILITY(U,$J,358.3,3114,0)
 ;;=151.1^^26^250^26
 ;;^UTILITY(U,$J,358.3,3114,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3114,1,4,0)
 ;;=4^CA of Pylorus
 ;;^UTILITY(U,$J,358.3,3114,1,5,0)
 ;;=5^151.1
 ;;^UTILITY(U,$J,358.3,3114,2)
 ;;=Cancer of Pylorus^267064
 ;;^UTILITY(U,$J,358.3,3115,0)
 ;;=151.8^^26^250^35
