IBDEI06Y ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3061,0)
 ;;=473.9^^26^248^14
 ;;^UTILITY(U,$J,358.3,3061,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3061,1,4,0)
 ;;=4^Sinusitis,Chronic
 ;;^UTILITY(U,$J,358.3,3061,1,5,0)
 ;;=5^473.9
 ;;^UTILITY(U,$J,358.3,3061,2)
 ;;=^123985
 ;;^UTILITY(U,$J,358.3,3062,0)
 ;;=382.9^^26^248^11
 ;;^UTILITY(U,$J,358.3,3062,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3062,1,4,0)
 ;;=4^Otitis Media
 ;;^UTILITY(U,$J,358.3,3062,1,5,0)
 ;;=5^382.9
 ;;^UTILITY(U,$J,358.3,3062,2)
 ;;=^123967
 ;;^UTILITY(U,$J,358.3,3063,0)
 ;;=145.9^^26^248^2
 ;;^UTILITY(U,$J,358.3,3063,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3063,1,4,0)
 ;;=4^Cancer of Mouth
 ;;^UTILITY(U,$J,358.3,3063,1,5,0)
 ;;=5^145.9
 ;;^UTILITY(U,$J,358.3,3063,2)
 ;;=Cancer of Mouth^267027
 ;;^UTILITY(U,$J,358.3,3064,0)
 ;;=173.40^^26^248^3
 ;;^UTILITY(U,$J,358.3,3064,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3064,1,4,0)
 ;;=4^Cancer of Skin, Scalp/Neck
 ;;^UTILITY(U,$J,358.3,3064,1,5,0)
 ;;=5^173.40
 ;;^UTILITY(U,$J,358.3,3064,2)
 ;;=^340600
 ;;^UTILITY(U,$J,358.3,3065,0)
 ;;=789.06^^26^249^4
 ;;^UTILITY(U,$J,358.3,3065,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3065,1,4,0)
 ;;=4^Epigastric Pain
 ;;^UTILITY(U,$J,358.3,3065,1,5,0)
 ;;=5^789.06
 ;;^UTILITY(U,$J,358.3,3065,2)
 ;;=Epigastric Pain^303323
 ;;^UTILITY(U,$J,358.3,3066,0)
 ;;=789.07^^26^249^1
 ;;^UTILITY(U,$J,358.3,3066,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3066,1,4,0)
 ;;=4^Abdominal Pain, Generalized
 ;;^UTILITY(U,$J,358.3,3066,1,5,0)
 ;;=5^789.07
 ;;^UTILITY(U,$J,358.3,3066,2)
 ;;=Generalized Abdominal Pain^303324
 ;;^UTILITY(U,$J,358.3,3067,0)
 ;;=789.04^^26^249^5
 ;;^UTILITY(U,$J,358.3,3067,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3067,1,4,0)
 ;;=4^LL Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,3067,1,5,0)
 ;;=5^789.04
 ;;^UTILITY(U,$J,358.3,3067,2)
 ;;=LL Quad Abdominal^303321
 ;;^UTILITY(U,$J,358.3,3068,0)
 ;;=789.02^^26^249^6
 ;;^UTILITY(U,$J,358.3,3068,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3068,1,4,0)
 ;;=4^LU Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,3068,1,5,0)
 ;;=5^789.02
 ;;^UTILITY(U,$J,358.3,3068,2)
 ;;=LU Quadrant Abdominal Pain^303319
 ;;^UTILITY(U,$J,358.3,3069,0)
 ;;=789.09^^26^249^2
 ;;^UTILITY(U,$J,358.3,3069,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3069,1,4,0)
 ;;=4^Abdominal Pain, Mult Sites
 ;;^UTILITY(U,$J,358.3,3069,1,5,0)
 ;;=5^789.09
 ;;^UTILITY(U,$J,358.3,3069,2)
 ;;=Abdominal Pain, Mult Sites^303325
 ;;^UTILITY(U,$J,358.3,3070,0)
 ;;=789.05^^26^249^7
 ;;^UTILITY(U,$J,358.3,3070,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3070,1,4,0)
 ;;=4^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,3070,1,5,0)
 ;;=5^789.05
 ;;^UTILITY(U,$J,358.3,3070,2)
 ;;=Periumbilical Pain^303322
 ;;^UTILITY(U,$J,358.3,3071,0)
 ;;=789.03^^26^249^8
 ;;^UTILITY(U,$J,358.3,3071,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3071,1,4,0)
 ;;=4^RL Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,3071,1,5,0)
 ;;=5^789.03
 ;;^UTILITY(U,$J,358.3,3071,2)
 ;;=RL Quadrant Abdominal Pain^303320
 ;;^UTILITY(U,$J,358.3,3072,0)
 ;;=789.01^^26^249^9
 ;;^UTILITY(U,$J,358.3,3072,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3072,1,4,0)
 ;;=4^RU Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,3072,1,5,0)
 ;;=5^789.01
 ;;^UTILITY(U,$J,358.3,3072,2)
 ;;=RU Quadrant Abdominal Pain^303318
 ;;^UTILITY(U,$J,358.3,3073,0)
 ;;=789.00^^26^249^3
 ;;^UTILITY(U,$J,358.3,3073,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3073,1,4,0)
 ;;=4^Abdominal Pain, Unspec
 ;;^UTILITY(U,$J,358.3,3073,1,5,0)
 ;;=5^789.00
 ;;^UTILITY(U,$J,358.3,3073,2)
 ;;=Abdominal Pain, Unspec^303317
 ;;^UTILITY(U,$J,358.3,3074,0)
 ;;=550.90^^26^250^61
