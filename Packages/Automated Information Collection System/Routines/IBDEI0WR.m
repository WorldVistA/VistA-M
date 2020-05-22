IBDEI0WR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14585,1,4,0)
 ;;=4^Z57.1
 ;;^UTILITY(U,$J,358.3,14585,2)
 ;;=^5063119
 ;;^UTILITY(U,$J,358.3,14586,0)
 ;;=Z57.4^^83^826^83
 ;;^UTILITY(U,$J,358.3,14586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14586,1,3,0)
 ;;=3^Occupational Exposure to Agriculture Toxic Agents
 ;;^UTILITY(U,$J,358.3,14586,1,4,0)
 ;;=4^Z57.4
 ;;^UTILITY(U,$J,358.3,14586,2)
 ;;=^5063123
 ;;^UTILITY(U,$J,358.3,14587,0)
 ;;=Z57.5^^83^826^87
 ;;^UTILITY(U,$J,358.3,14587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14587,1,3,0)
 ;;=3^Occupational Exposure to Industrial Toxic Agents
 ;;^UTILITY(U,$J,358.3,14587,1,4,0)
 ;;=4^Z57.5
 ;;^UTILITY(U,$J,358.3,14587,2)
 ;;=^5063124
 ;;^UTILITY(U,$J,358.3,14588,0)
 ;;=Z57.9^^83^826^92
 ;;^UTILITY(U,$J,358.3,14588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14588,1,3,0)
 ;;=3^Occupational Exposure to Unspec Risk Factor
 ;;^UTILITY(U,$J,358.3,14588,1,4,0)
 ;;=4^Z57.9
 ;;^UTILITY(U,$J,358.3,14588,2)
 ;;=^5063128
 ;;^UTILITY(U,$J,358.3,14589,0)
 ;;=Z57.7^^83^826^93
 ;;^UTILITY(U,$J,358.3,14589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14589,1,3,0)
 ;;=3^Occupational Exposure to Vibration
 ;;^UTILITY(U,$J,358.3,14589,1,4,0)
 ;;=4^Z57.7
 ;;^UTILITY(U,$J,358.3,14589,2)
 ;;=^5063126
 ;;^UTILITY(U,$J,358.3,14590,0)
 ;;=Z71.2^^83^826^95
 ;;^UTILITY(U,$J,358.3,14590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14590,1,3,0)
 ;;=3^Person Consulting for Explanation of Exam/Test Findings
 ;;^UTILITY(U,$J,358.3,14590,1,4,0)
 ;;=4^Z71.2
 ;;^UTILITY(U,$J,358.3,14590,2)
 ;;=^5063244
 ;;^UTILITY(U,$J,358.3,14591,0)
 ;;=Z71.0^^83^826^96
 ;;^UTILITY(U,$J,358.3,14591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14591,1,3,0)
 ;;=3^Person Consulting on Behalf Another Person
 ;;^UTILITY(U,$J,358.3,14591,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,14591,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,14592,0)
 ;;=Z71.1^^83^826^97
 ;;^UTILITY(U,$J,358.3,14592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14592,1,3,0)
 ;;=3^Person w/ Feared Health Complaint w/ No Diagnosis Made
 ;;^UTILITY(U,$J,358.3,14592,1,4,0)
 ;;=4^Z71.1
 ;;^UTILITY(U,$J,358.3,14592,2)
 ;;=^5063243
 ;;^UTILITY(U,$J,358.3,14593,0)
 ;;=Z91.419^^83^826^98
 ;;^UTILITY(U,$J,358.3,14593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14593,1,3,0)
 ;;=3^Personal Hx of Adult Abuse,Unspec
 ;;^UTILITY(U,$J,358.3,14593,1,4,0)
 ;;=4^Z91.419
 ;;^UTILITY(U,$J,358.3,14593,2)
 ;;=^5063622
 ;;^UTILITY(U,$J,358.3,14594,0)
 ;;=Z91.412^^83^826^99
 ;;^UTILITY(U,$J,358.3,14594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14594,1,3,0)
 ;;=3^Personal Hx of Adult Neglect
 ;;^UTILITY(U,$J,358.3,14594,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,14594,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,14595,0)
 ;;=Z87.892^^83^826^100
 ;;^UTILITY(U,$J,358.3,14595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14595,1,3,0)
 ;;=3^Personal Hx of Anaphylaxis
 ;;^UTILITY(U,$J,358.3,14595,1,4,0)
 ;;=4^Z87.892
 ;;^UTILITY(U,$J,358.3,14595,2)
 ;;=^5063519
 ;;^UTILITY(U,$J,358.3,14596,0)
 ;;=Z87.410^^83^826^101
 ;;^UTILITY(U,$J,358.3,14596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14596,1,3,0)
 ;;=3^Personal Hx of Cervical Dysplasia
 ;;^UTILITY(U,$J,358.3,14596,1,4,0)
 ;;=4^Z87.410
 ;;^UTILITY(U,$J,358.3,14596,2)
 ;;=^5063489
 ;;^UTILITY(U,$J,358.3,14597,0)
 ;;=Z86.51^^83^826^102
 ;;^UTILITY(U,$J,358.3,14597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14597,1,3,0)
 ;;=3^Personal Hx of Combat/Operational Stress Reaction
