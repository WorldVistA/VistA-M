IBDEI0TN ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29828,1,3,0)
 ;;=3^Pathological fracture, right fibula, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,29828,1,4,0)
 ;;=4^M84.463D
 ;;^UTILITY(U,$J,358.3,29828,2)
 ;;=^5013945
 ;;^UTILITY(U,$J,358.3,29829,0)
 ;;=M00.832^^111^1434^1
 ;;^UTILITY(U,$J,358.3,29829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29829,1,3,0)
 ;;=3^Arthritis d/t other bacteria, left wrist
 ;;^UTILITY(U,$J,358.3,29829,1,4,0)
 ;;=4^M00.832
 ;;^UTILITY(U,$J,358.3,29829,2)
 ;;=^5009677
 ;;^UTILITY(U,$J,358.3,29830,0)
 ;;=M00.831^^111^1434^2
 ;;^UTILITY(U,$J,358.3,29830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29830,1,3,0)
 ;;=3^Arthritis d/t other bacteria, right wrist
 ;;^UTILITY(U,$J,358.3,29830,1,4,0)
 ;;=4^M00.831
 ;;^UTILITY(U,$J,358.3,29830,2)
 ;;=^5009676
 ;;^UTILITY(U,$J,358.3,29831,0)
 ;;=G56.02^^111^1434^3
 ;;^UTILITY(U,$J,358.3,29831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29831,1,3,0)
 ;;=3^Carpal tunnel syndrome, left upper limb
 ;;^UTILITY(U,$J,358.3,29831,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,29831,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,29832,0)
 ;;=G56.01^^111^1434^4
 ;;^UTILITY(U,$J,358.3,29832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29832,1,3,0)
 ;;=3^Carpal tunnel syndrome, right upper limb
 ;;^UTILITY(U,$J,358.3,29832,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,29832,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,29833,0)
 ;;=S52.532A^^111^1434^5
 ;;^UTILITY(U,$J,358.3,29833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29833,1,3,0)
 ;;=3^Colles' fracture of left radius, init for clos fx
 ;;^UTILITY(U,$J,358.3,29833,1,4,0)
 ;;=4^S52.532A
 ;;^UTILITY(U,$J,358.3,29833,2)
 ;;=^5030737
 ;;^UTILITY(U,$J,358.3,29834,0)
 ;;=S52.531A^^111^1434^7
 ;;^UTILITY(U,$J,358.3,29834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29834,1,3,0)
 ;;=3^Colles' fracture of right radius, init for clos fx
 ;;^UTILITY(U,$J,358.3,29834,1,4,0)
 ;;=4^S52.531A
 ;;^UTILITY(U,$J,358.3,29834,2)
 ;;=^5030721
 ;;^UTILITY(U,$J,358.3,29835,0)
 ;;=S62.102A^^111^1434^13
 ;;^UTILITY(U,$J,358.3,29835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29835,1,3,0)
 ;;=3^Fracture of unsp carpal bone, left wrist, init for clos fx
 ;;^UTILITY(U,$J,358.3,29835,1,4,0)
 ;;=4^S62.102A
 ;;^UTILITY(U,$J,358.3,29835,2)
 ;;=^5033206
 ;;^UTILITY(U,$J,358.3,29836,0)
 ;;=S62.101A^^111^1434^14
 ;;^UTILITY(U,$J,358.3,29836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29836,1,3,0)
 ;;=3^Fracture of unsp carpal bone, right wrist, init for clos fx
 ;;^UTILITY(U,$J,358.3,29836,1,4,0)
 ;;=4^S62.101A
 ;;^UTILITY(U,$J,358.3,29836,2)
 ;;=^5033199
 ;;^UTILITY(U,$J,358.3,29837,0)
 ;;=M67.432^^111^1434^16
 ;;^UTILITY(U,$J,358.3,29837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29837,1,3,0)
 ;;=3^Ganglion, left wrist
 ;;^UTILITY(U,$J,358.3,29837,1,4,0)
 ;;=4^M67.432
 ;;^UTILITY(U,$J,358.3,29837,2)
 ;;=^5012964
 ;;^UTILITY(U,$J,358.3,29838,0)
 ;;=M67.431^^111^1434^17
 ;;^UTILITY(U,$J,358.3,29838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29838,1,3,0)
 ;;=3^Ganglion, right wrist
 ;;^UTILITY(U,$J,358.3,29838,1,4,0)
 ;;=4^M67.431
 ;;^UTILITY(U,$J,358.3,29838,2)
 ;;=^5012963
 ;;^UTILITY(U,$J,358.3,29839,0)
 ;;=M25.532^^111^1434^18
 ;;^UTILITY(U,$J,358.3,29839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29839,1,3,0)
 ;;=3^Pain in left wrist
 ;;^UTILITY(U,$J,358.3,29839,1,4,0)
 ;;=4^M25.532
 ;;^UTILITY(U,$J,358.3,29839,2)
 ;;=^5011609
 ;;^UTILITY(U,$J,358.3,29840,0)
 ;;=M25.531^^111^1434^19
 ;;^UTILITY(U,$J,358.3,29840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29840,1,3,0)
 ;;=3^Pain in right wrist
 ;;^UTILITY(U,$J,358.3,29840,1,4,0)
 ;;=4^M25.531
 ;;^UTILITY(U,$J,358.3,29840,2)
 ;;=^5011608
 ;;^UTILITY(U,$J,358.3,29841,0)
 ;;=M19.032^^111^1434^22
 ;;^UTILITY(U,$J,358.3,29841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29841,1,3,0)
 ;;=3^Primary osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,29841,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,29841,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,29842,0)
 ;;=M19.031^^111^1434^23
 ;;^UTILITY(U,$J,358.3,29842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29842,1,3,0)
 ;;=3^Primary osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,29842,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,29842,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,29843,0)
 ;;=M65.4^^111^1434^24
 ;;^UTILITY(U,$J,358.3,29843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29843,1,3,0)
 ;;=3^Radial styloid tenosynovitis [de Quervain]
 ;;^UTILITY(U,$J,358.3,29843,1,4,0)
 ;;=4^M65.4
 ;;^UTILITY(U,$J,358.3,29843,2)
 ;;=^5012792
 ;;^UTILITY(U,$J,358.3,29844,0)
 ;;=M12.532^^111^1434^31
 ;;^UTILITY(U,$J,358.3,29844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29844,1,3,0)
 ;;=3^Traumatic arthropathy, left wrist
 ;;^UTILITY(U,$J,358.3,29844,1,4,0)
 ;;=4^M12.532
 ;;^UTILITY(U,$J,358.3,29844,2)
 ;;=^5010626
 ;;^UTILITY(U,$J,358.3,29845,0)
 ;;=M12.531^^111^1434^32
 ;;^UTILITY(U,$J,358.3,29845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29845,1,3,0)
 ;;=3^Traumatic arthropathy, right wrist
 ;;^UTILITY(U,$J,358.3,29845,1,4,0)
 ;;=4^M12.531
 ;;^UTILITY(U,$J,358.3,29845,2)
 ;;=^5010625
 ;;^UTILITY(U,$J,358.3,29846,0)
 ;;=S52.502A^^111^1434^9
 ;;^UTILITY(U,$J,358.3,29846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29846,1,3,0)
 ;;=3^Fracture of the lower end of left radius, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,29846,1,4,0)
 ;;=4^S52.502A
 ;;^UTILITY(U,$J,358.3,29846,2)
 ;;=^5030603
 ;;^UTILITY(U,$J,358.3,29847,0)
 ;;=S52.501A^^111^1434^11
 ;;^UTILITY(U,$J,358.3,29847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29847,1,3,0)
 ;;=3^Fracture of the lower end of right radius, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,29847,1,4,0)
 ;;=4^S52.501A
 ;;^UTILITY(U,$J,358.3,29847,2)
 ;;=^5030587
 ;;^UTILITY(U,$J,358.3,29848,0)
 ;;=S63.502A^^111^1434^27
 ;;^UTILITY(U,$J,358.3,29848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29848,1,3,0)
 ;;=3^Sprain of left wrist, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,29848,1,4,0)
 ;;=4^S63.502A
 ;;^UTILITY(U,$J,358.3,29848,2)
 ;;=^5035586
 ;;^UTILITY(U,$J,358.3,29849,0)
 ;;=S63.501A^^111^1434^29
 ;;^UTILITY(U,$J,358.3,29849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29849,1,3,0)
 ;;=3^Sprain of right wrist, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,29849,1,4,0)
 ;;=4^S63.501A
 ;;^UTILITY(U,$J,358.3,29849,2)
 ;;=^5035583
 ;;^UTILITY(U,$J,358.3,29850,0)
 ;;=S52.532D^^111^1434^6
 ;;^UTILITY(U,$J,358.3,29850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29850,1,3,0)
 ;;=3^Colles' fracture of left radius, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,29850,1,4,0)
 ;;=4^S52.532D
 ;;^UTILITY(U,$J,358.3,29850,2)
 ;;=^5030740
 ;;^UTILITY(U,$J,358.3,29851,0)
 ;;=S52.531D^^111^1434^8
 ;;^UTILITY(U,$J,358.3,29851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29851,1,3,0)
 ;;=3^Colles' fracture of right radius, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,29851,1,4,0)
 ;;=4^S52.531D
 ;;^UTILITY(U,$J,358.3,29851,2)
 ;;=^5030724
 ;;^UTILITY(U,$J,358.3,29852,0)
 ;;=S52.502D^^111^1434^10
 ;;^UTILITY(U,$J,358.3,29852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29852,1,3,0)
 ;;=3^Fracture of the lower end of left radius, subs encntr
 ;;^UTILITY(U,$J,358.3,29852,1,4,0)
 ;;=4^S52.502D
 ;;^UTILITY(U,$J,358.3,29852,2)
 ;;=^5030605
 ;;^UTILITY(U,$J,358.3,29853,0)
 ;;=S62.101D^^111^1434^15
 ;;^UTILITY(U,$J,358.3,29853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29853,1,3,0)
 ;;=3^Fx unsp carpal bone, right wrist, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,29853,1,4,0)
 ;;=4^S62.101D
 ;;^UTILITY(U,$J,358.3,29853,2)
 ;;=^5033201
 ;;^UTILITY(U,$J,358.3,29854,0)
 ;;=M19.131^^111^1434^21
 ;;^UTILITY(U,$J,358.3,29854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29854,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,29854,1,4,0)
 ;;=4^M19.131
 ;;^UTILITY(U,$J,358.3,29854,2)
 ;;=^5010829
