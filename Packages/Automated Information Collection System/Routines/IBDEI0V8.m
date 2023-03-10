IBDEI0V8 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14090,1,4,0)
 ;;=4^M17.32
 ;;^UTILITY(U,$J,358.3,14090,2)
 ;;=^5010791
 ;;^UTILITY(U,$J,358.3,14091,0)
 ;;=M17.4^^55^670^7
 ;;^UTILITY(U,$J,358.3,14091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14091,1,3,0)
 ;;=3^Bilateral secondary osteoarthritis of knee
 ;;^UTILITY(U,$J,358.3,14091,1,4,0)
 ;;=4^M17.4
 ;;^UTILITY(U,$J,358.3,14091,2)
 ;;=^5010792
 ;;^UTILITY(U,$J,358.3,14092,0)
 ;;=M17.5^^55^670^88
 ;;^UTILITY(U,$J,358.3,14092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14092,1,3,0)
 ;;=3^Unilateral secondary osteoarthritis of knee
 ;;^UTILITY(U,$J,358.3,14092,1,4,0)
 ;;=4^M17.5
 ;;^UTILITY(U,$J,358.3,14092,2)
 ;;=^5010793
 ;;^UTILITY(U,$J,358.3,14093,0)
 ;;=S83.095D^^55^670^46
 ;;^UTILITY(U,$J,358.3,14093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14093,1,3,0)
 ;;=3^Dislocation Left Patella, subsequent encounter
 ;;^UTILITY(U,$J,358.3,14093,1,4,0)
 ;;=4^S83.095D
 ;;^UTILITY(U,$J,358.3,14093,2)
 ;;=^5137020
 ;;^UTILITY(U,$J,358.3,14094,0)
 ;;=S83.094D^^55^670^56
 ;;^UTILITY(U,$J,358.3,14094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14094,1,3,0)
 ;;=3^Dislocation Right Patella, subsequent encounter
 ;;^UTILITY(U,$J,358.3,14094,1,4,0)
 ;;=4^S83.094D
 ;;^UTILITY(U,$J,358.3,14094,2)
 ;;=^5042933
 ;;^UTILITY(U,$J,358.3,14095,0)
 ;;=S83.282D^^55^670^79
 ;;^UTILITY(U,$J,358.3,14095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14095,1,3,0)
 ;;=3^Tear of lat mensc, current injury, left knee, subs
 ;;^UTILITY(U,$J,358.3,14095,1,4,0)
 ;;=4^S83.282D
 ;;^UTILITY(U,$J,358.3,14095,2)
 ;;=^5137065
 ;;^UTILITY(U,$J,358.3,14096,0)
 ;;=S83.281D^^55^670^80
 ;;^UTILITY(U,$J,358.3,14096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14096,1,3,0)
 ;;=3^Tear of lat mensc, current injury, right knee, subs
 ;;^UTILITY(U,$J,358.3,14096,1,4,0)
 ;;=4^S83.281D
 ;;^UTILITY(U,$J,358.3,14096,2)
 ;;=^5043092
 ;;^UTILITY(U,$J,358.3,14097,0)
 ;;=S83.241D^^55^670^81
 ;;^UTILITY(U,$J,358.3,14097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14097,1,3,0)
 ;;=3^Tear of medial meniscus, current injury, r knee, subs
 ;;^UTILITY(U,$J,358.3,14097,1,4,0)
 ;;=4^S83.241D
 ;;^UTILITY(U,$J,358.3,14097,2)
 ;;=^5043062
 ;;^UTILITY(U,$J,358.3,14098,0)
 ;;=M24.661^^55^670^2
 ;;^UTILITY(U,$J,358.3,14098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14098,1,3,0)
 ;;=3^Ankylosis,Right Knee
 ;;^UTILITY(U,$J,358.3,14098,1,4,0)
 ;;=4^M24.661
 ;;^UTILITY(U,$J,358.3,14098,2)
 ;;=^5011442
 ;;^UTILITY(U,$J,358.3,14099,0)
 ;;=M24.662^^55^670^1
 ;;^UTILITY(U,$J,358.3,14099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14099,1,3,0)
 ;;=3^Ankylosis,Left Knee
 ;;^UTILITY(U,$J,358.3,14099,1,4,0)
 ;;=4^M24.662
 ;;^UTILITY(U,$J,358.3,14099,2)
 ;;=^5011443
 ;;^UTILITY(U,$J,358.3,14100,0)
 ;;=G90.521^^55^670^16
 ;;^UTILITY(U,$J,358.3,14100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14100,1,3,0)
 ;;=3^Complex Regional Pain Syndrome,I of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,14100,1,4,0)
 ;;=4^G90.521
 ;;^UTILITY(U,$J,358.3,14100,2)
 ;;=^5004168
 ;;^UTILITY(U,$J,358.3,14101,0)
 ;;=G90.522^^55^670^15
 ;;^UTILITY(U,$J,358.3,14101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14101,1,3,0)
 ;;=3^Complex Regional Pain Syndrome,I of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,14101,1,4,0)
 ;;=4^G90.522
 ;;^UTILITY(U,$J,358.3,14101,2)
 ;;=^5133371
 ;;^UTILITY(U,$J,358.3,14102,0)
 ;;=G90.523^^55^670^14
 ;;^UTILITY(U,$J,358.3,14102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14102,1,3,0)
 ;;=3^Complex Regional Pain Syndrome,I of Bilateral Lower Limbs
