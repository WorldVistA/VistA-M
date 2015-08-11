IBDEI028 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,559,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,559,1,4,0)
 ;;=4^Abdominal Pain,Generalized
 ;;^UTILITY(U,$J,358.3,559,1,5,0)
 ;;=5^789.07
 ;;^UTILITY(U,$J,358.3,559,2)
 ;;=Generalized Abdominal Pain^303324
 ;;^UTILITY(U,$J,358.3,560,0)
 ;;=789.04^^6^74^2
 ;;^UTILITY(U,$J,358.3,560,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,560,1,4,0)
 ;;=4^Abdominal Pain,LL Quad
 ;;^UTILITY(U,$J,358.3,560,1,5,0)
 ;;=5^789.04
 ;;^UTILITY(U,$J,358.3,560,2)
 ;;=LL Quad Abdominal^303321
 ;;^UTILITY(U,$J,358.3,561,0)
 ;;=789.02^^6^74^3
 ;;^UTILITY(U,$J,358.3,561,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,561,1,4,0)
 ;;=4^Abdominal Pain,LU Quad
 ;;^UTILITY(U,$J,358.3,561,1,5,0)
 ;;=5^789.02
 ;;^UTILITY(U,$J,358.3,561,2)
 ;;=LU Quadrant Abdominal Pain^303319
 ;;^UTILITY(U,$J,358.3,562,0)
 ;;=789.09^^6^74^4
 ;;^UTILITY(U,$J,358.3,562,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,562,1,4,0)
 ;;=4^Abdominal Pain,Mult Sites
 ;;^UTILITY(U,$J,358.3,562,1,5,0)
 ;;=5^789.09
 ;;^UTILITY(U,$J,358.3,562,2)
 ;;=Abdominal Pain, Mult Sites^303325
 ;;^UTILITY(U,$J,358.3,563,0)
 ;;=789.05^^6^74^9
 ;;^UTILITY(U,$J,358.3,563,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,563,1,4,0)
 ;;=4^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,563,1,5,0)
 ;;=5^789.05
 ;;^UTILITY(U,$J,358.3,563,2)
 ;;=Periumbilical Pain^303322
 ;;^UTILITY(U,$J,358.3,564,0)
 ;;=789.03^^6^74^5
 ;;^UTILITY(U,$J,358.3,564,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,564,1,4,0)
 ;;=4^Abdominal Pain,RL Quad
 ;;^UTILITY(U,$J,358.3,564,1,5,0)
 ;;=5^789.03
 ;;^UTILITY(U,$J,358.3,564,2)
 ;;=RL Quadrant Abdominal Pain^303320
 ;;^UTILITY(U,$J,358.3,565,0)
 ;;=789.01^^6^74^6
 ;;^UTILITY(U,$J,358.3,565,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,565,1,4,0)
 ;;=4^Abdominal Pain,RU Quad
 ;;^UTILITY(U,$J,358.3,565,1,5,0)
 ;;=5^789.01
 ;;^UTILITY(U,$J,358.3,565,2)
 ;;=RU Quadrant Abdominal Pain^303318
 ;;^UTILITY(U,$J,358.3,566,0)
 ;;=789.00^^6^74^7
 ;;^UTILITY(U,$J,358.3,566,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,566,1,4,0)
 ;;=4^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,566,1,5,0)
 ;;=5^789.00
 ;;^UTILITY(U,$J,358.3,566,2)
 ;;=Abdominal Pain, Unspec^303317
 ;;^UTILITY(U,$J,358.3,567,0)
 ;;=V72.83^^6^75^10
 ;;^UTILITY(U,$J,358.3,567,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,567,1,4,0)
 ;;=4^PRE-OP EVALUATION
 ;;^UTILITY(U,$J,358.3,567,1,5,0)
 ;;=5^V72.83
 ;;^UTILITY(U,$J,358.3,567,2)
 ;;=^321505
 ;;^UTILITY(U,$J,358.3,568,0)
 ;;=V58.49^^6^75^11
 ;;^UTILITY(U,$J,358.3,568,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,568,1,4,0)
 ;;=4^POST-OP AFTERCARE/EXAM
 ;;^UTILITY(U,$J,358.3,568,1,5,0)
 ;;=5^V58.49
 ;;^UTILITY(U,$J,358.3,568,2)
 ;;=^295530
 ;;^UTILITY(U,$J,358.3,569,0)
 ;;=788.99^^6^76^7
 ;;^UTILITY(U,$J,358.3,569,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,569,1,4,0)
 ;;=4^Urinary Sys Sym Other
 ;;^UTILITY(U,$J,358.3,569,1,5,0)
 ;;=5^788.99
 ;;^UTILITY(U,$J,358.3,569,2)
 ;;=^273391
 ;;^UTILITY(U,$J,358.3,570,0)
 ;;=780.99^^6^76^4
 ;;^UTILITY(U,$J,358.3,570,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,570,1,4,0)
 ;;=4^General Symptoms NEC
 ;;^UTILITY(U,$J,358.3,570,1,5,0)
 ;;=5^780.99
 ;;^UTILITY(U,$J,358.3,570,2)
 ;;=^328568
 ;;^UTILITY(U,$J,358.3,571,0)
 ;;=353.6^^6^76^5
 ;;^UTILITY(U,$J,358.3,571,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,571,1,4,0)
 ;;=4^Phantom Limb Syndrome
 ;;^UTILITY(U,$J,358.3,571,1,5,0)
 ;;=5^353.6
 ;;^UTILITY(U,$J,358.3,571,2)
 ;;=^92758
 ;;^UTILITY(U,$J,358.3,572,0)
 ;;=276.51^^6^76^2
 ;;^UTILITY(U,$J,358.3,572,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,572,1,4,0)
 ;;=4^Dehydration
 ;;^UTILITY(U,$J,358.3,572,1,5,0)
 ;;=5^276.51
