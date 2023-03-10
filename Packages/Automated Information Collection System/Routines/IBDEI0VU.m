IBDEI0VU ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14348,1,3,0)
 ;;=3^Traumatic arthropathy, left wrist
 ;;^UTILITY(U,$J,358.3,14348,1,4,0)
 ;;=4^M12.532
 ;;^UTILITY(U,$J,358.3,14348,2)
 ;;=^5010626
 ;;^UTILITY(U,$J,358.3,14349,0)
 ;;=M12.531^^55^676^32
 ;;^UTILITY(U,$J,358.3,14349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14349,1,3,0)
 ;;=3^Traumatic arthropathy, right wrist
 ;;^UTILITY(U,$J,358.3,14349,1,4,0)
 ;;=4^M12.531
 ;;^UTILITY(U,$J,358.3,14349,2)
 ;;=^5010625
 ;;^UTILITY(U,$J,358.3,14350,0)
 ;;=S52.502A^^55^676^9
 ;;^UTILITY(U,$J,358.3,14350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14350,1,3,0)
 ;;=3^Fracture of the lower end of left radius, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14350,1,4,0)
 ;;=4^S52.502A
 ;;^UTILITY(U,$J,358.3,14350,2)
 ;;=^5030603
 ;;^UTILITY(U,$J,358.3,14351,0)
 ;;=S52.501A^^55^676^11
 ;;^UTILITY(U,$J,358.3,14351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14351,1,3,0)
 ;;=3^Fracture of the lower end of right radius, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14351,1,4,0)
 ;;=4^S52.501A
 ;;^UTILITY(U,$J,358.3,14351,2)
 ;;=^5030587
 ;;^UTILITY(U,$J,358.3,14352,0)
 ;;=S63.502A^^55^676^27
 ;;^UTILITY(U,$J,358.3,14352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14352,1,3,0)
 ;;=3^Sprain of left wrist, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14352,1,4,0)
 ;;=4^S63.502A
 ;;^UTILITY(U,$J,358.3,14352,2)
 ;;=^5035586
 ;;^UTILITY(U,$J,358.3,14353,0)
 ;;=S63.501A^^55^676^29
 ;;^UTILITY(U,$J,358.3,14353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14353,1,3,0)
 ;;=3^Sprain of right wrist, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14353,1,4,0)
 ;;=4^S63.501A
 ;;^UTILITY(U,$J,358.3,14353,2)
 ;;=^5035583
 ;;^UTILITY(U,$J,358.3,14354,0)
 ;;=S52.532D^^55^676^6
 ;;^UTILITY(U,$J,358.3,14354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14354,1,3,0)
 ;;=3^Colles' fracture of left radius, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,14354,1,4,0)
 ;;=4^S52.532D
 ;;^UTILITY(U,$J,358.3,14354,2)
 ;;=^5030740
 ;;^UTILITY(U,$J,358.3,14355,0)
 ;;=S52.531D^^55^676^8
 ;;^UTILITY(U,$J,358.3,14355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14355,1,3,0)
 ;;=3^Colles' fracture of right radius, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,14355,1,4,0)
 ;;=4^S52.531D
 ;;^UTILITY(U,$J,358.3,14355,2)
 ;;=^5030724
 ;;^UTILITY(U,$J,358.3,14356,0)
 ;;=S52.502D^^55^676^10
 ;;^UTILITY(U,$J,358.3,14356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14356,1,3,0)
 ;;=3^Fracture of the lower end of left radius, subs encntr
 ;;^UTILITY(U,$J,358.3,14356,1,4,0)
 ;;=4^S52.502D
 ;;^UTILITY(U,$J,358.3,14356,2)
 ;;=^5030605
 ;;^UTILITY(U,$J,358.3,14357,0)
 ;;=S62.101D^^55^676^15
 ;;^UTILITY(U,$J,358.3,14357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14357,1,3,0)
 ;;=3^Fx unsp carpal bone, right wrist, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,14357,1,4,0)
 ;;=4^S62.101D
 ;;^UTILITY(U,$J,358.3,14357,2)
 ;;=^5033201
 ;;^UTILITY(U,$J,358.3,14358,0)
 ;;=M19.131^^55^676^21
 ;;^UTILITY(U,$J,358.3,14358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14358,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,14358,1,4,0)
 ;;=4^M19.131
 ;;^UTILITY(U,$J,358.3,14358,2)
 ;;=^5010829
 ;;^UTILITY(U,$J,358.3,14359,0)
 ;;=M19.132^^55^676^20
 ;;^UTILITY(U,$J,358.3,14359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14359,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,14359,1,4,0)
 ;;=4^M19.132
