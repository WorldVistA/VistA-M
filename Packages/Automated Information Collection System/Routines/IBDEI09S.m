IBDEI09S ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4530,1,5,0)
 ;;=5^151.4
 ;;^UTILITY(U,$J,358.3,4530,2)
 ;;=CA of Stomach Body^267067
 ;;^UTILITY(U,$J,358.3,4531,0)
 ;;=151.0^^37^345^31
 ;;^UTILITY(U,$J,358.3,4531,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4531,1,4,0)
 ;;=4^CA of Stomach Cardia
 ;;^UTILITY(U,$J,358.3,4531,1,5,0)
 ;;=5^151.0
 ;;^UTILITY(U,$J,358.3,4531,2)
 ;;=CA of Stomach Cardia^267063
 ;;^UTILITY(U,$J,358.3,4532,0)
 ;;=151.3^^37^345^32
 ;;^UTILITY(U,$J,358.3,4532,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4532,1,4,0)
 ;;=4^CA of Stomach Fundus
 ;;^UTILITY(U,$J,358.3,4532,1,5,0)
 ;;=5^151.3
 ;;^UTILITY(U,$J,358.3,4532,2)
 ;;=CA of Fundus of Stomach^267066
 ;;^UTILITY(U,$J,358.3,4533,0)
 ;;=151.6^^37^345^33
 ;;^UTILITY(U,$J,358.3,4533,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4533,1,4,0)
 ;;=4^CA of Stomach Great Curve
 ;;^UTILITY(U,$J,358.3,4533,1,5,0)
 ;;=5^151.6
 ;;^UTILITY(U,$J,358.3,4533,2)
 ;;=^267069
 ;;^UTILITY(U,$J,358.3,4534,0)
 ;;=151.5^^37^345^34
 ;;^UTILITY(U,$J,358.3,4534,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4534,1,4,0)
 ;;=4^CA of Stomach Less Curv
 ;;^UTILITY(U,$J,358.3,4534,1,5,0)
 ;;=5^151.5
 ;;^UTILITY(U,$J,358.3,4534,2)
 ;;=CA of Lesser Curve of Stomach^267068
 ;;^UTILITY(U,$J,358.3,4535,0)
 ;;=151.1^^37^345^26
 ;;^UTILITY(U,$J,358.3,4535,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4535,1,4,0)
 ;;=4^CA of Pylorus
 ;;^UTILITY(U,$J,358.3,4535,1,5,0)
 ;;=5^151.1
 ;;^UTILITY(U,$J,358.3,4535,2)
 ;;=Cancer of Pylorus^267064
 ;;^UTILITY(U,$J,358.3,4536,0)
 ;;=151.8^^37^345^35
 ;;^UTILITY(U,$J,358.3,4536,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4536,1,4,0)
 ;;=4^CA of Stomach,Other
 ;;^UTILITY(U,$J,358.3,4536,1,5,0)
 ;;=5^151.8
 ;;^UTILITY(U,$J,358.3,4536,2)
 ;;=CA, Stomach, Other^267070
 ;;^UTILITY(U,$J,358.3,4537,0)
 ;;=150.9^^37^345^14
 ;;^UTILITY(U,$J,358.3,4537,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4537,1,4,0)
 ;;=4^CA of Esophagus
 ;;^UTILITY(U,$J,358.3,4537,1,5,0)
 ;;=5^150.9
 ;;^UTILITY(U,$J,358.3,4537,2)
 ;;=CA of Esophagus^267055
 ;;^UTILITY(U,$J,358.3,4538,0)
 ;;=150.2^^37^345^3
 ;;^UTILITY(U,$J,358.3,4538,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4538,1,4,0)
 ;;=4^CA of Abdominal Esophagus
 ;;^UTILITY(U,$J,358.3,4538,1,5,0)
 ;;=5^150.2
 ;;^UTILITY(U,$J,358.3,4538,2)
 ;;=CA of Abdominal Esophagus^267058
 ;;^UTILITY(U,$J,358.3,4539,0)
 ;;=150.0^^37^345^7
 ;;^UTILITY(U,$J,358.3,4539,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4539,1,4,0)
 ;;=4^CA of Cervical Esophagus
 ;;^UTILITY(U,$J,358.3,4539,1,5,0)
 ;;=5^150.0
 ;;^UTILITY(U,$J,358.3,4539,2)
 ;;=CA of Cervical Esophagus^267056
 ;;^UTILITY(U,$J,358.3,4540,0)
 ;;=150.5^^37^345^15
 ;;^UTILITY(U,$J,358.3,4540,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4540,1,4,0)
 ;;=4^CA of Esophagus,Lower
 ;;^UTILITY(U,$J,358.3,4540,1,5,0)
 ;;=5^150.5
 ;;^UTILITY(U,$J,358.3,4540,2)
 ;;=CA of Lower Esophagus^267061
 ;;^UTILITY(U,$J,358.3,4541,0)
 ;;=150.4^^37^345^16
 ;;^UTILITY(U,$J,358.3,4541,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4541,1,4,0)
 ;;=4^CA of Esophagus,Middle
 ;;^UTILITY(U,$J,358.3,4541,1,5,0)
 ;;=5^150.4
 ;;^UTILITY(U,$J,358.3,4541,2)
 ;;=CA of Middle Esoph^267060
 ;;^UTILITY(U,$J,358.3,4542,0)
 ;;=150.3^^37^345^17
 ;;^UTILITY(U,$J,358.3,4542,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4542,1,4,0)
 ;;=4^CA of Esophagus,Upper
 ;;^UTILITY(U,$J,358.3,4542,1,5,0)
 ;;=5^150.3
 ;;^UTILITY(U,$J,358.3,4542,2)
 ;;=CA, Upper Esophagus^267059
 ;;^UTILITY(U,$J,358.3,4543,0)
 ;;=150.1^^37^345^36
 ;;^UTILITY(U,$J,358.3,4543,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4543,1,4,0)
 ;;=4^CA of Thoracic Esophagus
