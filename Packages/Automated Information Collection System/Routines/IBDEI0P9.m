IBDEI0P9 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11337,1,3,0)
 ;;=3^Unavailability/Inaccessibility of Health-Care Facilities
 ;;^UTILITY(U,$J,358.3,11337,1,4,0)
 ;;=4^Z75.3
 ;;^UTILITY(U,$J,358.3,11337,2)
 ;;=^5063292
 ;;^UTILITY(U,$J,358.3,11338,0)
 ;;=Z75.0^^42^527^3
 ;;^UTILITY(U,$J,358.3,11338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11338,1,3,0)
 ;;=3^Medical Services Not Available in Home
 ;;^UTILITY(U,$J,358.3,11338,1,4,0)
 ;;=4^Z75.0
 ;;^UTILITY(U,$J,358.3,11338,2)
 ;;=^5063289
 ;;^UTILITY(U,$J,358.3,11339,0)
 ;;=Z75.1^^42^527^4
 ;;^UTILITY(U,$J,358.3,11339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11339,1,3,0)
 ;;=3^Pt Awaiting Admission to Adequate Facility Elsewhere
 ;;^UTILITY(U,$J,358.3,11339,1,4,0)
 ;;=4^Z75.1
 ;;^UTILITY(U,$J,358.3,11339,2)
 ;;=^5063290
 ;;^UTILITY(U,$J,358.3,11340,0)
 ;;=Z75.4^^42^527^6
 ;;^UTILITY(U,$J,358.3,11340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11340,1,3,0)
 ;;=3^Unavailability/Inaccessibility of Helping Agencies
 ;;^UTILITY(U,$J,358.3,11340,1,4,0)
 ;;=4^Z75.4
 ;;^UTILITY(U,$J,358.3,11340,2)
 ;;=^5063293
 ;;^UTILITY(U,$J,358.3,11341,0)
 ;;=Z75.8^^42^527^2
 ;;^UTILITY(U,$J,358.3,11341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11341,1,3,0)
 ;;=3^Medical Facilities/Health Care Problems
 ;;^UTILITY(U,$J,358.3,11341,1,4,0)
 ;;=4^Z75.8
 ;;^UTILITY(U,$J,358.3,11341,2)
 ;;=^5063295
 ;;^UTILITY(U,$J,358.3,11342,0)
 ;;=Z71.9^^42^527^1
 ;;^UTILITY(U,$J,358.3,11342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11342,1,3,0)
 ;;=3^Counseling,Unspec
 ;;^UTILITY(U,$J,358.3,11342,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,11342,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,11343,0)
 ;;=Z89.201^^42^528^10
 ;;^UTILITY(U,$J,358.3,11343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11343,1,3,0)
 ;;=3^Acquired Absence of Right Upper Limb,Unspec Level
 ;;^UTILITY(U,$J,358.3,11343,1,4,0)
 ;;=4^Z89.201
 ;;^UTILITY(U,$J,358.3,11343,2)
 ;;=^5063543
 ;;^UTILITY(U,$J,358.3,11344,0)
 ;;=Z89.202^^42^528^4
 ;;^UTILITY(U,$J,358.3,11344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11344,1,3,0)
 ;;=3^Acquired Absence of Left Upper Limb,Unspec Level
 ;;^UTILITY(U,$J,358.3,11344,1,4,0)
 ;;=4^Z89.202
 ;;^UTILITY(U,$J,358.3,11344,2)
 ;;=^5063544
 ;;^UTILITY(U,$J,358.3,11345,0)
 ;;=Z89.111^^42^528^6
 ;;^UTILITY(U,$J,358.3,11345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11345,1,3,0)
 ;;=3^Acquired Absence of Right Hand
 ;;^UTILITY(U,$J,358.3,11345,1,4,0)
 ;;=4^Z89.111
 ;;^UTILITY(U,$J,358.3,11345,2)
 ;;=^5063537
 ;;^UTILITY(U,$J,358.3,11346,0)
 ;;=Z89.112^^42^528^1
 ;;^UTILITY(U,$J,358.3,11346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11346,1,3,0)
 ;;=3^Acquired Absence of Left Hand
 ;;^UTILITY(U,$J,358.3,11346,1,4,0)
 ;;=4^Z89.112
 ;;^UTILITY(U,$J,358.3,11346,2)
 ;;=^5063538
 ;;^UTILITY(U,$J,358.3,11347,0)
 ;;=Z89.121^^42^528^11
 ;;^UTILITY(U,$J,358.3,11347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11347,1,3,0)
 ;;=3^Acquired Absence of Right Wrist
 ;;^UTILITY(U,$J,358.3,11347,1,4,0)
 ;;=4^Z89.121
 ;;^UTILITY(U,$J,358.3,11347,2)
 ;;=^5063540
 ;;^UTILITY(U,$J,358.3,11348,0)
 ;;=Z89.122^^42^528^5
 ;;^UTILITY(U,$J,358.3,11348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11348,1,3,0)
 ;;=3^Acquired Absence of Left Wrist
 ;;^UTILITY(U,$J,358.3,11348,1,4,0)
 ;;=4^Z89.122
 ;;^UTILITY(U,$J,358.3,11348,2)
 ;;=^5063541
 ;;^UTILITY(U,$J,358.3,11349,0)
 ;;=Z89.211^^42^528^9
 ;;^UTILITY(U,$J,358.3,11349,1,0)
 ;;=^358.31IA^4^2
