IBDEI0VT ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14336,1,3,0)
 ;;=3^Carpal tunnel syndrome, right upper limb
 ;;^UTILITY(U,$J,358.3,14336,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,14336,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,14337,0)
 ;;=S52.532A^^55^676^5
 ;;^UTILITY(U,$J,358.3,14337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14337,1,3,0)
 ;;=3^Colles' fracture of left radius, init for clos fx
 ;;^UTILITY(U,$J,358.3,14337,1,4,0)
 ;;=4^S52.532A
 ;;^UTILITY(U,$J,358.3,14337,2)
 ;;=^5030737
 ;;^UTILITY(U,$J,358.3,14338,0)
 ;;=S52.531A^^55^676^7
 ;;^UTILITY(U,$J,358.3,14338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14338,1,3,0)
 ;;=3^Colles' fracture of right radius, init for clos fx
 ;;^UTILITY(U,$J,358.3,14338,1,4,0)
 ;;=4^S52.531A
 ;;^UTILITY(U,$J,358.3,14338,2)
 ;;=^5030721
 ;;^UTILITY(U,$J,358.3,14339,0)
 ;;=S62.102A^^55^676^13
 ;;^UTILITY(U,$J,358.3,14339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14339,1,3,0)
 ;;=3^Fracture of unsp carpal bone, left wrist, init for clos fx
 ;;^UTILITY(U,$J,358.3,14339,1,4,0)
 ;;=4^S62.102A
 ;;^UTILITY(U,$J,358.3,14339,2)
 ;;=^5033206
 ;;^UTILITY(U,$J,358.3,14340,0)
 ;;=S62.101A^^55^676^14
 ;;^UTILITY(U,$J,358.3,14340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14340,1,3,0)
 ;;=3^Fracture of unsp carpal bone, right wrist, init for clos fx
 ;;^UTILITY(U,$J,358.3,14340,1,4,0)
 ;;=4^S62.101A
 ;;^UTILITY(U,$J,358.3,14340,2)
 ;;=^5033199
 ;;^UTILITY(U,$J,358.3,14341,0)
 ;;=M67.432^^55^676^16
 ;;^UTILITY(U,$J,358.3,14341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14341,1,3,0)
 ;;=3^Ganglion, left wrist
 ;;^UTILITY(U,$J,358.3,14341,1,4,0)
 ;;=4^M67.432
 ;;^UTILITY(U,$J,358.3,14341,2)
 ;;=^5012964
 ;;^UTILITY(U,$J,358.3,14342,0)
 ;;=M67.431^^55^676^17
 ;;^UTILITY(U,$J,358.3,14342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14342,1,3,0)
 ;;=3^Ganglion, right wrist
 ;;^UTILITY(U,$J,358.3,14342,1,4,0)
 ;;=4^M67.431
 ;;^UTILITY(U,$J,358.3,14342,2)
 ;;=^5012963
 ;;^UTILITY(U,$J,358.3,14343,0)
 ;;=M25.532^^55^676^18
 ;;^UTILITY(U,$J,358.3,14343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14343,1,3,0)
 ;;=3^Pain in left wrist
 ;;^UTILITY(U,$J,358.3,14343,1,4,0)
 ;;=4^M25.532
 ;;^UTILITY(U,$J,358.3,14343,2)
 ;;=^5011609
 ;;^UTILITY(U,$J,358.3,14344,0)
 ;;=M25.531^^55^676^19
 ;;^UTILITY(U,$J,358.3,14344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14344,1,3,0)
 ;;=3^Pain in right wrist
 ;;^UTILITY(U,$J,358.3,14344,1,4,0)
 ;;=4^M25.531
 ;;^UTILITY(U,$J,358.3,14344,2)
 ;;=^5011608
 ;;^UTILITY(U,$J,358.3,14345,0)
 ;;=M19.032^^55^676^22
 ;;^UTILITY(U,$J,358.3,14345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14345,1,3,0)
 ;;=3^Primary osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,14345,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,14345,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,14346,0)
 ;;=M19.031^^55^676^23
 ;;^UTILITY(U,$J,358.3,14346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14346,1,3,0)
 ;;=3^Primary osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,14346,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,14346,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,14347,0)
 ;;=M65.4^^55^676^24
 ;;^UTILITY(U,$J,358.3,14347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14347,1,3,0)
 ;;=3^Radial styloid tenosynovitis [de Quervain]
 ;;^UTILITY(U,$J,358.3,14347,1,4,0)
 ;;=4^M65.4
 ;;^UTILITY(U,$J,358.3,14347,2)
 ;;=^5012792
 ;;^UTILITY(U,$J,358.3,14348,0)
 ;;=M12.532^^55^676^31
 ;;^UTILITY(U,$J,358.3,14348,1,0)
 ;;=^358.31IA^4^2
