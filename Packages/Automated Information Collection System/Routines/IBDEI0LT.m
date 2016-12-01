IBDEI0LT ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27593,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,27593,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,27593,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,27594,0)
 ;;=B20.^^74^1176^20
 ;;^UTILITY(U,$J,358.3,27594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27594,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27594,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,27594,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,27595,0)
 ;;=B20.^^74^1176^21
 ;;^UTILITY(U,$J,358.3,27595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27595,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27595,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,27595,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,27596,0)
 ;;=F10.27^^74^1176^1
 ;;^UTILITY(U,$J,358.3,27596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27596,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,27596,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,27596,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,27597,0)
 ;;=F02.81^^74^1176^14
 ;;^UTILITY(U,$J,358.3,27597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27597,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturb
 ;;^UTILITY(U,$J,358.3,27597,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,27597,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,27598,0)
 ;;=F02.80^^74^1176^15
 ;;^UTILITY(U,$J,358.3,27598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27598,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27598,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,27598,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,27599,0)
 ;;=F19.97^^74^1176^35
 ;;^UTILITY(U,$J,358.3,27599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27599,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,27599,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,27599,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,27600,0)
 ;;=F01.51^^74^1176^37
 ;;^UTILITY(U,$J,358.3,27600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27600,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,27600,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,27600,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,27601,0)
 ;;=G10.^^74^1176^24
 ;;^UTILITY(U,$J,358.3,27601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27601,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27601,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,27601,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,27602,0)
 ;;=G10.^^74^1176^25
 ;;^UTILITY(U,$J,358.3,27602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27602,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27602,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,27602,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,27603,0)
 ;;=G90.3^^74^1176^27
 ;;^UTILITY(U,$J,358.3,27603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27603,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,27603,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,27603,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,27604,0)
 ;;=G91.2^^74^1176^28
 ;;^UTILITY(U,$J,358.3,27604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27604,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27604,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,27604,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,27605,0)
 ;;=G91.2^^74^1176^29
 ;;^UTILITY(U,$J,358.3,27605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27605,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27605,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,27605,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,27606,0)
 ;;=G30.8^^74^1176^2
 ;;^UTILITY(U,$J,358.3,27606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27606,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,27606,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,27606,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,27607,0)
 ;;=G31.09^^74^1176^19
 ;;^UTILITY(U,$J,358.3,27607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27607,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,27607,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,27607,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,27608,0)
 ;;=G20.^^74^1176^30
 ;;^UTILITY(U,$J,358.3,27608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27608,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27608,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,27608,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,27609,0)
 ;;=G20.^^74^1176^31
 ;;^UTILITY(U,$J,358.3,27609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27609,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,27609,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,27609,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,27610,0)
 ;;=G23.1^^74^1176^34
 ;;^UTILITY(U,$J,358.3,27610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27610,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,27610,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,27610,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,27611,0)
 ;;=E53.8^^74^1177^6
 ;;^UTILITY(U,$J,358.3,27611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27611,1,3,0)
 ;;=3^Deficiency of Vitamin B Group,Other Spec
 ;;^UTILITY(U,$J,358.3,27611,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,27611,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,27612,0)
 ;;=F44.4^^74^1177^4
 ;;^UTILITY(U,$J,358.3,27612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27612,1,3,0)
 ;;=3^Conversion Disorder w/ Motor Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,27612,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,27612,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,27613,0)
 ;;=F44.6^^74^1177^5
 ;;^UTILITY(U,$J,358.3,27613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27613,1,3,0)
 ;;=3^Conversion Disorder w/ Sensory Symptom/Deficit
 ;;^UTILITY(U,$J,358.3,27613,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,27613,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,27614,0)
 ;;=F10.20^^74^1177^1
 ;;^UTILITY(U,$J,358.3,27614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27614,1,3,0)
 ;;=3^Alcohol Dependence Uncomplicated
 ;;^UTILITY(U,$J,358.3,27614,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,27614,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,27615,0)
 ;;=F32.9^^74^1177^13
 ;;^UTILITY(U,$J,358.3,27615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27615,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,27615,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,27615,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,27616,0)
 ;;=G91.1^^74^1177^14
 ;;^UTILITY(U,$J,358.3,27616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27616,1,3,0)
 ;;=3^Obstructive Hydrocephalus
 ;;^UTILITY(U,$J,358.3,27616,1,4,0)
 ;;=4^G91.1
 ;;^UTILITY(U,$J,358.3,27616,2)
 ;;=^84947
 ;;^UTILITY(U,$J,358.3,27617,0)
 ;;=I95.1^^74^1177^15
 ;;^UTILITY(U,$J,358.3,27617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27617,1,3,0)
 ;;=3^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,27617,1,4,0)
 ;;=4^I95.1
 ;;^UTILITY(U,$J,358.3,27617,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,27618,0)
 ;;=I95.89^^74^1177^12
 ;;^UTILITY(U,$J,358.3,27618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27618,1,3,0)
 ;;=3^Hypotension,Other
 ;;^UTILITY(U,$J,358.3,27618,1,4,0)
 ;;=4^I95.89
 ;;^UTILITY(U,$J,358.3,27618,2)
 ;;=^5008079
 ;;^UTILITY(U,$J,358.3,27619,0)
 ;;=R55.^^74^1177^19
 ;;^UTILITY(U,$J,358.3,27619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27619,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,27619,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,27619,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,27620,0)
 ;;=G47.10^^74^1177^11
 ;;^UTILITY(U,$J,358.3,27620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27620,1,3,0)
 ;;=3^Hypersomnia,Unspec
 ;;^UTILITY(U,$J,358.3,27620,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,27620,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,27621,0)
 ;;=G47.30^^74^1177^18
 ;;^UTILITY(U,$J,358.3,27621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27621,1,3,0)
 ;;=3^Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,27621,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,27621,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,27622,0)
 ;;=R20.0^^74^1177^2
 ;;^UTILITY(U,$J,358.3,27622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27622,1,3,0)
 ;;=3^Anesthesia of Skin
 ;;^UTILITY(U,$J,358.3,27622,1,4,0)
 ;;=4^R20.0
 ;;^UTILITY(U,$J,358.3,27622,2)
 ;;=^5019278
 ;;^UTILITY(U,$J,358.3,27623,0)
 ;;=F44.7^^74^1177^3
 ;;^UTILITY(U,$J,358.3,27623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27623,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,27623,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,27623,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,27624,0)
 ;;=G91.9^^74^1177^10
 ;;^UTILITY(U,$J,358.3,27624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27624,1,3,0)
 ;;=3^Hydrocephalus,Unspec
 ;;^UTILITY(U,$J,358.3,27624,1,4,0)
 ;;=4^G91.9
 ;;^UTILITY(U,$J,358.3,27624,2)
 ;;=^5004178
 ;;^UTILITY(U,$J,358.3,27625,0)
 ;;=G98.8^^74^1177^8
 ;;^UTILITY(U,$J,358.3,27625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27625,1,3,0)
 ;;=3^Disorders of Nervous System,Other
 ;;^UTILITY(U,$J,358.3,27625,1,4,0)
 ;;=4^G98.8
 ;;^UTILITY(U,$J,358.3,27625,2)
 ;;=^5004214
 ;;^UTILITY(U,$J,358.3,27626,0)
 ;;=R53.83^^74^1177^9
 ;;^UTILITY(U,$J,358.3,27626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27626,1,3,0)
 ;;=3^Fatigue,Other
 ;;^UTILITY(U,$J,358.3,27626,1,4,0)
 ;;=4^R53.83
 ;;^UTILITY(U,$J,358.3,27626,2)
 ;;=^5019520
 ;;^UTILITY(U,$J,358.3,27627,0)
 ;;=G96.8^^74^1177^7
 ;;^UTILITY(U,$J,358.3,27627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27627,1,3,0)
 ;;=3^Disorders of CNS,Other Spec
 ;;^UTILITY(U,$J,358.3,27627,1,4,0)
 ;;=4^G96.8
 ;;^UTILITY(U,$J,358.3,27627,2)
 ;;=^5004199
