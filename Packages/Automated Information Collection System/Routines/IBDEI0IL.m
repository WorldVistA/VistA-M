IBDEI0IL ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9056,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9056,1,4,0)
 ;;=4^CA of Stomach Fundus
 ;;^UTILITY(U,$J,358.3,9056,1,5,0)
 ;;=5^151.3
 ;;^UTILITY(U,$J,358.3,9056,2)
 ;;=CA of Fundus of Stomach^267066
 ;;^UTILITY(U,$J,358.3,9057,0)
 ;;=151.6^^61^636^33
 ;;^UTILITY(U,$J,358.3,9057,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9057,1,4,0)
 ;;=4^CA of Stomach Great Curve
 ;;^UTILITY(U,$J,358.3,9057,1,5,0)
 ;;=5^151.6
 ;;^UTILITY(U,$J,358.3,9057,2)
 ;;=^267069
 ;;^UTILITY(U,$J,358.3,9058,0)
 ;;=151.5^^61^636^34
 ;;^UTILITY(U,$J,358.3,9058,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9058,1,4,0)
 ;;=4^CA of Stomach Less Curv
 ;;^UTILITY(U,$J,358.3,9058,1,5,0)
 ;;=5^151.5
 ;;^UTILITY(U,$J,358.3,9058,2)
 ;;=CA of Lesser Curve of Stomach^267068
 ;;^UTILITY(U,$J,358.3,9059,0)
 ;;=151.1^^61^636^26
 ;;^UTILITY(U,$J,358.3,9059,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9059,1,4,0)
 ;;=4^CA of Pylorus
 ;;^UTILITY(U,$J,358.3,9059,1,5,0)
 ;;=5^151.1
 ;;^UTILITY(U,$J,358.3,9059,2)
 ;;=Cancer of Pylorus^267064
 ;;^UTILITY(U,$J,358.3,9060,0)
 ;;=151.8^^61^636^35
 ;;^UTILITY(U,$J,358.3,9060,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9060,1,4,0)
 ;;=4^CA of Stomach,Other
 ;;^UTILITY(U,$J,358.3,9060,1,5,0)
 ;;=5^151.8
 ;;^UTILITY(U,$J,358.3,9060,2)
 ;;=CA, Stomach, Other^267070
 ;;^UTILITY(U,$J,358.3,9061,0)
 ;;=150.9^^61^636^14
 ;;^UTILITY(U,$J,358.3,9061,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9061,1,4,0)
 ;;=4^CA of Esophagus
 ;;^UTILITY(U,$J,358.3,9061,1,5,0)
 ;;=5^150.9
 ;;^UTILITY(U,$J,358.3,9061,2)
 ;;=CA of Esophagus^267055
 ;;^UTILITY(U,$J,358.3,9062,0)
 ;;=150.2^^61^636^3
 ;;^UTILITY(U,$J,358.3,9062,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9062,1,4,0)
 ;;=4^CA of Abdominal Esophagus
 ;;^UTILITY(U,$J,358.3,9062,1,5,0)
 ;;=5^150.2
 ;;^UTILITY(U,$J,358.3,9062,2)
 ;;=CA of Abdominal Esophagus^267058
 ;;^UTILITY(U,$J,358.3,9063,0)
 ;;=150.0^^61^636^7
 ;;^UTILITY(U,$J,358.3,9063,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9063,1,4,0)
 ;;=4^CA of Cervical Esophagus
 ;;^UTILITY(U,$J,358.3,9063,1,5,0)
 ;;=5^150.0
 ;;^UTILITY(U,$J,358.3,9063,2)
 ;;=CA of Cervical Esophagus^267056
 ;;^UTILITY(U,$J,358.3,9064,0)
 ;;=150.5^^61^636^15
 ;;^UTILITY(U,$J,358.3,9064,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9064,1,4,0)
 ;;=4^CA of Esophagus,Lower
 ;;^UTILITY(U,$J,358.3,9064,1,5,0)
 ;;=5^150.5
 ;;^UTILITY(U,$J,358.3,9064,2)
 ;;=CA of Lower Esophagus^267061
 ;;^UTILITY(U,$J,358.3,9065,0)
 ;;=150.4^^61^636^16
 ;;^UTILITY(U,$J,358.3,9065,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9065,1,4,0)
 ;;=4^CA of Esophagus,Middle
 ;;^UTILITY(U,$J,358.3,9065,1,5,0)
 ;;=5^150.4
 ;;^UTILITY(U,$J,358.3,9065,2)
 ;;=CA of Middle Esoph^267060
 ;;^UTILITY(U,$J,358.3,9066,0)
 ;;=150.3^^61^636^17
 ;;^UTILITY(U,$J,358.3,9066,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9066,1,4,0)
 ;;=4^CA of Esophagus,Upper
 ;;^UTILITY(U,$J,358.3,9066,1,5,0)
 ;;=5^150.3
 ;;^UTILITY(U,$J,358.3,9066,2)
 ;;=CA, Upper Esophagus^267059
 ;;^UTILITY(U,$J,358.3,9067,0)
 ;;=150.1^^61^636^36
 ;;^UTILITY(U,$J,358.3,9067,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9067,1,4,0)
 ;;=4^CA of Thoracic Esophagus
 ;;^UTILITY(U,$J,358.3,9067,1,5,0)
 ;;=5^150.1
 ;;^UTILITY(U,$J,358.3,9067,2)
 ;;=CA of Thoracic Esophagus^267057
 ;;^UTILITY(U,$J,358.3,9068,0)
 ;;=157.9^^61^636^20
 ;;^UTILITY(U,$J,358.3,9068,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9068,1,4,0)
 ;;=4^CA of Pancreas
 ;;^UTILITY(U,$J,358.3,9068,1,5,0)
 ;;=5^157.9
 ;;^UTILITY(U,$J,358.3,9068,2)
 ;;=CA of Pancreas^267103
 ;;^UTILITY(U,$J,358.3,9069,0)
 ;;=157.1^^61^636^22
 ;;^UTILITY(U,$J,358.3,9069,1,0)
 ;;=^358.31IA^5^2
