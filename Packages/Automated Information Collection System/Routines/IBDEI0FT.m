IBDEI0FT ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6829,1,3,0)
 ;;=3^Unequal limb length (acq), lft tibia
 ;;^UTILITY(U,$J,358.3,6829,1,4,0)
 ;;=4^M21.762
 ;;^UTILITY(U,$J,358.3,6829,2)
 ;;=^5011144
 ;;^UTILITY(U,$J,358.3,6830,0)
 ;;=M21.763^^56^439^116
 ;;^UTILITY(U,$J,358.3,6830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6830,1,3,0)
 ;;=3^Unequal limb length (acq), right fibula
 ;;^UTILITY(U,$J,358.3,6830,1,4,0)
 ;;=4^M21.763
 ;;^UTILITY(U,$J,358.3,6830,2)
 ;;=^5011145
 ;;^UTILITY(U,$J,358.3,6831,0)
 ;;=M21.764^^56^439^114
 ;;^UTILITY(U,$J,358.3,6831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6831,1,3,0)
 ;;=3^Unequal limb length (acq), lft fibula
 ;;^UTILITY(U,$J,358.3,6831,1,4,0)
 ;;=4^M21.764
 ;;^UTILITY(U,$J,358.3,6831,2)
 ;;=^5011146
 ;;^UTILITY(U,$J,358.3,6832,0)
 ;;=M21.769^^56^439^119
 ;;^UTILITY(U,$J,358.3,6832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6832,1,3,0)
 ;;=3^Unequal limb length (acq), tibia/fibula, unspec
 ;;^UTILITY(U,$J,358.3,6832,1,4,0)
 ;;=4^M21.769
 ;;^UTILITY(U,$J,358.3,6832,2)
 ;;=^5011147
 ;;^UTILITY(U,$J,358.3,6833,0)
 ;;=M99.86^^56^439^8
 ;;^UTILITY(U,$J,358.3,6833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6833,1,3,0)
 ;;=3^Biomech lesions of lwr extr
 ;;^UTILITY(U,$J,358.3,6833,1,4,0)
 ;;=4^M99.86
 ;;^UTILITY(U,$J,358.3,6833,2)
 ;;=^5015486
 ;;^UTILITY(U,$J,358.3,6834,0)
 ;;=M99.87^^56^439^9
 ;;^UTILITY(U,$J,358.3,6834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6834,1,3,0)
 ;;=3^Biomechl lesions of upr extr
 ;;^UTILITY(U,$J,358.3,6834,1,4,0)
 ;;=4^M99.87
 ;;^UTILITY(U,$J,358.3,6834,2)
 ;;=^5015487
 ;;^UTILITY(U,$J,358.3,6835,0)
 ;;=M99.89^^56^439^7
 ;;^UTILITY(U,$J,358.3,6835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6835,1,3,0)
 ;;=3^Biomech lesions of abdmn & oth regns
 ;;^UTILITY(U,$J,358.3,6835,1,4,0)
 ;;=4^M99.89
 ;;^UTILITY(U,$J,358.3,6835,2)
 ;;=^5015489
 ;;^UTILITY(U,$J,358.3,6836,0)
 ;;=M79.10^^56^439^73
 ;;^UTILITY(U,$J,358.3,6836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6836,1,3,0)
 ;;=3^Myalgia,Unspec Site
 ;;^UTILITY(U,$J,358.3,6836,1,4,0)
 ;;=4^M79.10
 ;;^UTILITY(U,$J,358.3,6836,2)
 ;;=^5157394
 ;;^UTILITY(U,$J,358.3,6837,0)
 ;;=M79.11^^56^439^71
 ;;^UTILITY(U,$J,358.3,6837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6837,1,3,0)
 ;;=3^Myalgia,Mastication Muscle
 ;;^UTILITY(U,$J,358.3,6837,1,4,0)
 ;;=4^M79.11
 ;;^UTILITY(U,$J,358.3,6837,2)
 ;;=^5157395
 ;;^UTILITY(U,$J,358.3,6838,0)
 ;;=M79.12^^56^439^70
 ;;^UTILITY(U,$J,358.3,6838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6838,1,3,0)
 ;;=3^Myalgia,Auxiliary Muscles,Head/Neck
 ;;^UTILITY(U,$J,358.3,6838,1,4,0)
 ;;=4^M79.12
 ;;^UTILITY(U,$J,358.3,6838,2)
 ;;=^5157396
 ;;^UTILITY(U,$J,358.3,6839,0)
 ;;=M79.18^^56^439^72
 ;;^UTILITY(U,$J,358.3,6839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6839,1,3,0)
 ;;=3^Myalgia,Other Site
 ;;^UTILITY(U,$J,358.3,6839,1,4,0)
 ;;=4^M79.18
 ;;^UTILITY(U,$J,358.3,6839,2)
 ;;=^5157397
 ;;^UTILITY(U,$J,358.3,6840,0)
 ;;=M62.830^^56^439^68
 ;;^UTILITY(U,$J,358.3,6840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6840,1,3,0)
 ;;=3^Muscle Spasm,Back
 ;;^UTILITY(U,$J,358.3,6840,1,4,0)
 ;;=4^M62.830
 ;;^UTILITY(U,$J,358.3,6840,2)
 ;;=^5012680
 ;;^UTILITY(U,$J,358.3,6841,0)
 ;;=G44.221^^56^440^2
 ;;^UTILITY(U,$J,358.3,6841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6841,1,3,0)
 ;;=3^Chronic tension-type headache, intractable
