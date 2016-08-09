IBDEI0NO ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23887,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,23887,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,23887,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,23888,0)
 ;;=F31.5^^92^1103^16
 ;;^UTILITY(U,$J,358.3,23888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23888,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,23888,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,23888,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,23889,0)
 ;;=F31.75^^92^1103^18
 ;;^UTILITY(U,$J,358.3,23889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23889,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,23889,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,23889,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,23890,0)
 ;;=F31.76^^92^1103^17
 ;;^UTILITY(U,$J,358.3,23890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23890,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,23890,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,23890,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,23891,0)
 ;;=F31.81^^92^1103^23
 ;;^UTILITY(U,$J,358.3,23891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23891,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,23891,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,23891,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,23892,0)
 ;;=F34.0^^92^1103^24
 ;;^UTILITY(U,$J,358.3,23892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23892,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,23892,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,23892,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,23893,0)
 ;;=F31.0^^92^1103^20
 ;;^UTILITY(U,$J,358.3,23893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23893,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,23893,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,23893,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,23894,0)
 ;;=F31.71^^92^1103^22
 ;;^UTILITY(U,$J,358.3,23894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23894,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,23894,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,23894,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,23895,0)
 ;;=F31.72^^92^1103^21
 ;;^UTILITY(U,$J,358.3,23895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23895,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,23895,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,23895,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,23896,0)
 ;;=F06.33^^92^1103^3
 ;;^UTILITY(U,$J,358.3,23896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23896,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic/Hypomanic-Like Episode
 ;;^UTILITY(U,$J,358.3,23896,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,23896,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,23897,0)
 ;;=F31.9^^92^1103^12
 ;;^UTILITY(U,$J,358.3,23897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23897,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Unsp
 ;;^UTILITY(U,$J,358.3,23897,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,23897,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,23898,0)
 ;;=F31.9^^92^1103^19
 ;;^UTILITY(U,$J,358.3,23898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23898,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unsp
 ;;^UTILITY(U,$J,358.3,23898,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,23898,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,23899,0)
 ;;=F31.89^^92^1103^4
 ;;^UTILITY(U,$J,358.3,23899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23899,1,3,0)
 ;;=3^Bipolar & Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,23899,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,23899,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,23900,0)
 ;;=F31.9^^92^1103^5
 ;;^UTILITY(U,$J,358.3,23900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23900,1,3,0)
 ;;=3^Bipolar & Related Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,23900,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,23900,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,23901,0)
 ;;=A81.00^^92^1104^8
 ;;^UTILITY(U,$J,358.3,23901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23901,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23901,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,23901,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,23902,0)
 ;;=A81.09^^92^1104^7
 ;;^UTILITY(U,$J,358.3,23902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23902,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,23902,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,23902,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,23903,0)
 ;;=A81.2^^92^1104^72
 ;;^UTILITY(U,$J,358.3,23903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23903,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,23903,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,23903,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,23904,0)
 ;;=F01.50^^92^1104^46
 ;;^UTILITY(U,$J,358.3,23904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23904,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,23904,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,23904,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,23905,0)
 ;;=F01.51^^92^1104^47
 ;;^UTILITY(U,$J,358.3,23905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23905,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,23905,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,23905,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,23906,0)
 ;;=F02.80^^92^1104^34
 ;;^UTILITY(U,$J,358.3,23906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23906,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,23906,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,23906,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,23907,0)
 ;;=F02.81^^92^1104^35
 ;;^UTILITY(U,$J,358.3,23907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23907,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,23907,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,23907,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,23908,0)
 ;;=G30.9^^92^1104^4
 ;;^UTILITY(U,$J,358.3,23908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23908,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23908,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,23908,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,23909,0)
 ;;=G31.01^^92^1104^70
 ;;^UTILITY(U,$J,358.3,23909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23909,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,23909,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,23909,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,23910,0)
 ;;=G94.^^92^1104^6
 ;;^UTILITY(U,$J,358.3,23910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23910,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,23910,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,23910,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,23911,0)
 ;;=G31.83^^92^1104^18
 ;;^UTILITY(U,$J,358.3,23911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23911,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,23911,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,23911,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,23912,0)
 ;;=G31.89^^92^1104^11
 ;;^UTILITY(U,$J,358.3,23912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23912,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,23912,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,23912,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,23913,0)
 ;;=G31.9^^92^1104^12
 ;;^UTILITY(U,$J,358.3,23913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23913,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
