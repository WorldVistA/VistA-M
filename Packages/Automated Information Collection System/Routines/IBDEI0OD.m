IBDEI0OD ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30907,0)
 ;;=F31.31^^91^1336^13
 ;;^UTILITY(U,$J,358.3,30907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30907,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,30907,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,30907,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,30908,0)
 ;;=F31.32^^91^1336^14
 ;;^UTILITY(U,$J,358.3,30908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30908,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,30908,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,30908,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,30909,0)
 ;;=F31.4^^91^1336^15
 ;;^UTILITY(U,$J,358.3,30909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30909,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,30909,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,30909,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,30910,0)
 ;;=F31.5^^91^1336^16
 ;;^UTILITY(U,$J,358.3,30910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30910,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,30910,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,30910,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,30911,0)
 ;;=F31.75^^91^1336^18
 ;;^UTILITY(U,$J,358.3,30911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30911,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,30911,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,30911,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,30912,0)
 ;;=F31.76^^91^1336^17
 ;;^UTILITY(U,$J,358.3,30912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30912,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,30912,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,30912,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,30913,0)
 ;;=F31.81^^91^1336^23
 ;;^UTILITY(U,$J,358.3,30913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30913,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,30913,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,30913,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,30914,0)
 ;;=F34.0^^91^1336^24
 ;;^UTILITY(U,$J,358.3,30914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30914,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,30914,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,30914,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,30915,0)
 ;;=F31.0^^91^1336^20
 ;;^UTILITY(U,$J,358.3,30915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30915,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,30915,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,30915,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,30916,0)
 ;;=F31.71^^91^1336^22
 ;;^UTILITY(U,$J,358.3,30916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30916,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,30916,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,30916,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,30917,0)
 ;;=F31.72^^91^1336^21
 ;;^UTILITY(U,$J,358.3,30917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30917,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,30917,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,30917,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,30918,0)
 ;;=F06.33^^91^1336^3
 ;;^UTILITY(U,$J,358.3,30918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30918,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic/Hypomanic-Like Episode
 ;;^UTILITY(U,$J,358.3,30918,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,30918,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,30919,0)
 ;;=F31.9^^91^1336^12
 ;;^UTILITY(U,$J,358.3,30919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30919,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Unsp
 ;;^UTILITY(U,$J,358.3,30919,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,30919,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,30920,0)
 ;;=F31.9^^91^1336^19
 ;;^UTILITY(U,$J,358.3,30920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30920,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unsp
 ;;^UTILITY(U,$J,358.3,30920,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,30920,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,30921,0)
 ;;=F31.89^^91^1336^4
 ;;^UTILITY(U,$J,358.3,30921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30921,1,3,0)
 ;;=3^Bipolar & Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,30921,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,30921,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,30922,0)
 ;;=F31.9^^91^1336^5
 ;;^UTILITY(U,$J,358.3,30922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30922,1,3,0)
 ;;=3^Bipolar & Related Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,30922,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,30922,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,30923,0)
 ;;=A81.00^^91^1337^8
 ;;^UTILITY(U,$J,358.3,30923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30923,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,30923,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,30923,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,30924,0)
 ;;=A81.09^^91^1337^7
 ;;^UTILITY(U,$J,358.3,30924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30924,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,30924,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,30924,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,30925,0)
 ;;=A81.2^^91^1337^72
 ;;^UTILITY(U,$J,358.3,30925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30925,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,30925,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,30925,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,30926,0)
 ;;=F01.50^^91^1337^46
 ;;^UTILITY(U,$J,358.3,30926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30926,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,30926,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,30926,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,30927,0)
 ;;=F01.51^^91^1337^47
 ;;^UTILITY(U,$J,358.3,30927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30927,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,30927,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,30927,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,30928,0)
 ;;=F02.80^^91^1337^34
 ;;^UTILITY(U,$J,358.3,30928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30928,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,30928,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,30928,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,30929,0)
 ;;=F02.81^^91^1337^35
 ;;^UTILITY(U,$J,358.3,30929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30929,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,30929,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,30929,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,30930,0)
 ;;=G30.9^^91^1337^4
 ;;^UTILITY(U,$J,358.3,30930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30930,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,30930,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,30930,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,30931,0)
 ;;=G31.01^^91^1337^70
 ;;^UTILITY(U,$J,358.3,30931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30931,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,30931,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,30931,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,30932,0)
 ;;=G94.^^91^1337^6
 ;;^UTILITY(U,$J,358.3,30932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30932,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,30932,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,30932,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,30933,0)
 ;;=G31.83^^91^1337^18
 ;;^UTILITY(U,$J,358.3,30933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30933,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,30933,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,30933,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,30934,0)
 ;;=G31.89^^91^1337^11
 ;;^UTILITY(U,$J,358.3,30934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30934,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,30934,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,30934,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,30935,0)
 ;;=G31.9^^91^1337^12
 ;;^UTILITY(U,$J,358.3,30935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30935,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,30935,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,30935,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,30936,0)
 ;;=G23.8^^91^1337^10
 ;;^UTILITY(U,$J,358.3,30936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30936,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,30936,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,30936,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,30937,0)
 ;;=G30.0^^91^1337^2
 ;;^UTILITY(U,$J,358.3,30937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30937,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,30937,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,30937,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,30938,0)
 ;;=G30.1^^91^1337^3
 ;;^UTILITY(U,$J,358.3,30938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30938,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,30938,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,30938,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,30939,0)
 ;;=B20.^^91^1337^21
 ;;^UTILITY(U,$J,358.3,30939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30939,1,3,0)
 ;;=3^HIV Infection
 ;;^UTILITY(U,$J,358.3,30939,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,30939,2)
 ;;=^5000555^
 ;;^UTILITY(U,$J,358.3,30940,0)
 ;;=G10.^^91^1337^22
 ;;^UTILITY(U,$J,358.3,30940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30940,1,3,0)
 ;;=3^Huntington's Disease
 ;;^UTILITY(U,$J,358.3,30940,1,4,0)
 ;;=4^G10.
