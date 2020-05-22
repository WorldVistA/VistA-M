IBDEI24H ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33906,1,3,0)
 ;;=3^Fracture of unsp carpal bone, right wrist, init for clos fx
 ;;^UTILITY(U,$J,358.3,33906,1,4,0)
 ;;=4^S62.101A
 ;;^UTILITY(U,$J,358.3,33906,2)
 ;;=^5033199
 ;;^UTILITY(U,$J,358.3,33907,0)
 ;;=M67.432^^132^1714^16
 ;;^UTILITY(U,$J,358.3,33907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33907,1,3,0)
 ;;=3^Ganglion, left wrist
 ;;^UTILITY(U,$J,358.3,33907,1,4,0)
 ;;=4^M67.432
 ;;^UTILITY(U,$J,358.3,33907,2)
 ;;=^5012964
 ;;^UTILITY(U,$J,358.3,33908,0)
 ;;=M67.431^^132^1714^17
 ;;^UTILITY(U,$J,358.3,33908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33908,1,3,0)
 ;;=3^Ganglion, right wrist
 ;;^UTILITY(U,$J,358.3,33908,1,4,0)
 ;;=4^M67.431
 ;;^UTILITY(U,$J,358.3,33908,2)
 ;;=^5012963
 ;;^UTILITY(U,$J,358.3,33909,0)
 ;;=M25.532^^132^1714^18
 ;;^UTILITY(U,$J,358.3,33909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33909,1,3,0)
 ;;=3^Pain in left wrist
 ;;^UTILITY(U,$J,358.3,33909,1,4,0)
 ;;=4^M25.532
 ;;^UTILITY(U,$J,358.3,33909,2)
 ;;=^5011609
 ;;^UTILITY(U,$J,358.3,33910,0)
 ;;=M25.531^^132^1714^19
 ;;^UTILITY(U,$J,358.3,33910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33910,1,3,0)
 ;;=3^Pain in right wrist
 ;;^UTILITY(U,$J,358.3,33910,1,4,0)
 ;;=4^M25.531
 ;;^UTILITY(U,$J,358.3,33910,2)
 ;;=^5011608
 ;;^UTILITY(U,$J,358.3,33911,0)
 ;;=M19.032^^132^1714^22
 ;;^UTILITY(U,$J,358.3,33911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33911,1,3,0)
 ;;=3^Primary osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,33911,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,33911,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,33912,0)
 ;;=M19.031^^132^1714^23
 ;;^UTILITY(U,$J,358.3,33912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33912,1,3,0)
 ;;=3^Primary osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,33912,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,33912,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,33913,0)
 ;;=M65.4^^132^1714^24
 ;;^UTILITY(U,$J,358.3,33913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33913,1,3,0)
 ;;=3^Radial styloid tenosynovitis [de Quervain]
 ;;^UTILITY(U,$J,358.3,33913,1,4,0)
 ;;=4^M65.4
 ;;^UTILITY(U,$J,358.3,33913,2)
 ;;=^5012792
 ;;^UTILITY(U,$J,358.3,33914,0)
 ;;=M12.532^^132^1714^31
 ;;^UTILITY(U,$J,358.3,33914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33914,1,3,0)
 ;;=3^Traumatic arthropathy, left wrist
 ;;^UTILITY(U,$J,358.3,33914,1,4,0)
 ;;=4^M12.532
 ;;^UTILITY(U,$J,358.3,33914,2)
 ;;=^5010626
 ;;^UTILITY(U,$J,358.3,33915,0)
 ;;=M12.531^^132^1714^32
 ;;^UTILITY(U,$J,358.3,33915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33915,1,3,0)
 ;;=3^Traumatic arthropathy, right wrist
 ;;^UTILITY(U,$J,358.3,33915,1,4,0)
 ;;=4^M12.531
 ;;^UTILITY(U,$J,358.3,33915,2)
 ;;=^5010625
 ;;^UTILITY(U,$J,358.3,33916,0)
 ;;=S52.502A^^132^1714^9
 ;;^UTILITY(U,$J,358.3,33916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33916,1,3,0)
 ;;=3^Fracture of the lower end of left radius, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,33916,1,4,0)
 ;;=4^S52.502A
 ;;^UTILITY(U,$J,358.3,33916,2)
 ;;=^5030603
 ;;^UTILITY(U,$J,358.3,33917,0)
 ;;=S52.501A^^132^1714^11
 ;;^UTILITY(U,$J,358.3,33917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33917,1,3,0)
 ;;=3^Fracture of the lower end of right radius, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,33917,1,4,0)
 ;;=4^S52.501A
 ;;^UTILITY(U,$J,358.3,33917,2)
 ;;=^5030587
 ;;^UTILITY(U,$J,358.3,33918,0)
 ;;=S63.502A^^132^1714^27
