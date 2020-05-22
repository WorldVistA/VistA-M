IBDEI23V ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33651,1,3,0)
 ;;=3^Bilateral primary osteoarthritis of knee
 ;;^UTILITY(U,$J,358.3,33651,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,33651,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,33652,0)
 ;;=M17.11^^132^1708^87
 ;;^UTILITY(U,$J,358.3,33652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33652,1,3,0)
 ;;=3^Unilateral primary osteoarthritis, right knee
 ;;^UTILITY(U,$J,358.3,33652,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,33652,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,33653,0)
 ;;=M17.12^^132^1708^86
 ;;^UTILITY(U,$J,358.3,33653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33653,1,3,0)
 ;;=3^Unilateral primary osteoarthritis, left knee
 ;;^UTILITY(U,$J,358.3,33653,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,33653,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,33654,0)
 ;;=M17.2^^132^1708^5
 ;;^UTILITY(U,$J,358.3,33654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33654,1,3,0)
 ;;=3^Bilateral post-traumatic osteoarthritis of knee
 ;;^UTILITY(U,$J,358.3,33654,1,4,0)
 ;;=4^M17.2
 ;;^UTILITY(U,$J,358.3,33654,2)
 ;;=^5010788
 ;;^UTILITY(U,$J,358.3,33655,0)
 ;;=M17.31^^132^1708^84
 ;;^UTILITY(U,$J,358.3,33655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33655,1,3,0)
 ;;=3^Unilateral post-traumatic osteoarthritis, right knee
 ;;^UTILITY(U,$J,358.3,33655,1,4,0)
 ;;=4^M17.31
 ;;^UTILITY(U,$J,358.3,33655,2)
 ;;=^5010790
 ;;^UTILITY(U,$J,358.3,33656,0)
 ;;=M17.32^^132^1708^85
 ;;^UTILITY(U,$J,358.3,33656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33656,1,3,0)
 ;;=3^Unilateral post-traumatic osteoarthritis, left knee
 ;;^UTILITY(U,$J,358.3,33656,1,4,0)
 ;;=4^M17.32
 ;;^UTILITY(U,$J,358.3,33656,2)
 ;;=^5010791
 ;;^UTILITY(U,$J,358.3,33657,0)
 ;;=M17.4^^132^1708^7
 ;;^UTILITY(U,$J,358.3,33657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33657,1,3,0)
 ;;=3^Bilateral secondary osteoarthritis of knee
 ;;^UTILITY(U,$J,358.3,33657,1,4,0)
 ;;=4^M17.4
 ;;^UTILITY(U,$J,358.3,33657,2)
 ;;=^5010792
 ;;^UTILITY(U,$J,358.3,33658,0)
 ;;=M17.5^^132^1708^88
 ;;^UTILITY(U,$J,358.3,33658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33658,1,3,0)
 ;;=3^Unilateral secondary osteoarthritis of knee
 ;;^UTILITY(U,$J,358.3,33658,1,4,0)
 ;;=4^M17.5
 ;;^UTILITY(U,$J,358.3,33658,2)
 ;;=^5010793
 ;;^UTILITY(U,$J,358.3,33659,0)
 ;;=S83.095D^^132^1708^46
 ;;^UTILITY(U,$J,358.3,33659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33659,1,3,0)
 ;;=3^Dislocation Left Patella, subsequent encounter
 ;;^UTILITY(U,$J,358.3,33659,1,4,0)
 ;;=4^S83.095D
 ;;^UTILITY(U,$J,358.3,33659,2)
 ;;=^5137020
 ;;^UTILITY(U,$J,358.3,33660,0)
 ;;=S83.094D^^132^1708^56
 ;;^UTILITY(U,$J,358.3,33660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33660,1,3,0)
 ;;=3^Dislocation Right Patella, subsequent encounter
 ;;^UTILITY(U,$J,358.3,33660,1,4,0)
 ;;=4^S83.094D
 ;;^UTILITY(U,$J,358.3,33660,2)
 ;;=^5042933
 ;;^UTILITY(U,$J,358.3,33661,0)
 ;;=S83.282D^^132^1708^79
 ;;^UTILITY(U,$J,358.3,33661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33661,1,3,0)
 ;;=3^Tear of lat mensc, current injury, left knee, subs
 ;;^UTILITY(U,$J,358.3,33661,1,4,0)
 ;;=4^S83.282D
 ;;^UTILITY(U,$J,358.3,33661,2)
 ;;=^5137065
 ;;^UTILITY(U,$J,358.3,33662,0)
 ;;=S83.281D^^132^1708^80
 ;;^UTILITY(U,$J,358.3,33662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33662,1,3,0)
 ;;=3^Tear of lat mensc, current injury, right knee, subs
 ;;^UTILITY(U,$J,358.3,33662,1,4,0)
 ;;=4^S83.281D
 ;;^UTILITY(U,$J,358.3,33662,2)
 ;;=^5043092
