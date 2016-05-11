IBDEI0PM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11977,1,3,0)
 ;;=3^Occupational Exposure to Agriculture Toxic Agents
 ;;^UTILITY(U,$J,358.3,11977,1,4,0)
 ;;=4^Z57.4
 ;;^UTILITY(U,$J,358.3,11977,2)
 ;;=^5063123
 ;;^UTILITY(U,$J,358.3,11978,0)
 ;;=Z57.5^^47^538^87
 ;;^UTILITY(U,$J,358.3,11978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11978,1,3,0)
 ;;=3^Occupational Exposure to Industrial Toxic Agents
 ;;^UTILITY(U,$J,358.3,11978,1,4,0)
 ;;=4^Z57.5
 ;;^UTILITY(U,$J,358.3,11978,2)
 ;;=^5063124
 ;;^UTILITY(U,$J,358.3,11979,0)
 ;;=Z57.9^^47^538^92
 ;;^UTILITY(U,$J,358.3,11979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11979,1,3,0)
 ;;=3^Occupational Exposure to Unspec Risk Factor
 ;;^UTILITY(U,$J,358.3,11979,1,4,0)
 ;;=4^Z57.9
 ;;^UTILITY(U,$J,358.3,11979,2)
 ;;=^5063128
 ;;^UTILITY(U,$J,358.3,11980,0)
 ;;=Z57.7^^47^538^93
 ;;^UTILITY(U,$J,358.3,11980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11980,1,3,0)
 ;;=3^Occupational Exposure to Vibration
 ;;^UTILITY(U,$J,358.3,11980,1,4,0)
 ;;=4^Z57.7
 ;;^UTILITY(U,$J,358.3,11980,2)
 ;;=^5063126
 ;;^UTILITY(U,$J,358.3,11981,0)
 ;;=Z71.2^^47^538^95
 ;;^UTILITY(U,$J,358.3,11981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11981,1,3,0)
 ;;=3^Person Consulting for Explanation of Exam/Test Findings
 ;;^UTILITY(U,$J,358.3,11981,1,4,0)
 ;;=4^Z71.2
 ;;^UTILITY(U,$J,358.3,11981,2)
 ;;=^5063244
 ;;^UTILITY(U,$J,358.3,11982,0)
 ;;=Z71.0^^47^538^96
 ;;^UTILITY(U,$J,358.3,11982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11982,1,3,0)
 ;;=3^Person Consulting on Behalf Another Person
 ;;^UTILITY(U,$J,358.3,11982,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,11982,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,11983,0)
 ;;=Z71.1^^47^538^97
 ;;^UTILITY(U,$J,358.3,11983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11983,1,3,0)
 ;;=3^Person w/ Feared Health Complaint w/ No Diagnosis Made
 ;;^UTILITY(U,$J,358.3,11983,1,4,0)
 ;;=4^Z71.1
 ;;^UTILITY(U,$J,358.3,11983,2)
 ;;=^5063243
 ;;^UTILITY(U,$J,358.3,11984,0)
 ;;=Z91.419^^47^538^98
 ;;^UTILITY(U,$J,358.3,11984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11984,1,3,0)
 ;;=3^Personal Hx of Adult Abuse,Unspec
 ;;^UTILITY(U,$J,358.3,11984,1,4,0)
 ;;=4^Z91.419
 ;;^UTILITY(U,$J,358.3,11984,2)
 ;;=^5063622
 ;;^UTILITY(U,$J,358.3,11985,0)
 ;;=Z91.412^^47^538^99
 ;;^UTILITY(U,$J,358.3,11985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11985,1,3,0)
 ;;=3^Personal Hx of Adult Neglect
 ;;^UTILITY(U,$J,358.3,11985,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,11985,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,11986,0)
 ;;=Z87.892^^47^538^100
 ;;^UTILITY(U,$J,358.3,11986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11986,1,3,0)
 ;;=3^Personal Hx of Anaphylaxis
 ;;^UTILITY(U,$J,358.3,11986,1,4,0)
 ;;=4^Z87.892
 ;;^UTILITY(U,$J,358.3,11986,2)
 ;;=^5063519
 ;;^UTILITY(U,$J,358.3,11987,0)
 ;;=Z87.410^^47^538^101
 ;;^UTILITY(U,$J,358.3,11987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11987,1,3,0)
 ;;=3^Personal Hx of Cervical Dysplasia
 ;;^UTILITY(U,$J,358.3,11987,1,4,0)
 ;;=4^Z87.410
 ;;^UTILITY(U,$J,358.3,11987,2)
 ;;=^5063489
 ;;^UTILITY(U,$J,358.3,11988,0)
 ;;=Z86.51^^47^538^102
 ;;^UTILITY(U,$J,358.3,11988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11988,1,3,0)
 ;;=3^Personal Hx of Combat/Operational Stress Reaction
 ;;^UTILITY(U,$J,358.3,11988,1,4,0)
 ;;=4^Z86.51
 ;;^UTILITY(U,$J,358.3,11988,2)
 ;;=^5063470
 ;;^UTILITY(U,$J,358.3,11989,0)
 ;;=Z86.31^^47^538^103
 ;;^UTILITY(U,$J,358.3,11989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11989,1,3,0)
 ;;=3^Personal Hx of Diabetic Foot Ulcer
 ;;^UTILITY(U,$J,358.3,11989,1,4,0)
 ;;=4^Z86.31
 ;;^UTILITY(U,$J,358.3,11989,2)
 ;;=^5063467
