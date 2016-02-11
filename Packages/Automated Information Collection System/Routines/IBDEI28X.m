IBDEI28X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37711,1,3,0)
 ;;=3^Fracture of the lower end of left radius, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,37711,1,4,0)
 ;;=4^S52.502A
 ;;^UTILITY(U,$J,358.3,37711,2)
 ;;=^5030603
 ;;^UTILITY(U,$J,358.3,37712,0)
 ;;=S52.501A^^172^1890^11
 ;;^UTILITY(U,$J,358.3,37712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37712,1,3,0)
 ;;=3^Fracture of the lower end of right radius, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,37712,1,4,0)
 ;;=4^S52.501A
 ;;^UTILITY(U,$J,358.3,37712,2)
 ;;=^5030587
 ;;^UTILITY(U,$J,358.3,37713,0)
 ;;=S63.502A^^172^1890^27
 ;;^UTILITY(U,$J,358.3,37713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37713,1,3,0)
 ;;=3^Sprain of left wrist, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,37713,1,4,0)
 ;;=4^S63.502A
 ;;^UTILITY(U,$J,358.3,37713,2)
 ;;=^5035586
 ;;^UTILITY(U,$J,358.3,37714,0)
 ;;=S63.501A^^172^1890^29
 ;;^UTILITY(U,$J,358.3,37714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37714,1,3,0)
 ;;=3^Sprain of right wrist, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,37714,1,4,0)
 ;;=4^S63.501A
 ;;^UTILITY(U,$J,358.3,37714,2)
 ;;=^5035583
 ;;^UTILITY(U,$J,358.3,37715,0)
 ;;=S52.532D^^172^1890^6
 ;;^UTILITY(U,$J,358.3,37715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37715,1,3,0)
 ;;=3^Colles' fracture of left radius, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,37715,1,4,0)
 ;;=4^S52.532D
 ;;^UTILITY(U,$J,358.3,37715,2)
 ;;=^5030740
 ;;^UTILITY(U,$J,358.3,37716,0)
 ;;=S52.531D^^172^1890^8
 ;;^UTILITY(U,$J,358.3,37716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37716,1,3,0)
 ;;=3^Colles' fracture of right radius, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,37716,1,4,0)
 ;;=4^S52.531D
 ;;^UTILITY(U,$J,358.3,37716,2)
 ;;=^5030724
 ;;^UTILITY(U,$J,358.3,37717,0)
 ;;=S52.502D^^172^1890^10
 ;;^UTILITY(U,$J,358.3,37717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37717,1,3,0)
 ;;=3^Fracture of the lower end of left radius, subs encntr
 ;;^UTILITY(U,$J,358.3,37717,1,4,0)
 ;;=4^S52.502D
 ;;^UTILITY(U,$J,358.3,37717,2)
 ;;=^5030605
 ;;^UTILITY(U,$J,358.3,37718,0)
 ;;=S62.101D^^172^1890^15
 ;;^UTILITY(U,$J,358.3,37718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37718,1,3,0)
 ;;=3^Fx unsp carpal bone, right wrist, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,37718,1,4,0)
 ;;=4^S62.101D
 ;;^UTILITY(U,$J,358.3,37718,2)
 ;;=^5033201
 ;;^UTILITY(U,$J,358.3,37719,0)
 ;;=M19.131^^172^1890^21
 ;;^UTILITY(U,$J,358.3,37719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37719,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,37719,1,4,0)
 ;;=4^M19.131
 ;;^UTILITY(U,$J,358.3,37719,2)
 ;;=^5010829
 ;;^UTILITY(U,$J,358.3,37720,0)
 ;;=M19.132^^172^1890^20
 ;;^UTILITY(U,$J,358.3,37720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37720,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,37720,1,4,0)
 ;;=4^M19.132
 ;;^UTILITY(U,$J,358.3,37720,2)
 ;;=^5010830
 ;;^UTILITY(U,$J,358.3,37721,0)
 ;;=M19.231^^172^1890^26
 ;;^UTILITY(U,$J,358.3,37721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37721,1,3,0)
 ;;=3^Secondary osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,37721,1,4,0)
 ;;=4^M19.231
 ;;^UTILITY(U,$J,358.3,37721,2)
 ;;=^5010844
 ;;^UTILITY(U,$J,358.3,37722,0)
 ;;=M19.232^^172^1890^25
 ;;^UTILITY(U,$J,358.3,37722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37722,1,3,0)
 ;;=3^Secondary osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,37722,1,4,0)
 ;;=4^M19.232
 ;;^UTILITY(U,$J,358.3,37722,2)
 ;;=^5010845
 ;;^UTILITY(U,$J,358.3,37723,0)
 ;;=S63.502D^^172^1890^28
 ;;^UTILITY(U,$J,358.3,37723,1,0)
 ;;=^358.31IA^4^2
