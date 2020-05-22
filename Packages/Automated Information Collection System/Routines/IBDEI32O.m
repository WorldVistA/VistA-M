IBDEI32O ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,49059,0)
 ;;=Z87.440^^185^2428^119
 ;;^UTILITY(U,$J,358.3,49059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49059,1,3,0)
 ;;=3^Personal Hx of Urinary Tract Infections
 ;;^UTILITY(U,$J,358.3,49059,1,4,0)
 ;;=4^Z87.440
 ;;^UTILITY(U,$J,358.3,49059,2)
 ;;=^5063495
 ;;^UTILITY(U,$J,358.3,49060,0)
 ;;=Z87.442^^185^2428^118
 ;;^UTILITY(U,$J,358.3,49060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49060,1,3,0)
 ;;=3^Personal Hx of Urinary Calculi
 ;;^UTILITY(U,$J,358.3,49060,1,4,0)
 ;;=4^Z87.442
 ;;^UTILITY(U,$J,358.3,49060,2)
 ;;=^5063497
 ;;^UTILITY(U,$J,358.3,49061,0)
 ;;=Z91.83^^185^2428^120
 ;;^UTILITY(U,$J,358.3,49061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49061,1,3,0)
 ;;=3^Personal Hx of Wandering
 ;;^UTILITY(U,$J,358.3,49061,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,49061,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,49062,0)
 ;;=Z76.89^^185^2428^121
 ;;^UTILITY(U,$J,358.3,49062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49062,1,3,0)
 ;;=3^Persons Encountering Health Services
 ;;^UTILITY(U,$J,358.3,49062,1,4,0)
 ;;=4^Z76.89
 ;;^UTILITY(U,$J,358.3,49062,2)
 ;;=^5063304
 ;;^UTILITY(U,$J,358.3,49063,0)
 ;;=Z60.0^^185^2428^122
 ;;^UTILITY(U,$J,358.3,49063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49063,1,3,0)
 ;;=3^Problems Adjusting to Life-Cycle Transitions
 ;;^UTILITY(U,$J,358.3,49063,1,4,0)
 ;;=4^Z60.0
 ;;^UTILITY(U,$J,358.3,49063,2)
 ;;=^5063139
 ;;^UTILITY(U,$J,358.3,49064,0)
 ;;=Z63.31^^185^2428^148
 ;;^UTILITY(U,$J,358.3,49064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49064,1,3,0)
 ;;=3^Problems Related to Military Deployment Absence
 ;;^UTILITY(U,$J,358.3,49064,1,4,0)
 ;;=4^Z63.31
 ;;^UTILITY(U,$J,358.3,49064,2)
 ;;=^5063166
 ;;^UTILITY(U,$J,358.3,49065,0)
 ;;=Z63.32^^185^2428^135
 ;;^UTILITY(U,$J,358.3,49065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49065,1,3,0)
 ;;=3^Problems Related to Family Member Absence
 ;;^UTILITY(U,$J,358.3,49065,1,4,0)
 ;;=4^Z63.32
 ;;^UTILITY(U,$J,358.3,49065,2)
 ;;=^5063167
 ;;^UTILITY(U,$J,358.3,49066,0)
 ;;=Z60.3^^185^2428^123
 ;;^UTILITY(U,$J,358.3,49066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49066,1,3,0)
 ;;=3^Problems Related to Acculturation Difficulty
 ;;^UTILITY(U,$J,358.3,49066,1,4,0)
 ;;=4^Z60.3
 ;;^UTILITY(U,$J,358.3,49066,2)
 ;;=^5063141
 ;;^UTILITY(U,$J,358.3,49067,0)
 ;;=Z74.9^^185^2428^128
 ;;^UTILITY(U,$J,358.3,49067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49067,1,3,0)
 ;;=3^Problems Related to Care Provider Dependency,Unspec
 ;;^UTILITY(U,$J,358.3,49067,1,4,0)
 ;;=4^Z74.9
 ;;^UTILITY(U,$J,358.3,49067,2)
 ;;=^5063288
 ;;^UTILITY(U,$J,358.3,49068,0)
 ;;=Z63.4^^185^2428^127
 ;;^UTILITY(U,$J,358.3,49068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49068,1,3,0)
 ;;=3^Problems Related to Bereavement
 ;;^UTILITY(U,$J,358.3,49068,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,49068,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,49069,0)
 ;;=Z63.6^^185^2428^129
 ;;^UTILITY(U,$J,358.3,49069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49069,1,3,0)
 ;;=3^Problems Related to Dependent Relative Needing Care at Home
 ;;^UTILITY(U,$J,358.3,49069,1,4,0)
 ;;=4^Z63.6
 ;;^UTILITY(U,$J,358.3,49069,2)
 ;;=^5063170
 ;;^UTILITY(U,$J,358.3,49070,0)
 ;;=Z59.2^^185^2428^131
 ;;^UTILITY(U,$J,358.3,49070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49070,1,3,0)
 ;;=3^Problems Related to Discord w/ Neighbors/Lodgers/Landlord
 ;;^UTILITY(U,$J,358.3,49070,1,4,0)
 ;;=4^Z59.2
