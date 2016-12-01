IBDEI0QR ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35384,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,35384,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,35385,0)
 ;;=F01.50^^100^1514^12
 ;;^UTILITY(U,$J,358.3,35385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35385,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,35385,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,35385,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,35386,0)
 ;;=F10.27^^100^1514^11
 ;;^UTILITY(U,$J,358.3,35386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35386,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,35386,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,35386,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,35387,0)
 ;;=F06.1^^100^1514^6
 ;;^UTILITY(U,$J,358.3,35387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35387,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,35387,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,35387,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,35388,0)
 ;;=F06.8^^100^1514^21
 ;;^UTILITY(U,$J,358.3,35388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35388,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,35388,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,35388,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,35389,0)
 ;;=F06.0^^100^1514^37
 ;;^UTILITY(U,$J,358.3,35389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35389,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,35389,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,35389,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,35390,0)
 ;;=G44.209^^100^1514^42
 ;;^UTILITY(U,$J,358.3,35390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35390,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,35390,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,35390,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,35391,0)
 ;;=F09.^^100^1514^20
 ;;^UTILITY(U,$J,358.3,35391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35391,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,35391,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,35391,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,35392,0)
 ;;=F07.9^^100^1514^35
 ;;^UTILITY(U,$J,358.3,35392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35392,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,35392,1,4,0)
 ;;=4^F07.9
 ;;^UTILITY(U,$J,358.3,35392,2)
 ;;=^5003066
 ;;^UTILITY(U,$J,358.3,35393,0)
 ;;=G30.0^^100^1514^1
 ;;^UTILITY(U,$J,358.3,35393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35393,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,35393,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,35393,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,35394,0)
 ;;=G30.8^^100^1514^3
 ;;^UTILITY(U,$J,358.3,35394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35394,1,3,0)
 ;;=3^Alzheimer's Disease,Other
 ;;^UTILITY(U,$J,358.3,35394,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,35394,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,35395,0)
 ;;=G30.1^^100^1514^2
 ;;^UTILITY(U,$J,358.3,35395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35395,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,35395,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,35395,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,35396,0)
 ;;=G30.9^^100^1514^4
 ;;^UTILITY(U,$J,358.3,35396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35396,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,35396,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,35396,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,35397,0)
 ;;=G21.4^^100^1514^45
 ;;^UTILITY(U,$J,358.3,35397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35397,1,3,0)
 ;;=3^Vascular Parkinsonism
 ;;^UTILITY(U,$J,358.3,35397,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,35397,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,35398,0)
 ;;=G20.^^100^1514^34
 ;;^UTILITY(U,$J,358.3,35398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35398,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,35398,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,35398,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,35399,0)
 ;;=G25.0^^100^1514^15
 ;;^UTILITY(U,$J,358.3,35399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35399,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,35399,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,35399,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,35400,0)
 ;;=G25.2^^100^1514^44
 ;;^UTILITY(U,$J,358.3,35400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35400,1,3,0)
 ;;=3^Tremor,Other Spec Forms
 ;;^UTILITY(U,$J,358.3,35400,1,4,0)
 ;;=4^G25.2
 ;;^UTILITY(U,$J,358.3,35400,2)
 ;;=^5003793
 ;;^UTILITY(U,$J,358.3,35401,0)
 ;;=G25.1^^100^1514^43
 ;;^UTILITY(U,$J,358.3,35401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35401,1,3,0)
 ;;=3^Tremor,Drug-Induced
 ;;^UTILITY(U,$J,358.3,35401,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,35401,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,35402,0)
 ;;=G25.81^^100^1514^38
 ;;^UTILITY(U,$J,358.3,35402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35402,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,35402,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,35402,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,35403,0)
 ;;=G35.^^100^1514^31
 ;;^UTILITY(U,$J,358.3,35403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35403,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,35403,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,35403,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,35404,0)
 ;;=G40.901^^100^1514^13
 ;;^UTILITY(U,$J,358.3,35404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35404,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,35404,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,35404,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,35405,0)
 ;;=G40.909^^100^1514^14
 ;;^UTILITY(U,$J,358.3,35405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35405,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,35405,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,35405,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,35406,0)
 ;;=G43.809^^100^1514^28
 ;;^UTILITY(U,$J,358.3,35406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35406,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,35406,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,35406,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,35407,0)
 ;;=G43.B0^^100^1514^30
 ;;^UTILITY(U,$J,358.3,35407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35407,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,35407,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,35407,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,35408,0)
 ;;=G43.C0^^100^1514^17
 ;;^UTILITY(U,$J,358.3,35408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35408,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,35408,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,35408,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,35409,0)
 ;;=G43.A0^^100^1514^8
 ;;^UTILITY(U,$J,358.3,35409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35409,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,35409,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,35409,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,35410,0)
 ;;=G43.C1^^100^1514^16
 ;;^UTILITY(U,$J,358.3,35410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35410,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,35410,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,35410,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,35411,0)
 ;;=G43.B1^^100^1514^29
 ;;^UTILITY(U,$J,358.3,35411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35411,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,35411,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,35411,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,35412,0)
 ;;=G43.A1^^100^1514^7
 ;;^UTILITY(U,$J,358.3,35412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35412,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,35412,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,35412,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,35413,0)
 ;;=G43.819^^100^1514^25
 ;;^UTILITY(U,$J,358.3,35413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35413,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,35413,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,35413,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,35414,0)
 ;;=G43.909^^100^1514^27
 ;;^UTILITY(U,$J,358.3,35414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35414,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,35414,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,35414,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,35415,0)
 ;;=G43.919^^100^1514^26
 ;;^UTILITY(U,$J,358.3,35415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35415,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,35415,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,35415,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,35416,0)
 ;;=G51.0^^100^1514^5
 ;;^UTILITY(U,$J,358.3,35416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35416,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,35416,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,35416,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,35417,0)
 ;;=G57.10^^100^1514^22
 ;;^UTILITY(U,$J,358.3,35417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35417,1,3,0)
 ;;=3^Meralgia Paresthetica Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,35417,1,4,0)
 ;;=4^G57.10
 ;;^UTILITY(U,$J,358.3,35417,2)
 ;;=^5004041
 ;;^UTILITY(U,$J,358.3,35418,0)
 ;;=G57.12^^100^1514^23
 ;;^UTILITY(U,$J,358.3,35418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35418,1,3,0)
 ;;=3^Meralgia Paresthetica,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,35418,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,35418,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,35419,0)
 ;;=G57.11^^100^1514^24
 ;;^UTILITY(U,$J,358.3,35419,1,0)
 ;;=^358.31IA^4^2
