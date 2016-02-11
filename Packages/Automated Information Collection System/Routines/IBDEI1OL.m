IBDEI1OL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28129,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,28129,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,28129,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,28130,0)
 ;;=M16.12^^132^1326^110
 ;;^UTILITY(U,$J,358.3,28130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28130,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,28130,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,28130,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,28131,0)
 ;;=M17.0^^132^1326^106
 ;;^UTILITY(U,$J,358.3,28131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28131,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,28131,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,28131,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,28132,0)
 ;;=M17.11^^132^1326^117
 ;;^UTILITY(U,$J,358.3,28132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28132,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,28132,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,28132,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,28133,0)
 ;;=M17.12^^132^1326^111
 ;;^UTILITY(U,$J,358.3,28133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28133,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,28133,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,28133,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,28134,0)
 ;;=M18.0^^132^1326^105
 ;;^UTILITY(U,$J,358.3,28134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28134,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,28134,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,28134,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,28135,0)
 ;;=M18.11^^132^1326^115
 ;;^UTILITY(U,$J,358.3,28135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28135,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,28135,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,28135,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,28136,0)
 ;;=M18.12^^132^1326^109
 ;;^UTILITY(U,$J,358.3,28136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28136,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,28136,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,28136,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,28137,0)
 ;;=M19.011^^132^1326^118
 ;;^UTILITY(U,$J,358.3,28137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28137,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,28137,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,28137,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,28138,0)
 ;;=M19.012^^132^1326^112
 ;;^UTILITY(U,$J,358.3,28138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28138,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,28138,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,28138,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,28139,0)
 ;;=M19.031^^132^1326^119
 ;;^UTILITY(U,$J,358.3,28139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28139,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,28139,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,28139,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,28140,0)
 ;;=M19.032^^132^1326^113
 ;;^UTILITY(U,$J,358.3,28140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28140,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,28140,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,28140,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,28141,0)
 ;;=M19.041^^132^1326^114
 ;;^UTILITY(U,$J,358.3,28141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28141,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,28141,1,4,0)
 ;;=4^M19.041
