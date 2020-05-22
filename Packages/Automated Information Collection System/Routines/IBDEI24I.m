IBDEI24I ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33918,1,3,0)
 ;;=3^Sprain of left wrist, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,33918,1,4,0)
 ;;=4^S63.502A
 ;;^UTILITY(U,$J,358.3,33918,2)
 ;;=^5035586
 ;;^UTILITY(U,$J,358.3,33919,0)
 ;;=S63.501A^^132^1714^29
 ;;^UTILITY(U,$J,358.3,33919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33919,1,3,0)
 ;;=3^Sprain of right wrist, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,33919,1,4,0)
 ;;=4^S63.501A
 ;;^UTILITY(U,$J,358.3,33919,2)
 ;;=^5035583
 ;;^UTILITY(U,$J,358.3,33920,0)
 ;;=S52.532D^^132^1714^6
 ;;^UTILITY(U,$J,358.3,33920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33920,1,3,0)
 ;;=3^Colles' fracture of left radius, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,33920,1,4,0)
 ;;=4^S52.532D
 ;;^UTILITY(U,$J,358.3,33920,2)
 ;;=^5030740
 ;;^UTILITY(U,$J,358.3,33921,0)
 ;;=S52.531D^^132^1714^8
 ;;^UTILITY(U,$J,358.3,33921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33921,1,3,0)
 ;;=3^Colles' fracture of right radius, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,33921,1,4,0)
 ;;=4^S52.531D
 ;;^UTILITY(U,$J,358.3,33921,2)
 ;;=^5030724
 ;;^UTILITY(U,$J,358.3,33922,0)
 ;;=S52.502D^^132^1714^10
 ;;^UTILITY(U,$J,358.3,33922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33922,1,3,0)
 ;;=3^Fracture of the lower end of left radius, subs encntr
 ;;^UTILITY(U,$J,358.3,33922,1,4,0)
 ;;=4^S52.502D
 ;;^UTILITY(U,$J,358.3,33922,2)
 ;;=^5030605
 ;;^UTILITY(U,$J,358.3,33923,0)
 ;;=S62.101D^^132^1714^15
 ;;^UTILITY(U,$J,358.3,33923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33923,1,3,0)
 ;;=3^Fx unsp carpal bone, right wrist, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,33923,1,4,0)
 ;;=4^S62.101D
 ;;^UTILITY(U,$J,358.3,33923,2)
 ;;=^5033201
 ;;^UTILITY(U,$J,358.3,33924,0)
 ;;=M19.131^^132^1714^21
 ;;^UTILITY(U,$J,358.3,33924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33924,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,33924,1,4,0)
 ;;=4^M19.131
 ;;^UTILITY(U,$J,358.3,33924,2)
 ;;=^5010829
 ;;^UTILITY(U,$J,358.3,33925,0)
 ;;=M19.132^^132^1714^20
 ;;^UTILITY(U,$J,358.3,33925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33925,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,33925,1,4,0)
 ;;=4^M19.132
 ;;^UTILITY(U,$J,358.3,33925,2)
 ;;=^5010830
 ;;^UTILITY(U,$J,358.3,33926,0)
 ;;=M19.231^^132^1714^26
 ;;^UTILITY(U,$J,358.3,33926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33926,1,3,0)
 ;;=3^Secondary osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,33926,1,4,0)
 ;;=4^M19.231
 ;;^UTILITY(U,$J,358.3,33926,2)
 ;;=^5010844
 ;;^UTILITY(U,$J,358.3,33927,0)
 ;;=M19.232^^132^1714^25
 ;;^UTILITY(U,$J,358.3,33927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33927,1,3,0)
 ;;=3^Secondary osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,33927,1,4,0)
 ;;=4^M19.232
 ;;^UTILITY(U,$J,358.3,33927,2)
 ;;=^5010845
 ;;^UTILITY(U,$J,358.3,33928,0)
 ;;=S63.502D^^132^1714^28
 ;;^UTILITY(U,$J,358.3,33928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33928,1,3,0)
 ;;=3^Sprain of left wrist, subsequent encounter
 ;;^UTILITY(U,$J,358.3,33928,1,4,0)
 ;;=4^S63.502D
 ;;^UTILITY(U,$J,358.3,33928,2)
 ;;=^5035587
 ;;^UTILITY(U,$J,358.3,33929,0)
 ;;=S63.501D^^132^1714^30
 ;;^UTILITY(U,$J,358.3,33929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33929,1,3,0)
 ;;=3^Sprain of right wrist, subsequent encounter
