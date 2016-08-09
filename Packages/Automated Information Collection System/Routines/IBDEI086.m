IBDEI086 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8108,1,3,0)
 ;;=3^Postherpetic Nervous System Involvement,Other
 ;;^UTILITY(U,$J,358.3,8108,1,4,0)
 ;;=4^B02.29
 ;;^UTILITY(U,$J,358.3,8108,2)
 ;;=^5000492
 ;;^UTILITY(U,$J,358.3,8109,0)
 ;;=F03.90^^42^505^12
 ;;^UTILITY(U,$J,358.3,8109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8109,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,8109,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,8109,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,8110,0)
 ;;=F03.91^^42^505^11
 ;;^UTILITY(U,$J,358.3,8110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8110,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,8110,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,8110,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,8111,0)
 ;;=F01.50^^42^505^14
 ;;^UTILITY(U,$J,358.3,8111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8111,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,8111,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,8111,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,8112,0)
 ;;=F10.27^^42^505^13
 ;;^UTILITY(U,$J,358.3,8112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8112,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,8112,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,8112,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,8113,0)
 ;;=F06.1^^42^505^6
 ;;^UTILITY(U,$J,358.3,8113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8113,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,8113,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,8113,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,8114,0)
 ;;=F06.8^^42^505^21
 ;;^UTILITY(U,$J,358.3,8114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8114,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,8114,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,8114,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,8115,0)
 ;;=F06.0^^42^505^38
 ;;^UTILITY(U,$J,358.3,8115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8115,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,8115,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,8115,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,8116,0)
 ;;=G44.209^^42^505^41
 ;;^UTILITY(U,$J,358.3,8116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8116,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,8116,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,8116,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,8117,0)
 ;;=F09.^^42^505^20
 ;;^UTILITY(U,$J,358.3,8117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8117,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,8117,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,8117,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,8118,0)
 ;;=F07.9^^42^505^35
 ;;^UTILITY(U,$J,358.3,8118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8118,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,8118,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,8118,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,8119,0)
 ;;=G30.0^^42^505^1
 ;;^UTILITY(U,$J,358.3,8119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8119,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,8119,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,8119,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,8120,0)
 ;;=G30.8^^42^505^3
 ;;^UTILITY(U,$J,358.3,8120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8120,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,8120,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,8120,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,8121,0)
 ;;=G30.1^^42^505^2
 ;;^UTILITY(U,$J,358.3,8121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8121,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,8121,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,8121,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,8122,0)
 ;;=G30.9^^42^505^4
 ;;^UTILITY(U,$J,358.3,8122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8122,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8122,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,8122,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,8123,0)
 ;;=G21.4^^42^505^44
 ;;^UTILITY(U,$J,358.3,8123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8123,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,8123,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,8123,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,8124,0)
 ;;=G20.^^42^505^34
 ;;^UTILITY(U,$J,358.3,8124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8124,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,8124,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,8124,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,8125,0)
 ;;=G25.0^^42^505^17
 ;;^UTILITY(U,$J,358.3,8125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8125,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,8125,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,8125,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,8126,0)
 ;;=G25.2^^42^505^43
 ;;^UTILITY(U,$J,358.3,8126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8126,1,3,0)
 ;;=3^Tremor,Other Spec Forms
 ;;^UTILITY(U,$J,358.3,8126,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,8126,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,8127,0)
 ;;=G25.1^^42^505^42
 ;;^UTILITY(U,$J,358.3,8127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8127,1,3,0)
 ;;=3^Tremor,Drug-Induced
 ;;^UTILITY(U,$J,358.3,8127,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,8127,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,8128,0)
 ;;=G25.81^^42^505^39
 ;;^UTILITY(U,$J,358.3,8128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8128,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,8128,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,8128,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,8129,0)
 ;;=G35.^^42^505^31
 ;;^UTILITY(U,$J,358.3,8129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8129,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,8129,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,8129,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,8130,0)
 ;;=G40.901^^42^505^15
 ;;^UTILITY(U,$J,358.3,8130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8130,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,8130,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,8130,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,8131,0)
 ;;=G40.909^^42^505^16
 ;;^UTILITY(U,$J,358.3,8131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8131,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,8131,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,8131,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,8132,0)
 ;;=G43.809^^42^505^28
 ;;^UTILITY(U,$J,358.3,8132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8132,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,8132,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,8132,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,8133,0)
 ;;=G43.B0^^42^505^30
 ;;^UTILITY(U,$J,358.3,8133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8133,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,8133,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,8133,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,8134,0)
 ;;=G43.C0^^42^505^19
 ;;^UTILITY(U,$J,358.3,8134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8134,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,8134,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,8134,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,8135,0)
 ;;=G43.A0^^42^505^10
 ;;^UTILITY(U,$J,358.3,8135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8135,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,8135,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,8135,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,8136,0)
 ;;=G43.C1^^42^505^18
 ;;^UTILITY(U,$J,358.3,8136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8136,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
