IBDEI0A4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4206,1,4,0)
 ;;=4^Z57.31
 ;;^UTILITY(U,$J,358.3,4206,2)
 ;;=^5063121
 ;;^UTILITY(U,$J,358.3,4207,0)
 ;;=Z57.6^^28^263^86
 ;;^UTILITY(U,$J,358.3,4207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4207,1,3,0)
 ;;=3^Occupational Exposure to Extreme Temperature
 ;;^UTILITY(U,$J,358.3,4207,1,4,0)
 ;;=4^Z57.6
 ;;^UTILITY(U,$J,358.3,4207,2)
 ;;=^5063125
 ;;^UTILITY(U,$J,358.3,4208,0)
 ;;=Z57.0^^28^263^88
 ;;^UTILITY(U,$J,358.3,4208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4208,1,3,0)
 ;;=3^Occupational Exposure to Noise
 ;;^UTILITY(U,$J,358.3,4208,1,4,0)
 ;;=4^Z57.0
 ;;^UTILITY(U,$J,358.3,4208,2)
 ;;=^5063118
 ;;^UTILITY(U,$J,358.3,4209,0)
 ;;=Z57.39^^28^263^84
 ;;^UTILITY(U,$J,358.3,4209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4209,1,3,0)
 ;;=3^Occupational Exposure to Air Contaminants
 ;;^UTILITY(U,$J,358.3,4209,1,4,0)
 ;;=4^Z57.39
 ;;^UTILITY(U,$J,358.3,4209,2)
 ;;=^5063122
 ;;^UTILITY(U,$J,358.3,4210,0)
 ;;=Z57.8^^28^263^89
 ;;^UTILITY(U,$J,358.3,4210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4210,1,3,0)
 ;;=3^Occupational Exposure to Other Risk Factors
 ;;^UTILITY(U,$J,358.3,4210,1,4,0)
 ;;=4^Z57.8
 ;;^UTILITY(U,$J,358.3,4210,2)
 ;;=^5063127
 ;;^UTILITY(U,$J,358.3,4211,0)
 ;;=Z57.1^^28^263^90
 ;;^UTILITY(U,$J,358.3,4211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4211,1,3,0)
 ;;=3^Occupational Exposure to Radiation
 ;;^UTILITY(U,$J,358.3,4211,1,4,0)
 ;;=4^Z57.1
 ;;^UTILITY(U,$J,358.3,4211,2)
 ;;=^5063119
 ;;^UTILITY(U,$J,358.3,4212,0)
 ;;=Z57.4^^28^263^83
 ;;^UTILITY(U,$J,358.3,4212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4212,1,3,0)
 ;;=3^Occupational Exposure to Agriculture Toxic Agents
 ;;^UTILITY(U,$J,358.3,4212,1,4,0)
 ;;=4^Z57.4
 ;;^UTILITY(U,$J,358.3,4212,2)
 ;;=^5063123
 ;;^UTILITY(U,$J,358.3,4213,0)
 ;;=Z57.5^^28^263^87
 ;;^UTILITY(U,$J,358.3,4213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4213,1,3,0)
 ;;=3^Occupational Exposure to Industrial Toxic Agents
 ;;^UTILITY(U,$J,358.3,4213,1,4,0)
 ;;=4^Z57.5
 ;;^UTILITY(U,$J,358.3,4213,2)
 ;;=^5063124
 ;;^UTILITY(U,$J,358.3,4214,0)
 ;;=Z57.9^^28^263^92
 ;;^UTILITY(U,$J,358.3,4214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4214,1,3,0)
 ;;=3^Occupational Exposure to Unspec Risk Factor
 ;;^UTILITY(U,$J,358.3,4214,1,4,0)
 ;;=4^Z57.9
 ;;^UTILITY(U,$J,358.3,4214,2)
 ;;=^5063128
 ;;^UTILITY(U,$J,358.3,4215,0)
 ;;=Z57.7^^28^263^93
 ;;^UTILITY(U,$J,358.3,4215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4215,1,3,0)
 ;;=3^Occupational Exposure to Vibration
 ;;^UTILITY(U,$J,358.3,4215,1,4,0)
 ;;=4^Z57.7
 ;;^UTILITY(U,$J,358.3,4215,2)
 ;;=^5063126
 ;;^UTILITY(U,$J,358.3,4216,0)
 ;;=Z71.2^^28^263^95
 ;;^UTILITY(U,$J,358.3,4216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4216,1,3,0)
 ;;=3^Person Consulting for Explanation of Exam/Test Findings
 ;;^UTILITY(U,$J,358.3,4216,1,4,0)
 ;;=4^Z71.2
 ;;^UTILITY(U,$J,358.3,4216,2)
 ;;=^5063244
 ;;^UTILITY(U,$J,358.3,4217,0)
 ;;=Z71.0^^28^263^96
 ;;^UTILITY(U,$J,358.3,4217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4217,1,3,0)
 ;;=3^Person Consulting on Behalf Another Person
 ;;^UTILITY(U,$J,358.3,4217,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,4217,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,4218,0)
 ;;=Z71.1^^28^263^97
 ;;^UTILITY(U,$J,358.3,4218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4218,1,3,0)
 ;;=3^Person w/ Feared Health Complaint w/ No Diagnosis Made
 ;;^UTILITY(U,$J,358.3,4218,1,4,0)
 ;;=4^Z71.1
 ;;^UTILITY(U,$J,358.3,4218,2)
 ;;=^5063243
 ;;^UTILITY(U,$J,358.3,4219,0)
 ;;=Z91.419^^28^263^98
 ;;^UTILITY(U,$J,358.3,4219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4219,1,3,0)
 ;;=3^Personal Hx of Adult Abuse,Unspec
