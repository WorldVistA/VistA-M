IBDEI0EY ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6845,2)
 ;;=Abnormal UA^273408
 ;;^UTILITY(U,$J,358.3,6846,0)
 ;;=789.01^^31^415^7
 ;;^UTILITY(U,$J,358.3,6846,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6846,1,4,0)
 ;;=4^789.01
 ;;^UTILITY(U,$J,358.3,6846,1,5,0)
 ;;=5^Abdominal pain, RUQ
 ;;^UTILITY(U,$J,358.3,6846,2)
 ;;=^303318
 ;;^UTILITY(U,$J,358.3,6847,0)
 ;;=789.02^^31^415^4
 ;;^UTILITY(U,$J,358.3,6847,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6847,1,4,0)
 ;;=4^789.02
 ;;^UTILITY(U,$J,358.3,6847,1,5,0)
 ;;=5^Abdominal pain, LUQ
 ;;^UTILITY(U,$J,358.3,6847,2)
 ;;=^303319
 ;;^UTILITY(U,$J,358.3,6848,0)
 ;;=789.03^^31^415^6
 ;;^UTILITY(U,$J,358.3,6848,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6848,1,4,0)
 ;;=4^789.03
 ;;^UTILITY(U,$J,358.3,6848,1,5,0)
 ;;=5^Abdominal pain, RLQ
 ;;^UTILITY(U,$J,358.3,6848,2)
 ;;=^303320
 ;;^UTILITY(U,$J,358.3,6849,0)
 ;;=789.04^^31^415^3
 ;;^UTILITY(U,$J,358.3,6849,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6849,1,4,0)
 ;;=4^789.04
 ;;^UTILITY(U,$J,358.3,6849,1,5,0)
 ;;=5^Abdominal pain, LLQ
 ;;^UTILITY(U,$J,358.3,6849,2)
 ;;=^303321
 ;;^UTILITY(U,$J,358.3,6850,0)
 ;;=789.06^^31^415^2
 ;;^UTILITY(U,$J,358.3,6850,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6850,1,4,0)
 ;;=4^789.06
 ;;^UTILITY(U,$J,358.3,6850,1,5,0)
 ;;=5^Abdominal pain, Epigastric
 ;;^UTILITY(U,$J,358.3,6850,2)
 ;;=^303323
 ;;^UTILITY(U,$J,358.3,6851,0)
 ;;=789.05^^31^415^5
 ;;^UTILITY(U,$J,358.3,6851,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6851,1,4,0)
 ;;=4^789.05
 ;;^UTILITY(U,$J,358.3,6851,1,5,0)
 ;;=5^Abdominal pain, Periumbilical
 ;;^UTILITY(U,$J,358.3,6851,2)
 ;;=^303322
 ;;^UTILITY(U,$J,358.3,6852,0)
 ;;=789.40^^31^415^8
 ;;^UTILITY(U,$J,358.3,6852,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6852,1,4,0)
 ;;=4^789.40
 ;;^UTILITY(U,$J,358.3,6852,1,5,0)
 ;;=5^Abdominal rigidity, unsp site
 ;;^UTILITY(U,$J,358.3,6852,2)
 ;;=^273393
 ;;^UTILITY(U,$J,358.3,6853,0)
 ;;=789.1^^31^415^80
 ;;^UTILITY(U,$J,358.3,6853,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6853,1,4,0)
 ;;=4^789.1
 ;;^UTILITY(U,$J,358.3,6853,1,5,0)
 ;;=5^Hepatomegaly
 ;;^UTILITY(U,$J,358.3,6853,2)
 ;;=Hepatomegaly^56494
 ;;^UTILITY(U,$J,358.3,6854,0)
 ;;=789.30^^31^415^1
 ;;^UTILITY(U,$J,358.3,6854,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6854,1,4,0)
 ;;=4^789.30
 ;;^UTILITY(U,$J,358.3,6854,1,5,0)
 ;;=5^Abdominal Mass/Lump
 ;;^UTILITY(U,$J,358.3,6854,2)
 ;;=Abdominal Mass/Lump^917
 ;;^UTILITY(U,$J,358.3,6855,0)
 ;;=789.2^^31^415^139
 ;;^UTILITY(U,$J,358.3,6855,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6855,1,4,0)
 ;;=4^789.2
 ;;^UTILITY(U,$J,358.3,6855,1,5,0)
 ;;=5^Splenomegaly
 ;;^UTILITY(U,$J,358.3,6855,2)
 ;;=Splenomegaly^113452
 ;;^UTILITY(U,$J,358.3,6856,0)
 ;;=785.2^^31^415^36
 ;;^UTILITY(U,$J,358.3,6856,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6856,1,4,0)
 ;;=4^785.2
 ;;^UTILITY(U,$J,358.3,6856,1,5,0)
 ;;=5^Cardiac murmurs, undiagnosed
 ;;^UTILITY(U,$J,358.3,6856,2)
 ;;=^295854
 ;;^UTILITY(U,$J,358.3,6857,0)
 ;;=786.50^^31^415^39
 ;;^UTILITY(U,$J,358.3,6857,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6857,1,4,0)
 ;;=4^786.50
 ;;^UTILITY(U,$J,358.3,6857,1,5,0)
 ;;=5^Chest pain/Discomfort (nonsp) chest pain diff from discomfort
 ;;^UTILITY(U,$J,358.3,6857,2)
 ;;=^22485
 ;;^UTILITY(U,$J,358.3,6858,0)
 ;;=786.51^^31^415^130
 ;;^UTILITY(U,$J,358.3,6858,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6858,1,4,0)
 ;;=4^786.51
 ;;^UTILITY(U,$J,358.3,6858,1,5,0)
 ;;=5^Precordial Pain
 ;;^UTILITY(U,$J,358.3,6858,2)
 ;;=Precordial Pain^276877
 ;;^UTILITY(U,$J,358.3,6859,0)
 ;;=786.2^^31^415^45
 ;;^UTILITY(U,$J,358.3,6859,1,0)
 ;;=^358.31IA^5^2
