IBDEI030 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3595,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,3595,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,3596,0)
 ;;=R32.^^16^164^10
 ;;^UTILITY(U,$J,358.3,3596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3596,1,3,0)
 ;;=3^Urinary Incontinence,Unspec
 ;;^UTILITY(U,$J,358.3,3596,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,3596,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,3597,0)
 ;;=B97.89^^16^165^7
 ;;^UTILITY(U,$J,358.3,3597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3597,1,3,0)
 ;;=3^Viral Agents as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,3597,1,4,0)
 ;;=4^B97.89
 ;;^UTILITY(U,$J,358.3,3597,2)
 ;;=^5000879
 ;;^UTILITY(U,$J,358.3,3598,0)
 ;;=H54.7^^16^165^8
 ;;^UTILITY(U,$J,358.3,3598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3598,1,3,0)
 ;;=3^Visual Loss,Unspec
 ;;^UTILITY(U,$J,358.3,3598,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,3598,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,3599,0)
 ;;=I83.91^^16^165^5
 ;;^UTILITY(U,$J,358.3,3599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3599,1,3,0)
 ;;=3^Varicose Veins,Asymptomatic,Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,3599,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,3599,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,3600,0)
 ;;=I83.92^^16^165^4
 ;;^UTILITY(U,$J,358.3,3600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3600,1,3,0)
 ;;=3^Varicose Veins,Asymptomatic,Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,3600,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,3600,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,3601,0)
 ;;=I83.93^^16^165^3
 ;;^UTILITY(U,$J,358.3,3601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3601,1,3,0)
 ;;=3^Varicose Veins,Asymptomatic,Bilateral Lower Extremities
 ;;^UTILITY(U,$J,358.3,3601,1,4,0)
 ;;=4^I83.93
 ;;^UTILITY(U,$J,358.3,3601,2)
 ;;=^5008022
 ;;^UTILITY(U,$J,358.3,3602,0)
 ;;=R53.1^^16^165^9
 ;;^UTILITY(U,$J,358.3,3602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3602,1,3,0)
 ;;=3^Weakness
 ;;^UTILITY(U,$J,358.3,3602,1,4,0)
 ;;=4^R53.1
 ;;^UTILITY(U,$J,358.3,3602,2)
 ;;=^5019516
 ;;^UTILITY(U,$J,358.3,3603,0)
 ;;=R63.4^^16^165^10
 ;;^UTILITY(U,$J,358.3,3603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3603,1,3,0)
 ;;=3^Weight Loss,Abnormal
 ;;^UTILITY(U,$J,358.3,3603,1,4,0)
 ;;=4^R63.4
 ;;^UTILITY(U,$J,358.3,3603,2)
 ;;=^5019542
 ;;^UTILITY(U,$J,358.3,3604,0)
 ;;=B02.9^^16^165^11
 ;;^UTILITY(U,$J,358.3,3604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3604,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,3604,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,3604,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,3605,0)
 ;;=I49.3^^16^165^6
 ;;^UTILITY(U,$J,358.3,3605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3605,1,3,0)
 ;;=3^Vetricular Premature Depolarization
 ;;^UTILITY(U,$J,358.3,3605,1,4,0)
 ;;=4^I49.3
 ;;^UTILITY(U,$J,358.3,3605,2)
 ;;=^5007233
 ;;^UTILITY(U,$J,358.3,3606,0)
 ;;=I83.019^^16^165^2
 ;;^UTILITY(U,$J,358.3,3606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3606,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer Unspec Site
 ;;^UTILITY(U,$J,358.3,3606,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,3606,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,3607,0)
 ;;=I83.029^^16^165^1
 ;;^UTILITY(U,$J,358.3,3607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3607,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer Unspec Site
 ;;^UTILITY(U,$J,358.3,3607,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,3607,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,3608,0)
 ;;=E13.9^^17^166^7
 ;;^UTILITY(U,$J,358.3,3608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3608,1,3,0)
 ;;=3^Diabetes Mellitus w/o Complications,Other Spec
 ;;^UTILITY(U,$J,358.3,3608,1,4,0)
 ;;=4^E13.9
 ;;^UTILITY(U,$J,358.3,3608,2)
 ;;=^5002704
 ;;^UTILITY(U,$J,358.3,3609,0)
 ;;=R93.8^^17^166^2
 ;;^UTILITY(U,$J,358.3,3609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3609,1,3,0)
 ;;=3^Abnormal Findings on Diagnostic Imaging of Body Structures
 ;;^UTILITY(U,$J,358.3,3609,1,4,0)
 ;;=4^R93.8
 ;;^UTILITY(U,$J,358.3,3609,2)
 ;;=^5019721
 ;;^UTILITY(U,$J,358.3,3610,0)
 ;;=R94.8^^17^166^4
 ;;^UTILITY(U,$J,358.3,3610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3610,1,3,0)
 ;;=3^Abnormal Results of Function Studies of Organs/Systems
 ;;^UTILITY(U,$J,358.3,3610,1,4,0)
 ;;=4^R94.8
 ;;^UTILITY(U,$J,358.3,3610,2)
 ;;=^5019745
 ;;^UTILITY(U,$J,358.3,3611,0)
 ;;=Z63.4^^17^166^6
 ;;^UTILITY(U,$J,358.3,3611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3611,1,3,0)
 ;;=3^Bereavement
 ;;^UTILITY(U,$J,358.3,3611,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,3611,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,3612,0)
 ;;=Z45.2^^17^166^5
 ;;^UTILITY(U,$J,358.3,3612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3612,1,3,0)
 ;;=3^Adjustment & Management of VAD
 ;;^UTILITY(U,$J,358.3,3612,1,4,0)
 ;;=4^Z45.2
 ;;^UTILITY(U,$J,358.3,3612,2)
 ;;=^5062999
 ;;^UTILITY(U,$J,358.3,3613,0)
 ;;=Z76.0^^17^166^14
 ;;^UTILITY(U,$J,358.3,3613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3613,1,3,0)
 ;;=3^Issue of Repeat Prescription
 ;;^UTILITY(U,$J,358.3,3613,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,3613,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,3614,0)
 ;;=Z01.818^^17^166^20
 ;;^UTILITY(U,$J,358.3,3614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3614,1,3,0)
 ;;=3^Pre-Op Call
 ;;^UTILITY(U,$J,358.3,3614,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,3614,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,3615,0)
 ;;=Z01.812^^17^166^15
 ;;^UTILITY(U,$J,358.3,3615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3615,1,3,0)
 ;;=3^Lab Result Counseling
 ;;^UTILITY(U,$J,358.3,3615,1,4,0)
 ;;=4^Z01.812
 ;;^UTILITY(U,$J,358.3,3615,2)
 ;;=^5062627
 ;;^UTILITY(U,$J,358.3,3616,0)
 ;;=Z51.81^^17^166^21
 ;;^UTILITY(U,$J,358.3,3616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3616,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,3616,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,3616,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,3617,0)
 ;;=I10.^^17^166^13
 ;;^UTILITY(U,$J,358.3,3617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3617,1,3,0)
 ;;=3^Hypertension
 ;;^UTILITY(U,$J,358.3,3617,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,3617,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,3618,0)
 ;;=Z79.01^^17^166^16
 ;;^UTILITY(U,$J,358.3,3618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3618,1,3,0)
 ;;=3^Long Term (Current) Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,3618,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,3618,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,3619,0)
 ;;=R73.09^^17^166^3
 ;;^UTILITY(U,$J,358.3,3619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3619,1,3,0)
 ;;=3^Abnormal Glucose
 ;;^UTILITY(U,$J,358.3,3619,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,3619,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,3620,0)
 ;;=R68.89^^17^166^11
 ;;^UTILITY(U,$J,358.3,3620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3620,1,3,0)
 ;;=3^General Symptoms & Signs
 ;;^UTILITY(U,$J,358.3,3620,1,4,0)
 ;;=4^R68.89
 ;;^UTILITY(U,$J,358.3,3620,2)
 ;;=^5019557
 ;;^UTILITY(U,$J,358.3,3621,0)
 ;;=R79.89^^17^166^1
 ;;^UTILITY(U,$J,358.3,3621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3621,1,3,0)
 ;;=3^Abnormal Findings of Blood Chemistry
 ;;^UTILITY(U,$J,358.3,3621,1,4,0)
 ;;=4^R79.89
 ;;^UTILITY(U,$J,358.3,3621,2)
 ;;=^5019593
 ;;^UTILITY(U,$J,358.3,3622,0)
 ;;=Z71.89^^17^166^17
 ;;^UTILITY(U,$J,358.3,3622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3622,1,3,0)
 ;;=3^Other Specified Counseling
 ;;^UTILITY(U,$J,358.3,3622,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,3622,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,3623,0)
 ;;=Z98.89^^17^166^19
 ;;^UTILITY(U,$J,358.3,3623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3623,1,3,0)
 ;;=3^Post-Procedural Call
 ;;^UTILITY(U,$J,358.3,3623,1,4,0)
 ;;=4^Z98.89
 ;;^UTILITY(U,$J,358.3,3623,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,3624,0)
 ;;=Z71.2^^17^166^10
 ;;^UTILITY(U,$J,358.3,3624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3624,1,3,0)
 ;;=3^Explanation of Exam or Test Finding
 ;;^UTILITY(U,$J,358.3,3624,1,4,0)
 ;;=4^Z71.2
 ;;^UTILITY(U,$J,358.3,3624,2)
 ;;=^5063244
 ;;^UTILITY(U,$J,358.3,3625,0)
 ;;=Z86.51^^17^166^18
 ;;^UTILITY(U,$J,358.3,3625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3625,1,3,0)
 ;;=3^Personal Hx of Combat & Operational Stress Reaction
 ;;^UTILITY(U,$J,358.3,3625,1,4,0)
 ;;=4^Z86.51
 ;;^UTILITY(U,$J,358.3,3625,2)
 ;;=^5063470
 ;;^UTILITY(U,$J,358.3,3626,0)
 ;;=Z76.89^^17^166^12
 ;;^UTILITY(U,$J,358.3,3626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3626,1,3,0)
 ;;=3^Health Services in Other Specified Circumstances
 ;;^UTILITY(U,$J,358.3,3626,1,4,0)
 ;;=4^Z76.89
 ;;^UTILITY(U,$J,358.3,3626,2)
 ;;=^5063304
 ;;^UTILITY(U,$J,358.3,3627,0)
 ;;=E10.9^^17^166^8
 ;;^UTILITY(U,$J,358.3,3627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3627,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,3627,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,3627,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,3628,0)
 ;;=E11.9^^17^166^9
 ;;^UTILITY(U,$J,358.3,3628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3628,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,3628,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,3628,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,3629,0)
 ;;=D30.3^^18^167^3
 ;;^UTILITY(U,$J,358.3,3629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3629,1,3,0)
 ;;=3^Benign neoplasm of bladder
 ;;^UTILITY(U,$J,358.3,3629,1,4,0)
 ;;=4^D30.3
 ;;^UTILITY(U,$J,358.3,3629,2)
 ;;=^267665
 ;;^UTILITY(U,$J,358.3,3630,0)
 ;;=N21.0^^18^167^5
 ;;^UTILITY(U,$J,358.3,3630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3630,1,3,0)
 ;;=3^Calculus in bladder
 ;;^UTILITY(U,$J,358.3,3630,1,4,0)
 ;;=4^N21.0
 ;;^UTILITY(U,$J,358.3,3630,2)
 ;;=^5015611
 ;;^UTILITY(U,$J,358.3,3631,0)
 ;;=N30.00^^18^167^2
 ;;^UTILITY(U,$J,358.3,3631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3631,1,3,0)
 ;;=3^Acute cystitis w/o hematuria
 ;;^UTILITY(U,$J,358.3,3631,1,4,0)
 ;;=4^N30.00
 ;;^UTILITY(U,$J,358.3,3631,2)
 ;;=^5015632
 ;;^UTILITY(U,$J,358.3,3632,0)
 ;;=N30.01^^18^167^1
