IBDEI0IK ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9043,1,4,0)
 ;;=4^CA of Ileocecal Valve
 ;;^UTILITY(U,$J,358.3,9043,1,5,0)
 ;;=5^153.4
 ;;^UTILITY(U,$J,358.3,9043,2)
 ;;=CA of Ileocecal Valve^267083
 ;;^UTILITY(U,$J,358.3,9044,0)
 ;;=154.0^^61^636^9
 ;;^UTILITY(U,$J,358.3,9044,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9044,1,4,0)
 ;;=4^CA of Colon and Rectum
 ;;^UTILITY(U,$J,358.3,9044,1,5,0)
 ;;=5^154.0
 ;;^UTILITY(U,$J,358.3,9044,2)
 ;;=CA of Colon and Rectum^267089
 ;;^UTILITY(U,$J,358.3,9045,0)
 ;;=153.6^^61^636^6
 ;;^UTILITY(U,$J,358.3,9045,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9045,1,4,0)
 ;;=4^CA of Ascending Colon
 ;;^UTILITY(U,$J,358.3,9045,1,5,0)
 ;;=5^153.6
 ;;^UTILITY(U,$J,358.3,9045,2)
 ;;=CA of Ascending Colon^267085
 ;;^UTILITY(U,$J,358.3,9046,0)
 ;;=153.8^^61^636^12
 ;;^UTILITY(U,$J,358.3,9046,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9046,1,4,0)
 ;;=4^CA of Colon/Contiguous Sites
 ;;^UTILITY(U,$J,358.3,9046,1,5,0)
 ;;=5^153.8
 ;;^UTILITY(U,$J,358.3,9046,2)
 ;;=CA of Colon/Contiguous Sites^267087
 ;;^UTILITY(U,$J,358.3,9047,0)
 ;;=153.2^^61^636^13
 ;;^UTILITY(U,$J,358.3,9047,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9047,1,4,0)
 ;;=4^CA of Descending Colon
 ;;^UTILITY(U,$J,358.3,9047,1,5,0)
 ;;=5^153.2
 ;;^UTILITY(U,$J,358.3,9047,2)
 ;;=CA of Descending Colon^267081
 ;;^UTILITY(U,$J,358.3,9048,0)
 ;;=153.3^^61^636^28
 ;;^UTILITY(U,$J,358.3,9048,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9048,1,4,0)
 ;;=4^CA of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,9048,1,5,0)
 ;;=5^153.3
 ;;^UTILITY(U,$J,358.3,9048,2)
 ;;=Ca of Sigmoid Colon^267082
 ;;^UTILITY(U,$J,358.3,9049,0)
 ;;=153.1^^61^636^37
 ;;^UTILITY(U,$J,358.3,9049,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9049,1,4,0)
 ;;=4^CA of Transverse Colon
 ;;^UTILITY(U,$J,358.3,9049,1,5,0)
 ;;=5^153.1
 ;;^UTILITY(U,$J,358.3,9049,2)
 ;;=CA of Transverse Colon^267080
 ;;^UTILITY(U,$J,358.3,9050,0)
 ;;=153.0^^61^636^11
 ;;^UTILITY(U,$J,358.3,9050,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9050,1,4,0)
 ;;=4^CA of Colon, Hepatic Flexure.
 ;;^UTILITY(U,$J,358.3,9050,1,5,0)
 ;;=5^153.0
 ;;^UTILITY(U,$J,358.3,9050,2)
 ;;=CA of Colon at Hepatic Flexure^267079
 ;;^UTILITY(U,$J,358.3,9051,0)
 ;;=153.7^^61^636^10
 ;;^UTILITY(U,$J,358.3,9051,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9051,1,4,0)
 ;;=4^CA of Colon at Splenic Flexure
 ;;^UTILITY(U,$J,358.3,9051,1,5,0)
 ;;=5^153.7
 ;;^UTILITY(U,$J,358.3,9051,2)
 ;;=CA of Colon at Splenic Flexure^267086
 ;;^UTILITY(U,$J,358.3,9052,0)
 ;;=151.9^^61^636^29
 ;;^UTILITY(U,$J,358.3,9052,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9052,1,4,0)
 ;;=4^CA of Stomach
 ;;^UTILITY(U,$J,358.3,9052,1,5,0)
 ;;=5^151.9
 ;;^UTILITY(U,$J,358.3,9052,2)
 ;;=CA of Stomach^73532
 ;;^UTILITY(U,$J,358.3,9053,0)
 ;;=151.2^^61^636^4
 ;;^UTILITY(U,$J,358.3,9053,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9053,1,4,0)
 ;;=4^CA of Antrum of Stomach
 ;;^UTILITY(U,$J,358.3,9053,1,5,0)
 ;;=5^151.2
 ;;^UTILITY(U,$J,358.3,9053,2)
 ;;=CA of Antrum of Stomach^267065
 ;;^UTILITY(U,$J,358.3,9054,0)
 ;;=151.4^^61^636^30
 ;;^UTILITY(U,$J,358.3,9054,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9054,1,4,0)
 ;;=4^CA of Stomach Body
 ;;^UTILITY(U,$J,358.3,9054,1,5,0)
 ;;=5^151.4
 ;;^UTILITY(U,$J,358.3,9054,2)
 ;;=CA of Stomach Body^267067
 ;;^UTILITY(U,$J,358.3,9055,0)
 ;;=151.0^^61^636^31
 ;;^UTILITY(U,$J,358.3,9055,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9055,1,4,0)
 ;;=4^CA of Stomach Cardia
 ;;^UTILITY(U,$J,358.3,9055,1,5,0)
 ;;=5^151.0
 ;;^UTILITY(U,$J,358.3,9055,2)
 ;;=CA of Stomach Cardia^267063
 ;;^UTILITY(U,$J,358.3,9056,0)
 ;;=151.3^^61^636^32
