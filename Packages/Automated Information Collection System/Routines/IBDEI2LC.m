IBDEI2LC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43475,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43475,1,2,0)
 ;;=2^20550
 ;;^UTILITY(U,$J,358.3,43475,1,3,0)
 ;;=3^Injection, Tendon Sheath, Ligament, Ganglion Cyst
 ;;^UTILITY(U,$J,358.3,43476,0)
 ;;=20551^^199^2199^20^^^^1
 ;;^UTILITY(U,$J,358.3,43476,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43476,1,2,0)
 ;;=2^20551
 ;;^UTILITY(U,$J,358.3,43476,1,3,0)
 ;;=3^Injection, Tendon Origin/Insertion
 ;;^UTILITY(U,$J,358.3,43477,0)
 ;;=20552^^199^2199^22^^^^1
 ;;^UTILITY(U,$J,358.3,43477,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43477,1,2,0)
 ;;=2^20552
 ;;^UTILITY(U,$J,358.3,43477,1,3,0)
 ;;=3^Injection, Trigger Point, 1 or 2 Muscle groups
 ;;^UTILITY(U,$J,358.3,43478,0)
 ;;=20600^^199^2199^2^^^^1
 ;;^UTILITY(U,$J,358.3,43478,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43478,1,2,0)
 ;;=2^20600
 ;;^UTILITY(U,$J,358.3,43478,1,3,0)
 ;;=3^Arthrocentesis,Small Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,43479,0)
 ;;=20605^^199^2199^4^^^^1
 ;;^UTILITY(U,$J,358.3,43479,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43479,1,2,0)
 ;;=2^20605
 ;;^UTILITY(U,$J,358.3,43479,1,3,0)
 ;;=3^Arthrocentesis,Intermediate Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,43480,0)
 ;;=20610^^199^2199^6^^^^1
 ;;^UTILITY(U,$J,358.3,43480,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43480,1,2,0)
 ;;=2^20610
 ;;^UTILITY(U,$J,358.3,43480,1,3,0)
 ;;=3^Arthrocentesis,Major Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,43481,0)
 ;;=92950^^199^2199^9^^^^1
 ;;^UTILITY(U,$J,358.3,43481,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43481,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,43481,1,3,0)
 ;;=3^CPR
 ;;^UTILITY(U,$J,358.3,43482,0)
 ;;=11055^^199^2199^31^^^^1
 ;;^UTILITY(U,$J,358.3,43482,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43482,1,2,0)
 ;;=2^11055
 ;;^UTILITY(U,$J,358.3,43482,1,3,0)
 ;;=3^Trim Corn/Callous, One
 ;;^UTILITY(U,$J,358.3,43483,0)
 ;;=11056^^199^2199^32^^^^1
 ;;^UTILITY(U,$J,358.3,43483,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43483,1,2,0)
 ;;=2^11056
 ;;^UTILITY(U,$J,358.3,43483,1,3,0)
 ;;=3^Trim Corn/Callous, 2 to 4
 ;;^UTILITY(U,$J,358.3,43484,0)
 ;;=11057^^199^2199^33^^^^1
 ;;^UTILITY(U,$J,358.3,43484,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43484,1,2,0)
 ;;=2^11057
 ;;^UTILITY(U,$J,358.3,43484,1,3,0)
 ;;=3^Trim Corn/Callous, 5 or more
 ;;^UTILITY(U,$J,358.3,43485,0)
 ;;=12011^^199^2199^27^^^^1
 ;;^UTILITY(U,$J,358.3,43485,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43485,1,2,0)
 ;;=2^12011
 ;;^UTILITY(U,$J,358.3,43485,1,3,0)
 ;;=3^Suture Simple Wound,Face,2.5 cm or <
 ;;^UTILITY(U,$J,358.3,43486,0)
 ;;=97597^^199^2199^10^^^^1
 ;;^UTILITY(U,$J,358.3,43486,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43486,1,2,0)
 ;;=2^97597
 ;;^UTILITY(U,$J,358.3,43486,1,3,0)
 ;;=3^Debridement open wnd 1st 20sq cm
 ;;^UTILITY(U,$J,358.3,43487,0)
 ;;=97598^^199^2199^11^^^^1
 ;;^UTILITY(U,$J,358.3,43487,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43487,1,2,0)
 ;;=2^97598
 ;;^UTILITY(U,$J,358.3,43487,1,3,0)
 ;;=3^Debridement open wnd ea addl 20sq cm
 ;;^UTILITY(U,$J,358.3,43488,0)
 ;;=11200^^199^2199^23^^^^1
 ;;^UTILITY(U,$J,358.3,43488,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43488,1,2,0)
 ;;=2^11200
 ;;^UTILITY(U,$J,358.3,43488,1,3,0)
 ;;=3^Removal Skin Tags,up to 15 Lesions
 ;;^UTILITY(U,$J,358.3,43489,0)
 ;;=11201^^199^2199^24^^^^1
 ;;^UTILITY(U,$J,358.3,43489,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43489,1,2,0)
 ;;=2^11201
 ;;^UTILITY(U,$J,358.3,43489,1,3,0)
 ;;=3^Removal Skin Tags,ea addl 10 Lesions
 ;;^UTILITY(U,$J,358.3,43490,0)
 ;;=11100^^199^2199^7^^^^1
 ;;^UTILITY(U,$J,358.3,43490,1,0)
 ;;=^358.31IA^3^2
