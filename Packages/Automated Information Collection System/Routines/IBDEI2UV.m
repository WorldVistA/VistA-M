IBDEI2UV ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45552,1,3,0)
 ;;=3^Osteoporosis, age-related w/o current path fx
 ;;^UTILITY(U,$J,358.3,45552,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,45552,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,45553,0)
 ;;=M79.11^^172^2271^10
 ;;^UTILITY(U,$J,358.3,45553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45553,1,3,0)
 ;;=3^Myalgia,Mastication Muscle
 ;;^UTILITY(U,$J,358.3,45553,1,4,0)
 ;;=4^M79.11
 ;;^UTILITY(U,$J,358.3,45553,2)
 ;;=^5157395
 ;;^UTILITY(U,$J,358.3,45554,0)
 ;;=M79.12^^172^2271^9
 ;;^UTILITY(U,$J,358.3,45554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45554,1,3,0)
 ;;=3^Myalgia,Auxiliary Muscles,Head & Neck
 ;;^UTILITY(U,$J,358.3,45554,1,4,0)
 ;;=4^M79.12
 ;;^UTILITY(U,$J,358.3,45554,2)
 ;;=^5157396
 ;;^UTILITY(U,$J,358.3,45555,0)
 ;;=M79.10^^172^2271^11
 ;;^UTILITY(U,$J,358.3,45555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45555,1,3,0)
 ;;=3^Myalgia,Unspec Site
 ;;^UTILITY(U,$J,358.3,45555,1,4,0)
 ;;=4^M79.10
 ;;^UTILITY(U,$J,358.3,45555,2)
 ;;=^5157394
 ;;^UTILITY(U,$J,358.3,45556,0)
 ;;=J06.9^^172^2272^17
 ;;^UTILITY(U,$J,358.3,45556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45556,1,3,0)
 ;;=3^Upper respiratory infection, acute
 ;;^UTILITY(U,$J,358.3,45556,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,45556,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,45557,0)
 ;;=J10.1^^172^2272^8
 ;;^UTILITY(U,$J,358.3,45557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45557,1,3,0)
 ;;=3^Flu d/t indent influ virus w/ oth resp manifest
 ;;^UTILITY(U,$J,358.3,45557,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,45557,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,45558,0)
 ;;=J11.1^^172^2272^9
 ;;^UTILITY(U,$J,358.3,45558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45558,1,3,0)
 ;;=3^Flu d/t unident influ virus w/ oth resp manifest
 ;;^UTILITY(U,$J,358.3,45558,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,45558,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,45559,0)
 ;;=J43.9^^172^2272^7
 ;;^UTILITY(U,$J,358.3,45559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45559,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,45559,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,45559,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,45560,0)
 ;;=J44.9^^172^2272^4
 ;;^UTILITY(U,$J,358.3,45560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45560,1,3,0)
 ;;=3^COPD, unspec
 ;;^UTILITY(U,$J,358.3,45560,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,45560,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,45561,0)
 ;;=J45.909^^172^2272^1
 ;;^UTILITY(U,$J,358.3,45561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45561,1,3,0)
 ;;=3^Asthma, uncomplicated, unspec
 ;;^UTILITY(U,$J,358.3,45561,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,45561,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,45562,0)
 ;;=J91.8^^172^2272^10
 ;;^UTILITY(U,$J,358.3,45562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45562,1,3,0)
 ;;=3^Pleural effusion in other conditions classified elsewhere
 ;;^UTILITY(U,$J,358.3,45562,1,4,0)
 ;;=4^J91.8
 ;;^UTILITY(U,$J,358.3,45562,2)
 ;;=^5008311
 ;;^UTILITY(U,$J,358.3,45563,0)
 ;;=J20.9^^172^2272^2
 ;;^UTILITY(U,$J,358.3,45563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45563,1,3,0)
 ;;=3^Bronchitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,45563,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,45563,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,45564,0)
 ;;=J98.01^^172^2272^3
 ;;^UTILITY(U,$J,358.3,45564,1,0)
 ;;=^358.31IA^4^2
