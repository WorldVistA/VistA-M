IBDEI07G ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3327,1,4,0)
 ;;=4^438.12
 ;;^UTILITY(U,$J,358.3,3327,1,5,0)
 ;;=5^CVA w/Dysphasia (late effect)
 ;;^UTILITY(U,$J,358.3,3327,2)
 ;;=Stroke w/Dysphasia^317908
 ;;^UTILITY(U,$J,358.3,3328,0)
 ;;=356.8^^33^276^30
 ;;^UTILITY(U,$J,358.3,3328,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3328,1,4,0)
 ;;=4^356.8
 ;;^UTILITY(U,$J,358.3,3328,1,5,0)
 ;;=5^Peripheral Neuropathy, Idiopathic
 ;;^UTILITY(U,$J,358.3,3328,2)
 ;;=Peripheral Neuropathy, Idio^268525
 ;;^UTILITY(U,$J,358.3,3329,0)
 ;;=337.20^^33^276^33
 ;;^UTILITY(U,$J,358.3,3329,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3329,1,4,0)
 ;;=4^337.20
 ;;^UTILITY(U,$J,358.3,3329,1,5,0)
 ;;=5^Reflexive Sympathetic Dystrophy
 ;;^UTILITY(U,$J,358.3,3329,2)
 ;;=Reflexive Sympathetic Dystrophy^295799
 ;;^UTILITY(U,$J,358.3,3330,0)
 ;;=294.8^^33^276^16
 ;;^UTILITY(U,$J,358.3,3330,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3330,1,4,0)
 ;;=4^294.8
 ;;^UTILITY(U,$J,358.3,3330,1,5,0)
 ;;=5^Dementia, Other
 ;;^UTILITY(U,$J,358.3,3330,2)
 ;;=^268044
 ;;^UTILITY(U,$J,358.3,3331,0)
 ;;=438.6^^33^276^4
 ;;^UTILITY(U,$J,358.3,3331,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3331,1,4,0)
 ;;=4^438.6
 ;;^UTILITY(U,$J,358.3,3331,1,5,0)
 ;;=5^CVA w/Dysesthesia (late effect)
 ;;^UTILITY(U,$J,358.3,3331,2)
 ;;=CVA w/Dysesthesia (late effect)^328503
 ;;^UTILITY(U,$J,358.3,3332,0)
 ;;=438.7^^33^276^7
 ;;^UTILITY(U,$J,358.3,3332,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3332,1,4,0)
 ;;=4^438.7
 ;;^UTILITY(U,$J,358.3,3332,1,5,0)
 ;;=5^CVA w/Vision Changes (late effect)
 ;;^UTILITY(U,$J,358.3,3332,2)
 ;;=CVA w/Vision Changes (late effect)^328504
 ;;^UTILITY(U,$J,358.3,3333,0)
 ;;=438.84^^33^276^3
 ;;^UTILITY(U,$J,358.3,3333,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3333,1,4,0)
 ;;=4^438.84
 ;;^UTILITY(U,$J,358.3,3333,1,5,0)
 ;;=5^CVA w/Ataxia (late effect)
 ;;^UTILITY(U,$J,358.3,3333,2)
 ;;=CVA w/Ataxia (late effect)^328507
 ;;^UTILITY(U,$J,358.3,3334,0)
 ;;=434.91^^33^276^8
 ;;^UTILITY(U,$J,358.3,3334,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3334,1,4,0)
 ;;=4^434.91
 ;;^UTILITY(U,$J,358.3,3334,1,5,0)
 ;;=5^CVA, Acute Onset
 ;;^UTILITY(U,$J,358.3,3334,2)
 ;;=^295738
 ;;^UTILITY(U,$J,358.3,3335,0)
 ;;=333.94^^33^276^34
 ;;^UTILITY(U,$J,358.3,3335,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3335,1,4,0)
 ;;=4^333.94
 ;;^UTILITY(U,$J,358.3,3335,1,5,0)
 ;;=5^Restless Leg Syndrome
 ;;^UTILITY(U,$J,358.3,3335,2)
 ;;=^105368
 ;;^UTILITY(U,$J,358.3,3336,0)
 ;;=345.90^^33^276^36
 ;;^UTILITY(U,$J,358.3,3336,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3336,1,4,0)
 ;;=4^345.90
 ;;^UTILITY(U,$J,358.3,3336,1,5,0)
 ;;=5^Seizure Disorder
 ;;^UTILITY(U,$J,358.3,3336,2)
 ;;=^268477
 ;;^UTILITY(U,$J,358.3,3337,0)
 ;;=V12.54^^33^276^19
 ;;^UTILITY(U,$J,358.3,3337,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3337,1,4,0)
 ;;=4^V12.54
 ;;^UTILITY(U,$J,358.3,3337,1,5,0)
 ;;=5^HX OF STROKE W/O RESIDUALS
 ;;^UTILITY(U,$J,358.3,3337,2)
 ;;=^335309
 ;;^UTILITY(U,$J,358.3,3338,0)
 ;;=305.01^^33^277^11
 ;;^UTILITY(U,$J,358.3,3338,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3338,1,4,0)
 ;;=4^305.01
 ;;^UTILITY(U,$J,358.3,3338,1,5,0)
 ;;=5^Etoh Abuse-Continuous
 ;;^UTILITY(U,$J,358.3,3338,2)
 ;;=^268228
 ;;^UTILITY(U,$J,358.3,3339,0)
 ;;=305.02^^33^277^1
 ;;^UTILITY(U,$J,358.3,3339,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3339,1,4,0)
 ;;=4^305.02
 ;;^UTILITY(U,$J,358.3,3339,1,5,0)
 ;;=5^Alcohol Abuse-Episodic
 ;;^UTILITY(U,$J,358.3,3339,2)
 ;;=^268229
 ;;^UTILITY(U,$J,358.3,3340,0)
 ;;=305.03^^33^277^2
 ;;^UTILITY(U,$J,358.3,3340,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3340,1,4,0)
 ;;=4^305.03
