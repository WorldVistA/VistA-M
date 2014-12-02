IBDEI028 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,620,1,2,0)
 ;;=2^VENOUS ANGIO UPPER ARM/ELBOW,ANESTH
 ;;^UTILITY(U,$J,358.3,620,1,4,0)
 ;;=4^01780
 ;;^UTILITY(U,$J,358.3,621,0)
 ;;=01260^^8^81^1^^^^1
 ;;^UTILITY(U,$J,358.3,621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,621,1,2,0)
 ;;=2^VENOUS ANGIO UPPER LEG,ANESTH
 ;;^UTILITY(U,$J,358.3,621,1,4,0)
 ;;=4^01260
 ;;^UTILITY(U,$J,358.3,622,0)
 ;;=789.06^^9^82^1
 ;;^UTILITY(U,$J,358.3,622,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,622,1,4,0)
 ;;=4^Epigastric Pain
 ;;^UTILITY(U,$J,358.3,622,1,5,0)
 ;;=5^789.06
 ;;^UTILITY(U,$J,358.3,622,2)
 ;;=Epigastric Pain^303323
 ;;^UTILITY(U,$J,358.3,623,0)
 ;;=789.07^^9^82^2
 ;;^UTILITY(U,$J,358.3,623,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,623,1,4,0)
 ;;=4^Generalized Abdominal Pain
 ;;^UTILITY(U,$J,358.3,623,1,5,0)
 ;;=5^789.07
 ;;^UTILITY(U,$J,358.3,623,2)
 ;;=Generalized Abdominal Pain^303324
 ;;^UTILITY(U,$J,358.3,624,0)
 ;;=789.04^^9^82^3
 ;;^UTILITY(U,$J,358.3,624,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,624,1,4,0)
 ;;=4^LL Quad Abdominal
 ;;^UTILITY(U,$J,358.3,624,1,5,0)
 ;;=5^789.04
 ;;^UTILITY(U,$J,358.3,624,2)
 ;;=LL Quad Abdominal^303321
 ;;^UTILITY(U,$J,358.3,625,0)
 ;;=789.02^^9^82^4
 ;;^UTILITY(U,$J,358.3,625,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,625,1,4,0)
 ;;=4^LU Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,625,1,5,0)
 ;;=5^789.02
 ;;^UTILITY(U,$J,358.3,625,2)
 ;;=LU Quadrant Abdominal Pain^303319
 ;;^UTILITY(U,$J,358.3,626,0)
 ;;=789.09^^9^82^5
 ;;^UTILITY(U,$J,358.3,626,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,626,1,4,0)
 ;;=4^Abdominal Pain, Mult Sites
 ;;^UTILITY(U,$J,358.3,626,1,5,0)
 ;;=5^789.09
 ;;^UTILITY(U,$J,358.3,626,2)
 ;;=Abdominal Pain, Mult Sites^303325
 ;;^UTILITY(U,$J,358.3,627,0)
 ;;=789.05^^9^82^6
 ;;^UTILITY(U,$J,358.3,627,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,627,1,4,0)
 ;;=4^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,627,1,5,0)
 ;;=5^789.05
 ;;^UTILITY(U,$J,358.3,627,2)
 ;;=Periumbilical Pain^303322
 ;;^UTILITY(U,$J,358.3,628,0)
 ;;=789.03^^9^82^7
 ;;^UTILITY(U,$J,358.3,628,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,628,1,4,0)
 ;;=4^RL Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,628,1,5,0)
 ;;=5^789.03
 ;;^UTILITY(U,$J,358.3,628,2)
 ;;=RL Quadrant Abdominal Pain^303320
 ;;^UTILITY(U,$J,358.3,629,0)
 ;;=789.01^^9^82^8
 ;;^UTILITY(U,$J,358.3,629,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,629,1,4,0)
 ;;=4^RU Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,629,1,5,0)
 ;;=5^789.01
 ;;^UTILITY(U,$J,358.3,629,2)
 ;;=RU Quadrant Abdominal Pain^303318
 ;;^UTILITY(U,$J,358.3,630,0)
 ;;=789.00^^9^82^9
 ;;^UTILITY(U,$J,358.3,630,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,630,1,4,0)
 ;;=4^Abdominal Pain, Unspec
 ;;^UTILITY(U,$J,358.3,630,1,5,0)
 ;;=5^789.00
 ;;^UTILITY(U,$J,358.3,630,2)
 ;;=Abdominal Pain, Unspec^303317
 ;;^UTILITY(U,$J,358.3,631,0)
 ;;=V72.83^^9^83^10
 ;;^UTILITY(U,$J,358.3,631,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,631,1,4,0)
 ;;=4^PRE-OP EVALUATION
 ;;^UTILITY(U,$J,358.3,631,1,5,0)
 ;;=5^V72.83
 ;;^UTILITY(U,$J,358.3,631,2)
 ;;=^321505
 ;;^UTILITY(U,$J,358.3,632,0)
 ;;=V58.49^^9^83^11
 ;;^UTILITY(U,$J,358.3,632,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,632,1,4,0)
 ;;=4^POST-OP AFTERCARE/EXAM
 ;;^UTILITY(U,$J,358.3,632,1,5,0)
 ;;=5^V58.49
 ;;^UTILITY(U,$J,358.3,632,2)
 ;;=^295530
 ;;^UTILITY(U,$J,358.3,633,0)
 ;;=788.99^^9^84^7
 ;;^UTILITY(U,$J,358.3,633,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,633,1,4,0)
 ;;=4^Urinary Sys Sym Other
 ;;^UTILITY(U,$J,358.3,633,1,5,0)
 ;;=5^788.99
 ;;^UTILITY(U,$J,358.3,633,2)
 ;;=^273391
