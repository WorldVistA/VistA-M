IBDEI0FP ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19855,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,19855,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,19856,0)
 ;;=F01.50^^55^795^12
 ;;^UTILITY(U,$J,358.3,19856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19856,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,19856,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,19856,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,19857,0)
 ;;=F10.27^^55^795^11
 ;;^UTILITY(U,$J,358.3,19857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19857,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,19857,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,19857,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,19858,0)
 ;;=F06.1^^55^795^6
 ;;^UTILITY(U,$J,358.3,19858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19858,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,19858,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,19858,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,19859,0)
 ;;=F06.8^^55^795^21
 ;;^UTILITY(U,$J,358.3,19859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19859,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,19859,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,19859,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,19860,0)
 ;;=F06.0^^55^795^37
 ;;^UTILITY(U,$J,358.3,19860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19860,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,19860,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,19860,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,19861,0)
 ;;=G44.209^^55^795^42
 ;;^UTILITY(U,$J,358.3,19861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19861,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,19861,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,19861,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,19862,0)
 ;;=F09.^^55^795^20
 ;;^UTILITY(U,$J,358.3,19862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19862,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,19862,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,19862,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,19863,0)
 ;;=F07.9^^55^795^35
 ;;^UTILITY(U,$J,358.3,19863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19863,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,19863,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,19863,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,19864,0)
 ;;=G30.0^^55^795^1
 ;;^UTILITY(U,$J,358.3,19864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19864,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,19864,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,19864,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,19865,0)
 ;;=G30.8^^55^795^3
 ;;^UTILITY(U,$J,358.3,19865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19865,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,19865,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,19865,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,19866,0)
 ;;=G30.1^^55^795^2
 ;;^UTILITY(U,$J,358.3,19866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19866,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,19866,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,19866,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,19867,0)
 ;;=G30.9^^55^795^4
 ;;^UTILITY(U,$J,358.3,19867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19867,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,19867,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,19867,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,19868,0)
 ;;=G21.4^^55^795^45
 ;;^UTILITY(U,$J,358.3,19868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19868,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,19868,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,19868,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,19869,0)
 ;;=G20.^^55^795^34
 ;;^UTILITY(U,$J,358.3,19869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19869,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,19869,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,19869,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,19870,0)
 ;;=G25.0^^55^795^15
 ;;^UTILITY(U,$J,358.3,19870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19870,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,19870,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,19870,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,19871,0)
 ;;=G25.2^^55^795^44
 ;;^UTILITY(U,$J,358.3,19871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19871,1,3,0)
 ;;=3^Tremor,Other Spec Forms
 ;;^UTILITY(U,$J,358.3,19871,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,19871,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,19872,0)
 ;;=G25.1^^55^795^43
 ;;^UTILITY(U,$J,358.3,19872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19872,1,3,0)
 ;;=3^Tremor,Drug-Induced
 ;;^UTILITY(U,$J,358.3,19872,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,19872,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,19873,0)
 ;;=G25.81^^55^795^38
 ;;^UTILITY(U,$J,358.3,19873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19873,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,19873,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,19873,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,19874,0)
 ;;=G35.^^55^795^31
 ;;^UTILITY(U,$J,358.3,19874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19874,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,19874,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,19874,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,19875,0)
 ;;=G40.901^^55^795^13
 ;;^UTILITY(U,$J,358.3,19875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19875,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,19875,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,19875,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,19876,0)
 ;;=G40.909^^55^795^14
 ;;^UTILITY(U,$J,358.3,19876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19876,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,19876,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,19876,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,19877,0)
 ;;=G43.809^^55^795^28
 ;;^UTILITY(U,$J,358.3,19877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19877,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,19877,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,19877,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,19878,0)
 ;;=G43.B0^^55^795^30
 ;;^UTILITY(U,$J,358.3,19878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19878,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,19878,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,19878,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,19879,0)
 ;;=G43.C0^^55^795^17
 ;;^UTILITY(U,$J,358.3,19879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19879,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,19879,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,19879,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,19880,0)
 ;;=G43.A0^^55^795^8
 ;;^UTILITY(U,$J,358.3,19880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19880,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,19880,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,19880,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,19881,0)
 ;;=G43.C1^^55^795^16
 ;;^UTILITY(U,$J,358.3,19881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19881,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,19881,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,19881,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,19882,0)
 ;;=G43.B1^^55^795^29
 ;;^UTILITY(U,$J,358.3,19882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19882,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,19882,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,19882,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,19883,0)
 ;;=G43.A1^^55^795^7
 ;;^UTILITY(U,$J,358.3,19883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19883,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,19883,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,19883,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,19884,0)
 ;;=G43.819^^55^795^25
 ;;^UTILITY(U,$J,358.3,19884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19884,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,19884,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,19884,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,19885,0)
 ;;=G43.909^^55^795^27
 ;;^UTILITY(U,$J,358.3,19885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19885,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,19885,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,19885,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,19886,0)
 ;;=G43.919^^55^795^26
 ;;^UTILITY(U,$J,358.3,19886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19886,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,19886,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,19886,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,19887,0)
 ;;=G51.0^^55^795^5
 ;;^UTILITY(U,$J,358.3,19887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19887,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,19887,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,19887,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,19888,0)
 ;;=G57.10^^55^795^22
 ;;^UTILITY(U,$J,358.3,19888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19888,1,3,0)
 ;;=3^Meralgia Paresthetica Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,19888,1,4,0)
 ;;=4^G57.10
 ;;^UTILITY(U,$J,358.3,19888,2)
 ;;=^5004041
 ;;^UTILITY(U,$J,358.3,19889,0)
 ;;=G57.12^^55^795^23
 ;;^UTILITY(U,$J,358.3,19889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19889,1,3,0)
 ;;=3^Meralgia Paresthetica,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,19889,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,19889,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,19890,0)
 ;;=G57.11^^55^795^24
 ;;^UTILITY(U,$J,358.3,19890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19890,1,3,0)
 ;;=3^Meralgia Paresthetica,Right Lower Limb
