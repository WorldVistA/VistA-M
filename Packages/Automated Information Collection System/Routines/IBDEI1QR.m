IBDEI1QR ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30794,2)
 ;;=^5011606
 ;;^UTILITY(U,$J,358.3,30795,0)
 ;;=M25.521^^179^1928^26
 ;;^UTILITY(U,$J,358.3,30795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30795,1,3,0)
 ;;=3^Pain in right elbow
 ;;^UTILITY(U,$J,358.3,30795,1,4,0)
 ;;=4^M25.521
 ;;^UTILITY(U,$J,358.3,30795,2)
 ;;=^5011605
 ;;^UTILITY(U,$J,358.3,30796,0)
 ;;=M19.022^^179^1928^27
 ;;^UTILITY(U,$J,358.3,30796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30796,1,3,0)
 ;;=3^Primary osteoarthritis, left elbow
 ;;^UTILITY(U,$J,358.3,30796,1,4,0)
 ;;=4^M19.022
 ;;^UTILITY(U,$J,358.3,30796,2)
 ;;=^5010812
 ;;^UTILITY(U,$J,358.3,30797,0)
 ;;=M19.021^^179^1928^28
 ;;^UTILITY(U,$J,358.3,30797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30797,1,3,0)
 ;;=3^Primary osteoarthritis, right elbow
 ;;^UTILITY(U,$J,358.3,30797,1,4,0)
 ;;=4^M19.021
 ;;^UTILITY(U,$J,358.3,30797,2)
 ;;=^5010811
 ;;^UTILITY(U,$J,358.3,30798,0)
 ;;=M12.522^^179^1928^31
 ;;^UTILITY(U,$J,358.3,30798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30798,1,3,0)
 ;;=3^Traumatic arthropathy, left elbow
 ;;^UTILITY(U,$J,358.3,30798,1,4,0)
 ;;=4^M12.522
 ;;^UTILITY(U,$J,358.3,30798,2)
 ;;=^5010623
 ;;^UTILITY(U,$J,358.3,30799,0)
 ;;=M12.521^^179^1928^32
 ;;^UTILITY(U,$J,358.3,30799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30799,1,3,0)
 ;;=3^Traumatic arthropathy, right elbow
 ;;^UTILITY(U,$J,358.3,30799,1,4,0)
 ;;=4^M12.521
 ;;^UTILITY(U,$J,358.3,30799,2)
 ;;=^5010622
 ;;^UTILITY(U,$J,358.3,30800,0)
 ;;=S42.402A^^179^1928^11
 ;;^UTILITY(U,$J,358.3,30800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30800,1,3,0)
 ;;=3^Fracture of lower end of left humerus, init for clos fx,Unspec
 ;;^UTILITY(U,$J,358.3,30800,1,4,0)
 ;;=4^S42.402A
 ;;^UTILITY(U,$J,358.3,30800,2)
 ;;=^5134713
 ;;^UTILITY(U,$J,358.3,30801,0)
 ;;=S42.401A^^179^1928^12
 ;;^UTILITY(U,$J,358.3,30801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30801,1,3,0)
 ;;=3^Fracture of lower end of right humerus, init,Unspec
 ;;^UTILITY(U,$J,358.3,30801,1,4,0)
 ;;=4^S42.401A
 ;;^UTILITY(U,$J,358.3,30801,2)
 ;;=^5027294
 ;;^UTILITY(U,$J,358.3,30802,0)
 ;;=S53.402A^^179^1928^29
 ;;^UTILITY(U,$J,358.3,30802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30802,1,3,0)
 ;;=3^Sprain of left elbow, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,30802,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,30802,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,30803,0)
 ;;=S53.401A^^179^1928^30
 ;;^UTILITY(U,$J,358.3,30803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30803,1,3,0)
 ;;=3^Sprain of right elbow, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,30803,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,30803,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,30804,0)
 ;;=S70.12XA^^179^1929^1
 ;;^UTILITY(U,$J,358.3,30804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30804,1,3,0)
 ;;=3^Contusion of left thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,30804,1,4,0)
 ;;=4^S70.12XA
 ;;^UTILITY(U,$J,358.3,30804,2)
 ;;=^5036846
 ;;^UTILITY(U,$J,358.3,30805,0)
 ;;=S70.11XA^^179^1929^2
 ;;^UTILITY(U,$J,358.3,30805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30805,1,3,0)
 ;;=3^Contusion of right thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,30805,1,4,0)
 ;;=4^S70.11XA
 ;;^UTILITY(U,$J,358.3,30805,2)
 ;;=^5036843
 ;;^UTILITY(U,$J,358.3,30806,0)
 ;;=S72.352A^^179^1929^3
 ;;^UTILITY(U,$J,358.3,30806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30806,1,3,0)
 ;;=3^Displaced comminuted fracture of shaft of left femur, init
 ;;^UTILITY(U,$J,358.3,30806,1,4,0)
 ;;=4^S72.352A
 ;;^UTILITY(U,$J,358.3,30806,2)
 ;;=^5038448
 ;;^UTILITY(U,$J,358.3,30807,0)
 ;;=S72.351A^^179^1929^4
