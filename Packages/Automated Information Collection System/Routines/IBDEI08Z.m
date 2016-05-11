IBDEI08Z ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3917,0)
 ;;=Z57.5^^18^224^87
 ;;^UTILITY(U,$J,358.3,3917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3917,1,3,0)
 ;;=3^Occupational Exposure to Industrial Toxic Agents
 ;;^UTILITY(U,$J,358.3,3917,1,4,0)
 ;;=4^Z57.5
 ;;^UTILITY(U,$J,358.3,3917,2)
 ;;=^5063124
 ;;^UTILITY(U,$J,358.3,3918,0)
 ;;=Z57.9^^18^224^92
 ;;^UTILITY(U,$J,358.3,3918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3918,1,3,0)
 ;;=3^Occupational Exposure to Unspec Risk Factor
 ;;^UTILITY(U,$J,358.3,3918,1,4,0)
 ;;=4^Z57.9
 ;;^UTILITY(U,$J,358.3,3918,2)
 ;;=^5063128
 ;;^UTILITY(U,$J,358.3,3919,0)
 ;;=Z57.7^^18^224^93
 ;;^UTILITY(U,$J,358.3,3919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3919,1,3,0)
 ;;=3^Occupational Exposure to Vibration
 ;;^UTILITY(U,$J,358.3,3919,1,4,0)
 ;;=4^Z57.7
 ;;^UTILITY(U,$J,358.3,3919,2)
 ;;=^5063126
 ;;^UTILITY(U,$J,358.3,3920,0)
 ;;=Z71.2^^18^224^95
 ;;^UTILITY(U,$J,358.3,3920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3920,1,3,0)
 ;;=3^Person Consulting for Explanation of Exam/Test Findings
 ;;^UTILITY(U,$J,358.3,3920,1,4,0)
 ;;=4^Z71.2
 ;;^UTILITY(U,$J,358.3,3920,2)
 ;;=^5063244
 ;;^UTILITY(U,$J,358.3,3921,0)
 ;;=Z71.0^^18^224^96
 ;;^UTILITY(U,$J,358.3,3921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3921,1,3,0)
 ;;=3^Person Consulting on Behalf Another Person
 ;;^UTILITY(U,$J,358.3,3921,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,3921,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,3922,0)
 ;;=Z71.1^^18^224^97
 ;;^UTILITY(U,$J,358.3,3922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3922,1,3,0)
 ;;=3^Person w/ Feared Health Complaint w/ No Diagnosis Made
 ;;^UTILITY(U,$J,358.3,3922,1,4,0)
 ;;=4^Z71.1
 ;;^UTILITY(U,$J,358.3,3922,2)
 ;;=^5063243
 ;;^UTILITY(U,$J,358.3,3923,0)
 ;;=Z91.419^^18^224^98
 ;;^UTILITY(U,$J,358.3,3923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3923,1,3,0)
 ;;=3^Personal Hx of Adult Abuse,Unspec
 ;;^UTILITY(U,$J,358.3,3923,1,4,0)
 ;;=4^Z91.419
 ;;^UTILITY(U,$J,358.3,3923,2)
 ;;=^5063622
 ;;^UTILITY(U,$J,358.3,3924,0)
 ;;=Z91.412^^18^224^99
 ;;^UTILITY(U,$J,358.3,3924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3924,1,3,0)
 ;;=3^Personal Hx of Adult Neglect
 ;;^UTILITY(U,$J,358.3,3924,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,3924,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,3925,0)
 ;;=Z87.892^^18^224^100
 ;;^UTILITY(U,$J,358.3,3925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3925,1,3,0)
 ;;=3^Personal Hx of Anaphylaxis
 ;;^UTILITY(U,$J,358.3,3925,1,4,0)
 ;;=4^Z87.892
 ;;^UTILITY(U,$J,358.3,3925,2)
 ;;=^5063519
 ;;^UTILITY(U,$J,358.3,3926,0)
 ;;=Z87.410^^18^224^101
 ;;^UTILITY(U,$J,358.3,3926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3926,1,3,0)
 ;;=3^Personal Hx of Cervical Dysplasia
 ;;^UTILITY(U,$J,358.3,3926,1,4,0)
 ;;=4^Z87.410
 ;;^UTILITY(U,$J,358.3,3926,2)
 ;;=^5063489
 ;;^UTILITY(U,$J,358.3,3927,0)
 ;;=Z86.51^^18^224^102
 ;;^UTILITY(U,$J,358.3,3927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3927,1,3,0)
 ;;=3^Personal Hx of Combat/Operational Stress Reaction
 ;;^UTILITY(U,$J,358.3,3927,1,4,0)
 ;;=4^Z86.51
 ;;^UTILITY(U,$J,358.3,3927,2)
 ;;=^5063470
 ;;^UTILITY(U,$J,358.3,3928,0)
 ;;=Z86.31^^18^224^103
 ;;^UTILITY(U,$J,358.3,3928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3928,1,3,0)
 ;;=3^Personal Hx of Diabetic Foot Ulcer
 ;;^UTILITY(U,$J,358.3,3928,1,4,0)
 ;;=4^Z86.31
 ;;^UTILITY(U,$J,358.3,3928,2)
 ;;=^5063467
 ;;^UTILITY(U,$J,358.3,3929,0)
 ;;=Z86.59^^18^224^105
 ;;^UTILITY(U,$J,358.3,3929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3929,1,3,0)
 ;;=3^Personal Hx of Mental/Behavioral Disorders
 ;;^UTILITY(U,$J,358.3,3929,1,4,0)
 ;;=4^Z86.59
