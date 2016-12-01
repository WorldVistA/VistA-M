IBDEI08N ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10913,1,3,0)
 ;;=3^Dementia,Nervous System Degenerative Diseases
 ;;^UTILITY(U,$J,358.3,10913,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,10913,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,10914,0)
 ;;=F06.8^^40^574^30
 ;;^UTILITY(U,$J,358.3,10914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10914,1,3,0)
 ;;=3^Dementia,Mental Disorders d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,10914,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,10914,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,10915,0)
 ;;=F10.27^^40^574^32
 ;;^UTILITY(U,$J,358.3,10915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10915,1,3,0)
 ;;=3^Dementia,Persisting,Alcohol-Induced
 ;;^UTILITY(U,$J,358.3,10915,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,10915,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,10916,0)
 ;;=F19.97^^40^574^33
 ;;^UTILITY(U,$J,358.3,10916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10916,1,3,0)
 ;;=3^Dementia,Persisting,Psychoactive Subst Use
 ;;^UTILITY(U,$J,358.3,10916,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,10916,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,10917,0)
 ;;=G31.01^^40^574^34
 ;;^UTILITY(U,$J,358.3,10917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10917,1,3,0)
 ;;=3^Dementia,Pick's Disease
 ;;^UTILITY(U,$J,358.3,10917,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,10917,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,10918,0)
 ;;=A81.2^^40^574^35
 ;;^UTILITY(U,$J,358.3,10918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10918,1,3,0)
 ;;=3^Dementia,Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,10918,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,10918,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,10919,0)
 ;;=G31.1^^40^574^36
 ;;^UTILITY(U,$J,358.3,10919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10919,1,3,0)
 ;;=3^Dementia,Senile Degeneration of Brain NEC
 ;;^UTILITY(U,$J,358.3,10919,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,10919,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,10920,0)
 ;;=F03.90^^40^574^21
 ;;^UTILITY(U,$J,358.3,10920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10920,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,10920,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,10920,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,10921,0)
 ;;=F03.91^^40^574^18
 ;;^UTILITY(U,$J,358.3,10921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10921,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,10921,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,10921,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,10922,0)
 ;;=F01.51^^40^574^37
 ;;^UTILITY(U,$J,358.3,10922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10922,1,3,0)
 ;;=3^Dementia,Vascular w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,10922,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,10922,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,10923,0)
 ;;=F01.50^^40^574^38
 ;;^UTILITY(U,$J,358.3,10923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10923,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,10923,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,10923,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,10924,0)
 ;;=R42.^^40^574^39
 ;;^UTILITY(U,$J,358.3,10924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10924,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,10924,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,10924,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,10925,0)
 ;;=R45.86^^40^574^40
 ;;^UTILITY(U,$J,358.3,10925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10925,1,3,0)
 ;;=3^Emotional Lability
 ;;^UTILITY(U,$J,358.3,10925,1,4,0)
 ;;=4^R45.86
 ;;^UTILITY(U,$J,358.3,10925,2)
 ;;=^5019475
 ;;^UTILITY(U,$J,358.3,10926,0)
 ;;=R44.3^^40^574^43
 ;;^UTILITY(U,$J,358.3,10926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10926,1,3,0)
 ;;=3^Hallucinations,Unspec
 ;;^UTILITY(U,$J,358.3,10926,1,4,0)
 ;;=4^R44.3
 ;;^UTILITY(U,$J,358.3,10926,2)
 ;;=^5019458
 ;;^UTILITY(U,$J,358.3,10927,0)
 ;;=R46.0^^40^574^46
 ;;^UTILITY(U,$J,358.3,10927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10927,1,3,0)
 ;;=3^Hygiene,Personal,Very Low Level
 ;;^UTILITY(U,$J,358.3,10927,1,4,0)
 ;;=4^R46.0
 ;;^UTILITY(U,$J,358.3,10927,2)
 ;;=^5019478
 ;;^UTILITY(U,$J,358.3,10928,0)
 ;;=Z91.83^^40^574^52
 ;;^UTILITY(U,$J,358.3,10928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10928,1,3,0)
 ;;=3^Personal Hx of Wandering
 ;;^UTILITY(U,$J,358.3,10928,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,10928,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,10929,0)
 ;;=A81.9^^40^574^6
 ;;^UTILITY(U,$J,358.3,10929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10929,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,10929,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,10929,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,10930,0)
 ;;=A81.2^^40^574^53
 ;;^UTILITY(U,$J,358.3,10930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10930,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,10930,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,10930,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,10931,0)
 ;;=B20.^^40^574^41
 ;;^UTILITY(U,$J,358.3,10931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10931,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,10931,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,10931,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,10932,0)
 ;;=B20.^^40^574^42
 ;;^UTILITY(U,$J,358.3,10932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10932,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10932,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,10932,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,10933,0)
 ;;=G10.^^40^574^44
 ;;^UTILITY(U,$J,358.3,10933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10933,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10933,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,10933,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,10934,0)
 ;;=G20.^^40^574^50
 ;;^UTILITY(U,$J,358.3,10934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10934,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10934,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,10934,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,10935,0)
 ;;=G20.^^40^574^51
 ;;^UTILITY(U,$J,358.3,10935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10935,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10935,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,10935,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,10936,0)
 ;;=G23.1^^40^574^54
 ;;^UTILITY(U,$J,358.3,10936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10936,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,10936,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,10936,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,10937,0)
 ;;=G30.8^^40^574^1
 ;;^UTILITY(U,$J,358.3,10937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10937,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,10937,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,10937,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,10938,0)
 ;;=G90.3^^40^574^47
 ;;^UTILITY(U,$J,358.3,10938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10938,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,10938,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,10938,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,10939,0)
 ;;=G91.2^^40^574^48
 ;;^UTILITY(U,$J,358.3,10939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10939,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10939,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,10939,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,10940,0)
 ;;=G91.2^^40^574^49
 ;;^UTILITY(U,$J,358.3,10940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10940,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,10940,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,10940,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,10941,0)
 ;;=F43.21^^40^575^1
 ;;^UTILITY(U,$J,358.3,10941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10941,1,3,0)
 ;;=3^Adjustment Disorder w/ Depressed Mood
 ;;^UTILITY(U,$J,358.3,10941,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,10941,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,10942,0)
 ;;=F43.23^^40^575^2
 ;;^UTILITY(U,$J,358.3,10942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10942,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,10942,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,10942,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,10943,0)
 ;;=F10.10^^40^575^3
 ;;^UTILITY(U,$J,358.3,10943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10943,1,3,0)
 ;;=3^Alcohol Abuse Uncomplicated
 ;;^UTILITY(U,$J,358.3,10943,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,10943,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,10944,0)
 ;;=F10.20^^40^575^4
 ;;^UTILITY(U,$J,358.3,10944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10944,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,10944,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,10944,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,10945,0)
 ;;=F31.81^^40^575^8
 ;;^UTILITY(U,$J,358.3,10945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10945,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,10945,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,10945,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,10946,0)
 ;;=F34.1^^40^575^9
 ;;^UTILITY(U,$J,358.3,10946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10946,1,3,0)
 ;;=3^Dysthymic Disorder
 ;;^UTILITY(U,$J,358.3,10946,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,10946,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,10947,0)
 ;;=F41.1^^40^575^5
 ;;^UTILITY(U,$J,358.3,10947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10947,1,3,0)
 ;;=3^Anxiety Disorder,Generalized
 ;;^UTILITY(U,$J,358.3,10947,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,10947,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,10948,0)
 ;;=F33.1^^40^575^11
