IBDEI28G ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37503,1,3,0)
 ;;=3^Compartment syndrome of left upper extremity, subs
 ;;^UTILITY(U,$J,358.3,37503,1,4,0)
 ;;=4^T79.A12D
 ;;^UTILITY(U,$J,358.3,37503,2)
 ;;=^5054330
 ;;^UTILITY(U,$J,358.3,37504,0)
 ;;=T79.A21A^^172^1885^10
 ;;^UTILITY(U,$J,358.3,37504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37504,1,3,0)
 ;;=3^Compartment syndrome of right lower extrem, init
 ;;^UTILITY(U,$J,358.3,37504,1,4,0)
 ;;=4^T79.A21A
 ;;^UTILITY(U,$J,358.3,37504,2)
 ;;=^5054335
 ;;^UTILITY(U,$J,358.3,37505,0)
 ;;=T79.A21D^^172^1885^11
 ;;^UTILITY(U,$J,358.3,37505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37505,1,3,0)
 ;;=3^Compartment syndrome of right lower extrem, subs
 ;;^UTILITY(U,$J,358.3,37505,1,4,0)
 ;;=4^T79.A21D
 ;;^UTILITY(U,$J,358.3,37505,2)
 ;;=^5054336
 ;;^UTILITY(U,$J,358.3,37506,0)
 ;;=T79.A22A^^172^1885^4
 ;;^UTILITY(U,$J,358.3,37506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37506,1,3,0)
 ;;=3^Compartment syndrome of left lower extremity, init
 ;;^UTILITY(U,$J,358.3,37506,1,4,0)
 ;;=4^T79.A22A
 ;;^UTILITY(U,$J,358.3,37506,2)
 ;;=^5137969
 ;;^UTILITY(U,$J,358.3,37507,0)
 ;;=T79.A22D^^172^1885^5
 ;;^UTILITY(U,$J,358.3,37507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37507,1,3,0)
 ;;=3^Compartment syndrome of left lower extremity, subs
 ;;^UTILITY(U,$J,358.3,37507,1,4,0)
 ;;=4^T79.A22D
 ;;^UTILITY(U,$J,358.3,37507,2)
 ;;=^5137970
 ;;^UTILITY(U,$J,358.3,37508,0)
 ;;=T79.A9XA^^172^1885^8
 ;;^UTILITY(U,$J,358.3,37508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37508,1,3,0)
 ;;=3^Compartment syndrome of other sites, init encntr
 ;;^UTILITY(U,$J,358.3,37508,1,4,0)
 ;;=4^T79.A9XA
 ;;^UTILITY(U,$J,358.3,37508,2)
 ;;=^5054341
 ;;^UTILITY(U,$J,358.3,37509,0)
 ;;=T79.A9XD^^172^1885^9
 ;;^UTILITY(U,$J,358.3,37509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37509,1,3,0)
 ;;=3^Compartment syndrome of other sites, subs encntr
 ;;^UTILITY(U,$J,358.3,37509,1,4,0)
 ;;=4^T79.A9XD
 ;;^UTILITY(U,$J,358.3,37509,2)
 ;;=^5054342
 ;;^UTILITY(U,$J,358.3,37510,0)
 ;;=G90.513^^172^1885^19
 ;;^UTILITY(U,$J,358.3,37510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37510,1,3,0)
 ;;=3^Complex regional pain syndrome I of upper limb, bilateral
 ;;^UTILITY(U,$J,358.3,37510,1,4,0)
 ;;=4^G90.513
 ;;^UTILITY(U,$J,358.3,37510,2)
 ;;=^5004166
 ;;^UTILITY(U,$J,358.3,37511,0)
 ;;=T84.52XD^^172^1885^25
 ;;^UTILITY(U,$J,358.3,37511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37511,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal left hip prosth, subs
 ;;^UTILITY(U,$J,358.3,37511,1,4,0)
 ;;=4^T84.52XD
 ;;^UTILITY(U,$J,358.3,37511,2)
 ;;=^5055389
 ;;^UTILITY(U,$J,358.3,37512,0)
 ;;=T84.54XD^^172^1885^26
 ;;^UTILITY(U,$J,358.3,37512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37512,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal left knee prosth, subs
 ;;^UTILITY(U,$J,358.3,37512,1,4,0)
 ;;=4^T84.54XD
 ;;^UTILITY(U,$J,358.3,37512,2)
 ;;=^5055395
 ;;^UTILITY(U,$J,358.3,37513,0)
 ;;=T84.51XD^^172^1885^29
 ;;^UTILITY(U,$J,358.3,37513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37513,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal right hip prosth, subs
 ;;^UTILITY(U,$J,358.3,37513,1,4,0)
 ;;=4^T84.51XD
 ;;^UTILITY(U,$J,358.3,37513,2)
 ;;=^5055386
 ;;^UTILITY(U,$J,358.3,37514,0)
 ;;=T84.53XD^^172^1885^30
 ;;^UTILITY(U,$J,358.3,37514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37514,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal right knee prosth, subs
 ;;^UTILITY(U,$J,358.3,37514,1,4,0)
 ;;=4^T84.53XD
 ;;^UTILITY(U,$J,358.3,37514,2)
 ;;=^5055392
 ;;^UTILITY(U,$J,358.3,37515,0)
 ;;=T84.59XD^^172^1885^32
