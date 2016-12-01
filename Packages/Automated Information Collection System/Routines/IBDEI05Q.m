IBDEI05Q ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7112,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,7113,0)
 ;;=F10.27^^26^409^13
 ;;^UTILITY(U,$J,358.3,7113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7113,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,7113,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,7113,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,7114,0)
 ;;=F06.1^^26^409^6
 ;;^UTILITY(U,$J,358.3,7114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7114,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,7114,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,7114,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,7115,0)
 ;;=F06.8^^26^409^21
 ;;^UTILITY(U,$J,358.3,7115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7115,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,7115,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,7115,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,7116,0)
 ;;=F06.0^^26^409^38
 ;;^UTILITY(U,$J,358.3,7116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7116,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,7116,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,7116,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,7117,0)
 ;;=G44.209^^26^409^41
 ;;^UTILITY(U,$J,358.3,7117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7117,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,7117,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,7117,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,7118,0)
 ;;=F09.^^26^409^20
 ;;^UTILITY(U,$J,358.3,7118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7118,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,7118,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,7118,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,7119,0)
 ;;=F07.9^^26^409^35
 ;;^UTILITY(U,$J,358.3,7119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7119,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,7119,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,7119,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,7120,0)
 ;;=G30.0^^26^409^1
 ;;^UTILITY(U,$J,358.3,7120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7120,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,7120,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,7120,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,7121,0)
 ;;=G30.8^^26^409^3
 ;;^UTILITY(U,$J,358.3,7121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7121,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,7121,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,7121,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,7122,0)
 ;;=G30.1^^26^409^2
 ;;^UTILITY(U,$J,358.3,7122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7122,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,7122,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,7122,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,7123,0)
 ;;=G30.9^^26^409^4
 ;;^UTILITY(U,$J,358.3,7123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7123,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,7123,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,7123,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,7124,0)
 ;;=G21.4^^26^409^44
 ;;^UTILITY(U,$J,358.3,7124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7124,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,7124,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,7124,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,7125,0)
 ;;=G20.^^26^409^34
 ;;^UTILITY(U,$J,358.3,7125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7125,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,7125,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,7125,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,7126,0)
 ;;=G25.0^^26^409^17
 ;;^UTILITY(U,$J,358.3,7126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7126,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,7126,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,7126,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,7127,0)
 ;;=G25.2^^26^409^43
 ;;^UTILITY(U,$J,358.3,7127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7127,1,3,0)
 ;;=3^Tremor,Other Spec Forms
 ;;^UTILITY(U,$J,358.3,7127,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,7127,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,7128,0)
 ;;=G25.1^^26^409^42
 ;;^UTILITY(U,$J,358.3,7128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7128,1,3,0)
 ;;=3^Tremor,Drug-Induced
 ;;^UTILITY(U,$J,358.3,7128,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,7128,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,7129,0)
 ;;=G25.81^^26^409^39
 ;;^UTILITY(U,$J,358.3,7129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7129,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,7129,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,7129,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,7130,0)
 ;;=G35.^^26^409^31
 ;;^UTILITY(U,$J,358.3,7130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7130,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,7130,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,7130,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,7131,0)
 ;;=G40.901^^26^409^15
 ;;^UTILITY(U,$J,358.3,7131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7131,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,7131,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,7131,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,7132,0)
 ;;=G40.909^^26^409^16
 ;;^UTILITY(U,$J,358.3,7132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7132,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,7132,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,7132,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,7133,0)
 ;;=G43.809^^26^409^28
 ;;^UTILITY(U,$J,358.3,7133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7133,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,7133,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,7133,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,7134,0)
 ;;=G43.B0^^26^409^30
 ;;^UTILITY(U,$J,358.3,7134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7134,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,7134,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,7134,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,7135,0)
 ;;=G43.C0^^26^409^19
 ;;^UTILITY(U,$J,358.3,7135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7135,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,7135,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,7135,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,7136,0)
 ;;=G43.A0^^26^409^10
 ;;^UTILITY(U,$J,358.3,7136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7136,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,7136,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,7136,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,7137,0)
 ;;=G43.C1^^26^409^18
 ;;^UTILITY(U,$J,358.3,7137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7137,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,7137,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,7137,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,7138,0)
 ;;=G43.B1^^26^409^29
 ;;^UTILITY(U,$J,358.3,7138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7138,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,7138,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,7138,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,7139,0)
 ;;=G43.A1^^26^409^9
 ;;^UTILITY(U,$J,358.3,7139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7139,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,7139,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,7139,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,7140,0)
 ;;=G43.819^^26^409^25
 ;;^UTILITY(U,$J,358.3,7140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7140,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,7140,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,7140,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,7141,0)
 ;;=G43.909^^26^409^27
 ;;^UTILITY(U,$J,358.3,7141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7141,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,7141,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,7141,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,7142,0)
 ;;=G43.919^^26^409^26
 ;;^UTILITY(U,$J,358.3,7142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7142,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,7142,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,7142,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,7143,0)
 ;;=G51.0^^26^409^5
 ;;^UTILITY(U,$J,358.3,7143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7143,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,7143,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,7143,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,7144,0)
 ;;=G57.10^^26^409^22
 ;;^UTILITY(U,$J,358.3,7144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7144,1,3,0)
 ;;=3^Meralgia Paresthetica Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,7144,1,4,0)
 ;;=4^G57.10
 ;;^UTILITY(U,$J,358.3,7144,2)
 ;;=^5004041
 ;;^UTILITY(U,$J,358.3,7145,0)
 ;;=G57.12^^26^409^23
 ;;^UTILITY(U,$J,358.3,7145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7145,1,3,0)
 ;;=3^Meralgia Paresthetica,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,7145,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,7145,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,7146,0)
 ;;=G57.11^^26^409^24
 ;;^UTILITY(U,$J,358.3,7146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7146,1,3,0)
 ;;=3^Meralgia Paresthetica,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,7146,1,4,0)
 ;;=4^G57.11
 ;;^UTILITY(U,$J,358.3,7146,2)
 ;;=^5004042
 ;;^UTILITY(U,$J,358.3,7147,0)
 ;;=G60.8^^26^409^32
 ;;^UTILITY(U,$J,358.3,7147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7147,1,3,0)
 ;;=3^Neuropathies,Oth Hereditary and Idiopathic
 ;;^UTILITY(U,$J,358.3,7147,1,4,0)
 ;;=4^G60.8
 ;;^UTILITY(U,$J,358.3,7147,2)
 ;;=^5004070
 ;;^UTILITY(U,$J,358.3,7148,0)
 ;;=G60.9^^26^409^33
 ;;^UTILITY(U,$J,358.3,7148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7148,1,3,0)
 ;;=3^Neuropathy,Hereditary and Idiopathic Unspec
