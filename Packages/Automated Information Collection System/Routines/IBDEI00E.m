IBDEI00E ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3)
 ;;=^IBE(358.3,
 ;;^UTILITY(U,$J,358.3,0)
 ;;=IMP/EXP SELECTION^358.3I^14555^14555
 ;;^UTILITY(U,$J,358.3,1,0)
 ;;=309.24^^1^1^7
 ;;^UTILITY(U,$J,358.3,1,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1,1,2,0)
 ;;=2^309.24
 ;;^UTILITY(U,$J,358.3,1,1,5,0)
 ;;=5^Adjustment Reaction w/Anxious Mood
 ;;^UTILITY(U,$J,358.3,1,2)
 ;;=Adjustment Reaction w/Anxious Mood^268308
 ;;^UTILITY(U,$J,358.3,2,0)
 ;;=309.4^^1^1^5
 ;;^UTILITY(U,$J,358.3,2,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2,1,2,0)
 ;;=2^309.4
 ;;^UTILITY(U,$J,358.3,2,1,5,0)
 ;;=5^Adjustment Reac w/Emotion & Conduct
 ;;^UTILITY(U,$J,358.3,2,2)
 ;;=^268312
 ;;^UTILITY(U,$J,358.3,3,0)
 ;;=309.28^^1^1^3
 ;;^UTILITY(U,$J,358.3,3,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3,1,2,0)
 ;;=2^309.28
 ;;^UTILITY(U,$J,358.3,3,1,5,0)
 ;;=5^Adjustment Reac W/Mixed Emotion
 ;;^UTILITY(U,$J,358.3,3,2)
 ;;=^268309
 ;;^UTILITY(U,$J,358.3,4,0)
 ;;=309.9^^1^1^6
 ;;^UTILITY(U,$J,358.3,4,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4,1,2,0)
 ;;=2^309.9
 ;;^UTILITY(U,$J,358.3,4,1,5,0)
 ;;=5^Adjustment Reaction NOS
 ;;^UTILITY(U,$J,358.3,4,2)
 ;;=^123757
 ;;^UTILITY(U,$J,358.3,5,0)
 ;;=309.0^^1^1^9
 ;;^UTILITY(U,$J,358.3,5,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5,1,2,0)
 ;;=2^309.0
 ;;^UTILITY(U,$J,358.3,5,1,5,0)
 ;;=5^Depressive Reac-Brief
 ;;^UTILITY(U,$J,358.3,5,2)
 ;;=^3308
 ;;^UTILITY(U,$J,358.3,6,0)
 ;;=309.1^^1^1^10
 ;;^UTILITY(U,$J,358.3,6,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6,1,2,0)
 ;;=2^309.1
 ;;^UTILITY(U,$J,358.3,6,1,5,0)
 ;;=5^Depressive Reac-Prolong
 ;;^UTILITY(U,$J,358.3,6,2)
 ;;=^268304
 ;;^UTILITY(U,$J,358.3,7,0)
 ;;=309.3^^1^1^4
 ;;^UTILITY(U,$J,358.3,7,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7,1,2,0)
 ;;=2^309.3
 ;;^UTILITY(U,$J,358.3,7,1,5,0)
 ;;=5^Adjustment Reac w/Conduct Disord
 ;;^UTILITY(U,$J,358.3,7,2)
 ;;=^268311
 ;;^UTILITY(U,$J,358.3,8,0)
 ;;=V62.82^^1^1^8
 ;;^UTILITY(U,$J,358.3,8,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8,1,2,0)
 ;;=2^V62.82
 ;;^UTILITY(U,$J,358.3,8,1,5,0)
 ;;=5^Bereavement, Uncomplcated
 ;;^UTILITY(U,$J,358.3,8,2)
 ;;=^13552
 ;;^UTILITY(U,$J,358.3,9,0)
 ;;=309.82^^1^1^1
 ;;^UTILITY(U,$J,358.3,9,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9,1,2,0)
 ;;=2^309.82
 ;;^UTILITY(U,$J,358.3,9,1,5,0)
 ;;=5^Adj Reac w/ Phys Symptoms
 ;;^UTILITY(U,$J,358.3,9,2)
 ;;=^268315
 ;;^UTILITY(U,$J,358.3,10,0)
 ;;=309.83^^1^1^2
 ;;^UTILITY(U,$J,358.3,10,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10,1,2,0)
 ;;=2^309.83
 ;;^UTILITY(U,$J,358.3,10,1,5,0)
 ;;=5^Adj Reac w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,10,2)
 ;;=^268316
 ;;^UTILITY(U,$J,358.3,11,0)
 ;;=300.00^^1^2^3
 ;;^UTILITY(U,$J,358.3,11,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11,1,2,0)
 ;;=2^300.00
 ;;^UTILITY(U,$J,358.3,11,1,5,0)
 ;;=5^Anxiety State
 ;;^UTILITY(U,$J,358.3,11,2)
 ;;=^9200
 ;;^UTILITY(U,$J,358.3,12,0)
 ;;=300.01^^1^2^9
 ;;^UTILITY(U,$J,358.3,12,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,12,1,2,0)
 ;;=2^300.01
 ;;^UTILITY(U,$J,358.3,12,1,5,0)
 ;;=5^Panic Disord w/o Agoraphobia
 ;;^UTILITY(U,$J,358.3,12,2)
 ;;=^89489
 ;;^UTILITY(U,$J,358.3,13,0)
 ;;=300.02^^1^2^5
 ;;^UTILITY(U,$J,358.3,13,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13,1,2,0)
 ;;=2^300.02
 ;;^UTILITY(U,$J,358.3,13,1,5,0)
 ;;=5^Generalized Anxiety Dis
 ;;^UTILITY(U,$J,358.3,13,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,14,0)
 ;;=300.20^^1^2^13
 ;;^UTILITY(U,$J,358.3,14,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14,1,2,0)
 ;;=2^300.20
 ;;^UTILITY(U,$J,358.3,14,1,5,0)
 ;;=5^Phobia, Unspecified
 ;;^UTILITY(U,$J,358.3,14,2)
 ;;=^93428
 ;;^UTILITY(U,$J,358.3,15,0)
 ;;=300.21^^1^2^10
 ;;^UTILITY(U,$J,358.3,15,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15,1,2,0)
 ;;=2^300.21
 ;;^UTILITY(U,$J,358.3,15,1,5,0)
 ;;=5^Panic W/Agoraphobia
 ;;^UTILITY(U,$J,358.3,15,2)
 ;;=^268168
 ;;^UTILITY(U,$J,358.3,16,0)
 ;;=300.22^^1^2^2
 ;;^UTILITY(U,$J,358.3,16,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16,1,2,0)
 ;;=2^300.22
 ;;^UTILITY(U,$J,358.3,16,1,5,0)
 ;;=5^Agoraphobia w/o Panic
 ;;^UTILITY(U,$J,358.3,16,2)
 ;;=^4218
 ;;^UTILITY(U,$J,358.3,17,0)
 ;;=300.23^^1^2^12
 ;;^UTILITY(U,$J,358.3,17,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17,1,2,0)
 ;;=2^300.23
 ;;^UTILITY(U,$J,358.3,17,1,5,0)
 ;;=5^Phobia, Social
 ;;^UTILITY(U,$J,358.3,17,2)
 ;;=^93420
 ;;^UTILITY(U,$J,358.3,18,0)
 ;;=300.29^^1^2^11
 ;;^UTILITY(U,$J,358.3,18,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18,1,2,0)
 ;;=2^300.29
 ;;^UTILITY(U,$J,358.3,18,1,5,0)
 ;;=5^Phobia, Simple
 ;;^UTILITY(U,$J,358.3,18,2)
 ;;=^87670
 ;;^UTILITY(U,$J,358.3,19,0)
 ;;=300.3^^1^2^6
 ;;^UTILITY(U,$J,358.3,19,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19,1,2,0)
 ;;=2^300.3
 ;;^UTILITY(U,$J,358.3,19,1,5,0)
 ;;=5^Obsessive/Compulsive
 ;;^UTILITY(U,$J,358.3,19,2)
 ;;=^84904
 ;;^UTILITY(U,$J,358.3,20,0)
 ;;=308.9^^1^2^1
 ;;^UTILITY(U,$J,358.3,20,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,20,1,2,0)
 ;;=2^308.9
 ;;^UTILITY(U,$J,358.3,20,1,5,0)
 ;;=5^Acute Stress Reaction
 ;;^UTILITY(U,$J,358.3,20,2)
 ;;=^268303
 ;;^UTILITY(U,$J,358.3,21,0)
 ;;=309.81^^1^2^7
 ;;^UTILITY(U,$J,358.3,21,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21,1,2,0)
 ;;=2^309.81
 ;;^UTILITY(U,$J,358.3,21,1,5,0)
 ;;=5^PTSD, Chronic
 ;;^UTILITY(U,$J,358.3,21,2)
 ;;=^114716
 ;;^UTILITY(U,$J,358.3,22,0)
 ;;=300.15^^1^2^4
 ;;^UTILITY(U,$J,358.3,22,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22,1,2,0)
 ;;=2^300.15
 ;;^UTILITY(U,$J,358.3,22,1,5,0)
 ;;=5^Dissociative Reaction
 ;;^UTILITY(U,$J,358.3,22,2)
 ;;=^35700
 ;;^UTILITY(U,$J,358.3,23,0)
 ;;=309.89^^1^2^8
 ;;^UTILITY(U,$J,358.3,23,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23,1,2,0)
 ;;=2^309.89
 ;;^UTILITY(U,$J,358.3,23,1,5,0)
 ;;=5^PTSD, Other
 ;;^UTILITY(U,$J,358.3,23,2)
 ;;=^268313
 ;;^UTILITY(U,$J,358.3,24,0)
 ;;=291.1^^1^3^1
 ;;^UTILITY(U,$J,358.3,24,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24,1,2,0)
 ;;=2^291.1
 ;;^UTILITY(U,$J,358.3,24,1,5,0)
 ;;=5^Amnestic Due to Alcohol
 ;;^UTILITY(U,$J,358.3,24,2)
 ;;=^303492
 ;;^UTILITY(U,$J,358.3,25,0)
 ;;=294.0^^1^3^3
 ;;^UTILITY(U,$J,358.3,25,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25,1,2,0)
 ;;=2^294.0
 ;;^UTILITY(U,$J,358.3,25,1,5,0)
 ;;=5^Amnestic Syndrome, NOS
 ;;^UTILITY(U,$J,358.3,25,2)
 ;;=^6319
 ;;^UTILITY(U,$J,358.3,26,0)
 ;;=292.83^^1^3^2
 ;;^UTILITY(U,$J,358.3,26,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,26,1,2,0)
 ;;=2^292.83
 ;;^UTILITY(U,$J,358.3,26,1,5,0)
 ;;=5^Amnestic Due to Drugs
 ;;^UTILITY(U,$J,358.3,26,2)
 ;;=^268027
 ;;^UTILITY(U,$J,358.3,27,0)
 ;;=310.1^^1^4^7
 ;;^UTILITY(U,$J,358.3,27,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,27,1,2,0)
 ;;=2^310.1
 ;;^UTILITY(U,$J,358.3,27,1,5,0)
 ;;=5^Personality Syndrome
 ;;^UTILITY(U,$J,358.3,27,2)
 ;;=^268318
 ;;^UTILITY(U,$J,358.3,28,0)
 ;;=293.81^^1^4^5
 ;;^UTILITY(U,$J,358.3,28,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28,1,2,0)
 ;;=2^293.81
 ;;^UTILITY(U,$J,358.3,28,1,5,0)
 ;;=5^Delusional Syndrome
 ;;^UTILITY(U,$J,358.3,28,2)
 ;;=^259055
 ;;^UTILITY(U,$J,358.3,29,0)
 ;;=293.82^^1^4^6
 ;;^UTILITY(U,$J,358.3,29,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,29,1,2,0)
 ;;=2^293.82
 ;;^UTILITY(U,$J,358.3,29,1,5,0)
 ;;=5^Hallucinosis
 ;;^UTILITY(U,$J,358.3,29,2)
 ;;=^268040
 ;;^UTILITY(U,$J,358.3,30,0)
 ;;=294.9^^1^4^4
 ;;^UTILITY(U,$J,358.3,30,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,30,1,2,0)
 ;;=2^294.9
 ;;^UTILITY(U,$J,358.3,30,1,5,0)
 ;;=5^Cognitive Disorder, NOS
 ;;^UTILITY(U,$J,358.3,30,2)
 ;;=^123962
 ;;^UTILITY(U,$J,358.3,31,0)
 ;;=293.84^^1^4^3
 ;;^UTILITY(U,$J,358.3,31,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,31,1,2,0)
 ;;=2^293.84
 ;;^UTILITY(U,$J,358.3,31,1,5,0)
 ;;=5^Anxiety Syndrome
 ;;^UTILITY(U,$J,358.3,31,2)
 ;;=^304299
 ;;^UTILITY(U,$J,358.3,32,0)
 ;;=293.89^^1^4^1
 ;;^UTILITY(U,$J,358.3,32,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,32,1,2,0)
 ;;=2^293.89
 ;;^UTILITY(U,$J,358.3,32,1,5,0)
 ;;=5^Affective Syndrome
 ;;^UTILITY(U,$J,358.3,32,2)
 ;;=^331840
 ;;^UTILITY(U,$J,358.3,33,0)
 ;;=290.10^^1^5^3
 ;;^UTILITY(U,$J,358.3,33,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,33,1,2,0)
 ;;=2^290.10
 ;;^UTILITY(U,$J,358.3,33,1,5,0)
 ;;=5^Alzheimers Type Dementia, Early Onset
 ;;^UTILITY(U,$J,358.3,33,2)
 ;;=^31674
 ;;^UTILITY(U,$J,358.3,34,0)
 ;;=290.20^^1^5^12
 ;;^UTILITY(U,$J,358.3,34,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,34,1,2,0)
 ;;=2^290.20
 ;;^UTILITY(U,$J,358.3,34,1,5,0)
 ;;=5^Dementia w/Delusion
 ;;^UTILITY(U,$J,358.3,34,2)
 ;;=^303486
 ;;^UTILITY(U,$J,358.3,35,0)
 ;;=290.40^^1^5^22
 ;;^UTILITY(U,$J,358.3,35,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,35,1,2,0)
 ;;=2^290.40
 ;;^UTILITY(U,$J,358.3,35,1,5,0)
 ;;=5^Vascular Dementia
 ;;^UTILITY(U,$J,358.3,35,2)
 ;;=^303487
 ;;^UTILITY(U,$J,358.3,36,0)
 ;;=291.2^^1^5^1
 ;;^UTILITY(U,$J,358.3,36,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,36,1,2,0)
 ;;=2^291.2
 ;;^UTILITY(U,$J,358.3,36,1,5,0)
 ;;=5^Alcoholic Dementia
 ;;^UTILITY(U,$J,358.3,36,2)
 ;;=Alcoholic Dementia^268015
 ;;^UTILITY(U,$J,358.3,37,0)
 ;;=290.0^^1^5^2
 ;;^UTILITY(U,$J,358.3,37,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,37,1,2,0)
 ;;=2^290.0
 ;;^UTILITY(U,$J,358.3,37,1,5,0)
 ;;=5^Alzheimers Type Dementia Late Onset
 ;;^UTILITY(U,$J,358.3,37,2)
 ;;=^31700
 ;;^UTILITY(U,$J,358.3,38,0)
 ;;=290.3^^1^5^11
 ;;^UTILITY(U,$J,358.3,38,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,38,1,2,0)
 ;;=2^290.3
 ;;^UTILITY(U,$J,358.3,38,1,5,0)
 ;;=5^Dementia w/Delirium
 ;;^UTILITY(U,$J,358.3,38,2)
 ;;=^268009
 ;;^UTILITY(U,$J,358.3,39,0)
 ;;=331.0^^1^5^21
 ;;^UTILITY(U,$J,358.3,39,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,39,1,2,0)
 ;;=2^331.0
 ;;^UTILITY(U,$J,358.3,39,1,5,0)
 ;;=5^True Alzheimer's Disease
 ;;^UTILITY(U,$J,358.3,39,2)
 ;;=^5679^294.10
 ;;^UTILITY(U,$J,358.3,40,0)
 ;;=907.0^^1^5^7
 ;;^UTILITY(U,$J,358.3,40,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,40,1,2,0)
 ;;=2^907.0
 ;;^UTILITY(U,$J,358.3,40,1,5,0)
 ;;=5^Dementia Due to Head Trauma
 ;;^UTILITY(U,$J,358.3,40,2)
 ;;=^68489^294.8
