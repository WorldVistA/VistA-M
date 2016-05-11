IBDEI0G6 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7479,1,4,0)
 ;;=4^K08.530
 ;;^UTILITY(U,$J,358.3,7479,2)
 ;;=^5008460
 ;;^UTILITY(U,$J,358.3,7480,0)
 ;;=K08.531^^30^408^81
 ;;^UTILITY(U,$J,358.3,7480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7480,1,3,0)
 ;;=3^Fx Dental Restorative Material w/ Loss of Material
 ;;^UTILITY(U,$J,358.3,7480,1,4,0)
 ;;=4^K08.531
 ;;^UTILITY(U,$J,358.3,7480,2)
 ;;=^5008461
 ;;^UTILITY(U,$J,358.3,7481,0)
 ;;=R53.0^^30^408^128
 ;;^UTILITY(U,$J,358.3,7481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7481,1,3,0)
 ;;=3^Neoplastic Related Fatigue
 ;;^UTILITY(U,$J,358.3,7481,1,4,0)
 ;;=4^R53.0
 ;;^UTILITY(U,$J,358.3,7481,2)
 ;;=^5019515
 ;;^UTILITY(U,$J,358.3,7482,0)
 ;;=R11.11^^30^408^171
 ;;^UTILITY(U,$J,358.3,7482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7482,1,3,0)
 ;;=3^Vomiting w/o Nausea
 ;;^UTILITY(U,$J,358.3,7482,1,4,0)
 ;;=4^R11.11
 ;;^UTILITY(U,$J,358.3,7482,2)
 ;;=^5019233
 ;;^UTILITY(U,$J,358.3,7483,0)
 ;;=S43.51XA^^30^409^11
 ;;^UTILITY(U,$J,358.3,7483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7483,1,3,0)
 ;;=3^Sprain of Right Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,7483,1,4,0)
 ;;=4^S43.51XA
 ;;^UTILITY(U,$J,358.3,7483,2)
 ;;=^5027903
 ;;^UTILITY(U,$J,358.3,7484,0)
 ;;=S43.52XA^^30^409^2
 ;;^UTILITY(U,$J,358.3,7484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7484,1,3,0)
 ;;=3^Sprain of Left Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,7484,1,4,0)
 ;;=4^S43.52XA
 ;;^UTILITY(U,$J,358.3,7484,2)
 ;;=^5027906
 ;;^UTILITY(U,$J,358.3,7485,0)
 ;;=S43.421A^^30^409^16
 ;;^UTILITY(U,$J,358.3,7485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7485,1,3,0)
 ;;=3^Sprain of Right Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,7485,1,4,0)
 ;;=4^S43.421A
 ;;^UTILITY(U,$J,358.3,7485,2)
 ;;=^5027879
 ;;^UTILITY(U,$J,358.3,7486,0)
 ;;=S43.422A^^30^409^7
 ;;^UTILITY(U,$J,358.3,7486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7486,1,3,0)
 ;;=3^Sprain of Left Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,7486,1,4,0)
 ;;=4^S43.422A
 ;;^UTILITY(U,$J,358.3,7486,2)
 ;;=^5027882
 ;;^UTILITY(U,$J,358.3,7487,0)
 ;;=S53.401A^^30^409^13
 ;;^UTILITY(U,$J,358.3,7487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7487,1,3,0)
 ;;=3^Sprain of Right Elbow
 ;;^UTILITY(U,$J,358.3,7487,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,7487,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,7488,0)
 ;;=S53.402A^^30^409^4
 ;;^UTILITY(U,$J,358.3,7488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7488,1,3,0)
 ;;=3^Sprain of Left Elbow
 ;;^UTILITY(U,$J,358.3,7488,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,7488,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,7489,0)
 ;;=S56.011A^^30^409^53
 ;;^UTILITY(U,$J,358.3,7489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7489,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,7489,1,4,0)
 ;;=4^S56.011A
 ;;^UTILITY(U,$J,358.3,7489,2)
 ;;=^5031568
 ;;^UTILITY(U,$J,358.3,7490,0)
 ;;=S56.012A^^30^409^35
 ;;^UTILITY(U,$J,358.3,7490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7490,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,7490,1,4,0)
 ;;=4^S56.012A
 ;;^UTILITY(U,$J,358.3,7490,2)
 ;;=^5031571
 ;;^UTILITY(U,$J,358.3,7491,0)
 ;;=S56.111A^^30^409^41
 ;;^UTILITY(U,$J,358.3,7491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7491,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,7491,1,4,0)
 ;;=4^S56.111A
 ;;^UTILITY(U,$J,358.3,7491,2)
 ;;=^5031616
 ;;^UTILITY(U,$J,358.3,7492,0)
 ;;=S56.112A^^30^409^22
 ;;^UTILITY(U,$J,358.3,7492,1,0)
 ;;=^358.31IA^4^2
