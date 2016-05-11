IBDEI0PR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12040,1,4,0)
 ;;=4^Z60.9
 ;;^UTILITY(U,$J,358.3,12040,2)
 ;;=^5063145
 ;;^UTILITY(U,$J,358.3,12041,0)
 ;;=Z60.4^^47^538^157
 ;;^UTILITY(U,$J,358.3,12041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12041,1,3,0)
 ;;=3^Problems Related to Social Exclusion/Rejection
 ;;^UTILITY(U,$J,358.3,12041,1,4,0)
 ;;=4^Z60.4
 ;;^UTILITY(U,$J,358.3,12041,2)
 ;;=^5063142
 ;;^UTILITY(U,$J,358.3,12042,0)
 ;;=Z60.5^^47^538^125
 ;;^UTILITY(U,$J,358.3,12042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12042,1,3,0)
 ;;=3^Problems Related to Adverse Discrimination/Persecution
 ;;^UTILITY(U,$J,358.3,12042,1,4,0)
 ;;=4^Z60.5
 ;;^UTILITY(U,$J,358.3,12042,2)
 ;;=^5063143
 ;;^UTILITY(U,$J,358.3,12043,0)
 ;;=Z75.3^^47^538^158
 ;;^UTILITY(U,$J,358.3,12043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12043,1,3,0)
 ;;=3^Problems Related to Unavailability/Inaccessibility of Health-Care Facilities
 ;;^UTILITY(U,$J,358.3,12043,1,4,0)
 ;;=4^Z75.3
 ;;^UTILITY(U,$J,358.3,12043,2)
 ;;=^5063292
 ;;^UTILITY(U,$J,358.3,12044,0)
 ;;=Z75.4^^47^538^159
 ;;^UTILITY(U,$J,358.3,12044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12044,1,3,0)
 ;;=3^Problems Related to Unavailability/Inaccessibility of Helping Agencies
 ;;^UTILITY(U,$J,358.3,12044,1,4,0)
 ;;=4^Z75.4
 ;;^UTILITY(U,$J,358.3,12044,2)
 ;;=^5063293
 ;;^UTILITY(U,$J,358.3,12045,0)
 ;;=Z65.9^^47^538^153
 ;;^UTILITY(U,$J,358.3,12045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12045,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,12045,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,12045,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,12046,0)
 ;;=Z75.2^^47^538^160
 ;;^UTILITY(U,$J,358.3,12046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12046,1,3,0)
 ;;=3^Problems Related to Waiting Period for Investigation/Treatment
 ;;^UTILITY(U,$J,358.3,12046,1,4,0)
 ;;=4^Z75.2
 ;;^UTILITY(U,$J,358.3,12046,2)
 ;;=^5063291
 ;;^UTILITY(U,$J,358.3,12047,0)
 ;;=Z75.5^^47^538^161
 ;;^UTILITY(U,$J,358.3,12047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12047,1,3,0)
 ;;=3^Respite/Holiday Relief Care
 ;;^UTILITY(U,$J,358.3,12047,1,4,0)
 ;;=4^Z75.5
 ;;^UTILITY(U,$J,358.3,12047,2)
 ;;=^5063294
 ;;^UTILITY(U,$J,358.3,12048,0)
 ;;=R68.89^^47^538^165
 ;;^UTILITY(U,$J,358.3,12048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12048,1,3,0)
 ;;=3^Symptoms/Signs,General,Other
 ;;^UTILITY(U,$J,358.3,12048,1,4,0)
 ;;=4^R68.89
 ;;^UTILITY(U,$J,358.3,12048,2)
 ;;=^5019557
 ;;^UTILITY(U,$J,358.3,12049,0)
 ;;=Z72.0^^47^538^168
 ;;^UTILITY(U,$J,358.3,12049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12049,1,3,0)
 ;;=3^Tobacco Use
 ;;^UTILITY(U,$J,358.3,12049,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,12049,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,12050,0)
 ;;=Z94.9^^47^538^169
 ;;^UTILITY(U,$J,358.3,12050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12050,1,3,0)
 ;;=3^Transplanted Organ/Tissue Status,Unspec
 ;;^UTILITY(U,$J,358.3,12050,1,4,0)
 ;;=4^Z94.9
 ;;^UTILITY(U,$J,358.3,12050,2)
 ;;=^5063667
 ;;^UTILITY(U,$J,358.3,12051,0)
 ;;=R76.11^^47^538^166
 ;;^UTILITY(U,$J,358.3,12051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12051,1,3,0)
 ;;=3^TB Skin Test,Nonspecific Reaction w/o Active Tuberculosis
 ;;^UTILITY(U,$J,358.3,12051,1,4,0)
 ;;=4^R76.11
 ;;^UTILITY(U,$J,358.3,12051,2)
 ;;=^5019570
 ;;^UTILITY(U,$J,358.3,12052,0)
 ;;=W10.9XXS^^47^539^18
 ;;^UTILITY(U,$J,358.3,12052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12052,1,3,0)
 ;;=3^Fall from Stairs/Steps,Sequela
 ;;^UTILITY(U,$J,358.3,12052,1,4,0)
 ;;=4^W10.9XXS
 ;;^UTILITY(U,$J,358.3,12052,2)
 ;;=^5059594
 ;;^UTILITY(U,$J,358.3,12053,0)
 ;;=W10.0XXS^^47^539^9
