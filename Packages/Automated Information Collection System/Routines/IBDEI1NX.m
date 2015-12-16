IBDEI1NX ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29531,1,3,0)
 ;;=3^Lumbosacral plexus disorders
 ;;^UTILITY(U,$J,358.3,29531,1,4,0)
 ;;=4^G54.1
 ;;^UTILITY(U,$J,358.3,29531,2)
 ;;=^5004008
 ;;^UTILITY(U,$J,358.3,29532,0)
 ;;=G54.8^^176^1888^30
 ;;^UTILITY(U,$J,358.3,29532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29532,1,3,0)
 ;;=3^Nerve root and plexus disorders NEC
 ;;^UTILITY(U,$J,358.3,29532,1,4,0)
 ;;=4^G54.8
 ;;^UTILITY(U,$J,358.3,29532,2)
 ;;=^268502
 ;;^UTILITY(U,$J,358.3,29533,0)
 ;;=G56.21^^176^1888^20
 ;;^UTILITY(U,$J,358.3,29533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29533,1,3,0)
 ;;=3^Lesion of ulnar nerve, right upper limb
 ;;^UTILITY(U,$J,358.3,29533,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,29533,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,29534,0)
 ;;=G56.22^^176^1888^19
 ;;^UTILITY(U,$J,358.3,29534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29534,1,3,0)
 ;;=3^Lesion of ulnar nerve, left upper limb
 ;;^UTILITY(U,$J,358.3,29534,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,29534,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,29535,0)
 ;;=G56.31^^176^1888^16
 ;;^UTILITY(U,$J,358.3,29535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29535,1,3,0)
 ;;=3^Lesion of radial nerve, right upper limb
 ;;^UTILITY(U,$J,358.3,29535,1,4,0)
 ;;=4^G56.31
 ;;^UTILITY(U,$J,358.3,29535,2)
 ;;=^5004027
 ;;^UTILITY(U,$J,358.3,29536,0)
 ;;=G56.32^^176^1888^15
 ;;^UTILITY(U,$J,358.3,29536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29536,1,3,0)
 ;;=3^Lesion of radial nerve, left upper limb
 ;;^UTILITY(U,$J,358.3,29536,1,4,0)
 ;;=4^G56.32
 ;;^UTILITY(U,$J,358.3,29536,2)
 ;;=^5004028
 ;;^UTILITY(U,$J,358.3,29537,0)
 ;;=G56.81^^176^1888^27
 ;;^UTILITY(U,$J,358.3,29537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29537,1,3,0)
 ;;=3^Mononeuropathies of right upper limb NEC
 ;;^UTILITY(U,$J,358.3,29537,1,4,0)
 ;;=4^G56.81
 ;;^UTILITY(U,$J,358.3,29537,2)
 ;;=^5004033
 ;;^UTILITY(U,$J,358.3,29538,0)
 ;;=G56.82^^176^1888^25
 ;;^UTILITY(U,$J,358.3,29538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29538,1,3,0)
 ;;=3^Mononeuropathies of left upper limb NEC
 ;;^UTILITY(U,$J,358.3,29538,1,4,0)
 ;;=4^G56.82
 ;;^UTILITY(U,$J,358.3,29538,2)
 ;;=^5004034
 ;;^UTILITY(U,$J,358.3,29539,0)
 ;;=G57.01^^176^1888^18
 ;;^UTILITY(U,$J,358.3,29539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29539,1,3,0)
 ;;=3^Lesion of sciatic nerve, right lower limb
 ;;^UTILITY(U,$J,358.3,29539,1,4,0)
 ;;=4^G57.01
 ;;^UTILITY(U,$J,358.3,29539,2)
 ;;=^5004039
 ;;^UTILITY(U,$J,358.3,29540,0)
 ;;=G57.02^^176^1888^17
 ;;^UTILITY(U,$J,358.3,29540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29540,1,3,0)
 ;;=3^Lesion of sciatic nerve, left lower limb
 ;;^UTILITY(U,$J,358.3,29540,1,4,0)
 ;;=4^G57.02
 ;;^UTILITY(U,$J,358.3,29540,2)
 ;;=^5004040
 ;;^UTILITY(U,$J,358.3,29541,0)
 ;;=G57.11^^176^1888^23
 ;;^UTILITY(U,$J,358.3,29541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29541,1,3,0)
 ;;=3^Meralgia paresthetica, right lower limb
 ;;^UTILITY(U,$J,358.3,29541,1,4,0)
 ;;=4^G57.11
 ;;^UTILITY(U,$J,358.3,29541,2)
 ;;=^5004042
 ;;^UTILITY(U,$J,358.3,29542,0)
 ;;=G57.12^^176^1888^22
 ;;^UTILITY(U,$J,358.3,29542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29542,1,3,0)
 ;;=3^Meralgia paresthetica, left lower limb
 ;;^UTILITY(U,$J,358.3,29542,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,29542,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,29543,0)
 ;;=G57.21^^176^1888^8
 ;;^UTILITY(U,$J,358.3,29543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29543,1,3,0)
 ;;=3^Lesion of femoral nerve, right lower limb
 ;;^UTILITY(U,$J,358.3,29543,1,4,0)
 ;;=4^G57.21
 ;;^UTILITY(U,$J,358.3,29543,2)
 ;;=^5004045
