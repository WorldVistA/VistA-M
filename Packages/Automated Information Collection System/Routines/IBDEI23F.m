IBDEI23F ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33461,1,3,0)
 ;;=3^Nondisp fx of head of left radius, init for clos fx
 ;;^UTILITY(U,$J,358.3,33461,1,4,0)
 ;;=4^S52.125A
 ;;^UTILITY(U,$J,358.3,33461,2)
 ;;=^5029111
 ;;^UTILITY(U,$J,358.3,33462,0)
 ;;=S52.124A^^132^1702^31
 ;;^UTILITY(U,$J,358.3,33462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33462,1,3,0)
 ;;=3^Nondisp fx of head of right radius, init for clos fx
 ;;^UTILITY(U,$J,358.3,33462,1,4,0)
 ;;=4^S52.124A
 ;;^UTILITY(U,$J,358.3,33462,2)
 ;;=^5029095
 ;;^UTILITY(U,$J,358.3,33463,0)
 ;;=M70.22^^132^1702^33
 ;;^UTILITY(U,$J,358.3,33463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33463,1,3,0)
 ;;=3^Olecranon bursitis, left elbow
 ;;^UTILITY(U,$J,358.3,33463,1,4,0)
 ;;=4^M70.22
 ;;^UTILITY(U,$J,358.3,33463,2)
 ;;=^5013048
 ;;^UTILITY(U,$J,358.3,33464,0)
 ;;=M70.21^^132^1702^34
 ;;^UTILITY(U,$J,358.3,33464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33464,1,3,0)
 ;;=3^Olecranon bursitis, right elbow
 ;;^UTILITY(U,$J,358.3,33464,1,4,0)
 ;;=4^M70.21
 ;;^UTILITY(U,$J,358.3,33464,2)
 ;;=^5013047
 ;;^UTILITY(U,$J,358.3,33465,0)
 ;;=M25.522^^132^1702^35
 ;;^UTILITY(U,$J,358.3,33465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33465,1,3,0)
 ;;=3^Pain in left elbow
 ;;^UTILITY(U,$J,358.3,33465,1,4,0)
 ;;=4^M25.522
 ;;^UTILITY(U,$J,358.3,33465,2)
 ;;=^5011606
 ;;^UTILITY(U,$J,358.3,33466,0)
 ;;=M25.521^^132^1702^36
 ;;^UTILITY(U,$J,358.3,33466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33466,1,3,0)
 ;;=3^Pain in right elbow
 ;;^UTILITY(U,$J,358.3,33466,1,4,0)
 ;;=4^M25.521
 ;;^UTILITY(U,$J,358.3,33466,2)
 ;;=^5011605
 ;;^UTILITY(U,$J,358.3,33467,0)
 ;;=M19.022^^132^1702^39
 ;;^UTILITY(U,$J,358.3,33467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33467,1,3,0)
 ;;=3^Primary osteoarthritis, left elbow
 ;;^UTILITY(U,$J,358.3,33467,1,4,0)
 ;;=4^M19.022
 ;;^UTILITY(U,$J,358.3,33467,2)
 ;;=^5010812
 ;;^UTILITY(U,$J,358.3,33468,0)
 ;;=M19.021^^132^1702^40
 ;;^UTILITY(U,$J,358.3,33468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33468,1,3,0)
 ;;=3^Primary osteoarthritis, right elbow
 ;;^UTILITY(U,$J,358.3,33468,1,4,0)
 ;;=4^M19.021
 ;;^UTILITY(U,$J,358.3,33468,2)
 ;;=^5010811
 ;;^UTILITY(U,$J,358.3,33469,0)
 ;;=M12.522^^132^1702^45
 ;;^UTILITY(U,$J,358.3,33469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33469,1,3,0)
 ;;=3^Traumatic arthropathy, left elbow
 ;;^UTILITY(U,$J,358.3,33469,1,4,0)
 ;;=4^M12.522
 ;;^UTILITY(U,$J,358.3,33469,2)
 ;;=^5010623
 ;;^UTILITY(U,$J,358.3,33470,0)
 ;;=M12.521^^132^1702^46
 ;;^UTILITY(U,$J,358.3,33470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33470,1,3,0)
 ;;=3^Traumatic arthropathy, right elbow
 ;;^UTILITY(U,$J,358.3,33470,1,4,0)
 ;;=4^M12.521
 ;;^UTILITY(U,$J,358.3,33470,2)
 ;;=^5010622
 ;;^UTILITY(U,$J,358.3,33471,0)
 ;;=S42.402A^^132^1702^19
 ;;^UTILITY(U,$J,358.3,33471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33471,1,3,0)
 ;;=3^Fracture of lower end of left humerus, init for clos fx,Unspec
 ;;^UTILITY(U,$J,358.3,33471,1,4,0)
 ;;=4^S42.402A
 ;;^UTILITY(U,$J,358.3,33471,2)
 ;;=^5134713
 ;;^UTILITY(U,$J,358.3,33472,0)
 ;;=S42.401A^^132^1702^20
 ;;^UTILITY(U,$J,358.3,33472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33472,1,3,0)
 ;;=3^Fracture of lower end of right humerus, init,Unspec
 ;;^UTILITY(U,$J,358.3,33472,1,4,0)
 ;;=4^S42.401A
 ;;^UTILITY(U,$J,358.3,33472,2)
 ;;=^5027294
 ;;^UTILITY(U,$J,358.3,33473,0)
 ;;=S53.402A^^132^1702^41
