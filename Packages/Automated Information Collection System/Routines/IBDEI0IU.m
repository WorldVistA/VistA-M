IBDEI0IU ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9145,0)
 ;;=382.9^^55^611^11
 ;;^UTILITY(U,$J,358.3,9145,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9145,1,4,0)
 ;;=4^Otitis Media
 ;;^UTILITY(U,$J,358.3,9145,1,5,0)
 ;;=5^382.9
 ;;^UTILITY(U,$J,358.3,9145,2)
 ;;=^123967
 ;;^UTILITY(U,$J,358.3,9146,0)
 ;;=145.9^^55^611^2
 ;;^UTILITY(U,$J,358.3,9146,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9146,1,4,0)
 ;;=4^Cancer of Mouth
 ;;^UTILITY(U,$J,358.3,9146,1,5,0)
 ;;=5^145.9
 ;;^UTILITY(U,$J,358.3,9146,2)
 ;;=Cancer of Mouth^267027
 ;;^UTILITY(U,$J,358.3,9147,0)
 ;;=173.40^^55^611^3
 ;;^UTILITY(U,$J,358.3,9147,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9147,1,4,0)
 ;;=4^Cancer of Skin, Scalp/Neck
 ;;^UTILITY(U,$J,358.3,9147,1,5,0)
 ;;=5^173.40
 ;;^UTILITY(U,$J,358.3,9147,2)
 ;;=^340600
 ;;^UTILITY(U,$J,358.3,9148,0)
 ;;=789.06^^55^612^4
 ;;^UTILITY(U,$J,358.3,9148,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9148,1,4,0)
 ;;=4^Epigastric Pain
 ;;^UTILITY(U,$J,358.3,9148,1,5,0)
 ;;=5^789.06
 ;;^UTILITY(U,$J,358.3,9148,2)
 ;;=Epigastric Pain^303323
 ;;^UTILITY(U,$J,358.3,9149,0)
 ;;=789.07^^55^612^1
 ;;^UTILITY(U,$J,358.3,9149,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9149,1,4,0)
 ;;=4^Abdominal Pain, Generalized
 ;;^UTILITY(U,$J,358.3,9149,1,5,0)
 ;;=5^789.07
 ;;^UTILITY(U,$J,358.3,9149,2)
 ;;=Generalized Abdominal Pain^303324
 ;;^UTILITY(U,$J,358.3,9150,0)
 ;;=789.04^^55^612^5
 ;;^UTILITY(U,$J,358.3,9150,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9150,1,4,0)
 ;;=4^LL Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,9150,1,5,0)
 ;;=5^789.04
 ;;^UTILITY(U,$J,358.3,9150,2)
 ;;=LL Quad Abdominal^303321
 ;;^UTILITY(U,$J,358.3,9151,0)
 ;;=789.02^^55^612^6
 ;;^UTILITY(U,$J,358.3,9151,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9151,1,4,0)
 ;;=4^LU Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,9151,1,5,0)
 ;;=5^789.02
 ;;^UTILITY(U,$J,358.3,9151,2)
 ;;=LU Quadrant Abdominal Pain^303319
 ;;^UTILITY(U,$J,358.3,9152,0)
 ;;=789.09^^55^612^2
 ;;^UTILITY(U,$J,358.3,9152,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9152,1,4,0)
 ;;=4^Abdominal Pain, Mult Sites
 ;;^UTILITY(U,$J,358.3,9152,1,5,0)
 ;;=5^789.09
 ;;^UTILITY(U,$J,358.3,9152,2)
 ;;=Abdominal Pain, Mult Sites^303325
 ;;^UTILITY(U,$J,358.3,9153,0)
 ;;=789.05^^55^612^7
 ;;^UTILITY(U,$J,358.3,9153,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9153,1,4,0)
 ;;=4^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,9153,1,5,0)
 ;;=5^789.05
 ;;^UTILITY(U,$J,358.3,9153,2)
 ;;=Periumbilical Pain^303322
 ;;^UTILITY(U,$J,358.3,9154,0)
 ;;=789.03^^55^612^8
 ;;^UTILITY(U,$J,358.3,9154,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9154,1,4,0)
 ;;=4^RL Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,9154,1,5,0)
 ;;=5^789.03
 ;;^UTILITY(U,$J,358.3,9154,2)
 ;;=RL Quadrant Abdominal Pain^303320
 ;;^UTILITY(U,$J,358.3,9155,0)
 ;;=789.01^^55^612^9
 ;;^UTILITY(U,$J,358.3,9155,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9155,1,4,0)
 ;;=4^RU Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,9155,1,5,0)
 ;;=5^789.01
 ;;^UTILITY(U,$J,358.3,9155,2)
 ;;=RU Quadrant Abdominal Pain^303318
 ;;^UTILITY(U,$J,358.3,9156,0)
 ;;=789.00^^55^612^3
 ;;^UTILITY(U,$J,358.3,9156,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9156,1,4,0)
 ;;=4^Abdominal Pain, Unspec
 ;;^UTILITY(U,$J,358.3,9156,1,5,0)
 ;;=5^789.00
 ;;^UTILITY(U,$J,358.3,9156,2)
 ;;=Abdominal Pain, Unspec^303317
 ;;^UTILITY(U,$J,358.3,9157,0)
 ;;=550.90^^55^613^61
 ;;^UTILITY(U,$J,358.3,9157,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9157,1,4,0)
 ;;=4^Hernia,Inguinal Unilateral
 ;;^UTILITY(U,$J,358.3,9157,1,5,0)
 ;;=5^550.90
 ;;^UTILITY(U,$J,358.3,9157,2)
 ;;=^63302
