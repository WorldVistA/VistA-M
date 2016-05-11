IBDEI0PO ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12002,2)
 ;;=^5063477
 ;;^UTILITY(U,$J,358.3,12003,0)
 ;;=Z86.11^^47^538^117
 ;;^UTILITY(U,$J,358.3,12003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12003,1,3,0)
 ;;=3^Personal Hx of Tuberculosis
 ;;^UTILITY(U,$J,358.3,12003,1,4,0)
 ;;=4^Z86.11
 ;;^UTILITY(U,$J,358.3,12003,2)
 ;;=^5063461
 ;;^UTILITY(U,$J,358.3,12004,0)
 ;;=Z87.440^^47^538^119
 ;;^UTILITY(U,$J,358.3,12004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12004,1,3,0)
 ;;=3^Personal Hx of Urinary Tract Infections
 ;;^UTILITY(U,$J,358.3,12004,1,4,0)
 ;;=4^Z87.440
 ;;^UTILITY(U,$J,358.3,12004,2)
 ;;=^5063495
 ;;^UTILITY(U,$J,358.3,12005,0)
 ;;=Z87.442^^47^538^118
 ;;^UTILITY(U,$J,358.3,12005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12005,1,3,0)
 ;;=3^Personal Hx of Urinary Calculi
 ;;^UTILITY(U,$J,358.3,12005,1,4,0)
 ;;=4^Z87.442
 ;;^UTILITY(U,$J,358.3,12005,2)
 ;;=^5063497
 ;;^UTILITY(U,$J,358.3,12006,0)
 ;;=Z91.83^^47^538^120
 ;;^UTILITY(U,$J,358.3,12006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12006,1,3,0)
 ;;=3^Personal Hx of Wandering
 ;;^UTILITY(U,$J,358.3,12006,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,12006,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,12007,0)
 ;;=Z76.89^^47^538^121
 ;;^UTILITY(U,$J,358.3,12007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12007,1,3,0)
 ;;=3^Persons Encountering Health Services
 ;;^UTILITY(U,$J,358.3,12007,1,4,0)
 ;;=4^Z76.89
 ;;^UTILITY(U,$J,358.3,12007,2)
 ;;=^5063304
 ;;^UTILITY(U,$J,358.3,12008,0)
 ;;=Z60.0^^47^538^122
 ;;^UTILITY(U,$J,358.3,12008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12008,1,3,0)
 ;;=3^Problems Adjusting to Life-Cycle Transitions
 ;;^UTILITY(U,$J,358.3,12008,1,4,0)
 ;;=4^Z60.0
 ;;^UTILITY(U,$J,358.3,12008,2)
 ;;=^5063139
 ;;^UTILITY(U,$J,358.3,12009,0)
 ;;=Z63.31^^47^538^148
 ;;^UTILITY(U,$J,358.3,12009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12009,1,3,0)
 ;;=3^Problems Related to Military Deployment Absence
 ;;^UTILITY(U,$J,358.3,12009,1,4,0)
 ;;=4^Z63.31
 ;;^UTILITY(U,$J,358.3,12009,2)
 ;;=^5063166
 ;;^UTILITY(U,$J,358.3,12010,0)
 ;;=Z63.32^^47^538^135
 ;;^UTILITY(U,$J,358.3,12010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12010,1,3,0)
 ;;=3^Problems Related to Family Member Absence
 ;;^UTILITY(U,$J,358.3,12010,1,4,0)
 ;;=4^Z63.32
 ;;^UTILITY(U,$J,358.3,12010,2)
 ;;=^5063167
 ;;^UTILITY(U,$J,358.3,12011,0)
 ;;=Z60.3^^47^538^123
 ;;^UTILITY(U,$J,358.3,12011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12011,1,3,0)
 ;;=3^Problems Related to Acculturation Difficulty
 ;;^UTILITY(U,$J,358.3,12011,1,4,0)
 ;;=4^Z60.3
 ;;^UTILITY(U,$J,358.3,12011,2)
 ;;=^5063141
 ;;^UTILITY(U,$J,358.3,12012,0)
 ;;=Z74.9^^47^538^128
 ;;^UTILITY(U,$J,358.3,12012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12012,1,3,0)
 ;;=3^Problems Related to Care Provider Dependency,Unspec
 ;;^UTILITY(U,$J,358.3,12012,1,4,0)
 ;;=4^Z74.9
 ;;^UTILITY(U,$J,358.3,12012,2)
 ;;=^5063288
 ;;^UTILITY(U,$J,358.3,12013,0)
 ;;=Z63.4^^47^538^127
 ;;^UTILITY(U,$J,358.3,12013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12013,1,3,0)
 ;;=3^Problems Related to Bereavement
 ;;^UTILITY(U,$J,358.3,12013,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,12013,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,12014,0)
 ;;=Z63.6^^47^538^129
 ;;^UTILITY(U,$J,358.3,12014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12014,1,3,0)
 ;;=3^Problems Related to Dependent Relative Needing Care at Home
 ;;^UTILITY(U,$J,358.3,12014,1,4,0)
 ;;=4^Z63.6
 ;;^UTILITY(U,$J,358.3,12014,2)
 ;;=^5063170
 ;;^UTILITY(U,$J,358.3,12015,0)
 ;;=Z59.2^^47^538^131
 ;;^UTILITY(U,$J,358.3,12015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12015,1,3,0)
 ;;=3^Problems Related to Discord w/ Neighbors/Lodgers/Landlord
