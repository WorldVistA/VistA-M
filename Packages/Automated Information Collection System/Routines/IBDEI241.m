IBDEI241 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33720,1,3,0)
 ;;=3^Psoriatic juvenile arthropathy
 ;;^UTILITY(U,$J,358.3,33720,1,4,0)
 ;;=4^L40.54
 ;;^UTILITY(U,$J,358.3,33720,2)
 ;;=^5009169
 ;;^UTILITY(U,$J,358.3,33721,0)
 ;;=L40.59^^132^1709^50
 ;;^UTILITY(U,$J,358.3,33721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33721,1,3,0)
 ;;=3^Psoriatic arthropathy, other
 ;;^UTILITY(U,$J,358.3,33721,1,4,0)
 ;;=4^L40.59
 ;;^UTILITY(U,$J,358.3,33721,2)
 ;;=^5009170
 ;;^UTILITY(U,$J,358.3,33722,0)
 ;;=T79.A11A^^132^1709^12
 ;;^UTILITY(U,$J,358.3,33722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33722,1,3,0)
 ;;=3^Compartment syndrome of right upper extrem, init encntr
 ;;^UTILITY(U,$J,358.3,33722,1,4,0)
 ;;=4^T79.A11A
 ;;^UTILITY(U,$J,358.3,33722,2)
 ;;=^5054326
 ;;^UTILITY(U,$J,358.3,33723,0)
 ;;=T79.A11D^^132^1709^13
 ;;^UTILITY(U,$J,358.3,33723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33723,1,3,0)
 ;;=3^Compartment syndrome of right upper extrem, subs
 ;;^UTILITY(U,$J,358.3,33723,1,4,0)
 ;;=4^T79.A11D
 ;;^UTILITY(U,$J,358.3,33723,2)
 ;;=^5054327
 ;;^UTILITY(U,$J,358.3,33724,0)
 ;;=T79.A12A^^132^1709^6
 ;;^UTILITY(U,$J,358.3,33724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33724,1,3,0)
 ;;=3^Compartment syndrome of left upper extremity, init
 ;;^UTILITY(U,$J,358.3,33724,1,4,0)
 ;;=4^T79.A12A
 ;;^UTILITY(U,$J,358.3,33724,2)
 ;;=^5054329
 ;;^UTILITY(U,$J,358.3,33725,0)
 ;;=T79.A12D^^132^1709^7
 ;;^UTILITY(U,$J,358.3,33725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33725,1,3,0)
 ;;=3^Compartment syndrome of left upper extremity, subs
 ;;^UTILITY(U,$J,358.3,33725,1,4,0)
 ;;=4^T79.A12D
 ;;^UTILITY(U,$J,358.3,33725,2)
 ;;=^5054330
 ;;^UTILITY(U,$J,358.3,33726,0)
 ;;=T79.A21A^^132^1709^10
 ;;^UTILITY(U,$J,358.3,33726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33726,1,3,0)
 ;;=3^Compartment syndrome of right lower extrem, init
 ;;^UTILITY(U,$J,358.3,33726,1,4,0)
 ;;=4^T79.A21A
 ;;^UTILITY(U,$J,358.3,33726,2)
 ;;=^5054335
 ;;^UTILITY(U,$J,358.3,33727,0)
 ;;=T79.A21D^^132^1709^11
 ;;^UTILITY(U,$J,358.3,33727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33727,1,3,0)
 ;;=3^Compartment syndrome of right lower extrem, subs
 ;;^UTILITY(U,$J,358.3,33727,1,4,0)
 ;;=4^T79.A21D
 ;;^UTILITY(U,$J,358.3,33727,2)
 ;;=^5054336
 ;;^UTILITY(U,$J,358.3,33728,0)
 ;;=T79.A22A^^132^1709^4
 ;;^UTILITY(U,$J,358.3,33728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33728,1,3,0)
 ;;=3^Compartment syndrome of left lower extremity, init
 ;;^UTILITY(U,$J,358.3,33728,1,4,0)
 ;;=4^T79.A22A
 ;;^UTILITY(U,$J,358.3,33728,2)
 ;;=^5137969
 ;;^UTILITY(U,$J,358.3,33729,0)
 ;;=T79.A22D^^132^1709^5
 ;;^UTILITY(U,$J,358.3,33729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33729,1,3,0)
 ;;=3^Compartment syndrome of left lower extremity, subs
 ;;^UTILITY(U,$J,358.3,33729,1,4,0)
 ;;=4^T79.A22D
 ;;^UTILITY(U,$J,358.3,33729,2)
 ;;=^5137970
 ;;^UTILITY(U,$J,358.3,33730,0)
 ;;=T79.A9XA^^132^1709^8
 ;;^UTILITY(U,$J,358.3,33730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33730,1,3,0)
 ;;=3^Compartment syndrome of other sites, init encntr
 ;;^UTILITY(U,$J,358.3,33730,1,4,0)
 ;;=4^T79.A9XA
 ;;^UTILITY(U,$J,358.3,33730,2)
 ;;=^5054341
 ;;^UTILITY(U,$J,358.3,33731,0)
 ;;=T79.A9XD^^132^1709^9
 ;;^UTILITY(U,$J,358.3,33731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33731,1,3,0)
 ;;=3^Compartment syndrome of other sites, subs encntr
