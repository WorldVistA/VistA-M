IBDEI0KB ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20471,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,20471,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,20471,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,20472,0)
 ;;=F06.8^^86^1001^21
 ;;^UTILITY(U,$J,358.3,20472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20472,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,20472,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,20472,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,20473,0)
 ;;=F06.0^^86^1001^37
 ;;^UTILITY(U,$J,358.3,20473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20473,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,20473,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,20473,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,20474,0)
 ;;=G44.209^^86^1001^42
 ;;^UTILITY(U,$J,358.3,20474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20474,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,20474,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,20474,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,20475,0)
 ;;=F09.^^86^1001^20
 ;;^UTILITY(U,$J,358.3,20475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20475,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,20475,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,20475,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,20476,0)
 ;;=F07.9^^86^1001^35
 ;;^UTILITY(U,$J,358.3,20476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20476,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,20476,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,20476,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,20477,0)
 ;;=G30.0^^86^1001^1
 ;;^UTILITY(U,$J,358.3,20477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20477,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,20477,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,20477,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,20478,0)
 ;;=G30.8^^86^1001^3
 ;;^UTILITY(U,$J,358.3,20478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20478,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,20478,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,20478,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,20479,0)
 ;;=G30.1^^86^1001^2
 ;;^UTILITY(U,$J,358.3,20479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20479,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,20479,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,20479,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,20480,0)
 ;;=G30.9^^86^1001^4
 ;;^UTILITY(U,$J,358.3,20480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20480,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,20480,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,20480,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,20481,0)
 ;;=G21.4^^86^1001^45
 ;;^UTILITY(U,$J,358.3,20481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20481,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,20481,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,20481,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,20482,0)
 ;;=G20.^^86^1001^34
 ;;^UTILITY(U,$J,358.3,20482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20482,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,20482,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,20482,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,20483,0)
 ;;=G25.0^^86^1001^15
 ;;^UTILITY(U,$J,358.3,20483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20483,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,20483,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,20483,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,20484,0)
 ;;=G25.2^^86^1001^44
 ;;^UTILITY(U,$J,358.3,20484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20484,1,3,0)
 ;;=3^Tremor,Other Spec Forms
 ;;^UTILITY(U,$J,358.3,20484,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,20484,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,20485,0)
 ;;=G25.1^^86^1001^43
 ;;^UTILITY(U,$J,358.3,20485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20485,1,3,0)
 ;;=3^Tremor,Drug-Induced
 ;;^UTILITY(U,$J,358.3,20485,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,20485,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,20486,0)
 ;;=G25.81^^86^1001^38
 ;;^UTILITY(U,$J,358.3,20486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20486,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,20486,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,20486,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,20487,0)
 ;;=G35.^^86^1001^31
 ;;^UTILITY(U,$J,358.3,20487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20487,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,20487,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,20487,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,20488,0)
 ;;=G40.901^^86^1001^13
 ;;^UTILITY(U,$J,358.3,20488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20488,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,20488,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,20488,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,20489,0)
 ;;=G40.909^^86^1001^14
 ;;^UTILITY(U,$J,358.3,20489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20489,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,20489,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,20489,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,20490,0)
 ;;=G43.809^^86^1001^28
 ;;^UTILITY(U,$J,358.3,20490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20490,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,20490,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,20490,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,20491,0)
 ;;=G43.B0^^86^1001^30
 ;;^UTILITY(U,$J,358.3,20491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20491,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,20491,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,20491,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,20492,0)
 ;;=G43.C0^^86^1001^17
 ;;^UTILITY(U,$J,358.3,20492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20492,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,20492,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,20492,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,20493,0)
 ;;=G43.A0^^86^1001^8
 ;;^UTILITY(U,$J,358.3,20493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20493,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,20493,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,20493,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,20494,0)
 ;;=G43.C1^^86^1001^16
 ;;^UTILITY(U,$J,358.3,20494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20494,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,20494,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,20494,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,20495,0)
 ;;=G43.B1^^86^1001^29
 ;;^UTILITY(U,$J,358.3,20495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20495,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,20495,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,20495,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,20496,0)
 ;;=G43.A1^^86^1001^7
 ;;^UTILITY(U,$J,358.3,20496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20496,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,20496,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,20496,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,20497,0)
 ;;=G43.819^^86^1001^25
 ;;^UTILITY(U,$J,358.3,20497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20497,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,20497,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,20497,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,20498,0)
 ;;=G43.909^^86^1001^27
 ;;^UTILITY(U,$J,358.3,20498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20498,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
