IBDEI0GQ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7252,1,3,0)
 ;;=3^Rheumatoid Arthritis w/o Rhematoid Factor,Unspec Site
 ;;^UTILITY(U,$J,358.3,7252,1,4,0)
 ;;=4^M06.00
 ;;^UTILITY(U,$J,358.3,7252,2)
 ;;=^5010047
 ;;^UTILITY(U,$J,358.3,7253,0)
 ;;=M06.30^^58^473^161
 ;;^UTILITY(U,$J,358.3,7253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7253,1,3,0)
 ;;=3^Rheumatoid Nodule,Unspec Site
 ;;^UTILITY(U,$J,358.3,7253,1,4,0)
 ;;=4^M06.30
 ;;^UTILITY(U,$J,358.3,7253,2)
 ;;=^5010096
 ;;^UTILITY(U,$J,358.3,7254,0)
 ;;=M06.4^^58^473^48
 ;;^UTILITY(U,$J,358.3,7254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7254,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,7254,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,7254,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,7255,0)
 ;;=M06.39^^58^473^160
 ;;^UTILITY(U,$J,358.3,7255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7255,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,7255,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,7255,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,7256,0)
 ;;=M15.0^^58^473^124
 ;;^UTILITY(U,$J,358.3,7256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7256,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,7256,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,7256,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,7257,0)
 ;;=M06.9^^58^473^159
 ;;^UTILITY(U,$J,358.3,7257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7257,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,7257,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,7257,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,7258,0)
 ;;=M16.0^^58^473^127
 ;;^UTILITY(U,$J,358.3,7258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7258,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,7258,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,7258,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,7259,0)
 ;;=M16.11^^58^473^136
 ;;^UTILITY(U,$J,358.3,7259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7259,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,7259,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,7259,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,7260,0)
 ;;=M16.12^^58^473^130
 ;;^UTILITY(U,$J,358.3,7260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7260,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,7260,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,7260,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,7261,0)
 ;;=M17.0^^58^473^126
 ;;^UTILITY(U,$J,358.3,7261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7261,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,7261,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,7261,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,7262,0)
 ;;=M17.11^^58^473^137
 ;;^UTILITY(U,$J,358.3,7262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7262,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,7262,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,7262,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,7263,0)
 ;;=M17.12^^58^473^131
 ;;^UTILITY(U,$J,358.3,7263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7263,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,7263,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,7263,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,7264,0)
 ;;=M18.0^^58^473^125
 ;;^UTILITY(U,$J,358.3,7264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7264,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
