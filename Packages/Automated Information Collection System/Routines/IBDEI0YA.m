IBDEI0YA ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44982,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,44982,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,44982,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,44983,0)
 ;;=B20.^^136^1926^42
 ;;^UTILITY(U,$J,358.3,44983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44983,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,44983,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,44983,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,44984,0)
 ;;=G10.^^136^1926^44
 ;;^UTILITY(U,$J,358.3,44984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44984,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,44984,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,44984,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,44985,0)
 ;;=G20.^^136^1926^50
 ;;^UTILITY(U,$J,358.3,44985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44985,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,44985,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,44985,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,44986,0)
 ;;=G20.^^136^1926^51
 ;;^UTILITY(U,$J,358.3,44986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44986,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,44986,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,44986,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,44987,0)
 ;;=G23.1^^136^1926^54
 ;;^UTILITY(U,$J,358.3,44987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44987,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,44987,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,44987,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,44988,0)
 ;;=G30.8^^136^1926^1
 ;;^UTILITY(U,$J,358.3,44988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44988,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,44988,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,44988,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,44989,0)
 ;;=G90.3^^136^1926^47
 ;;^UTILITY(U,$J,358.3,44989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44989,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,44989,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,44989,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,44990,0)
 ;;=G91.2^^136^1926^48
 ;;^UTILITY(U,$J,358.3,44990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44990,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,44990,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,44990,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,44991,0)
 ;;=G91.2^^136^1926^49
 ;;^UTILITY(U,$J,358.3,44991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44991,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,44991,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,44991,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,44992,0)
 ;;=F43.21^^136^1927^1
 ;;^UTILITY(U,$J,358.3,44992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44992,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,44992,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,44992,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,44993,0)
 ;;=F43.23^^136^1927^2
 ;;^UTILITY(U,$J,358.3,44993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44993,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,44993,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,44993,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,44994,0)
 ;;=F10.10^^136^1927^3
 ;;^UTILITY(U,$J,358.3,44994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44994,1,3,0)
 ;;=3^Alcohol Abuse Uncomplicated
 ;;^UTILITY(U,$J,358.3,44994,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,44994,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,44995,0)
 ;;=F10.20^^136^1927^4
 ;;^UTILITY(U,$J,358.3,44995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44995,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,44995,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,44995,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,44996,0)
 ;;=F31.81^^136^1927^8
 ;;^UTILITY(U,$J,358.3,44996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44996,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,44996,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,44996,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,44997,0)
 ;;=F34.1^^136^1927^9
 ;;^UTILITY(U,$J,358.3,44997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44997,1,3,0)
 ;;=3^Dysthymic Disorder
 ;;^UTILITY(U,$J,358.3,44997,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,44997,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,44998,0)
 ;;=F41.1^^136^1927^5
 ;;^UTILITY(U,$J,358.3,44998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44998,1,3,0)
 ;;=3^Anxiety Disorder,Generalized
 ;;^UTILITY(U,$J,358.3,44998,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,44998,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,44999,0)
 ;;=F33.1^^136^1927^11
 ;;^UTILITY(U,$J,358.3,44999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44999,1,3,0)
 ;;=3^MDD,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,44999,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,44999,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,45000,0)
 ;;=F06.8^^136^1927^13
 ;;^UTILITY(U,$J,358.3,45000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45000,1,3,0)
 ;;=3^Mental Disorders d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,45000,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,45000,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,45001,0)
 ;;=F43.12^^136^1927^32
 ;;^UTILITY(U,$J,358.3,45001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45001,1,3,0)
 ;;=3^PTSD,Chronic
 ;;^UTILITY(U,$J,358.3,45001,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,45001,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,45002,0)
 ;;=F43.10^^136^1927^33
 ;;^UTILITY(U,$J,358.3,45002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45002,1,3,0)
 ;;=3^PTSD,Unspec
 ;;^UTILITY(U,$J,358.3,45002,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,45002,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,45003,0)
 ;;=F06.0^^136^1927^37
 ;;^UTILITY(U,$J,358.3,45003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45003,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Physiol Condition
 ;;^UTILITY(U,$J,358.3,45003,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,45003,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,45004,0)
 ;;=F20.9^^136^1927^39
 ;;^UTILITY(U,$J,358.3,45004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45004,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,45004,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,45004,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,45005,0)
 ;;=F29.^^136^1927^36
 ;;^UTILITY(U,$J,358.3,45005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45005,1,3,0)
 ;;=3^Psychosis Not d/t Substance/Physiol Condition
 ;;^UTILITY(U,$J,358.3,45005,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,45005,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,45006,0)
 ;;=F41.9^^136^1927^6
 ;;^UTILITY(U,$J,358.3,45006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45006,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,45006,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,45006,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,45007,0)
 ;;=F31.9^^136^1927^7
 ;;^UTILITY(U,$J,358.3,45007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45007,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,45007,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,45007,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,45008,0)
 ;;=F32.9^^136^1927^12
 ;;^UTILITY(U,$J,358.3,45008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45008,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,45008,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,45008,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,45009,0)
 ;;=R46.0^^136^1927^10
 ;;^UTILITY(U,$J,358.3,45009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45009,1,3,0)
 ;;=3^Hygiene,Personal,Very Lowe Level
 ;;^UTILITY(U,$J,358.3,45009,1,4,0)
 ;;=4^R46.0
 ;;^UTILITY(U,$J,358.3,45009,2)
 ;;=^5019478
 ;;^UTILITY(U,$J,358.3,45010,0)
 ;;=F39.^^136^1927^14
 ;;^UTILITY(U,$J,358.3,45010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45010,1,3,0)
 ;;=3^Mood Affective Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,45010,1,4,0)
 ;;=4^F39.
 ;;^UTILITY(U,$J,358.3,45010,2)
 ;;=^5003541
 ;;^UTILITY(U,$J,358.3,45011,0)
 ;;=F06.30^^136^1927^15
 ;;^UTILITY(U,$J,358.3,45011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45011,1,3,0)
 ;;=3^Mood Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,45011,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,45011,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,45012,0)
 ;;=F17.221^^136^1927^19
 ;;^UTILITY(U,$J,358.3,45012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45012,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,in Remission
 ;;^UTILITY(U,$J,358.3,45012,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,45012,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,45013,0)
 ;;=F17.220^^136^1927^18
 ;;^UTILITY(U,$J,358.3,45013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45013,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,45013,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,45013,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,45014,0)
 ;;=F17.229^^136^1927^16
 ;;^UTILITY(U,$J,358.3,45014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45014,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Unspec Disorders
 ;;^UTILITY(U,$J,358.3,45014,1,4,0)
 ;;=4^F17.229
 ;;^UTILITY(U,$J,358.3,45014,2)
 ;;=^5003374
 ;;^UTILITY(U,$J,358.3,45015,0)
 ;;=F17.223^^136^1927^17
 ;;^UTILITY(U,$J,358.3,45015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45015,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,45015,1,4,0)
 ;;=4^F17.223
 ;;^UTILITY(U,$J,358.3,45015,2)
 ;;=^5003372
 ;;^UTILITY(U,$J,358.3,45016,0)
 ;;=F17.211^^136^1927^23
 ;;^UTILITY(U,$J,358.3,45016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45016,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,in Remission
 ;;^UTILITY(U,$J,358.3,45016,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,45016,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,45017,0)
 ;;=F17.210^^136^1927^22
